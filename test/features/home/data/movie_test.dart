import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:movies_list/features/home/data/movie.dart';
import 'package:movies_list/features/home/data/request_response.dart';

void main() {
  final tNumberTriviaModel = Movie(
      posterPath: "/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg",
      id: 283552,
      genreIds: [18],
      overview:
          "A lighthouse keeper and his wife living off the coast of Western Australia raise a baby they rescue from an adrift rowboat.",
      releaseDate: "2016-09-02",
      title: "The Light Between Oceans");

  test(
    'Check model instance is Movie',
    () async {
      // assert
      expect(tNumberTriviaModel, isA<Movie>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model ',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
            File('test/features/home/data/mocked_200_movies_list.json')
                .readAsStringSync());
        // act
        final result = RequestResponse.fromJson(jsonMap);
        // assert
        expect(result.results!.first, tNumberTriviaModel);
      },
    );
    test(
      'should return a valid model [] when is 400',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
            File('test/features/home/data/mocked_400_movies_empty_list.json')
                .readAsStringSync());
        // act
        final result = RequestResponse.fromJson(jsonMap);
        // assert
        expect(result.results!.length, 0);
      },
    );
    test(
      'should return a null when is 401',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
            File('test/features/home/data/mocked_401.json').readAsStringSync());
        // act
        final result = RequestResponse.fromJson(jsonMap);
        // assert
        expect(result.results, null);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tNumberTriviaModel.toJson();
        // assert
        final expectedMap = {
          "poster_path": "/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg",
          "overview":
              "A lighthouse keeper and his wife living off the coast of Western Australia raise a baby they rescue from an adrift rowboat.",
          "release_date": "2016-09-02",
          "genre_ids": [18],
          "id": 283552,
          "title": "The Light Between Oceans",
        };
        expect(result, expectedMap);
      },
    );
  });
}

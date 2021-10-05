import 'package:dio/dio.dart';
import 'package:movies_list/features/home/data/movie.dart';
import 'package:movies_list/features/home/data/movie_response.dart';

class MoviesApiClient {
  static String baseURL = 'https://api.themoviedb.org/3';
  static String apiKey = 'c5850ed73901b8d268d0898a8a9d8bff';
  static String defaultConfiguration = 'language=en-US';
  static String upcomingMoviesURL =
      '$baseURL/movie/upcoming?api_key=$apiKey&$defaultConfiguration';

  static String searchMoviesURL =
      '$baseURL/search/movie?api_key=$apiKey&$defaultConfiguration';

  Future<List<Movie>?> fetchMovies(int page) async {
    Response response = await Dio().get(upcomingMoviesURL + '&page=$page');
    return MovieResponse.fromJson(response.data).results;
  }

  Future<List<Movie>?> searchMovies(String query, int page) async {
    Response response =
        await Dio().get(searchMoviesURL + '&page=$page&query=$query');
    return MovieResponse.fromJson(response.data).results;
  }
}

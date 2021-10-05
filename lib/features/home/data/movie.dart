import 'package:equatable/equatable.dart';

class Movie extends Equatable{
  String? posterPath;
  int? id;
  List<int>? genreIds;
  String? title;
  String? overview;
  String? releaseDate;

  Movie(
      {this.posterPath,
      this.id,
      this.genreIds,
      this.title,
      this.overview,
      this.releaseDate});

  Movie.fromJson(Map<String, dynamic> json) {
    posterPath = json['poster_path'];
    id = json['id'];
    genreIds = json['genre_ids'].cast<int>();
    title = json['title'];
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['poster_path'] = posterPath;
    data['id'] = id;
    data['genre_ids'] = genreIds;
    data['title'] = title;
    data['overview'] = overview;
    data['release_date'] = releaseDate;
    return data;
  }

  @override
  List<Object?> get props => [];
}

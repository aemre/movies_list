import 'movie.dart';

class RequestResponse {
  int? page;
  int? totalResults;
  int? totalPages;
  List<Movie>? results;

  RequestResponse(
      {required this.page,
      required this.totalResults,
      required this.totalPages,
      required this.results});

  RequestResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = <Movie>[];
      json['results'].forEach((movie) {
        results!.add(Movie.fromJson(movie));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['total_results'] = totalResults;
    data['total_pages'] = totalPages;
    if (results != null) {
      data['results'] = results!.map((movie) => movie.toJson()).toList();
    }
    return data;
  }
}

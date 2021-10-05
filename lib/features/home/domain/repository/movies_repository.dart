import 'package:movies_list/features/home/data/movie.dart';

import 'movie_api_client.dart';

class MoviesRepository {
  final MoviesApiClient moviesApiClient;

  MoviesRepository({required this.moviesApiClient});

  Future<List<Movie>?>? fetchMovies(int page) async {
    return await moviesApiClient.fetchMovies(page);
  }

  Future<List<Movie>?> searchMovies(String query, int page) async {
    return await moviesApiClient.searchMovies(query, page);
  }
}

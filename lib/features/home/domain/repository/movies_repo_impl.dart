import 'package:dartz/dartz.dart';
import 'package:movies_list/common/error.dart';
import 'package:movies_list/features/home/data/movie.dart';
import 'package:movies_list/features/home/domain/repository/movies_repo.dart';

import 'movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepo {
  final MoviesRepository remoteDataSource;

  MoviesRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Error, List<Movie>>> getMovies(int number) async {
    try {
      final remoteTrivia =
          await remoteDataSource.moviesApiClient.fetchMovies(number);

      return Right(remoteTrivia!);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Error, List<Movie>>> searchMovies(String query) async {
    try {
      var remoteTrivia =
          await remoteDataSource.moviesApiClient.searchMovies(query, 0);

      return Right(remoteTrivia!);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}

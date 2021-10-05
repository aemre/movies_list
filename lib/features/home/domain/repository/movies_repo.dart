import 'package:dartz/dartz.dart';
import 'package:movies_list/common/error.dart';
import 'package:movies_list/features/home/data/movie.dart';


abstract class MoviesRepo {
  Future<Either<Error, List<Movie>>> getMovies(int number);
  Future<Either<Error, List<Movie>>> searchMovies(String query);
}
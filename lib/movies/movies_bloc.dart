import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movies_list/features/home/data/movie.dart';
import 'package:movies_list/features/home/domain/repository/movie_api_client.dart';
import 'package:movies_list/features/home/domain/repository/movies_repo_impl.dart';
import 'package:movies_list/features/home/domain/repository/movies_repository.dart';

import './movies.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MoviesRepository moviesRepository;
  MoviesRepositoryImpl moviesRepositoryImpl = MoviesRepositoryImpl(
      remoteDataSource: MoviesRepository(moviesApiClient: MoviesApiClient()));

  MoviesBloc({required this.moviesRepository}) : super(MoviesUnitialized());

  MoviesState get initialState => MoviesUnitialized();

  @override
  Stream<MoviesState> mapEventToState(
    MoviesEvent event,
  ) async* {
    final currentState = state;
    if (event is Fetch) {
      try {
        if (currentState is MoviesUnitialized) {
          final x = await moviesRepositoryImpl.getMovies(1);
          yield x.fold((l) => MoviesEmpty(),
              (r) => MoviesFetched(movies: r, hasReachedMax: false));
          final movies = await moviesRepository.fetchMovies(1);

/*
          if (movies!.isEmpty) {
            yield MoviesEmpty();
          } else {
            yield MoviesFetched(movies: movies, hasReachedMax: false);
          }*/
          return;
        }
        if (currentState is MoviesFetched) {
          final movies = await moviesRepository
              .fetchMovies(_getNextPage(currentState.movies));
          yield movies!.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : MoviesFetched(
                  movies: currentState.movies + movies,
                  hasReachedMax: false,
                );
          return;
        }
      } catch (error) {
        yield MoviesError(error: error.toString());
      }
    }
    if (event is Search) {
      if (currentState is MoviesUnitialized) {
        final movies = await moviesRepository.searchMovies(event.query, 1);
        if (movies!.isEmpty) {
          yield MoviesEmpty();
        } else {
          yield MoviesFetched(movies: movies, hasReachedMax: false);
        }
        return;
      }
      if (currentState is MoviesFetched) {
        final movies = await moviesRepository.searchMovies(
            event.query, _getNextPage(currentState.movies));
        yield movies!.isEmpty
            ? currentState.copyWith(hasReachedMax: true)
            : MoviesFetched(
                movies: currentState.movies + movies,
                hasReachedMax: false,
              );
        return;
      }
    }
  }
}

int _getNextPage(List<Movie> movies) {
  return movies.length ~/ 20 + 1;
}

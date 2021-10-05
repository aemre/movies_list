import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/home/domain/repository/movie_api_client.dart';
import 'features/home/domain/repository/movies_repository.dart';
import 'movies/movies_bloc.dart';
import 'movies/movies_page.dart';

void main() {
  final moviesRepository = MoviesRepository(moviesApiClient: MoviesApiClient());
  runApp(
    BlocProvider<MoviesBloc>(
      create: (context) {
        return MoviesBloc(moviesRepository: moviesRepository);
      },
      child: App(moviesRepository: moviesRepository),
    ),
  );
}

class App extends StatelessWidget {
  final MoviesRepository moviesRepository;

  const App({Key? key, required this.moviesRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MoviesPage(),
    );
  }
}

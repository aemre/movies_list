import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list/features/home/data/movie.dart';
import 'package:movies_list/features/home/presentation/movies_bloc_widget.dart';
import 'package:movies_list/movies/movies_bloc.dart';
import 'package:movies_list/movies/movies_event.dart';

class CustomSearchDelegate extends SearchDelegate<Movie?> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }

    var moviesRepository =
        BlocProvider.of<MoviesBloc>(context).moviesRepository;

    return MoviesBlocWidget(
      bloc: MoviesBloc( moviesRepository:moviesRepository ),
      event: Search(query: query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}
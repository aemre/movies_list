import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list/common/constants.dart';
import 'package:movies_list/common/custom_search_delegate.dart';
import 'package:movies_list/features/home/presentation/movies_bloc_widget.dart';

import 'movies.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({
    Key? key,
  }) : super(key: key);

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            'Movie Viewer',
            style: titleStyle,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          )
        ],
      ),
      body: MoviesBlocWidget(bloc: BlocProvider.of<MoviesBloc>(context)),
    );
  }
}

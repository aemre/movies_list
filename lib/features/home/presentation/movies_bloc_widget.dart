import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list/common/constants.dart';
import 'package:movies_list/movies/movies_bloc.dart';
import 'package:movies_list/movies/movies_detail_page.dart';
import 'package:movies_list/movies/movies_event.dart';
import 'package:movies_list/movies/movies_state.dart';

import '../../widget/bottom_loader.dart';
import '../../widget/error_message_widget.dart';
import '../../widget/loading_indicator.dart';
import '../../widget/movie_list_item.dart';

class MoviesBlocWidget extends StatefulWidget {
  const MoviesBlocWidget({Key? key, required this.bloc, this.event});

  final MoviesBloc bloc;
  final MoviesEvent? event;

  @override
  _MoviesBlocWidgetState createState() => _MoviesBlocWidgetState();
}

class _MoviesBlocWidgetState extends State<MoviesBlocWidget> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  late MoviesBloc _moviesBloc;
  late MoviesEvent _event;

  @override
  void initState() {
    _moviesBloc = widget.bloc;
    _event = widget.event ?? Fetch();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      bloc: _moviesBloc..add(_event),
      builder: (context, state) {
        if (state is MoviesFetched) {
          height:
          MediaQuery.of(context).size.height;
          return ListView.separated(
            key: const PageStorageKey('movies_list'),
            separatorBuilder: (context, index) =>
                const Divider(height: 1, color: Colors.grey),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final movie = state.movies[index];
              return index >= state.movies.length
                  ? BottomLoader()
                  : MovieListItem(
                      movie: movie,
                      onTapFunction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MoviesDetailPage(
                              movie: movie,
                            ),
                          ),
                        );
                      },
                    );
            },
            itemCount: state.movies.length,
            controller: _scrollController,
          );
        }
        if (state is MoviesEmpty) {
          return const ErrorMessageWidget(
            message: 'There are no movies for this query.',
            textKey: emptyStateKey,
          );
        }
        if (state is MoviesError) {
          return const ErrorMessageWidget(
            message: 'Oops, something wrong happened :(',
            textKey: errorStateKey,
          );
        }
        return LoadingIndicator();
      },
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _moviesBloc.add(_event);
    }
  }
}

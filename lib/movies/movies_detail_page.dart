import 'package:flutter/material.dart';
import 'package:movies_list/common/constants.dart';
import 'package:movies_list/features/home/data/movie.dart';
import 'package:movies_list/features/widget/movie_image.dart';

class MoviesDetailPage extends StatelessWidget {
  const MoviesDetailPage({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            movie.title!,
            style: titleStyle,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              MovieImage(movie),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      movie.overview!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

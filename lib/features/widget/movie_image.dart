import 'package:flutter/material.dart';
import 'package:movies_list/common/constants.dart';
import 'package:movies_list/features/home/data/movie.dart';

class MovieImage extends StatelessWidget {
  const MovieImage(this.movie);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: movie.hashCode,
      child: movie.posterPath == null
          ? const Icon(
              Icons.movie,
              size: 48,
            )
          : Image.network(
              imagePrefix + movie.posterPath!,
              fit: BoxFit.fitHeight,
            ),
    );
  }
}

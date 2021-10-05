import 'package:flutter/material.dart';
import 'package:movies_list/common/constants.dart';
import 'package:movies_list/features/home/data/movie.dart';

class MovieListItem extends StatelessWidget {
  const MovieListItem({
    Key? key,
    required this.movie,
    required this.onTapFunction,
  }) : super(key: key);

  final Movie movie;
  final VoidCallback onTapFunction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          imagePrefix + movie.posterPath!,
        ),
      ),
      title: Text(movie.title!),
      subtitle: Text(movie.releaseDate!),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: onTapFunction,
      selected: true,
    );
  }
}

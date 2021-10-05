import 'package:equatable/equatable.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends MoviesEvent {}

class Search extends MoviesEvent {
  final String query;

  const Search({required this.query});

  @override
  List<Object> get props => [query];

  @override
  String toString() => 'Search { query: $query }';
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_list/features/home/domain/repository/repository.dart';
import 'package:movies_list/movies/movies.dart';
import 'package:movies_list/movies/movies_bloc.dart';
import 'package:movies_list/movies/movies_state.dart';

@GenerateMocks([MockMoviesRepository])
class MockMoviesRepository extends Mock implements MoviesRepository {}

void main() {
  late MoviesBloc moviesBloc;
  late MockMoviesRepository moviesRepository;

  setUp(() {
    moviesRepository = MockMoviesRepository();
    moviesBloc = MoviesBloc(moviesRepository: moviesRepository);
  });

  tearDown(() {
    moviesBloc.close();
  });

  test('initial state is correct', () {
    expect(moviesBloc.initialState, MoviesUnitialized());
  });

  group('MoviesBlock', () {
    blocTest<MoviesBloc, MoviesState>(
      'emits [] when nothing is added',
      build: () => MoviesBloc(moviesRepository: moviesRepository),
      expect: () => [],
    );

    blocTest<MoviesBloc, MoviesState>(
      'emits [movies] fetch is added',
      build: () => MoviesBloc(moviesRepository: moviesRepository),
      act: (bloc) => bloc.add(Fetch()),
      expect: () => [isA<MoviesFetched>()],
    );
    blocTest<MoviesBloc, MoviesState>(
        'MoviesBlock emits []  when search is added',
        build: () => MoviesBloc(moviesRepository: moviesRepository),
        act: (bloc) => bloc.add(Search(query: "")),
        expect: () => []);
    blocTest<MoviesBloc, MoviesState>(
      'MoviesBlock emits [] when search is added with query',
      build: () => MoviesBloc(moviesRepository: moviesRepository),
      act: (bloc) => bloc
        ..add(Fetch())
        ..add(Search(query: "r")),
      skip: 1,
      expect: () => [],
    );
  });
}

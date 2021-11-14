import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import 'popular_movie_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMoviesBloc popularMoviesBloc;
  late MockGetPopularMovies mockPopularMovies;

  setUp(() {
    mockPopularMovies = MockGetPopularMovies();
    popularMoviesBloc = PopularMoviesBloc(getPopularMovies: mockPopularMovies);
  });

  test('initial state should be loading', () {
    expect(popularMoviesBloc.state, PopularMoviesLoading());
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () => [
      PopularMoviesLoading(),
      GetPopularMoviesState(tMovieList),
    ],
    verify: (bloc) {
      verify(mockPopularMovies.execute());
    },
  );

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'Should emit [Loading, Error] when get popular is unsuccessful',
    build: () {
      when(mockPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () => [
      PopularMoviesLoading(),
      PopularMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockPopularMovies.execute());
    },
  );
}

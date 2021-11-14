import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks(
    [GetWatchListStatus, SaveWatchlist, RemoveWatchlist, GetWatchlistMovies])
void main() {
  late WatchlistMoviesBloc watchlistMoviesBloc;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMoviesBloc = WatchlistMoviesBloc(
      getWatchListStatus: mockGetWatchListStatus,
      getWatchlistMovies: mockGetWatchlistMovies,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  test('initial state should be loading', () {
    expect(watchlistMoviesBloc.state, WatchlistMoviesLoading());
  });

  final tMovieModel1 = Movie(
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
  final tMovieModel2 = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 60.441,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovieModel1];
  final tId = 1;

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(StartWatchlistMovies()),
    expect: () => [
      WatchlistMoviesLoading(),
      WatchlistMoviesLoaded(movies: tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should emit [Loading, Error] when get watchlist is unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(StartWatchlistMovies()),
    expect: () => [
      WatchlistMoviesLoading(),
      WatchlistMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should emit [Loaded, GetStatus] when save watchlist is gotten successfully',
    build: () {
      when(mockSaveWatchlist.executeMovies(tMovieDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right([tMovieModel2]));
      when(mockGetWatchListStatus.executeMovies(tId))
          .thenAnswer((_) async => true);
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(AddWatchlistMovie(tMovieDetail)),
    expect: () => [
      WatchlistMoviesLoaded(movies: [tMovieModel2]),
      GetWatchlistMovieStatus(true),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.executeMovies(tMovieDetail));
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should emit [Loaded, GetStatus] when remove watchlist is gotten successfully',
    build: () {
      when(mockRemoveWatchlist.executeMovies(tMovieDetail))
          .thenAnswer((_) async => Right('Removed from Watchlist'));
      when(mockGetWatchlistMovies.execute()).thenAnswer((_) async => Right([]));
      when(mockGetWatchListStatus.executeMovies(tId))
          .thenAnswer((_) async => false);
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(RemoveWatchlistMovie(tMovieDetail)),
    expect: () => [
      WatchlistMoviesLoaded(movies: []),
      GetWatchlistMovieStatus(false),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.executeMovies(tMovieDetail));
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should emit [GetStatus] when check watchlist status is gotten successfully',
    build: () {
      when(mockGetWatchListStatus.executeMovies(tId))
          .thenAnswer((_) async => true);
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistMovieStatus(tId)),
    expect: () => [
      GetWatchlistMovieStatus(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.executeMovies(tId));
    },
  );
}

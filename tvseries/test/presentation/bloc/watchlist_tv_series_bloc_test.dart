import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tvseries/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks(
    [GetWatchListStatus, SaveWatchlist, RemoveWatchlist, GetWatchlistTVSeries])
void main() {
  late WatchlistTVSeriesBloc watchlistTVSeriesBloc;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockGetWatchlistTVSeries mockGetWatchlistTVSeries;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockGetWatchlistTVSeries = MockGetWatchlistTVSeries();
    watchlistTVSeriesBloc = WatchlistTVSeriesBloc(
      getWatchListStatus: mockGetWatchListStatus,
      getWatchlistTVSeries: mockGetWatchlistTVSeries,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  test('initial state should be loading', () {
    expect(watchlistTVSeriesBloc.state, WatchlistTVSeriesLoading());
  });

  final tTVSeriesModel = TVSeries(
    posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
    popularity: 47.432451,
    id: 31917,
    backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
    voteAverage: 5.04,
    overview:
        "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
    firstAirDate: "2010-06-08",
    originCountry: ["US"],
    genreIds: [18, 9648],
    originalLanguage: "en",
    voteCount: 133,
    name: "Pretty Little Liars",
    originalName: "Pretty Little Liars",
  );

  final tTVSeriesDetail = TVSeriesDetail(
    backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
    episodeRunTime: [60, 58],
    genres: [Genre(id: 1, name: 'Action')],
    id: 31917,
    name: "Pretty Little Liars",
    originalName: "Pretty Little Liars",
    overview:
        "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
    posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
    seasons: [
      Season(
          airDate: "2010-12-05",
          episodeCount: 64,
          id: 3627,
          name: "Specials",
          overview: "",
          posterPath: "/kMTcwNRfFKCZ0O2OaBZS0nZ2AIe.jpg",
          seasonNumber: 0,
          episodes: [
            Episode(
                airDate: "2021-09-17",
                episodeNumber: 1,
                id: 1922715,
                name: "Red Light, Green Light",
                overview:
                    "Hoping to win easy money, a broke and desperate Gi-hun agrees to take part in an enigmatic game. Not long into the first round, unforeseen horrors unfold.",
                productionCode: "",
                seasonNumber: 1,
                stillPath: "/vMFJS9LIUUAmQ1thq4vJ7iHKwRz.jpg",
                voteAverage: 8.022,
                voteCount: 46)
          ])
    ],
    voteAverage: 5.04,
    voteCount: 133,
  );

  final tTVSeriesList = <TVSeries>[tTVSeriesModel];
  final tId = 31917;

  blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      return watchlistTVSeriesBloc;
    },
    act: (bloc) => bloc.add(StartWatchlistTVSeries()),
    expect: () => [
      WatchlistTVSeriesLoading(),
      WatchlistTVSeriesLoaded(tvSeries: tTVSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTVSeries.execute());
    },
  );

  blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
    'Should emit [Loading, Error] when get watchlist is unsuccessful',
    build: () {
      when(mockGetWatchlistTVSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistTVSeriesBloc;
    },
    act: (bloc) => bloc.add(StartWatchlistTVSeries()),
    expect: () => [
      WatchlistTVSeriesLoading(),
      WatchlistTVSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTVSeries.execute());
    },
  );

  blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
    'Should emit [Loaded, GetStatus] when save watchlist is gotten successfully',
    build: () {
      when(mockSaveWatchlist.executeTVSeries(tTVSeriesDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      when(mockGetWatchListStatus.executeTVSeries(tId))
          .thenAnswer((_) async => true);
      return watchlistTVSeriesBloc;
    },
    act: (bloc) => bloc.add(AddWatchlistTVSeries(tTVSeriesDetail)),
    expect: () => [
      WatchlistTVSeriesLoaded(tvSeries: tTVSeriesList),
      GetWatchlistTVSeriesStatus(true),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.executeTVSeries(tTVSeriesDetail));
    },
  );

  blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
    'Should emit [Loaded, GetStatus] when remove watchlist is gotten successfully',
    build: () {
      when(mockRemoveWatchlist.executeTVSeries(tTVSeriesDetail))
          .thenAnswer((_) async => Right('Removed from Watchlist'));
      when(mockGetWatchlistTVSeries.execute())
          .thenAnswer((_) async => Right([]));
      when(mockGetWatchListStatus.executeTVSeries(tId))
          .thenAnswer((_) async => false);
      return watchlistTVSeriesBloc;
    },
    act: (bloc) => bloc.add(RemoveWatchlistTVSeries(tTVSeriesDetail)),
    expect: () => [
      WatchlistTVSeriesLoaded(tvSeries: []),
      GetWatchlistTVSeriesStatus(false),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.executeTVSeries(tTVSeriesDetail));
    },
  );

  blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
    'Should emit [GetStatus] when check watchlist status is gotten successfully',
    build: () {
      when(mockGetWatchListStatus.executeTVSeries(tId))
          .thenAnswer((_) async => true);
      return watchlistTVSeriesBloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistTVSeriesStatus(tId)),
    expect: () => [
      GetWatchlistTVSeriesStatus(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.executeTVSeries(tId));
    },
  );
}

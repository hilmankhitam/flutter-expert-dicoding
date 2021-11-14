import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVSeriesRepositoryImpl repository;
  late MockTVSeriesRemoteDataSource mockRemoteDataSource;
  late MockTVSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTVSeriesRemoteDataSource();
    mockLocalDataSource = MockTVSeriesLocalDataSource();
    repository = TVSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTVSeriesModel = TVSeriesModel(
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

  final tTVSeries = TVSeries(
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

  final tTVSeriesModelList = <TVSeriesModel>[tTVSeriesModel];
  final tTVSeriesList = <TVSeries>[tTVSeries];

  group('On The Air TV Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTVSeries())
          .thenAnswer((_) async => tTVSeriesModelList);
      // act
      final result = await repository.getOnTheAirTVSeries();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTVSeries());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTVSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getOnTheAirTVSeries();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTVSeries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTVSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getOnTheAirTVSeries();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTVSeries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular TV Series', () {
    test('should return tv series list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVSeries())
          .thenAnswer((_) async => tTVSeriesModelList);
      // act
      final result = await repository.getPopularTVSeries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVSeriesList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTVSeries();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTVSeries();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated TV Series', () {
    test('should return tv series list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVSeries())
          .thenAnswer((_) async => tTVSeriesModelList);
      // act
      final result = await repository.getTopRatedTVSeries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTVSeries();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTVSeries();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get TV Series Detail', () {
    final tId = 1;
    final tTVSeriesResponse = TVSeriesDetailResponse(
        backdropPath: "/suopoADq0k8YZr4dQXcU6pToj6s.jpg",
        createdBy: [
          CreatedByModel(
            id: 9813,
            creditId: "5256c8c219c2956ff604858a",
            name: "David Benioff",
            gender: 2,
            profilePath: "/xvNN5huL0X8yJ7h3IZfGG4O2zBD.jpg",
          )
        ],
        episodeRunTime: [60],
        firstAirDate: DateTime.parse("2010-06-08"),
        genres: [GenreModel(id: 1, name: 'Action')],
        homepage: "http://www.hbo.com/game-of-thrones",
        id: 31917,
        inProduction: false,
        languages: ["en"],
        lastAirDate: DateTime.parse("2019-05-19"),
        lastEpisodeToAir: LastEpisodeToAirModel(
            airDate: DateTime.parse("2019-05-19"),
            episodeNumber: 6,
            id: 1551830,
            name: "The Iron Throne",
            overview:
                "In the aftermath of the devastating attack on King's Landing, Daenerys must face the survivors.",
            productionCode: "806",
            seasonNumber: 8,
            stillPath: "/3x8tJon5jXFa1ziAM93hPKNyW7i.jpg",
            voteAverage: 4.8,
            voteCount: 106),
        name: "Game of Thrones",
        nextEpisodeToAir: null,
        networks: [
          NetworkModel(
              name: "HBO",
              id: 49,
              logoPath: "/tuomPhY2UtuPTqqFnKMVHvSb724.png",
              originCountry: "US")
        ],
        numberOfEpisodes: 73,
        numberOfSeasons: 8,
        originCountry: ["US"],
        originalLanguage: "en",
        originalName: "Game of Thrones",
        overview:
            "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
        popularity: 369.594,
        posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
        productionCompanies: [
          ProductionCompanyModel(
              id: 76043,
              logoPath: "/9RO2vbQ67otPrBLXCaC8UMp3Qat.png",
              name: "Revolution Sun Studios",
              originCountry: "US")
        ],
        productionCountries: [
          ProductionCountryModel(iso31661: "GB", name: "United Kingdom")
        ],
        seasons: [
          SeasonModel(
            airDate: "2010-12-05",
            episodeCount: 64,
            id: 3627,
            name: "Specials",
            overview: "",
            posterPath: "/kMTcwNRfFKCZ0O2OaBZS0nZ2AIe.jpg",
            seasonNumber: 0,
            episodes: [
              EpisodeModel(
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
            ],
          )
        ],
        spokenLanguages: [
          SpokenLanguageModel(
              englishName: "English", iso6391: "en", name: "English")
        ],
        status: "Ended",
        tagline: "Winter Is Coming",
        type: "Scripted",
        voteAverage: 8.3,
        voteCount: 11504);

    test(
        'should return tv series data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesDetail(tId))
          .thenAnswer((_) async => tTVSeriesResponse);
      // act
      final result = await repository.getTVSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVSeriesDetail(tId));
      expect(result, equals(Right(tTVSeriesDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTVSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVSeriesDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVSeriesDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get TV Series Season Detail', () {
    final tId = 1;
    final tSeasonNumber = 1;
    final tEpisodeList = <EpisodeModel>[];

    test('should return data (episode list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber))
          .thenAnswer((_) async => tEpisodeList);
      // act
      final result = await repository.getSeasonDetail(tId, tSeasonNumber);
      // assert
      verify(mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tEpisodeList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber))
          .thenThrow(ServerException());
      // act
      final result = await repository.getSeasonDetail(tId, tSeasonNumber);
      // assertbuild runner
      verify(mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getSeasonDetail(tId, tSeasonNumber);
      // assert
      verify(mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get TV Series Recommendations', () {
    final tTVSeriesList = <TVSeriesModel>[];
    final tId = 1;

    test('should return data (tv series list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesRecommendations(tId))
          .thenAnswer((_) async => tTVSeriesList);
      // act
      final result = await repository.getTVSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTVSeriesRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTVSeriesList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTVSeriesRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTVSeriesRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTVSeriesRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach TV Series', () {
    final tQuery = 'Game of Thrones';

    test('should return tv series list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTVSeries(tQuery))
          .thenAnswer((_) async => tTVSeriesModelList);
      // act
      final result = await repository.searchTVSeries(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTVSeries(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTVSeries(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTVSeries(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTVSeries(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist tv series', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTVSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTVSeriesDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTVSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTVSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist tv series', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTVSeriesTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTVSeriesDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTVSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTVSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status tv series', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTVSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of TV Series', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTVSeries())
          .thenAnswer((_) async => [testTVSeriesTable]);
      // act
      final result = await repository.getWatchlistTVSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTVSeries]);
    });
  });
}

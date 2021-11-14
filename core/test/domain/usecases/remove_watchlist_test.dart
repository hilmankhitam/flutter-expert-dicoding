import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlist usecase;
  late MockMovieRepository mockMovieRepository;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = RemoveWatchlist(mockMovieRepository, mockTVSeriesRepository);
  });

  group('RemoveWatchlist', () {
    group('execute movie', () {
      test('should remove watchlist movie from repository', () async {
        // arrange
        when(mockMovieRepository.removeWatchlist(testMovieDetail))
            .thenAnswer((_) async => Right('Removed from watchlist'));
        // act
        final result = await usecase.executeMovies(testMovieDetail);
        // assert
        verify(mockMovieRepository.removeWatchlist(testMovieDetail));
        expect(result, Right('Removed from watchlist'));
      });
    });
    group('execute tv series', () {
      test('should remove watchlist tv series from repository', () async {
        // arrange
        when(mockTVSeriesRepository.removeWatchlist(testTVSeriesDetail))
            .thenAnswer((_) async => Right('Removed from watchlist'));
        // act
        final result = await usecase.executeTVSeries(testTVSeriesDetail);
        // assert
        verify(mockTVSeriesRepository.removeWatchlist(testTVSeriesDetail));
        expect(result, Right('Removed from watchlist'));
      });
    });
  });
}

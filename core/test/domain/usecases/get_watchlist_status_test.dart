import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatus usecase;
  late MockMovieRepository mockMovieRepository;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetWatchListStatus(mockMovieRepository, mockTVSeriesRepository);
  });

  group('GetWatchlistStatus', () {
    group('execute movie', () {
      test('should get watchlist movie status from repository', () async {
        // arrange
        when(mockMovieRepository.isAddedToWatchlist(1))
            .thenAnswer((_) async => true);
        // act
        final result = await usecase.executeMovies(1);
        // assert
        expect(result, true);
      });
    });
    group('execute tv series', () {
      test('should get watchlist tv series status from repository', () async {
        // arrange
        when(mockTVSeriesRepository.isAddedToWatchlist(1))
            .thenAnswer((_) async => true);
        // act
        final result = await usecase.executeTVSeries(1);
        // assert
        expect(result, true);
      });
    });
  });
}

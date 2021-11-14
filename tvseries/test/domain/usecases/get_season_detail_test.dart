import 'package:dartz/dartz.dart';
import 'package:tvseries/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetSeasonDetail usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetSeasonDetail(mockTVSeriesRepository);
  });

  final tId = 1;
  final tSeasonNumber = 0;
  final tEpisode = <Episode>[];

  group('GetSeasonDetail', () {
    group('execute', () {
      test('should get season detail from the repository', () async {
        // arrange
        when(mockTVSeriesRepository.getSeasonDetail(tId, tSeasonNumber))
            .thenAnswer((_) async => Right(tEpisode));
        // act
        final result = await usecase.execute(tId, tSeasonNumber);
        // assert
        expect(result, Right(tEpisode));
      });
    });
  });
}

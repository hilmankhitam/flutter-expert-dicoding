import 'package:dartz/dartz.dart';
import 'package:tvseries/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVSeriesDetail usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetTVSeriesDetail(mockTVSeriesRepository);
  });

  final tId = 1;

  group('GetTVSeriesDetail', () {
    group('execute', () {
      test('should get tv series detail from the repository', () async {
        // arrange
        when(mockTVSeriesRepository.getTVSeriesDetail(tId))
            .thenAnswer((_) async => Right(testTVSeriesDetail));
        // act
        final result = await usecase.execute(tId);
        // assert
        expect(result, Right(testTVSeriesDetail));
      });
    });
  });
}

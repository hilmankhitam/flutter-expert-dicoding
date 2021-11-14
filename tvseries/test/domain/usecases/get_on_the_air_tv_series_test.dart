import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetOnTheAirTVSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetOnTheAirTVSeries(mockTVSeriesRepository);
  });

  final tTVSeries = <TVSeries>[];

  group('GetOnTheAirTVSeries', () {
    group('execute', () {
      test('should get list of tv series from the repository', () async {
        // arrange
        when(mockTVSeriesRepository.getOnTheAirTVSeries())
            .thenAnswer((_) async => Right(tTVSeries));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTVSeries));
      });
    });
  });
}

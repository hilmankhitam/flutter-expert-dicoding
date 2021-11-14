import 'package:tvseries/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTVSeriesTable = TVSeriesTable(
    id: 1,
    title: 'title',
    overview: 'overview',
    posterPath: 'posterPath',
    category: 'tvSeries',
  );
  group('toJson', () {
    test('should return a JSON map containing proper data', () {
      // arrange

      // act
      final result = tTVSeriesTable.toJson();
      // assert
      final expectedJsonMap = {
        'id': 1,
        'title': 'title',
        'overview': 'overview',
        'posterPath': 'posterPath',
        'category': 'tvSeries',
      };
      expect(result, expectedJsonMap);
    });
  });
}

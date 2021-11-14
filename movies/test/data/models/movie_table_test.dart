import 'package:movies/movies.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieTable = MovieTable(
    id: 1,
    title: 'title',
    overview: 'overview',
    posterPath: 'posterPath',
    category: 'movies',
  );
  group('toJson', () {
    test('should return a JSON map containing proper data', () {
      // arrange

      // act
      final result = tMovieTable.toJson();
      // assert
      final expectedJsonMap = {
        'id': 1,
        'title': 'title',
        'overview': 'overview',
        'posterPath': 'posterPath',
        'category': 'movies',
      };
      expect(result, expectedJsonMap);
    });
  });
}

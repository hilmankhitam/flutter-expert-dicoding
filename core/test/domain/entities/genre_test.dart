import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tGenre = Genre(
    id: 1,
    name: 'name',
  );
  final tGenreList = <Genre>[tGenre];

  group('equatable', () {
    test('should equal', () {
      // arrange

      // act
      final result = [
        Genre(
          id: 1,
          name: 'name',
        ),
      ];
      // assert
      expect(result, tGenreList);
    });
  });
}

import 'package:core/common/commons.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tServerFailure = ServerFailure('Failed');
  final tConnectionFailure = ConnectionFailure('Failed');
  final tDatabaseFailure = DatabaseFailure('Failed');
  final tCommonFailure = CommonFailure('Failed');
  group('equatable', () {
    test('should equal', () {
      // arrange

      // act
      final result = ServerFailure('Failed');
      // assert
      expect(result, tServerFailure);
    });
    test('should equal', () {
      // arrange

      // act
      final result = ConnectionFailure('Failed');
      // assert
      expect(result, tConnectionFailure);
    });
    test('should equal', () {
      // arrange

      // act
      final result = DatabaseFailure('Failed');
      // assert
      expect(result, tDatabaseFailure);
    });
    test('should equal', () {
      // arrange

      // act
      final result = CommonFailure('Failed');
      // assert
      expect(result, tCommonFailure);
    });
  });
}

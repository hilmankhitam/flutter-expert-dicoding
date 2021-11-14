import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/tvseries.dart';

void main() {
  final tCreatedByModel = CreatedByModel(
    id: 1,
    creditId: 'credit_id',
    name: 'name',
    gender: 1,
    profilePath: 'profile_path',
  );

  group('toJson', () {
    test('should return a JSON map containing proper data', () {
      // arrange

      // act
      final result = tCreatedByModel.toJson();
      // assert
      final expectedJsonMap = {
        'id': 1,
        'credit_id': 'credit_id',
        'name': 'name',
        'gender': 1,
        'profile_path': 'profile_path',
      };
      expect(result, expectedJsonMap);
    });
  });
}

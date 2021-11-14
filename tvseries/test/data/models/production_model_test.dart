import 'package:tvseries/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tProductionModel = ProductionCompanyModel(
    id: 1,
    logoPath: "logo_path",
    name: "name",
    originCountry: "origin_country",
  );
  group('toJson', () {
    test('should return a JSON map containing proper data', () {
      // arrange

      // act
      final result = tProductionModel.toJson();
      // assert
      final expectedJsonMap = {
        "id": 1,
        "logo_path": "logo_path",
        "name": "name",
        "origin_country": "origin_country",
      };
      expect(result, expectedJsonMap);
    });
  });
}

import 'package:tvseries/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSpokenLanguageModel = SpokenLanguageModel(
    englishName: 'englishName',
    iso6391: 'iso6391',
    name: "name",
  );
  group('toJson', () {
    test('should return a JSON map containing proper data', () {
      // arrange

      // act
      final result = tSpokenLanguageModel.toJson();
      // assert
      final expectedJsonMap = {
        "english_name": 'englishName',
        "iso_639_1": "iso6391",
        "name": "name"
      };
      expect(result, expectedJsonMap);
    });
  });
}

import 'package:tvseries/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeasonModel = SeasonModel(
      airDate: "air_date",
      episodeCount: 1,
      id: 1,
      name: "name",
      overview: "overview",
      posterPath: "poster_path",
      seasonNumber: 1);
  group('toJson', () {
    test('should return a JSON map containing proper data', () {
      // arrange

      // act
      final result = tSeasonModel.toJson();
      // assert
      final expectedJsonMap = {
        "air_date": "air_date",
        "episode_count": 1,
        "id": 1,
        "name": "name",
        "overview": "overview",
        "poster_path": "poster_path",
        "season_number": 1
      };
      expect(result, expectedJsonMap);
    });
  });
}

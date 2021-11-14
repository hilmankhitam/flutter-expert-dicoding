import 'package:tvseries/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tLastEpisodeToAirModel = LastEpisodeToAirModel(
    airDate: DateTime.parse("2021-10-21"),
    episodeNumber: 1,
    id: 1,
    name: "name",
    overview: "overview",
    productionCode: "production_code",
    seasonNumber: 1,
    stillPath: "still_path",
    voteAverage: 8.5,
    voteCount: 1,
  );

  group('toJson', () {
    test('should return a JSON map containing proper data', () {
      // arrange

      // act
      final result = tLastEpisodeToAirModel.toJson();
      // assert
      final expectedJsonMap = {
        "air_date":
            "${tLastEpisodeToAirModel.airDate.year.toString().padLeft(4, '0')}-${tLastEpisodeToAirModel.airDate.month.toString().padLeft(2, '0')}-${tLastEpisodeToAirModel.airDate.day.toString().padLeft(2, '0')}",
        "episode_number": 1,
        "id": 1,
        "name": "name",
        "overview": "overview",
        "production_code": "production_code",
        "season_number": 1,
        "still_path": "still_path",
        "vote_average": 8.5,
        "vote_count": 1,
      };
      expect(result, expectedJsonMap);
    });
  });
}

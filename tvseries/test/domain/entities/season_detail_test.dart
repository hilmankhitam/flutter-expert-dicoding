import 'package:tvseries/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeasonDetailResponse = SeasonDetailModelResponse(
    episodes: [
      EpisodeModel(
          airDate: 'airDate',
          episodeNumber: 1,
          id: 1,
          name: 'name',
          overview: 'overview',
          productionCode: 'productionCode',
          seasonNumber: 1,
          stillPath: 'stillPath',
          voteAverage: 1.0,
          voteCount: 1)
    ],
  );
  final tSeasonDetail = SeasonDetail(
    episodes: [
      Episode(
          airDate: 'airDate',
          episodeNumber: 1,
          id: 1,
          name: 'name',
          overview: 'overview',
          productionCode: 'productionCode',
          seasonNumber: 1,
          stillPath: 'stillPath',
          voteAverage: 1.0,
          voteCount: 1)
    ],
  );
  group('toJson', () {
    test(
        'should return a SeasonDetailModelResponse JSON map containing proper data',
        () {
      // arrange

      // act
      final result = tSeasonDetailResponse.toJson();
      // assert
      final expectedJsonMap = {
        "episodes": [
          {
            'air_date': 'airDate',
            'episode_number': 1,
            'id': 1,
            'name': 'name',
            'overview': 'overview',
            'production_code': 'productionCode',
            'season_number': 1,
            'still_path': 'stillPath',
            'vote_average': 1.0,
            'vote_count': 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });

    test('should return a SeasonDetail JSON map containing proper data', () {
      // arrange

      // act
      final result = tSeasonDetail.toJson();
      // assert
      final expectedJsonMap = {
        "episodes": [
          {
            'air_date': 'airDate',
            'episode_number': 1,
            'id': 1,
            'name': 'name',
            'overview': 'overview',
            'production_code': 'productionCode',
            'season_number': 1,
            'still_path': 'stillPath',
            'vote_average': 1.0,
            'vote_count': 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}

import 'package:tvseries/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tEpisode = Episode(
      airDate: 'airDate',
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      productionCode: 'productionCode',
      seasonNumber: 1,
      stillPath: 'stillPath',
      voteAverage: 1.0,
      voteCount: 1);

  final tEpisodeList = <Episode>[tEpisode];

  group('toJson', () {
    test('should return a JSON map containing proper data', () {
      // arrange

      // act
      final result = tEpisode.toJson();
      // assert
      final expectedJsonMap = {
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
      };
      expect(result, expectedJsonMap);
    });
  });

  group('equatable', () {
    test('should equal', () {
      // arrange

      // act
      final result = [
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
      ];
      // assert
      expect(result, tEpisodeList);
    });
  });
}

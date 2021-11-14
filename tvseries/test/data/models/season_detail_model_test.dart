import 'package:tvseries/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeasonDetailModel = SeasonDetailModelResponse(episodes: [
    EpisodeModel(
        airDate: "airDate",
        episodeNumber: 1,
        id: 1,
        name: "name",
        overview: "overview",
        productionCode: "productionCode",
        seasonNumber: 1,
        stillPath: "stillPath",
        voteAverage: 5.1,
        voteCount: 1)
  ]);

  final tSeasonDetailToEntity = tSeasonDetailModel.toEntity();

  group('equatable', () {
    test('should equal', () {
      // arrange

      // act
      final result = SeasonDetailModelResponse(episodes: [
        EpisodeModel(
            airDate: "airDate",
            episodeNumber: 1,
            id: 1,
            name: "name",
            overview: "overview",
            productionCode: "productionCode",
            seasonNumber: 1,
            stillPath: "stillPath",
            voteAverage: 5.1,
            voteCount: 1)
      ]);
      // assert
      expect(result, tSeasonDetailModel);
    });
  });

  group('toEntity', () {
    test('Should change to entity', () {
      // arrange

      // act
      final result = SeasonDetail(episodes: [
        Episode(
            airDate: "airDate",
            episodeNumber: 1,
            id: 1,
            name: "name",
            overview: "overview",
            productionCode: "productionCode",
            seasonNumber: 1,
            stillPath: "stillPath",
            voteAverage: 5.1,
            voteCount: 1)
      ]);
      // assert
      expect(result, tSeasonDetailToEntity);
    });
  });
}

import 'package:core/core.dart';
import 'package:tvseries/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTVSeriesDetailModel = TVSeriesDetailResponse(
      backdropPath: "backdropPath",
      createdBy: [
        CreatedByModel(
            id: 1,
            creditId: "creditId",
            name: "name",
            gender: 1,
            profilePath: "profilePath")
      ],
      episodeRunTime: [10, 10],
      firstAirDate: DateTime.parse("2021-10-21"),
      genres: [GenreModel(id: 1, name: "name")],
      homepage: "homepage",
      id: 1,
      inProduction: true,
      languages: ["languages"],
      lastAirDate: DateTime.parse("2021-10-21"),
      lastEpisodeToAir: LastEpisodeToAirModel(
          airDate: DateTime.parse("2021-10-21"),
          episodeNumber: 1,
          id: 1,
          name: "name",
          overview: "overview",
          productionCode: "",
          seasonNumber: 1,
          stillPath: "stillPath",
          voteAverage: 5.0,
          voteCount: 1),
      name: "name",
      nextEpisodeToAir: "nextEpisodeToAir",
      networks: [
        NetworkModel(
            name: "name",
            id: 1,
            logoPath: "logoPath",
            originCountry: "originCountry")
      ],
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      originCountry: ["originCountry"],
      originalLanguage: "originalLanguage",
      originalName: "originalName",
      overview: "overview",
      popularity: 5.0,
      posterPath: "posterPath",
      productionCompanies: [
        ProductionCompanyModel(
            id: 1,
            logoPath: "logoPath",
            name: "name",
            originCountry: "originCountry")
      ],
      productionCountries: [
        ProductionCountryModel(iso31661: "iso31661", name: "name")
      ],
      seasons: [
        SeasonModel(
            airDate: "airDate",
            episodeCount: 1,
            id: 1,
            name: "name",
            overview: "overview",
            posterPath: "posterPath",
            seasonNumber: 1)
      ],
      spokenLanguages: [
        SpokenLanguageModel(
            englishName: "englishName", iso6391: "iso6391", name: "name")
      ],
      status: "status",
      tagline: "tagline",
      type: "type",
      voteAverage: 5.0,
      voteCount: 1);
  group('toJson', () {
    test('should return a JSON map containing proper data', () {
      // arrange

      // act
      final result = tTVSeriesDetailModel.toJson();
      // assert
      final expectedJsonMap = {
        "backdrop_path": "backdropPath",
        "created_by": [
          {
            'id': 1,
            'credit_id': "creditId",
            'name': "name",
            'gender': 1,
            'profile_path': "profilePath",
          }
        ],
        "episode_run_time": [10, 10],
        "first_air_date":
            "${tTVSeriesDetailModel.firstAirDate.year.toString().padLeft(4, '0')}-${tTVSeriesDetailModel.firstAirDate.month.toString().padLeft(2, '0')}-${tTVSeriesDetailModel.firstAirDate.day.toString().padLeft(2, '0')}",
        "genres": [
          {
            "id": 1,
            "name": "name",
          }
        ],
        "homepage": "homepage",
        "id": 1,
        "in_production": true,
        "languages": ["languages"],
        "last_air_date":
            "${tTVSeriesDetailModel.lastAirDate.year.toString().padLeft(4, '0')}-${tTVSeriesDetailModel.lastAirDate.month.toString().padLeft(2, '0')}-${tTVSeriesDetailModel.lastAirDate.day.toString().padLeft(2, '0')}",
        "last_episode_to_air": {
          "air_date":
              "${tTVSeriesDetailModel.lastEpisodeToAir.airDate.year.toString().padLeft(4, '0')}-${tTVSeriesDetailModel.lastEpisodeToAir.airDate.month.toString().padLeft(2, '0')}-${tTVSeriesDetailModel.lastEpisodeToAir.airDate.day.toString().padLeft(2, '0')}",
          "episode_number": 1,
          "id": 1,
          "name": "name",
          "overview": "overview",
          "production_code": "",
          "season_number": 1,
          "still_path": "stillPath",
          "vote_average": 5.0,
          "vote_count": 1,
        },
        "name": "name",
        "next_episode_to_air": "nextEpisodeToAir",
        "networks": [
          {
            "name": "name",
            "id": 1,
            "logo_path": "logoPath",
            "origin_country": "originCountry",
          }
        ],
        "number_of_episodes": 1,
        "number_of_seasons": 1,
        "origin_country": ["originCountry"],
        "original_language": "originalLanguage",
        "original_name": "originalName",
        "overview": "overview",
        "popularity": 5.0,
        "poster_path": "posterPath",
        "production_companies": [
          {
            "id": 1,
            "logo_path": "logoPath",
            "name": "name",
            "origin_country": "originCountry",
          }
        ],
        "production_countries": [
          {
            "iso_3166_1": "iso31661",
            "name": "name",
          }
        ],
        "seasons": [
          {
            "air_date": "airDate",
            "episode_count": 1,
            "id": 1,
            "name": "name",
            "overview": "overview",
            "poster_path": "posterPath",
            "season_number": 1,
          }
        ],
        "spoken_languages": [
          {
            "english_name": "englishName",
            "iso_639_1": "iso6391",
            "name": "name"
          }
        ],
        "status": "status",
        "tagline": "tagline",
        "type": "type",
        "vote_average": 5.0,
        "vote_count": 1,
      };
      expect(result, expectedJsonMap);
    });
  });
}

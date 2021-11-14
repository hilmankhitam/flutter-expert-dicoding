import 'package:core/core.dart';
import 'package:movies/movies.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieDetailModelModel = MovieDetailResponse(
    adult: true,
    backdropPath: "backdrop_path",
    budget: 1,
    genres: [GenreModel(id: 1, name: "name")],
    homepage: "homepage",
    id: 1,
    imdbId: "imdb_id",
    originalLanguage: "original_language",
    originalTitle: "original_title",
    overview: "overview",
    popularity: 5.1,
    posterPath: "poster_path",
    releaseDate: "release_date",
    revenue: 1,
    runtime: 50,
    status: "status",
    tagline: "tagline",
    title: "title",
    video: true,
    voteAverage: 5.1,
    voteCount: 1,
  );
  group('toJson', () {
    test('should return a JSON map containing proper data', () {
      // arrange

      // act
      final result = tMovieDetailModelModel.toJson();
      // assert
      final expectedJsonMap = {
        "adult": true,
        "backdrop_path": "backdrop_path",
        "budget": 1,
        "genres": [
          {"id": 1, "name": "name"}
        ],
        "homepage": "homepage",
        "id": 1,
        "imdb_id": "imdb_id",
        "original_language": "original_language",
        "original_title": "original_title",
        "overview": "overview",
        "popularity": 5.1,
        "poster_path": "poster_path",
        "release_date": "release_date",
        "revenue": 1,
        "runtime": 50,
        "status": "status",
        "tagline": "tagline",
        "title": "title",
        "video": true,
        "vote_average": 5.1,
        "vote_count": 1,
      };
      expect(result, expectedJsonMap);
    });
  });
}

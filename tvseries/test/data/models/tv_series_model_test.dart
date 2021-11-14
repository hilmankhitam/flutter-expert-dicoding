import 'package:tvseries/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTVSeriesModel = TVSeriesModel(
    posterPath: 'posterpath.jpg',
    popularity: 5.04,
    id: 1,
    backdropPath: 'backdroppath.jpg',
    voteAverage: 5.19,
    overview: 'overview',
    firstAirDate: 'firstAirDate',
    originCountry: ['ID', 'EU', 'US'],
    genreIds: [1, 2, 3],
    originalLanguage: 'originalLanguage',
    voteCount: 123,
    name: 'name',
    originalName: 'originalName',
  );

  final tTVSeries = TVSeries(
    posterPath: 'posterpath.jpg',
    popularity: 5.04,
    id: 1,
    backdropPath: 'backdroppath.jpg',
    voteAverage: 5.19,
    overview: 'overview',
    firstAirDate: 'firstAirDate',
    originCountry: ['ID', 'EU', 'US'],
    genreIds: [1, 2, 3],
    originalLanguage: 'originalLanguage',
    voteCount: 123,
    name: 'name',
    originalName: 'originalName',
  );

  test('should be a subclass of TV Series entity', () async {
    final result = tTVSeriesModel.toEntity();
    expect(result, tTVSeries);
  });
}

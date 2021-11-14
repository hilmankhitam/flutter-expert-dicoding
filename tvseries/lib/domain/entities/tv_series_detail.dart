part of 'entities.dart';

class TVSeriesDetail extends Equatable {
  TVSeriesDetail({
    required this.backdropPath,
    required this.episodeRunTime,
    required this.genres,
    required this.id,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.seasons,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final List<int>? episodeRunTime;
  final List<Genre>? genres;
  final int id;
  final String? name;
  final String? originalName;
  final String? overview;
  final String? posterPath;
  final List<Season>? seasons;
  final double? voteAverage;
  final int? voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        episodeRunTime,
        genres,
        id,
        name,
        originalName,
        overview,
        posterPath,
        seasons,
        voteAverage,
        voteCount,
      ];
}

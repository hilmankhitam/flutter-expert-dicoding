part of 'models.dart';

class TVSeriesTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final String? category;

  TVSeriesTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    this.category = 'tvSeries',
  });

  factory TVSeriesTable.fromEntity(TVSeriesDetail tvSeries) => TVSeriesTable(
        id: tvSeries.id,
        title: tvSeries.name,
        posterPath: tvSeries.posterPath,
        overview: tvSeries.overview,
        category: 'tvSeries',
      );

  factory TVSeriesTable.fromMap(Map<String, dynamic> map) => TVSeriesTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        category: map['category'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'category': category,
      };

  TVSeries toEntity() => TVSeries.watchlist(
        id: id,
        name: title,
        overview: overview,
        posterPath: posterPath,
      );
  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        posterPath,
        category,
      ];
}

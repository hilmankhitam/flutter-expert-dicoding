part of 'entities.dart';

class SeasonDetail extends Equatable {
  SeasonDetail({
    required this.episodes,
  });

  final List<Episode> episodes;

  Map<String, dynamic> toJson() => {
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [episodes];
}

part of 'models.dart';

class SeasonDetailModelResponse extends Equatable {
  SeasonDetailModelResponse({
    required this.episodes,
  });

  final List<EpisodeModel> episodes;

  factory SeasonDetailModelResponse.fromJson(Map<String, dynamic> json) =>
      SeasonDetailModelResponse(
        episodes: List<EpisodeModel>.from(
            json["episodes"].map((x) => EpisodeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
      };

  SeasonDetail toEntity() {
    return SeasonDetail(
      episodes: this.episodes.map((episode) => episode.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [episodes];
}

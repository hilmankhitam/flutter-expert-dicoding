part of 'recommendations_tv_series_bloc.dart';

abstract class RecommendationsTVSeriesEvent extends Equatable {
  const RecommendationsTVSeriesEvent();
}

class FetchRecommendations extends RecommendationsTVSeriesEvent {
  final int id;

  FetchRecommendations(this.id);

  @override
  List<Object> get props => [id];
}

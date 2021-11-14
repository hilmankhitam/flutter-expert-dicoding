part of 'recommendations_tv_series_bloc.dart';

abstract class RecommendationsTVSeriesState extends Equatable {
  const RecommendationsTVSeriesState();

  @override
  List<Object> get props => [];
}

class GetRecommendationTVSeriesState extends RecommendationsTVSeriesState {
  final List<TVSeries> tvSeries;

  GetRecommendationTVSeriesState(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class RecommendationLoading extends RecommendationsTVSeriesState {}

class RecommendationTVSeriesError extends RecommendationsTVSeriesState {
  final String message;

  RecommendationTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

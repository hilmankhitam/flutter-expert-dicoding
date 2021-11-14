part of 'populartvseries_bloc.dart';

abstract class PopularTVSeriesState extends Equatable {
  const PopularTVSeriesState();

  @override
  List<Object> get props => [];
}

class GetPopularTVSeriesState extends PopularTVSeriesState {
  final List<TVSeries> tvSeries;

  GetPopularTVSeriesState(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class PopularTVSeriesLoading extends PopularTVSeriesState {}

class PopularTVSeriesError extends PopularTVSeriesState {
  final String message;

  PopularTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

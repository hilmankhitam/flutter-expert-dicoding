part of 'topratedtvseries_bloc.dart';

abstract class TopRatedTVSeriesState extends Equatable {
  const TopRatedTVSeriesState();
  
  @override
  List<Object> get props => [];
}

class GetTopRatedTVSeriesState extends TopRatedTVSeriesState {
  final List<TVSeries> tvSeries;

  GetTopRatedTVSeriesState(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class TopRatedTVSeriesLoading extends TopRatedTVSeriesState {}

class TopRatedTVSeriesError extends TopRatedTVSeriesState {
  final String message;

  TopRatedTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

part of 'tv_series_detail_bloc.dart';

abstract class TVSeriesDetailState extends Equatable {
  const TVSeriesDetailState();

  @override
  List<Object> get props => [];
}

class GetTVSeriesDetailState extends TVSeriesDetailState {
  final TVSeriesDetail tvSeries;

  GetTVSeriesDetailState(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class TVSeriesDetailLoading extends TVSeriesDetailState {}

class TVSeriesDetailError extends TVSeriesDetailState {
  final String message;

  TVSeriesDetailError(this.message);

  @override
  List<Object> get props => [message];
}

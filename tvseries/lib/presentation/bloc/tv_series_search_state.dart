part of 'tv_series_search_bloc.dart';

abstract class TVSeriesSearchState extends Equatable {
  const TVSeriesSearchState();
  
  @override
  List<Object> get props => [];
}

class TVSeriesSearchStateEmpty extends TVSeriesSearchState {}

class TVSeriesSearchStateLoading extends TVSeriesSearchState {}

class TVSeriesSearchStateSuccess extends TVSeriesSearchState {
  final List<TVSeries> tvSeries;

  const TVSeriesSearchStateSuccess(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class TVSeriesSearchStateError extends TVSeriesSearchState {
  final String message;

  const TVSeriesSearchStateError(this.message);

  @override
  List<Object> get props => [message];
}
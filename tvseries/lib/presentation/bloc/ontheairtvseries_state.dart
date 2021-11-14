part of 'ontheairtvseries_bloc.dart';

abstract class OnTheAirTVSeriesState extends Equatable {
  const OnTheAirTVSeriesState();

  @override
  List<Object> get props => [];
}

class GetOnTheAirTVSeriesState extends OnTheAirTVSeriesState {
  final List<TVSeries> tvSeries;

  GetOnTheAirTVSeriesState(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class OnTheAirTVSeriesLoading extends OnTheAirTVSeriesState {}

class OnTheAirTVSeriesError extends OnTheAirTVSeriesState {
  final String message;

  OnTheAirTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

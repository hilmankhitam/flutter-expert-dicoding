part of 'topratedtvseries_bloc.dart';

abstract class TopRatedTVSeriesEvent extends Equatable {
  const TopRatedTVSeriesEvent();

}

class FetchTopRatedTVSeries extends TopRatedTVSeriesEvent {
  @override
  List<Object> get props => [];
}
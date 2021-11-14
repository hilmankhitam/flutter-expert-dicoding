part of 'tv_series_detail_bloc.dart';

abstract class TVSeriesDetailEvent extends Equatable {
  const TVSeriesDetailEvent();
}

class FetchTVSeriesDetail extends TVSeriesDetailEvent {
  final int id;

  FetchTVSeriesDetail(this.id);

  @override
  List<Object> get props => [id];
}

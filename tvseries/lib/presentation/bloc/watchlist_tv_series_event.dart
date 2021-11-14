part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTVSeriesEvent extends Equatable {
  const WatchlistTVSeriesEvent();

  @override
  List<Object> get props => [];
}

class StartWatchlistTVSeries extends WatchlistTVSeriesEvent {
  @override
  List<Object> get props => [];
}

class AddWatchlistTVSeries extends WatchlistTVSeriesEvent {
  final TVSeriesDetail tvSeries;

  const AddWatchlistTVSeries(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class RemoveWatchlistTVSeries extends WatchlistTVSeriesEvent {
  final TVSeriesDetail tvSeries;

  const RemoveWatchlistTVSeries(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class LoadWatchlistTVSeriesStatus extends WatchlistTVSeriesEvent {
  final int id;

  const LoadWatchlistTVSeriesStatus(this.id);

  @override
  List<Object> get props => [id];
}

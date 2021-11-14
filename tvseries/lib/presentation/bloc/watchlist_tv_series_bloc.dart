import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:tvseries/domain/entities/entities.dart';
import 'package:tvseries/domain/usecases/usecases.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTVSeriesBloc
    extends Bloc<WatchlistTVSeriesEvent, WatchlistTVSeriesState> {
  WatchlistTVSeriesBloc({
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.getWatchlistTVSeries,
  }) : super(WatchlistTVSeriesLoading());

  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchlistTVSeries getWatchlistTVSeries;

  @override
  Stream<WatchlistTVSeriesState> mapEventToState(
    WatchlistTVSeriesEvent event,
  ) async* {
    if (event is StartWatchlistTVSeries) {
      yield WatchlistTVSeriesLoading();
      try {
        final result = await getWatchlistTVSeries.execute();
        yield* result.fold((failure) async* {
          yield WatchlistTVSeriesError(failure.message);
        }, (tvSeries) async* {
          yield WatchlistTVSeriesLoaded(tvSeries: tvSeries);
        });
      } catch (error) {
        yield WatchlistTVSeriesError(error.toString());
      }
    } else if (event is AddWatchlistTVSeries) {
      await saveWatchlist.executeTVSeries(event.tvSeries);

      final result = await getWatchlistTVSeries.execute();

      yield* result.fold((failure) async* {}, (tvSeries) async* {
        yield WatchlistTVSeriesLoaded(tvSeries: tvSeries);
      });
      final resultIsAdded =
          await getWatchListStatus.executeTVSeries(event.tvSeries.id);
      yield GetWatchlistTVSeriesStatus(resultIsAdded);
    } else if (event is RemoveWatchlistTVSeries) {
      try {
        await removeWatchlist.executeTVSeries(event.tvSeries);

        final result = await getWatchlistTVSeries.execute();
        yield* result.fold((failure) async* {}, (tvSeries) async* {
          yield WatchlistTVSeriesLoaded(tvSeries: tvSeries);
        });
        final resultIsAdded =
            await getWatchListStatus.executeTVSeries(event.tvSeries.id);
        yield GetWatchlistTVSeriesStatus(resultIsAdded);
      } catch (_) {}
    } else if (event is LoadWatchlistTVSeriesStatus) {
      final result = await getWatchListStatus.executeTVSeries(event.id);
      yield GetWatchlistTVSeriesStatus(result);
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:tvseries/domain/entities/entities.dart';
import 'package:tvseries/domain/usecases/usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'tv_series_search_event.dart';
part 'tv_series_search_state.dart';

class TVSeriesSearchBloc
    extends Bloc<TVSeriesSearchEvent, TVSeriesSearchState> {
  TVSeriesSearchBloc({required this.searchTVSeries})
      : super(TVSeriesSearchStateEmpty());

  final SearchTVSeries searchTVSeries;

  @override
  Stream<Transition<TVSeriesSearchEvent, TVSeriesSearchState>> transformEvents(
    Stream<TVSeriesSearchEvent> events,
    Stream<Transition<TVSeriesSearchEvent, TVSeriesSearchState>> Function(
      TVSeriesSearchEvent event,
    )
        transitionFn,
  ) {
    return events
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap(transitionFn);
  }

  @override
  Stream<TVSeriesSearchState> mapEventToState(
    TVSeriesSearchEvent event,
  ) async* {
    if (event is TVSeriesTextChanged) {
      final search = event.text;
      if (search.isEmpty) {
        yield TVSeriesSearchStateEmpty();
      } else {
        yield TVSeriesSearchStateLoading();
        try {
          final result = await searchTVSeries.execute(search);
          yield* result.fold((failure) async* {
            yield TVSeriesSearchStateError(failure.message);
          }, (tvSeries) async* {
            yield TVSeriesSearchStateSuccess(tvSeries);
          });
        } catch (error) {
          yield TVSeriesSearchStateError(error.toString());
        }
      }
    }
  }
}

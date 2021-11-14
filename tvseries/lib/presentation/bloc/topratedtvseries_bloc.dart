import 'package:bloc/bloc.dart';
import 'package:tvseries/domain/entities/entities.dart';
import 'package:tvseries/domain/usecases/usecases.dart';
import 'package:equatable/equatable.dart';

part 'topratedtvseries_event.dart';
part 'topratedtvseries_state.dart';

class TopRatedTVSeriesBloc
    extends Bloc<TopRatedTVSeriesEvent, TopRatedTVSeriesState> {
  TopRatedTVSeriesBloc({required this.getTopRatedTVSeries})
      : super(TopRatedTVSeriesLoading());

  final GetTopRatedTVSeries getTopRatedTVSeries;

  @override
  Stream<TopRatedTVSeriesState> mapEventToState(
      TopRatedTVSeriesEvent event) async* {
    if (event is FetchTopRatedTVSeries) {
      yield TopRatedTVSeriesLoading();
      try {
        final result = await getTopRatedTVSeries.execute();
        yield* result.fold((failure) async* {
          yield TopRatedTVSeriesError(failure.message);
        }, (movies) async* {
          yield GetTopRatedTVSeriesState(movies);
        });
      } catch (error) {
        yield TopRatedTVSeriesError(error.toString());
      }
    }
  }
}

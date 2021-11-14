import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/entities.dart';
import 'package:tvseries/domain/usecases/usecases.dart';

part 'ontheairtvseries_event.dart';
part 'ontheairtvseries_state.dart';

class OnTheAirTVSeriesBloc
    extends Bloc<OnTheAirTVSeriesEvent, OnTheAirTVSeriesState> {
  OnTheAirTVSeriesBloc({required this.getOnTheAirTVSeries})
      : super(OnTheAirTVSeriesLoading());

  final GetOnTheAirTVSeries getOnTheAirTVSeries;

  @override
  Stream<OnTheAirTVSeriesState> mapEventToState(
      OnTheAirTVSeriesEvent event) async* {
    if (event is FetchOnTheAirTVSeries) {
      yield OnTheAirTVSeriesLoading();
      try {
        final result = await getOnTheAirTVSeries.execute();
        yield* result.fold((failure) async* {
          yield OnTheAirTVSeriesError(failure.message);
        }, (tvSeries) async* {
          yield GetOnTheAirTVSeriesState(tvSeries);
        });
      } catch (error) {
        yield OnTheAirTVSeriesError(error.toString());
      }
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:tvseries/domain/entities/entities.dart';
import 'package:tvseries/domain/usecases/usecases.dart';
import 'package:equatable/equatable.dart';

part 'populartvseries_event.dart';
part 'populartvseries_state.dart';

class PopularTVSeriesBloc
    extends Bloc<PopularTVSeriesEvent, PopularTVSeriesState> {
  PopularTVSeriesBloc({required this.getPopularTVSeries})
      : super(PopularTVSeriesLoading());

  final GetPopularTVSeries getPopularTVSeries;

  @override
  Stream<PopularTVSeriesState> mapEventToState(
      PopularTVSeriesEvent event) async* {
    if (event is FetchPopularTVSeries) {
      yield PopularTVSeriesLoading();
      try {
        final result = await getPopularTVSeries.execute();
        yield* result.fold((failure) async* {
          yield PopularTVSeriesError(failure.message);
        }, (tvSeries) async* {
          yield GetPopularTVSeriesState(tvSeries);
        });
      } catch (error) {
        yield PopularTVSeriesError(error.toString());
      }
    }
  }
}

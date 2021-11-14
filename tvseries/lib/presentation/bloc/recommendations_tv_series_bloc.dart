import 'package:bloc/bloc.dart';
import 'package:tvseries/domain/entities/entities.dart';
import 'package:tvseries/domain/usecases/usecases.dart';
import 'package:equatable/equatable.dart';

part 'recommendations_tv_series_event.dart';
part 'recommendations_tv_series_state.dart';

class RecommendationsTVSeriesBloc
    extends Bloc<RecommendationsTVSeriesEvent, RecommendationsTVSeriesState> {
  RecommendationsTVSeriesBloc({
    required this.getTVSeriesRecommendations,
  }) : super(RecommendationLoading());

  final GetTVSeriesRecommendations getTVSeriesRecommendations;

  @override
  Stream<RecommendationsTVSeriesState> mapEventToState(
      RecommendationsTVSeriesEvent event) async* {
    if (event is FetchRecommendations) {
      try {
        final recommendationResult =
            await getTVSeriesRecommendations.execute(event.id);

        yield* recommendationResult.fold((failure) async* {
          yield RecommendationTVSeriesError(failure.message);
        }, (tvSeries) async* {
          yield GetRecommendationTVSeriesState(tvSeries);
        });
      } catch (error) {
        yield RecommendationTVSeriesError(error.toString());
      }
    }
  }
}

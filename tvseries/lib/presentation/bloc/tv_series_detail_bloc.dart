import 'package:bloc/bloc.dart';
import 'package:tvseries/domain/entities/entities.dart';
import 'package:tvseries/domain/usecases/usecases.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TVSeriesDetailBloc
    extends Bloc<TVSeriesDetailEvent, TVSeriesDetailState> {
  TVSeriesDetailBloc({
    required this.getTVSeriesDetail,
    required this.getSeasonDetail,
  }) : super(TVSeriesDetailLoading());

  final GetTVSeriesDetail getTVSeriesDetail;
  final GetSeasonDetail getSeasonDetail;

  @override
  Stream<TVSeriesDetailState> mapEventToState(
      TVSeriesDetailEvent event) async* {
    TVSeriesDetail detail;
    if (event is FetchTVSeriesDetail) {
      yield TVSeriesDetailLoading();
      try {
        final detailResult = await getTVSeriesDetail.execute(event.id);

        yield* detailResult.fold((failure) async* {
          yield TVSeriesDetailError(failure.message);
        }, (tvSeries) async* {
          detail = tvSeries;
          for (int index = 0; index < tvSeries.seasons!.length; index++) {
            final detailSeason = await getSeasonDetail.execute(
                event.id, tvSeries.seasons![index].seasonNumber);

            yield* detailSeason.fold((failure) async* {}, (episodes) async* {
              detail.seasons![index].episodes = episodes;
            });
          }

          yield GetTVSeriesDetailState(detail);
        });
      } catch (error) {
        yield TVSeriesDetailError(error.toString());
      }
    }
  }
}

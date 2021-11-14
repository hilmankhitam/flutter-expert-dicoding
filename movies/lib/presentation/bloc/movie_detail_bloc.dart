import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/entities.dart';
import 'package:movies/domain/usecases/usecases.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc({
    required this.getMovieDetail,
  }) : super(MovieDetailLoading());

  final GetMovieDetail getMovieDetail;

  @override
  Stream<MovieDetailState> mapEventToState(MovieDetailEvent event) async* {
    if (event is FetchMovieDetail) {
      yield MovieDetailLoading();
      try {
        final detailResult = await getMovieDetail.execute(event.id);

        yield* detailResult.fold((failure) async* {
          yield MovieDetailError(failure.message);
        }, (movie) async* {
          yield GetMovieDetailState(movie);
        });
      } catch (error) {
        yield MovieDetailError(error.toString());
      }
    }
  }
}

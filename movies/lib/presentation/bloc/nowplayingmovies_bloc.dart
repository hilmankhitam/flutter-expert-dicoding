import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/entities.dart';
import 'package:movies/domain/usecases/usecases.dart';

part 'nowplayingmovies_event.dart';
part 'nowplayingmovies_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  NowPlayingMoviesBloc({
    required this.getNowPlayingMovies,
  }) : super(NowPlayingMoviesLoading());

  final GetNowPlayingMovies getNowPlayingMovies;

  @override
  Stream<NowPlayingMoviesState> mapEventToState(
      NowPlayingMoviesEvent event) async* {
    if (event is FetchNowPlayingMovies) {
      yield NowPlayingMoviesLoading();
      try {
        final result = await getNowPlayingMovies.execute();
        yield* result.fold((failure) async* {
          yield NowPlayingMoviesError(failure.message);
        }, (movies) async* {
          yield GetNowPlayingMoviesState(movies);
        });
      } catch (error) {
        yield NowPlayingMoviesError(error.toString());
      }
    }
  }
}

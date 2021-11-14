import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/entities.dart';
import 'package:movies/domain/usecases/usecases.dart';

part 'topratedmovies_event.dart';
part 'topratedmovies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  TopRatedMoviesBloc({required this.getTopRatedMovies})
      : super(TopRatedMoviesLoading());

  final GetTopRatedMovies getTopRatedMovies;

  @override
  Stream<TopRatedMoviesState> mapEventToState(
      TopRatedMoviesEvent event) async* {
    if (event is FetchTopRatedMovies) {
      yield TopRatedMoviesLoading();
      try {
        final result = await getTopRatedMovies.execute();
        yield* result.fold((failure) async* {
          yield TopRatedMoviesError(failure.message);
        }, (movies) async* {
          yield GetTopRatedMoviesState(movies);
        });
      } catch (error) {
        yield TopRatedMoviesError(error.toString());
      }
    }
  }
}

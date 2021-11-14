import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/entities.dart';
import 'package:movies/domain/usecases/usecases.dart';

part 'popularmovies_event.dart';
part 'popularmovies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  PopularMoviesBloc({required this.getPopularMovies})
      : super(PopularMoviesLoading());
  final GetPopularMovies getPopularMovies;

  @override
  Stream<PopularMoviesState> mapEventToState(PopularMoviesEvent event) async* {
    if (event is FetchPopularMovies) {
      yield PopularMoviesLoading();
      try {
        final result = await getPopularMovies.execute();
        yield* result.fold((failure) async* {
          yield PopularMoviesError(failure.message);
        }, (movies) async* {
          yield GetPopularMoviesState(movies);
        });
      } catch (error) {
        yield PopularMoviesError(error.toString());
      }
    }
  }
}

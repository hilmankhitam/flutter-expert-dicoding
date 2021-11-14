import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/entities.dart';
import 'package:movies/domain/usecases/usecases.dart';
import 'package:rxdart/rxdart.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  MovieSearchBloc({required this.searchMovies})
      : super(MovieSearchStateEmpty());

  final SearchMovies searchMovies;

  @override
  Stream<Transition<MovieSearchEvent, MovieSearchState>> transformEvents(
    Stream<MovieSearchEvent> events,
    Stream<Transition<MovieSearchEvent, MovieSearchState>> Function(
      MovieSearchEvent event,
    )
        transitionFn,
  ) {
    return events
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap(transitionFn);
  }

  @override
  Stream<MovieSearchState> mapEventToState(
    MovieSearchEvent event,
  ) async* {
    if (event is MovieTextChanged) {
      final search = event.text;
      if (search.isEmpty) {
        yield MovieSearchStateEmpty();
      } else {
        yield MovieSearchStateLoading();
        try {
          final result = await searchMovies.execute(search);
          yield* result.fold((failure) async* {
            yield MovieSearchStateError(failure.message);
          }, (movies) async* {
            yield MovieSearchStateSuccess(movies);
          });
        } catch (error) {
          yield MovieSearchStateError(error.toString());
        }
      }
    }
  }
}

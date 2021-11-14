import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:core/core.dart';
import 'package:movies/domain/entities/entities.dart';
import 'package:movies/domain/usecases/usecases.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  WatchlistMoviesBloc({
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.getWatchlistMovies,
  }) : super(WatchlistMoviesLoading());

  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchlistMovies getWatchlistMovies;

  @override
  Stream<WatchlistMoviesState> mapEventToState(
    WatchlistMoviesEvent event,
  ) async* {
    if (event is StartWatchlistMovies) {
      yield WatchlistMoviesLoading();
      try {
        final result = await getWatchlistMovies.execute();
        yield* result.fold((failure) async* {
          yield WatchlistMoviesError(failure.message);
        }, (movies) async* {
          yield WatchlistMoviesLoaded(movies: movies);
        });
      } catch (error) {
        yield WatchlistMoviesError(error.toString());
      }
    } else if (event is AddWatchlistMovie) {
      await saveWatchlist.executeMovies(event.movie);

      final result = await getWatchlistMovies.execute();

      yield* result.fold((failure) async* {}, (movies) async* {
        yield WatchlistMoviesLoaded(movies: movies);
      });
      final resultIsAdded =
          await getWatchListStatus.executeMovies(event.movie.id);
      yield GetWatchlistMovieStatus(resultIsAdded);
    } else if (event is RemoveWatchlistMovie) {
      try {
        await removeWatchlist.executeMovies(event.movie);

        final result = await getWatchlistMovies.execute();
        yield* result.fold((failure) async* {}, (movies) async* {
          yield WatchlistMoviesLoaded(movies: movies);
        });
        final resultIsAdded =
            await getWatchListStatus.executeMovies(event.movie.id);
        yield GetWatchlistMovieStatus(resultIsAdded);
      } catch (_) {}
    } else if (event is LoadWatchlistMovieStatus) {
      final result = await getWatchListStatus.executeMovies(event.id);
      yield GetWatchlistMovieStatus(result);
    }
  }
}

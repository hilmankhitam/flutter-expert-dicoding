part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesEvent extends Equatable {
  const WatchlistMoviesEvent();

  @override
  List<Object> get props => [];
}

class StartWatchlistMovies extends WatchlistMoviesEvent {
  @override
  List<Object> get props => [];
}

class AddWatchlistMovie extends WatchlistMoviesEvent {
  final MovieDetail movie;

  const AddWatchlistMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveWatchlistMovie extends WatchlistMoviesEvent {
  final MovieDetail movie;

  const RemoveWatchlistMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class LoadWatchlistMovieStatus extends WatchlistMoviesEvent {
  final int id;

  const LoadWatchlistMovieStatus(this.id);

  @override
  List<Object> get props => [id];
}

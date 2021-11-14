part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesState extends Equatable {
  const WatchlistMoviesState();

  @override
  List<Object> get props => [];
}

class WatchlistMoviesLoading extends WatchlistMoviesState {}

class WatchlistMoviesLoaded extends WatchlistMoviesState {
  final List<Movie> movies;

  const WatchlistMoviesLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class WatchlistMoviesError extends WatchlistMoviesState {
  final String message;

  const WatchlistMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class GetWatchlistMovieStatus extends WatchlistMoviesState {
  final bool status;

  const GetWatchlistMovieStatus(this.status);

  @override
  List<Object> get props => [status];
}

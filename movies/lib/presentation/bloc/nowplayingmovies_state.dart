part of 'nowplayingmovies_bloc.dart';

abstract class NowPlayingMoviesState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetNowPlayingMoviesState extends NowPlayingMoviesState {
  final List<Movie> movies;

  GetNowPlayingMoviesState(this.movies);

  @override
  List<Object> get props => [movies];
}

class NowPlayingMoviesLoading extends NowPlayingMoviesState {}

class NowPlayingMoviesError extends NowPlayingMoviesState {
  final String message;

  NowPlayingMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

part of 'topratedmovies_bloc.dart';

abstract class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState();
  
  @override
  List<Object> get props => [];
}


class GetTopRatedMoviesState extends TopRatedMoviesState {
  final List<Movie> movies;

  GetTopRatedMoviesState(this.movies);

  @override
  List<Object> get props => [movies];
}

class TopRatedMoviesLoading extends TopRatedMoviesState {}

class TopRatedMoviesError extends TopRatedMoviesState {
  final String message;

  TopRatedMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

part of 'popularmovies_bloc.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

class GetPopularMoviesState extends PopularMoviesState {
  final List<Movie> movies;

  GetPopularMoviesState(this.movies);

  @override
  List<Object> get props => [movies];
}

class PopularMoviesLoading extends PopularMoviesState {}

class PopularMoviesError extends PopularMoviesState {
  final String message;

  PopularMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

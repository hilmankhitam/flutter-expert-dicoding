part of 'movie_search_bloc.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

class MovieSearchStateEmpty extends MovieSearchState {}

class MovieSearchStateLoading extends MovieSearchState {}

class MovieSearchStateSuccess extends MovieSearchState {
  final List<Movie> movies;

  const MovieSearchStateSuccess(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieSearchStateError extends MovieSearchState {
  final String message;

  const MovieSearchStateError(this.message);

  @override
  List<Object> get props => [message];
}

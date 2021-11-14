part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();
  
  @override
  List<Object> get props => [];
}

class GetMovieDetailState extends MovieDetailState {
  final MovieDetail movie;

  GetMovieDetailState(this.movie);

  @override
  List<Object> get props => [movie];
}


class MovieDetailLoading extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}
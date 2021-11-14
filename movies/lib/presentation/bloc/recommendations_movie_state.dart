part of 'recommendations_movie_bloc.dart';

abstract class RecommendationsMovieState extends Equatable {
  const RecommendationsMovieState();

  @override
  List<Object> get props => [];
}

class GetRecommendationMoviesState extends RecommendationsMovieState {
  final List<Movie> movies;

  GetRecommendationMoviesState(this.movies);

  @override
  List<Object> get props => [movies];
}

class RecommendationLoading extends RecommendationsMovieState {}

class RecommendationMoviesError extends RecommendationsMovieState {
  final String message;

  RecommendationMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

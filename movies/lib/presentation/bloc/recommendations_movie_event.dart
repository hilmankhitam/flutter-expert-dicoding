part of 'recommendations_movie_bloc.dart';

abstract class RecommendationsMovieEvent extends Equatable {
  const RecommendationsMovieEvent();
}

class FetchRecommendations extends RecommendationsMovieEvent {
  final int id;

  FetchRecommendations(this.id);

  @override
  List<Object> get props => [id];
}

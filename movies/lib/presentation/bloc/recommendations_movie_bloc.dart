import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/entities.dart';
import 'package:movies/domain/usecases/usecases.dart';

part 'recommendations_movie_event.dart';
part 'recommendations_movie_state.dart';

class RecommendationsMovieBloc
    extends Bloc<RecommendationsMovieEvent, RecommendationsMovieState> {
  RecommendationsMovieBloc({
    required this.getMovieRecommendations,
  }) : super(RecommendationLoading());

  final GetMovieRecommendations getMovieRecommendations;

  @override
  Stream<RecommendationsMovieState> mapEventToState(
      RecommendationsMovieEvent event) async* {
    if (event is FetchRecommendations) {
      try {
        final recommendationResult =
            await getMovieRecommendations.execute(event.id);

        yield* recommendationResult.fold((failure) async* {
          yield RecommendationMoviesError(failure.message);
        }, (movies) async* {
          yield GetRecommendationMoviesState(movies);
        });
      } catch (error) {
        yield RecommendationMoviesError(error.toString());
      }
    }
  }
}

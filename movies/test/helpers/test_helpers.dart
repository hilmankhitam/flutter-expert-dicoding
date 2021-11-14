import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:movies/movies.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MovieDetailEventFake extends Fake implements MovieDetailEvent {}

class MovieDetailStateFake extends Fake implements MovieDetailState {}

class MockRecommendationsMovieBloc
    extends MockBloc<RecommendationsMovieEvent, RecommendationsMovieState>
    implements RecommendationsMovieBloc {}

class RecommendationsMovieEventFake extends Fake
    implements RecommendationsMovieEvent {}

class RecommendationsMovieStateFake extends Fake
    implements RecommendationsMovieState {}

class MockWatchlistMoviesBloc
    extends MockBloc<WatchlistMoviesEvent, WatchlistMoviesState>
    implements WatchlistMoviesBloc {}

class WatchlistMoviesEventFake extends Fake implements WatchlistMoviesEvent {}

class WatchlistMoviesStateFake extends Fake implements WatchlistMoviesState {}

class MockPopularMoviesBloc
    extends MockBloc<PopularMoviesEvent, PopularMoviesState>
    implements PopularMoviesBloc {}

class PopularMoviesEventFake extends Fake implements PopularMoviesEvent {}

class PopularMoviesStateFake extends Fake implements PopularMoviesState {}

class MockTopRatedMoviesBloc
    extends MockBloc<TopRatedMoviesEvent, TopRatedMoviesState>
    implements TopRatedMoviesBloc {}

class TopRatedMoviesEventFake extends Fake implements TopRatedMoviesEvent {}

class TopRatedMoviesStateFake extends Fake implements TopRatedMoviesState {}

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}

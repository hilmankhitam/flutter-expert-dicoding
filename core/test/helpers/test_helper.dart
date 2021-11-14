import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';
import 'package:tvseries/tvseries.dart';
import 'package:mockito/annotations.dart';

class MockOnTheAirTVSeriesBloc
    extends MockBloc<OnTheAirTVSeriesEvent, OnTheAirTVSeriesState>
    implements OnTheAirTVSeriesBloc {}

class OnTheAirTVSeriesEventFake extends Fake implements OnTheAirTVSeriesEvent {}

class OnTheAirTVSeriesStateFake extends Fake implements OnTheAirTVSeriesState {}

class MockPopularTVSeriesBloc
    extends MockBloc<PopularTVSeriesEvent, PopularTVSeriesState>
    implements PopularTVSeriesBloc {}

class PopularTVSeriesEventFake extends Fake implements PopularTVSeriesEvent {}

class PopularTVSeriesStateFake extends Fake implements PopularTVSeriesState {}

class MockTopRatedTVSeriesBloc
    extends MockBloc<TopRatedTVSeriesEvent, TopRatedTVSeriesState>
    implements TopRatedTVSeriesBloc {}

class TopRatedTVSeriesEventFake extends Fake implements TopRatedTVSeriesEvent {}

class TopRatedTVSeriesStateFake extends Fake implements TopRatedTVSeriesState {}

class MockTVSeriesDetailBloc
    extends MockBloc<TVSeriesDetailEvent, TVSeriesDetailState>
    implements TVSeriesDetailBloc {}

class TVSeriesDetailEventFake extends Fake implements TVSeriesDetailEvent {}

class TVSeriesDetailStateFake extends Fake implements TVSeriesDetailState {}

class MockRecommendationsTVSeriesBloc
    extends MockBloc<RecommendationsTVSeriesEvent, RecommendationsTVSeriesState>
    implements RecommendationsTVSeriesBloc {}

class RecommendationsTVSeriesEventFake extends Fake
    implements RecommendationsTVSeriesEvent {}

class RecommendationsTVSeriesStateFake extends Fake
    implements RecommendationsTVSeriesState {}

class MockWatchlistTVSeriesBloc
    extends MockBloc<WatchlistTVSeriesEvent, WatchlistTVSeriesState>
    implements WatchlistTVSeriesBloc {}

class WatchlistTVSeriesEventFake extends Fake
    implements WatchlistTVSeriesEvent {}

class WatchlistTVSeriesStateFake extends Fake
    implements WatchlistTVSeriesState {}

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

class MockNowPlayingMoviesBloc
    extends MockBloc<NowPlayingMoviesEvent, NowPlayingMoviesState>
    implements NowPlayingMoviesBloc {}

class NowPlayingMoviesEventFake extends Fake implements NowPlayingMoviesEvent {}

class NowPlayingMoviesStateFake extends Fake implements NowPlayingMoviesState {}

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

class MockMovieSearchBloc extends MockBloc<MovieSearchEvent, MovieSearchState>
    implements MovieSearchBloc {}

class MovieSearchEventFake extends Fake implements MovieSearchEvent {}

class MovieSearchStateFake extends Fake implements MovieSearchState {}

class MockTVSeriesSearchBloc
    extends MockBloc<TVSeriesSearchEvent, TVSeriesSearchState>
    implements TVSeriesSearchBloc {}

class TVSeriesSearchEventFake extends Fake implements TVSeriesSearchEvent {}

class TVSeriesSearchStateFake extends Fake implements TVSeriesSearchState {}

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
  TVSeriesRepository,
  TVSeriesRemoteDataSource,
  TVSeriesLocalDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}

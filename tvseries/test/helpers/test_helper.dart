import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:tvseries/tvseries.dart';
import 'package:mockito/annotations.dart';

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

@GenerateMocks([
  DatabaseHelper,
  TVSeriesRepository,
  TVSeriesRemoteDataSource,
  TVSeriesLocalDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}

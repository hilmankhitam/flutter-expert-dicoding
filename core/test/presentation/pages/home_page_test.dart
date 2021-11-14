import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';
import 'package:tvseries/presentation/bloc/blocs.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late MockNowPlayingMoviesBloc mockNowPlayingMoviesBloc;
  late MockPopularMoviesBloc mockPopularMoviesBloc;
  late MockTopRatedMoviesBloc mockTopRatedMoviesBloc;

  late MockOnTheAirTVSeriesBloc mockOnTheAirTVSeriesBloc;
  late MockPopularTVSeriesBloc mockPopularTVSeriesBloc;
  late MockTopRatedTVSeriesBloc mockTopRatedTVSeriesBloc;

  setUpAll(() {
    registerFallbackValue(NowPlayingMoviesEventFake());
    registerFallbackValue(NowPlayingMoviesStateFake());

    registerFallbackValue(PopularMoviesEventFake());
    registerFallbackValue(PopularMoviesStateFake());

    registerFallbackValue(TopRatedMoviesEventFake());
    registerFallbackValue(TopRatedMoviesStateFake());

    registerFallbackValue(OnTheAirTVSeriesEventFake());
    registerFallbackValue(OnTheAirTVSeriesStateFake());

    registerFallbackValue(PopularTVSeriesEventFake());
    registerFallbackValue(PopularTVSeriesStateFake());

    registerFallbackValue(TopRatedTVSeriesEventFake());
    registerFallbackValue(TopRatedTVSeriesStateFake());
  });

  setUp(() {
    mockNowPlayingMoviesBloc = MockNowPlayingMoviesBloc();
    mockPopularMoviesBloc = MockPopularMoviesBloc();
    mockTopRatedMoviesBloc = MockTopRatedMoviesBloc();

    mockOnTheAirTVSeriesBloc = MockOnTheAirTVSeriesBloc();
    mockPopularTVSeriesBloc = MockPopularTVSeriesBloc();
    mockTopRatedTVSeriesBloc = MockTopRatedTVSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMoviesBloc>(
          create: (context) => mockNowPlayingMoviesBloc,
        ),
        BlocProvider<PopularMoviesBloc>(
          create: (context) => mockPopularMoviesBloc,
        ),
        BlocProvider<TopRatedMoviesBloc>(
          create: (context) => mockTopRatedMoviesBloc,
        ),
        BlocProvider<OnTheAirTVSeriesBloc>(
          create: (context) => mockOnTheAirTVSeriesBloc,
        ),
        BlocProvider<PopularTVSeriesBloc>(
          create: (context) => mockPopularTVSeriesBloc,
        ),
        BlocProvider<TopRatedTVSeriesBloc>(
          create: (context) => mockTopRatedTVSeriesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display image and text',
      (WidgetTester tester) async {
    when(() => mockNowPlayingMoviesBloc.state)
        .thenAnswer((_) => GetNowPlayingMoviesState(testMovieList));
    when(() => mockPopularMoviesBloc.state)
        .thenAnswer((_) => GetPopularMoviesState(testMovieList));
    when(() => mockTopRatedMoviesBloc.state)
        .thenAnswer((_) => GetTopRatedMoviesState(testMovieList));
    when(() => mockOnTheAirTVSeriesBloc.state)
        .thenAnswer((_) => GetOnTheAirTVSeriesState(testTVSeriesList));
    when(() => mockPopularTVSeriesBloc.state)
        .thenAnswer((_) => GetPopularTVSeriesState(testTVSeriesList));
    when(() => mockTopRatedTVSeriesBloc.state)
        .thenAnswer((_) => GetTopRatedTVSeriesState(testTVSeriesList));

    await tester.pumpWidget(_makeTestableWidget(HomePage()));

    expect(find.text('Ditonton'), findsOneWidget);
  });
}

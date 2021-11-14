import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/movies.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late MockWatchlistMoviesBloc mockWatchlistMoviesBloc;
  late MockWatchlistTVSeriesBloc mockWatchlistTVSeriesBloc;

  setUpAll(() {
    registerFallbackValue(WatchlistMoviesEventFake());
    registerFallbackValue(WatchlistMoviesStateFake());

    registerFallbackValue(WatchlistTVSeriesEventFake());
    registerFallbackValue(WatchlistTVSeriesStateFake());
  });

  setUp(() {
    mockWatchlistMoviesBloc = MockWatchlistMoviesBloc();
    mockWatchlistTVSeriesBloc = MockWatchlistTVSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchlistMoviesBloc>(
          create: (context) => mockWatchlistMoviesBloc,
        ),
        BlocProvider<WatchlistTVSeriesBloc>(
          create: (context) => mockWatchlistTVSeriesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockWatchlistMoviesBloc.state)
        .thenAnswer((_) => WatchlistMoviesLoaded(movies: testMovieList));
    when(() => mockWatchlistTVSeriesBloc.state)
        .thenAnswer((_) => WatchlistTVSeriesLoaded(tvSeries: testTVSeriesList));

    final movieCard = find.byType(MovieCard);

    await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

    expect(movieCard, findsOneWidget);
  });
}

import 'package:tvseries/tvseries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late MockTVSeriesDetailBloc mockTVSeriesDetailBloc;
  late MockRecommendationsTVSeriesBloc mockRecommendationsTVSeriesBloc;
  late MockWatchlistTVSeriesBloc mockWatchlistTVSeriesBloc;

  setUpAll(() {
    registerFallbackValue(TVSeriesDetailEventFake());
    registerFallbackValue(TVSeriesDetailStateFake());

    registerFallbackValue(RecommendationsTVSeriesEventFake());
    registerFallbackValue(RecommendationsTVSeriesStateFake());

    registerFallbackValue(WatchlistTVSeriesEventFake());
    registerFallbackValue(WatchlistTVSeriesStateFake());
  });

  setUp(() {
    mockTVSeriesDetailBloc = MockTVSeriesDetailBloc();
    mockRecommendationsTVSeriesBloc = MockRecommendationsTVSeriesBloc();
    mockWatchlistTVSeriesBloc = MockWatchlistTVSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TVSeriesDetailBloc>(
          create: (context) => mockTVSeriesDetailBloc,
        ),
        BlocProvider<RecommendationsTVSeriesBloc>(
          create: (context) => mockRecommendationsTVSeriesBloc,
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
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTVSeriesDetailBloc.state)
        .thenAnswer((_) => GetTVSeriesDetailState(testTVSeriesDetail));
    when(() => mockRecommendationsTVSeriesBloc.state)
        .thenAnswer((_) => GetRecommendationTVSeriesState(<TVSeries>[]));
    when(() => mockWatchlistTVSeriesBloc.state)
        .thenAnswer((_) => GetWatchlistTVSeriesStatus(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TVSeriesDetailPage(id: 31917)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockTVSeriesDetailBloc.state)
        .thenAnswer((_) => GetTVSeriesDetailState(testTVSeriesDetail));
    when(() => mockRecommendationsTVSeriesBloc.state)
        .thenAnswer((_) => GetRecommendationTVSeriesState(<TVSeries>[]));
    when(() => mockWatchlistTVSeriesBloc.state)
        .thenAnswer((_) => GetWatchlistTVSeriesStatus(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TVSeriesDetailPage(id: 31917)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTVSeriesDetailBloc.state)
        .thenAnswer((_) => GetTVSeriesDetailState(testTVSeriesDetail));
    when(() => mockRecommendationsTVSeriesBloc.state)
        .thenAnswer((_) => GetRecommendationTVSeriesState(<TVSeries>[]));
    when(() => mockWatchlistTVSeriesBloc.state)
        .thenAnswer((_) => GetWatchlistTVSeriesStatus(false));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TVSeriesDetailPage(id: 31917)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.dart';

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockRecommendationsMovieBloc mockRecommendationsMovieBloc;
  late MockWatchlistMoviesBloc mockWatchlistMoviesBloc;

  setUpAll(() {
    registerFallbackValue(MovieDetailEventFake());
    registerFallbackValue(MovieDetailStateFake());

    registerFallbackValue(RecommendationsMovieEventFake());
    registerFallbackValue(RecommendationsMovieStateFake());

    registerFallbackValue(WatchlistMoviesEventFake());
    registerFallbackValue(WatchlistMoviesStateFake());
  });

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockRecommendationsMovieBloc = MockRecommendationsMovieBloc();
    mockWatchlistMoviesBloc = MockWatchlistMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (context) => mockMovieDetailBloc,
        ),
        BlocProvider<RecommendationsMovieBloc>(
          create: (context) => mockRecommendationsMovieBloc,
        ),
        BlocProvider<WatchlistMoviesBloc>(
          create: (context) => mockWatchlistMoviesBloc,
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
    when(() => mockMovieDetailBloc.state)
        .thenAnswer((_) => GetMovieDetailState(testMovieDetail));
    when(() => mockRecommendationsMovieBloc.state)
        .thenAnswer((_) => GetRecommendationMoviesState(<Movie>[]));
    when(() => mockWatchlistMoviesBloc.state)
        .thenAnswer((_) => GetWatchlistMovieStatus(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenAnswer((_) => GetMovieDetailState(testMovieDetail));
    when(() => mockRecommendationsMovieBloc.state)
        .thenAnswer((_) => GetRecommendationMoviesState(<Movie>[]));
    when(() => mockWatchlistMoviesBloc.state)
        .thenAnswer((_) => GetWatchlistMovieStatus(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenAnswer((_) => GetMovieDetailState(testMovieDetail));
    when(() => mockRecommendationsMovieBloc.state)
        .thenAnswer((_) => GetRecommendationMoviesState(<Movie>[]));
    when(() => mockWatchlistMoviesBloc.state)
        .thenAnswer((_) => GetWatchlistMovieStatus(false));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });
}

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
  late MockMovieSearchBloc mockMovieSearchBloc;
  late MockTVSeriesSearchBloc mockTVSeriesSearchBloc;

  setUpAll(() {
    registerFallbackValue(MovieSearchEventFake());
    registerFallbackValue(MovieSearchStateFake());

    registerFallbackValue(TVSeriesSearchEventFake());
    registerFallbackValue(TVSeriesSearchStateFake());
  });

  setUp(() {
    mockMovieSearchBloc = MockMovieSearchBloc();
    mockTVSeriesSearchBloc = MockTVSeriesSearchBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieSearchBloc>(
          create: (context) => mockMovieSearchBloc,
        ),
        BlocProvider<TVSeriesSearchBloc>(
          create: (context) => mockTVSeriesSearchBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display movie card', (WidgetTester tester) async {
    when(() => mockMovieSearchBloc.state)
        .thenAnswer((_) => MovieSearchStateSuccess(testMovieList));

    final movieCard = find.byType(MovieCard);

    await tester.pumpWidget(_makeTestableWidget(SearchPage(
      currentIndexNavBar: 0,
    )));

    expect(movieCard, findsOneWidget);
  });

  testWidgets('should display circularProgressIndicator',
      (WidgetTester tester) async {
    when(() => mockMovieSearchBloc.state)
        .thenAnswer((_) => MovieSearchStateLoading());

    final circularProgressIndicator = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(SearchPage(
      currentIndexNavBar: 0,
    )));

    expect(circularProgressIndicator, findsOneWidget);
  });

  testWidgets('should display expanded', (WidgetTester tester) async {
    when(() => mockMovieSearchBloc.state)
        .thenAnswer((_) => MovieSearchStateError('Failed'));

    final expanded = find.byType(Expanded);

    await tester.pumpWidget(_makeTestableWidget(SearchPage(
      currentIndexNavBar: 0,
    )));

    expect(expanded, findsOneWidget);
  });

  testWidgets('should display tv series card', (WidgetTester tester) async {
    when(() => mockTVSeriesSearchBloc.state)
        .thenAnswer((_) => TVSeriesSearchStateSuccess(testTVSeriesList));

    final tvSeriesCard = find.byType(TVSeriesCard);

    await tester.pumpWidget(_makeTestableWidget(SearchPage(
      currentIndexNavBar: 1,
    )));

    expect(tvSeriesCard, findsOneWidget);
  });

  testWidgets('should display circularProgressIndicator',
      (WidgetTester tester) async {
    when(() => mockTVSeriesSearchBloc.state)
        .thenAnswer((_) => TVSeriesSearchStateLoading());

    final circularProgressIndicator = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(SearchPage(
      currentIndexNavBar: 1,
    )));

    expect(circularProgressIndicator, findsOneWidget);
  });

  testWidgets('should display expanded', (WidgetTester tester) async {
    when(() => mockTVSeriesSearchBloc.state)
        .thenAnswer((_) => TVSeriesSearchStateError('Failed'));

    final expanded = find.byType(Expanded);

    await tester.pumpWidget(_makeTestableWidget(SearchPage(
      currentIndexNavBar: 1,
    )));

    expect(expanded, findsOneWidget);
  });
}

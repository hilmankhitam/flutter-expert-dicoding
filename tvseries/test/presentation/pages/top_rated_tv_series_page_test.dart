import 'package:tvseries/tvseries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_helper.dart';

void main() {
  late MockTopRatedTVSeriesBloc mockTopRatedTVSeriesBloc;

  setUpAll(() {
    registerFallbackValue(TopRatedTVSeriesEventFake());
    registerFallbackValue(TopRatedTVSeriesStateFake());
  });

  setUp(() {
    mockTopRatedTVSeriesBloc = MockTopRatedTVSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTVSeriesBloc>(
      create: (context) => mockTopRatedTVSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedTVSeriesBloc.state)
        .thenAnswer((_) => TopRatedTVSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVSeriesPage()));

    expect(progressBarFinder, findsOneWidget);
    expect(centerFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedTVSeriesBloc.state)
        .thenAnswer((_) => GetTopRatedTVSeriesState(<TVSeries>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedTVSeriesBloc.state)
        .thenAnswer((_) => TopRatedTVSeriesError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}

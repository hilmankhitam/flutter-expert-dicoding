import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/tvseries.dart';

import '../../helpers/test_helper.dart';

void main() {
  late MockPopularTVSeriesBloc mockPopularTVSeriesBloc;

  setUpAll(() {
    registerFallbackValue(PopularTVSeriesEventFake());
    registerFallbackValue(PopularTVSeriesStateFake());
  });

  setUp(() {
    mockPopularTVSeriesBloc = MockPopularTVSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTVSeriesBloc>(
      create: (context) => mockPopularTVSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularTVSeriesBloc.state)
        .thenAnswer((_) => PopularTVSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTVSeriesPage()));

    expect(progressBarFinder, findsOneWidget);
    expect(centerFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularTVSeriesBloc.state)
        .thenAnswer((_) => GetPopularTVSeriesState(<TVSeries>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTVSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularTVSeriesBloc.state)
        .thenAnswer((_) => PopularTVSeriesError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTVSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}

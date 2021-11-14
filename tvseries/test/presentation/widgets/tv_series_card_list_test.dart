import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/dummy_objects.dart';
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

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedTVSeriesBloc.state)
        .thenAnswer((_) => GetTopRatedTVSeriesState(testTVSeriesList));

    final tvSeriesCardFinder = find.byType(TVSeriesCard);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVSeriesPage()));

    expect(tvSeriesCardFinder, findsOneWidget);
  });
}

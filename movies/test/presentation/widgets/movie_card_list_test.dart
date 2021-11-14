import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockTopRatedMoviesBloc mockTopRatedMoviesBloc;

  setUpAll(() {
    registerFallbackValue(TopRatedMoviesEventFake());
    registerFallbackValue(TopRatedMoviesStateFake());
  });

  setUp(() {
    mockTopRatedMoviesBloc = MockTopRatedMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesBloc>(
      create: (context) => mockTopRatedMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedMoviesBloc.state)
        .thenAnswer((_) => GetTopRatedMoviesState(testMovieList));
    final movieCardFinder = find.byType(MovieCard);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(movieCardFinder, findsOneWidget);
  });
}

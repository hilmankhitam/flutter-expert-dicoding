import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  testWidgets('Page should display image and text',
      (WidgetTester tester) async {
    final imageFinder = find.byType(Image);
    final textFinder = find.byType(Text);

    await tester.pumpWidget(_makeTestableWidget(AboutPage()));

    expect(imageFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);
  });
}

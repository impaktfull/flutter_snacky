import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snacky/snacky.dart';
import 'package:snacky/src/widget/touch_feedback.dart';

void main() {
  const duration = Duration(seconds: 2);
  late SnackyController snackyController;
  String? onTapValue;

  setUp(() {
    snackyController = SnackyController();
  });

  tearDown(() {
    snackyController.cancelAll();
    onTapValue = null;
  });

  Widget prepareWidgetForTesting([hideOptionalData = false]) =>
      SnackyConfiguratorWidget(
        snackyController: snackyController,
        app: MaterialApp(
          theme: ThemeData(useMaterial3: false),
          home: Builder(
            builder: (context) => ElevatedButton(
              child: const Text('show_message'),
              onPressed: () => snackyController.showMessage(
                (context) => Snacky(
                  title: 'title',
                  subtitle: 'subtitle',
                  onTap: () {
                    onTapValue = 'tapped';
                  },
                  showDuration: duration,
                ),
              ),
            ),
          ),
        ),
      );

  group('showMessage', () {
    testWidgets('Should render without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(prepareWidgetForTesting());
      await tester.pumpAndSettle();

      await tester.tap(find.text('show_message'));
      await tester.pumpAndSettle();

      expect(find.byType(BaseSnackyWidget), findsOneWidget);
      expect(find.text('title'), findsOneWidget);
      expect(find.text('subtitle'), findsOneWidget);

      await tester.pump(duration);
      await tester.pumpAndSettle();
    });

    testWidgets('Should call the onTap when tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(prepareWidgetForTesting());
      await tester.pumpAndSettle();

      await tester.tap(find.text('show_message'));
      await tester.pumpAndSettle();

      expect(find.byType(BaseSnackyWidget), findsOneWidget);

      final touchFeedback = find.byType(TouchFeedback);
      expect(touchFeedback, findsOneWidget);

      expect(onTapValue, isNull);
      await tester.tap(touchFeedback);
      await tester.pumpAndSettle();
      expect(onTapValue, isNotNull);

      await tester.pump(duration);
      await tester.pumpAndSettle();
    });
  });
}

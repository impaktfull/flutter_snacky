import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snacky/snacky.dart';

void main() {
  const showDuration = Duration(seconds: 5);
  const transitionDuration = Duration(milliseconds: 250);
  const tick = Duration(milliseconds: 1);
  late SnackyController snackyController;

  setUp(() {
    snackyController = SnackyController();
  });

  Widget prepareWidgetForTesting() => SnackyConfiguratorWidget(
        snackyController: snackyController,
        app: MaterialApp(
          theme: ThemeData(useMaterial3: false),
          home: const SizedBox(),
        ),
      );

  void show(String title) => snackyController.showMessage(
        (context) => Snacky(
          title: title,
          canBeClosed: true,
          showDuration: showDuration,
          transitionDuration: transitionDuration,
        ),
      );

  Future<void> showAndSettle(WidgetTester tester, String title) async {
    show(title);
    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.text(title), findsOneWidget);
  }

  /// Asserts [title] stays visible until its full `showDuration` has passed
  /// (counted from the end of the slide in) and is removed afterwards.
  Future<void> expectVisibleForFullDuration(
    WidgetTester tester,
    String title,
  ) async {
    await tester.pump(showDuration - tick);
    expect(find.text(title), findsOneWidget);
    await tester.pump(tick);
    await tester.pumpAndSettle();
    expect(find.text(title), findsNothing);
    expect(snackyController.activeSnacky.value, isNull);
  }

  group('closing a snacky early', () {
    testWidgets('with the close button leaves no timer pending',
        (tester) async {
      await tester.pumpWidget(prepareWidgetForTesting());
      await showAndSettle(tester, 'first');

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.text('first'), findsNothing);
      expect(find.byType(BaseSnackyWidget), findsNothing);
      expect(snackyController.activeSnacky.value, isNull);
      // The test ends without waiting for `showDuration`: flutter_test fails
      // with "A Timer is still pending" if the display timer outlives it.
    });

    testWidgets('with cancelActiveSnacky leaves no timer pending',
        (tester) async {
      await tester.pumpWidget(prepareWidgetForTesting());
      await showAndSettle(tester, 'first');

      snackyController.cancelActiveSnacky();
      await tester.pumpAndSettle();

      expect(find.text('first'), findsNothing);
      expect(snackyController.activeSnacky.value, isNull);
    });

    testWidgets('while it slides in removes it and leaves no timer pending',
        (tester) async {
      await tester.pumpWidget(prepareWidgetForTesting());
      show('first');
      await tester.pump();
      await tester.pump(transitionDuration ~/ 2);

      snackyController.cancelActiveSnacky();
      await tester.pumpAndSettle();

      expect(find.text('first'), findsNothing);
      expect(snackyController.activeSnacky.value, isNull);
    });

    testWidgets('before it is built never shows it', (tester) async {
      await tester.pumpWidget(prepareWidgetForTesting());
      show('first');
      snackyController.cancelActiveSnacky();
      await tester.pumpAndSettle();

      expect(find.text('first'), findsNothing);
      expect(snackyController.activeSnacky.value, isNull);
    });

    testWidgets('then showing a new snacky shows it for its full duration',
        (tester) async {
      await tester.pumpWidget(prepareWidgetForTesting());
      await showAndSettle(tester, 'first');
      await tester.pump(showDuration ~/ 2);

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();
      expect(find.text('first'), findsNothing);

      await showAndSettle(tester, 'second');
      await expectVisibleForFullDuration(tester, 'second');
    });

    testWidgets(
        'twice while it slides in does not remove the next queued snacky',
        (tester) async {
      await tester.pumpWidget(prepareWidgetForTesting());
      show('first');
      show('second');
      await tester.pump();
      await tester.pump(transitionDuration ~/ 2);

      snackyController.cancelActiveSnacky();
      await tester.pump(tick);
      snackyController.cancelActiveSnacky();
      await tester.pump(transitionDuration);
      await tester.pumpAndSettle();

      expect(find.text('first'), findsNothing);
      expect(find.text('second'), findsOneWidget);
      await expectVisibleForFullDuration(tester, 'second');
    });

    testWidgets('when the configurator is removed leaves no timer pending',
        (tester) async {
      await tester.pumpWidget(prepareWidgetForTesting());
      await showAndSettle(tester, 'first');

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();

      expect(find.text('first'), findsNothing);
    });
  });

  group('configurator', () {
    testWidgets(
        'removed while a snacky is shown, a new configurator shows snackies again',
        (tester) async {
      await tester.pumpWidget(prepareWidgetForTesting());
      show('first');
      show('queued');
      await tester.pump();
      await tester.pumpAndSettle();
      expect(find.text('first'), findsOneWidget);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
      expect(find.text('first'), findsNothing);
      expect(snackyController.activeSnacky.value, isNull);

      await tester.pumpWidget(prepareWidgetForTesting());
      await tester.pumpAndSettle();
      // Snackies queued while no configurator was attached are dropped, like
      // `showMessage` drops a snacky when there is no overlay.
      expect(find.text('queued'), findsNothing);

      await showAndSettle(tester, 'second');
      await expectVisibleForFullDuration(tester, 'second');
    });

    testWidgets(
        'replaced while a snacky is shown, the new configurator shows snackies',
        (tester) async {
      await tester.pumpWidget(prepareWidgetForTesting());
      show('first');
      show('queued');
      await tester.pump();
      await tester.pumpAndSettle();
      expect(find.text('first'), findsOneWidget);

      // A new key replaces the configurator: the new one attaches before the
      // old one is disposed.
      await tester.pumpWidget(
        KeyedSubtree(key: UniqueKey(), child: prepareWidgetForTesting()),
      );
      await tester.pumpAndSettle();
      expect(find.text('first'), findsNothing);
      // The queue continues on the configurator that is still attached.
      expect(find.text('queued'), findsOneWidget);
      await expectVisibleForFullDuration(tester, 'queued');

      await showAndSettle(tester, 'second');
      await expectVisibleForFullDuration(tester, 'second');
    });
  });

  group('queue', () {
    testWidgets('shows the next snacky for its full duration', (tester) async {
      await tester.pumpWidget(prepareWidgetForTesting());
      show('first');
      show('second');
      await tester.pump();
      await tester.pumpAndSettle();
      expect(find.text('first'), findsOneWidget);
      expect(find.text('second'), findsNothing);

      await tester.pump(showDuration);
      await tester.pumpAndSettle();
      expect(find.text('first'), findsNothing);
      expect(find.text('second'), findsOneWidget);

      await expectVisibleForFullDuration(tester, 'second');
    });

    testWidgets('closing the active snacky shows the next one', (tester) async {
      await tester.pumpWidget(prepareWidgetForTesting());
      show('first');
      show('second');
      await tester.pump();
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();
      expect(find.text('first'), findsNothing);
      expect(find.text('second'), findsOneWidget);

      await expectVisibleForFullDuration(tester, 'second');
    });

    testWidgets('cancelAll clears the queue and leaves no timer pending',
        (tester) async {
      await tester.pumpWidget(prepareWidgetForTesting());
      show('first');
      show('second');
      show('third');
      await tester.pump();
      await tester.pumpAndSettle();

      snackyController.cancelAll();
      await tester.pumpAndSettle();

      expect(find.byType(BaseSnackyWidget), findsNothing);
      expect(snackyController.activeSnacky.value, isNull);
    });

    testWidgets('a snacky shown after cancelAll gets its full duration',
        (tester) async {
      await tester.pumpWidget(prepareWidgetForTesting());
      show('first');
      show('second');
      await tester.pump();
      await tester.pumpAndSettle();
      await tester.pump(showDuration ~/ 2);

      snackyController.cancelAll();
      await tester.pumpAndSettle();
      expect(find.byType(BaseSnackyWidget), findsNothing);

      await showAndSettle(tester, 'third');
      await expectVisibleForFullDuration(tester, 'third');
    });
  });
}

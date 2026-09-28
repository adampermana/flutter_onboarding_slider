import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

void main() {
  Widget buildTestableWidget({
    bool isTop = false,
    IndicatorType indicatorType = IndicatorType.circle,
    int totalPage = 3,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: OnBoardingSlider(
          totalPage: totalPage,
          headerBackgroundColor: Colors.white,
          isTop: isTop,
          indicatorType: indicatorType,
          speed: 1.8,
          background: [
            Container(key: const Key('bg_0')),
            Container(key: const Key('bg_1')),
            Container(key: const Key('bg_2')),
          ],
          pageBodies: [
            Container(key: const Key('body_0'), child: const Text('Page 1')),
            Container(key: const Key('body_1'), child: const Text('Page 2')),
            Container(key: const Key('body_2'), child: const Text('Page 3')),
          ],
        ),
      ),
    );
  }

  testWidgets('renders OnBoardingSlider with default circle indicator at bottom',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget());

    expect(find.byType(OnBoardingSlider), findsOneWidget);
    expect(find.text('Page 1'), findsOneWidget);

    final animatedContainers = find.byType(AnimatedContainer);
    expect(animatedContainers, findsNWidgets(3));

    // Circle indicators: width (8) + left margin (4) + right margin (4) = 16
    final Size firstDotSize = tester.getSize(animatedContainers.at(0));
    final Size secondDotSize = tester.getSize(animatedContainers.at(1));
    expect(firstDotSize.width, 16.0);
    expect(secondDotSize.width, 16.0);
  });

  testWidgets('renders expanding indicator correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      buildTestableWidget(indicatorType: IndicatorType.expanding),
    );

    final animatedContainers = find.byType(AnimatedContainer);
    expect(animatedContainers, findsNWidgets(3));

    // Active indicator (expanding): width (24) + margin (8) = 32
    // Inactive indicator: width (8) + margin (8) = 16
    final Size activeSize = tester.getSize(animatedContainers.at(0));
    final Size inactiveSize = tester.getSize(animatedContainers.at(1));

    expect(activeSize.width, 32.0);
    expect(inactiveSize.width, 16.0);
  });

  testWidgets('positions indicator at top when isTop is true',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      buildTestableWidget(isTop: true),
    );

    final safeAreaFinder = find.byType(SafeArea);
    final Column mainColumn = tester.widget<Column>(
      find.descendant(of: safeAreaFinder, matching: find.byType(Column)).first,
    );

    expect(mainColumn.children.length, 4);
    expect(mainColumn.children[1], isA<Align>());
    expect(mainColumn.children[2], isA<Expanded>());
  });

  testWidgets('positions indicator at bottom when isTop is false',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      buildTestableWidget(isTop: false),
    );

    final safeAreaFinder = find.byType(SafeArea);
    final Column mainColumn = tester.widget<Column>(
      find.descendant(of: safeAreaFinder, matching: find.byType(Column)).first,
    );

    expect(mainColumn.children.length, 4);
    expect(mainColumn.children[1], isA<Expanded>());
    expect(mainColumn.children[2], isA<Align>());
  });

  testWidgets('line indicator renders Expanded segments', (WidgetTester tester) async {
    await tester.pumpWidget(
      buildTestableWidget(indicatorType: IndicatorType.line),
    );

    // Line indicator uses Expanded children — 3 AnimatedContainers inside Padding > Row
    final animatedContainers = find.byType(AnimatedContainer);
    expect(animatedContainers, findsNWidgets(3));

    // All segments have equal height 8px
    for (int i = 0; i < 3; i++) {
      final Size s = tester.getSize(animatedContainers.at(i));
      expect(s.height, 8.0);
    }

    // Each segment is equal width (Expanded)
    final Size s0 = tester.getSize(animatedContainers.at(0));
    final Size s1 = tester.getSize(animatedContainers.at(1));
    final Size s2 = tester.getSize(animatedContainers.at(2));
    expect(s0.width, s1.width);
    expect(s1.width, s2.width);
  });
}

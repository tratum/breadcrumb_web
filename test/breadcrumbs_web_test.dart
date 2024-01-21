import 'package:breadcrumbs_web/breadcrumbs_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BreadcrumbTrail Widget Tests', () {
    testWidgets(
        'BreadcrumbTrail.getCrumbsForWeb creates the correct widget tree',
        (WidgetTester tester) async {
      // Arrange
      bool homeClicked = false;
      bool categoryClicked = false;
      bool itemClicked = false;

      final List<String> crumbs = ['Home', 'Category', 'Item'];
      final List<Future<dynamic> Function()> callbacks = [
        () async => homeClicked = true,
        () async => categoryClicked = true,
        () async => itemClicked = true,
      ];

      // New part for breadcrumb states
      final List<BreadcrumbState> breadcrumbStates = [
        BreadcrumbState.active,
        BreadcrumbState.completed,
        BreadcrumbState.disabled,
      ];

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BreadcrumbTrail.getCrumbsForWeb(
              crumbs: crumbs,
              callbacks: callbacks,
              breadcrumbStates: breadcrumbStates,

              /// Optional: Add custom colors for testing
              activeStateColor: Colors.blue,
              completedStateColor: Colors.green,
              disabledStateColor: Colors.grey,
            ),
          ),
        ),
      );

      // Assert initial state
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Category'), findsOneWidget);
      expect(find.text('Item'), findsOneWidget);
      expect(homeClicked, isFalse);
      expect(categoryClicked, isFalse);
      expect(itemClicked, isFalse);

      /// Tap on the first breadcrumb and check if the callback is executed
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(homeClicked, isTrue);

      /// Repeat for other breadcrumbs
      await tester.tap(find.text('Category'));
      await tester.pumpAndSettle();
      expect(categoryClicked, isTrue);

      await tester.tap(find.text('Item'));
      await tester.pumpAndSettle();
      expect(itemClicked, isTrue);
    });

    testWidgets('BreadcrumbTrail handles empty lists',
        (WidgetTester tester) async {
      // Arrange
      final List<String> crumbs = [];
      final List<Future<dynamic> Function()> callbacks = [];

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BreadcrumbTrail.getCrumbsForWeb(
              crumbs: crumbs,
              callbacks: callbacks,
              breadcrumbStates: [],
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(Text), findsNothing);
    });

    testWidgets('BreadcrumbTrail displays correct colors for different states',
        (WidgetTester tester) async {
      // Arrange
      final List<String> crumbs = ['Home', 'Category', 'Item'];
      final List<Future<dynamic> Function()> callbacks = [
        () async => print('Home clicked'),
        () async => print('Category clicked'),
        () async => print('Item clicked'),
      ];
      final List<BreadcrumbState> breadcrumbStates = [
        BreadcrumbState.active,
        BreadcrumbState.completed,
        BreadcrumbState.disabled,
      ];

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BreadcrumbTrail.getCrumbsForWeb(
              crumbs: crumbs,
              callbacks: callbacks,
              breadcrumbStates: breadcrumbStates,
              activeStateColor: Colors.blue,
              completedStateColor: Colors.green,
              disabledStateColor: Colors.grey,
            ),
          ),
        ),
      );

      // Assert
      final Finder homeCrumb = find.text('Home');
      final Finder categoryCrumb = find.text('Category');
      final Finder itemCrumb = find.text('Item');

      /// Check color of each breadcrumb based on its state
      expect((tester.widget(homeCrumb) as Text).style?.color,
          Colors.blue); // Active
      expect((tester.widget(categoryCrumb) as Text).style?.color,
          Colors.green); // Completed
      expect((tester.widget(itemCrumb) as Text).style?.color,
          Colors.grey); // Disabled
    });

    testWidgets('BreadcrumbTrail handles breadcrumbs with long text',
        (WidgetTester tester) async {
      // Arrange
      final List<String> crumbs = [
        'This is a very long breadcrumb',
        'Category',
        'Item'
      ];
      final List<Future<dynamic> Function()> callbacks = [
        () async => print('Home clicked'),
        () async => print('Category clicked'),
        () async => print('Item clicked'),
      ];

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BreadcrumbTrail.getCrumbsForWeb(
              crumbs: crumbs,
              callbacks: callbacks,
              breadcrumbStates:
                  List.generate(crumbs.length, (_) => BreadcrumbState.active),
            ),
          ),
        ),
      );
    });

    testWidgets('BreadcrumbTrail handles a large number of breadcrumbs',
        (WidgetTester tester) async {
      // Arrange
      final List<String> crumbs =
          List.generate(100, (index) => 'Breadcrumb $index');
      final List<Future<dynamic> Function()> callbacks = List.generate(
        100,
        (index) => () async => print('Clicked on Breadcrumb $index'),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BreadcrumbTrail.getCrumbsForWeb(
              crumbs: crumbs,
              callbacks: callbacks,
              breadcrumbStates:
                  List.generate(crumbs.length, (_) => BreadcrumbState.active),
            ),
          ),
        ),
      );
    });
  });
}

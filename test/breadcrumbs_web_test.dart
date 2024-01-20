import 'package:breadcrumbs_web/breadcrumbs_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BreadcrumbTrail Widget Tests', () {
    testWidgets('BreadcrumbTrail.getCrumbsForWeb creates the correct widget tree', (WidgetTester tester) async {
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

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BreadcrumbTrail.getCrumbsForWeb(
              crumbs: crumbs,
              callbacks: callbacks,
            ),
          ),
        ),
      );

      /// Assert initial state
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Category'), findsOneWidget);
      expect(find.text('Item'), findsOneWidget);
      expect(homeClicked, isFalse);
      expect(categoryClicked, isFalse);
      expect(itemClicked, isFalse);

      /// Tap on the first breadcrumb and check if callback is executed
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

    testWidgets('BreadcrumbTrail handles empty lists', (WidgetTester tester) async {
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
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(Text), findsNothing);
    });

    // testWidgets('BreadcrumbTrail handles disabled breadcrumbs', (WidgetTester tester) async {
    //   // Arrange
    //   final List<String> crumbs = ['Home', 'Category', 'Item'];
    //   bool itemClicked = false;
    //
    //   final List<Future<dynamic> Function()> callbacks = [
    //         () async => print('Home clicked'),
    //         () async => print('Category clicked'),
    //         () async => itemClicked = true, // This breadcrumb is effectively 'disabled'
    //   ];
    //
    //   // Act
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: Scaffold(
    //         body: BreadcrumbTrail.getCrumbsForWeb(
    //           crumbs: crumbs,
    //           callbacks: callbacks,
    //         ),
    //       ),
    //     ),
    //   );
    //
    //   /// Attempt to tap on the 'disabled' breadcrumb
    //   await tester.tap(find.text('Item'));
    //   await tester.pumpAndSettle();
    //
    //   /// Assert that the callback is not executed
    //   expect(itemClicked, isFalse);
    // });

    testWidgets('BreadcrumbTrail handles breadcrumbs with long text', (WidgetTester tester) async {
      // Arrange
      final List<String> crumbs = ['This is a very long breadcrumb', 'Category', 'Item'];
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
            ),
          ),
        ),
      );
    });

    testWidgets('BreadcrumbTrail handles a large number of breadcrumbs', (WidgetTester tester) async {
      // Arrange
      final List<String> crumbs = List.generate(100, (index) => 'Breadcrumb $index');
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
            ),
          ),
        ),
      );
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tickme/widgets/common/error_widget.dart';
import '../helpers/test_helpers.dart';

void main() {
  group('AppErrorWidget Tests', () {
    testWidgets('should display error message', (WidgetTester tester) async {
      const message = 'An error occurred';
      await tester.pumpWidget(
        TestHelpers.createTestWidget(const AppErrorWidget(message: message)),
      );

      expect(find.text(message), findsOneWidget);
    });

    testWidgets('should display default error icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TestHelpers.createTestWidget(const AppErrorWidget(message: 'Error')),
      );

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('should display custom icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestHelpers.createTestWidget(
          const AppErrorWidget(
            message: 'Error',
            icon: Icons.warning,
          ),
        ),
      );

      expect(find.byIcon(Icons.warning), findsOneWidget);
    });

    testWidgets('should display retry button when onRetry is provided',
        (WidgetTester tester) async {
      bool retryCalled = false;
      await tester.pumpWidget(
        TestHelpers.createTestWidget(
          AppErrorWidget(
            message: 'Error',
            onRetry: () => retryCalled = true,
          ),
        ),
      );

      expect(find.text('Retry'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should not display retry button when onRetry is null',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TestHelpers.createTestWidget(const AppErrorWidget(message: 'Error')),
      );

      expect(find.text('Retry'), findsNothing);
      expect(find.byType(ElevatedButton), findsNothing);
    });

    testWidgets('should call onRetry when retry button is tapped',
        (WidgetTester tester) async {
      bool retryCalled = false;
      await tester.pumpWidget(
        TestHelpers.createTestWidget(
          AppErrorWidget(
            message: 'Error',
            onRetry: () => retryCalled = true,
          ),
        ),
      );

      await tester.tap(find.text('Retry'));
      expect(retryCalled, isTrue);
    });

    testWidgets('should center the error content', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestHelpers.createTestWidget(const AppErrorWidget(message: 'Error')),
      );

      expect(find.byType(Center), findsOneWidget);
    });

    testWidgets('should apply padding to content', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestHelpers.createTestWidget(const AppErrorWidget(message: 'Error')),
      );

      expect(find.byType(Padding), findsOneWidget);
    });

    testWidgets('should display icon, message, and button in correct order',
        (WidgetTester tester) async {
      bool retryCalled = false;
      await tester.pumpWidget(
        TestHelpers.createTestWidget(
          AppErrorWidget(
            message: 'Error message',
            onRetry: () => retryCalled = true,
          ),
        ),
      );

      final column = tester.widget<Column>(find.byType(Column));
      expect(column.children.length, equals(3));
      expect(column.children[0], isA<Icon>());
      expect(column.children[1], isA<Text>());
      expect(column.children[2], isA<ElevatedButton>());
    });
  });
}

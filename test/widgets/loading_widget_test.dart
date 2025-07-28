import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tickme/widgets/common/loading_widget.dart';
import '../helpers/test_helpers.dart';

void main() {
  group('LoadingWidget Tests', () {
    testWidgets('should display loading indicator',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TestHelpers.createTestWidget(const LoadingWidget()),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display custom message', (WidgetTester tester) async {
      const message = 'Loading data...';
      await tester.pumpWidget(
        TestHelpers.createTestWidget(const LoadingWidget(message: message)),
      );

      expect(find.text(message), findsOneWidget);
    });

    testWidgets('should not display message when null',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TestHelpers.createTestWidget(const LoadingWidget(message: null)),
      );

      expect(find.byType(Text), findsNothing);
    });

    testWidgets('should use custom size', (WidgetTester tester) async {
      const customSize = 100.0;
      await tester.pumpWidget(
        TestHelpers.createTestWidget(const LoadingWidget(size: customSize)),
      );

      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(sizedBox.width, equals(customSize));
      expect(sizedBox.height, equals(customSize));
    });

    testWidgets('should center the loading indicator',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TestHelpers.createTestWidget(const LoadingWidget()),
      );

      expect(find.byType(Center), findsOneWidget);
    });

    testWidgets('should display message below indicator',
        (WidgetTester tester) async {
      const message = 'Loading...';
      await tester.pumpWidget(
        TestHelpers.createTestWidget(const LoadingWidget(message: message)),
      );

      final column = tester.widget<Column>(find.byType(Column));
      expect(column.children.length, equals(3));
      expect(column.children[0], isA<SizedBox>()); // Loading indicator
      expect(column.children[1], isA<SizedBox>()); // Spacing
      expect(column.children[2], isA<Text>()); // Message
    });
  });
}

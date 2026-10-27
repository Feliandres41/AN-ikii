import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/responsive.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('keeps phone layout width unchanged', (tester) async {
    late double width;
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(400, 800)),
        child: Builder(
          builder: (context) {
            width = anchoDiseno(context);
            return const SizedBox();
          },
        ),
      ),
    );

    expect(width, 400);
  });

  testWidgets('caps design scale on tablets while keeping layout full width', (
    tester,
  ) async {
    late double width;
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(1024, 1366)),
        child: Builder(
          builder: (context) {
            width = anchoDiseno(context);
            return const SizedBox();
          },
        ),
      ),
    );

    expect(width, 600);
  });
}

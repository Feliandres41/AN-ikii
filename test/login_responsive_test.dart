import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/services/service_api.dart';
import 'package:flutter_application_1/themes/theme_apk.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

class _FakeServiceApi extends ChangeNotifier implements ServiceApi {
  @override
  Future<bool> restaurarSesion() async => false;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  for (final size in [const Size(320, 568), const Size(1024, 1366)]) {
    testWidgets('login fits and scrolls at ${size.width}px width', (
      tester,
    ) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<ThemeApk>(create: (_) => ThemeApk()),
            ChangeNotifierProvider<ServiceApi>.value(value: _FakeServiceApi()),
          ],
          child: const MaterialApp(home: LoginScreen()),
        ),
      );
      await tester.pumpAndSettle();

      final card = tester.getSize(find.byType(Card).first);
      expect(card.width, lessThanOrEqualTo(480));
      expect(find.text('Acceso seguro Institucional Sena'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('login button animates its width over 500ms on rotation', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeApk>(create: (_) => ThemeApk()),
          ChangeNotifierProvider<ServiceApi>.value(value: _FakeServiceApi()),
        ],
        child: const MaterialApp(home: LoginScreen()),
      ),
    );
    await tester.pumpAndSettle();

    final buttonWidth = find.byKey(const ValueKey('loginButtonWidth'));
    final startWidth = tester.getSize(buttonWidth).width;
    expect(
      tester.widget<AnimatedContainer>(buttonWidth).duration,
      const Duration(milliseconds: 500),
    );

    tester.view.physicalSize = const Size(568, 320);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));
    final middleWidth = tester.getSize(buttonWidth).width;

    await tester.pump(const Duration(milliseconds: 250));
    final endWidth = tester.getSize(buttonWidth).width;

    expect(endWidth, greaterThan(startWidth));
    expect(middleWidth, greaterThan(startWidth));
    expect(middleWidth, lessThan(endWidth));
    expect(tester.takeException(), isNull);
  });
}

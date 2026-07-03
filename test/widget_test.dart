import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:pbti/router/app_router.dart';
import 'package:pbti/state/test_session_state.dart';
import 'package:pbti/theme/app_theme.dart';

void main() {
  testWidgets('Home screen renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TestSessionState()),
        ],
        child: MaterialApp.router(
          theme: AppTheme.light,
          routerConfig: appRouter,
        ),
      ),
    );

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}

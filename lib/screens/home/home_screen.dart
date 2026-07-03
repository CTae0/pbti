import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/app_router.dart';

/// Step 5~7 진행 중 순차적으로 구현 예정. 임시로 화면 이동 테스트용 버튼 배치.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('PBTI Home - TODO'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.fullTest),
              child: const Text('상세 테스트 (40문항)'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.miniTest),
              child: const Text('미니 테스트 (12문항)'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.dashboard),
              child: const Text('여론 대시보드'),
            ),
          ],
        ),
      ),
    );
  }
}

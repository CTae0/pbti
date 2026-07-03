import 'package:go_router/go_router.dart';

import '../screens/dashboard/dashboard_screen.dart';
import '../screens/full_test/full_test_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/mini_test/mini_test_screen.dart';
import '../screens/result/result_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const home = '/';
  static const miniTest = '/test/mini';
  static const fullTest = '/test/full';
  static const result = '/result/:code';
  static const dashboard = '/dashboard';

  static String resultPath(String code) => '/result/$code';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.miniTest,
      name: 'miniTest',
      builder: (context, state) => const MiniTestScreen(),
    ),
    GoRoute(
      path: AppRoutes.fullTest,
      name: 'fullTest',
      builder: (context, state) => const FullTestScreen(),
    ),
    GoRoute(
      path: AppRoutes.result,
      name: 'result',
      builder: (context, state) {
        final code = state.pathParameters['code']!;
        return ResultScreen(resultCode: code);
      },
    ),
    GoRoute(
      path: AppRoutes.dashboard,
      name: 'dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
  ],
  errorBuilder: (context, state) => const HomeScreen(),
);

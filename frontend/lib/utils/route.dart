import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/pages/camera/camera_screen.dart';
import 'package:frontend/pages/dashboard/dashboard_page.dart';
import 'package:frontend/pages/error_page.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: DashboardPage.routeName,
    routes: [
      GoRoute(path: DashboardPage.routeName, builder: (context, state) => const DashboardPage()),
      GoRoute(path: CameraScreen.routeName, builder: (context, state) => const CameraScreen()),
    ],
    errorBuilder: (context, state) => const ErrorPage(),
  );
});

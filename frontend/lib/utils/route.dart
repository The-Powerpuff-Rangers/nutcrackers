import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutcracker/pages/camera/camera_screen.dart';
import 'package:nutcracker/pages/dashboard/dashboard_page.dart';
import 'package:nutcracker/pages/not_found_page.dart';
import 'package:nutcracker/pages/result/result_page.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: DashboardPage.routeName,
    routes: [
      GoRoute(path: DashboardPage.routeName, builder: (context, state) => const DashboardPage()),
      GoRoute(path: CameraScreen.routeName, builder: (context, state) => const CameraScreen()),
      GoRoute(path: ResultPage.routeName, builder: (context, state) => const ResultPage()),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );
});

import 'package:go_router/go_router.dart';
import 'package:nexus_manger_dashboard/domain/entity/repos_entity.dart';
import '../../presentation/dashboard/dashboard_page.dart';
import '../../presentation/login/login_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) {
          final repositories = state.extra as List<RepoEntity>? ?? [];
          return DashboardPage(repositories: repositories);
        },
      ),
    ],
  );
}


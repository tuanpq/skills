import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../screens/attempt_result_screen.dart';
import '../screens/exam_attempt_screen.dart';
import '../screens/home_shell.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/review_screen.dart';
import '../state/auth_provider.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      if (authState.isRestoring) return null;

      final loggingIn = state.matchedLocation == '/login' || state.matchedLocation == '/register';
      if (!authState.isAuthenticated && !loggingIn) return '/login';
      if (authState.isAuthenticated && loggingIn) return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
      GoRoute(path: '/', builder: (context, state) => const HomeShell()),
      GoRoute(
        path: '/attempts/:attemptId',
        builder: (context, state) => ExamAttemptScreen(
          attemptId: int.parse(state.pathParameters['attemptId']!),
        ),
      ),
      GoRoute(
        path: '/attempts/:attemptId/result',
        builder: (context, state) => AttemptResultScreen(
          attemptId: int.parse(state.pathParameters['attemptId']!),
        ),
      ),
      GoRoute(
        path: '/review/:type',
        builder: (context, state) => ReviewScreen(
          reviewType: state.pathParameters['type']!,
        ),
      ),
    ],
  );
});

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router/app_router.dart';
import 'state/auth_provider.dart';

void main() {
  runApp(const ProviderScope(child: JlptApp()));
}

class JlptApp extends ConsumerWidget {
  const JlptApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRestoring = ref.watch(authProvider.select((s) => s.isRestoring));
    final theme = ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true);

    if (isRestoring) {
      return MaterialApp(
        theme: theme,
        home: const Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'JLPT Luyện Thi',
      theme: theme,
      routerConfig: router,
    );
  }
}

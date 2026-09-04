import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/auth_provider.dart';
import 'dashboard_screen.dart';
import 'exam_list_screen.dart';
import 'progress_screen.dart';
import 'study_screen.dart';

const int _progressTabIndex = 3;

class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({super.key});

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  int _tabIndex = 0;

  static const _titles = ['JLPT 学習', 'Học tập', 'Luyện thi', 'Tiến độ'];

  void _goToTab(int index) {
    setState(() => _tabIndex = index);
    if (index == _progressTabIndex) {
      // Progress/history data can go stale while the tab sits inactive in the
      // IndexedStack, so force a refresh whenever the user navigates to it.
      ref.invalidate(myProgressProvider);
      ref.invalidate(myAttemptsProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      DashboardScreen(onNavigateToTab: _goToTab),
      const StudyScreen(),
      const ExamListScreen(),
      const ProgressScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_tabIndex]),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Đăng xuất',
            onPressed: () => ref.read(authProvider.notifier).logout(),
          ),
        ],
      ),
      body: IndexedStack(index: _tabIndex, children: screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabIndex,
        onDestinationSelected: _goToTab,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Trang chủ'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'Học'),
          NavigationDestination(icon: Icon(Icons.edit_note_outlined), selectedIcon: Icon(Icons.edit_note), label: 'Luyện thi'),
          NavigationDestination(icon: Icon(Icons.bar_chart_outlined), selectedIcon: Icon(Icons.bar_chart), label: 'Tiến độ'),
        ],
      ),
    );
  }
}

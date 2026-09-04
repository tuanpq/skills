import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/auth_provider.dart';
import '../widgets/level_dropdown.dart';

class DashboardScreen extends ConsumerWidget {
  final ValueChanged<int> onNavigateToTab;

  const DashboardScreen({super.key, required this.onNavigateToTab});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;
    final selectedLevel = ref.watch(selectedLevelProvider);

    final shortcuts = [
      ('Từ vựng', 'Học từ vựng dạng flashcard theo cấp độ', 1),
      ('Luyện thi', 'Làm đề luyện tập tổng hợp và xem kết quả', 2),
      ('Tiến độ', 'Theo dõi tiến độ học và lịch sử làm bài', 3),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Xin chào, ${user?.displayName ?? ''} 👋',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          const Text('Chọn cấp độ bạn đang luyện tập:'),
          const SizedBox(height: 4),
          LevelDropdown(
            value: selectedLevel,
            onChanged: (level) => ref.read(selectedLevelProvider.notifier).setLevel(level),
          ),
          const SizedBox(height: 16),
          ...shortcuts.map((s) => Card(
                child: ListTile(
                  title: Text(s.$1, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(s.$2),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => onNavigateToTab(s.$3),
                ),
              )),
        ],
      ),
    );
  }
}

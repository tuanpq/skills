import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/common.dart';
import '../models/exam.dart';
import '../models/study.dart';
import '../state/auth_provider.dart';

final myProgressProvider = FutureProvider<ProgressSummary>((ref) {
  return ref.watch(studyApiProvider).fetchMyProgress();
});

final myAttemptsProvider = FutureProvider<List<Attempt>>((ref) {
  return ref.watch(examApiProvider).fetchMyAttempts();
});

const _itemTypeLabels = {'VOCABULARY': 'Từ vựng', 'KANJI': 'Kanji', 'GRAMMAR': 'Ngữ pháp'};

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressAsync = ref.watch(myProgressProvider);
    final attemptsAsync = ref.watch(myAttemptsProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Tiến độ học tập', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        progressAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Text('Lỗi tải tiến độ: $e'),
          data: (progress) => Column(
            children: _itemTypeLabels.entries.map((entry) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entry.value, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      ...studyStatusLabels.entries.map((s) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(s.value),
                                Text('${progress.countFor(entry.key, s.key)}',
                                    style: const TextStyle(fontWeight: FontWeight.w600)),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
        const Text('Lịch sử làm bài', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        attemptsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Text('Lỗi tải lịch sử: $e'),
          data: (attempts) {
            if (attempts.isEmpty) return const Text('Chưa có lượt làm bài nào.');
            return Column(
              children: attempts.map((attempt) {
                final submitted = attempt.status == 'SUBMITTED';
                return Card(
                  child: ListTile(
                    title: Text(attempt.examTitle),
                    subtitle: Text(submitted ? 'Đã nộp' : 'Đang làm'),
                    trailing: submitted
                        ? OutlinedButton(
                            onPressed: () => context.push('/attempts/${attempt.id}/result'),
                            child: Text('${attempt.score}/${attempt.maxScore} điểm'),
                          )
                        : FilledButton(
                            onPressed: () => context.push('/attempts/${attempt.id}'),
                            child: const Text('Tiếp tục'),
                          ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

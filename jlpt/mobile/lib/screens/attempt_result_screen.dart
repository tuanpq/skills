import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/exam.dart';
import '../state/auth_provider.dart';

final attemptResultProvider = FutureProvider.family<AttemptResult, int>((ref, attemptId) {
  return ref.watch(examApiProvider).fetchAttemptResult(attemptId);
});

class AttemptResultScreen extends ConsumerWidget {
  final int attemptId;
  const AttemptResultScreen({super.key, required this.attemptId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(attemptResultProvider(attemptId));

    return Scaffold(
      appBar: AppBar(title: const Text('Kết quả bài thi')),
      body: resultAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Lỗi tải kết quả: $e')),
        data: (result) {
          final percentage = result.maxScore > 0 ? (result.score / result.maxScore * 100).round() : 0;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text('Điểm số', style: TextStyle(color: Colors.grey)),
                      Text('${result.score}/${result.maxScore}',
                          style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.indigo)),
                      Text('$percentage% chính xác', style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ...result.answers.asMap().entries.map((entry) {
                final index = entry.key;
                final answer = entry.value;
                return Card(
                  color: answer.correct ? Colors.green.shade50 : Colors.red.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Câu ${index + 1} · ${answer.correct ? "Đúng" : "Sai"}',
                            style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        const SizedBox(height: 4),
                        Text(answer.questionText, style: const TextStyle(fontWeight: FontWeight.w600)),
                        if (answer.explanation != null) ...[
                          const SizedBox(height: 6),
                          Text(answer.explanation!),
                        ],
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => context.go('/'),
                      child: const Text('Về trang chủ'),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

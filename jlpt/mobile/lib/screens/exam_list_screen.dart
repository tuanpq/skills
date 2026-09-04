import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/common.dart';
import '../models/exam.dart';
import '../state/auth_provider.dart';
import '../widgets/level_dropdown.dart';

final examsProvider = FutureProvider.family<List<ExamSummary>, ({String level, String? skill})>((ref, params) {
  return ref.watch(examApiProvider).fetchExams(params.level, skill: params.skill);
});

class ExamListScreen extends ConsumerStatefulWidget {
  const ExamListScreen({super.key});

  @override
  ConsumerState<ExamListScreen> createState() => _ExamListScreenState();
}

class _ExamListScreenState extends ConsumerState<ExamListScreen> {
  String? _skill;
  bool _starting = false;

  Future<void> _startExam(int examId) async {
    setState(() => _starting = true);
    try {
      final attempt = await ref.read(examApiProvider).startAttempt(examId);
      if (mounted) context.push('/attempts/${attempt.id}');
    } finally {
      if (mounted) setState(() => _starting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final level = ref.watch(selectedLevelProvider);
    final examsAsync = ref.watch(examsProvider((level: level, skill: _skill)));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Luyện thi', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Row(children: [
                LevelDropdown(
                  value: level,
                  onChanged: (l) => ref.read(selectedLevelProvider.notifier).setLevel(l),
                ),
                const SizedBox(width: 8),
                DropdownButton<String?>(
                  value: _skill,
                  hint: const Text('Tất cả'),
                  items: [
                    const DropdownMenuItem(value: null, child: Text('Tất cả kỹ năng')),
                    ...skillLabels.entries
                        .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value))),
                  ],
                  onChanged: (value) => setState(() => _skill = value),
                ),
              ]),
            ],
          ),
        ),
        Expanded(
          child: examsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Lỗi tải danh sách đề: $e')),
            data: (exams) {
              if (exams.isEmpty) return const Center(child: Text('Chưa có đề cho cấp độ này.'));
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: exams.length,
                itemBuilder: (context, index) {
                  final exam = exams[index];
                  return Card(
                    child: ListTile(
                      title: Text(exam.title),
                      subtitle: Text('${exam.questionCount} câu · ${exam.timeLimitMinutes} phút'),
                      trailing: FilledButton(
                        onPressed: _starting ? null : () => _startExam(exam.id),
                        child: const Text('Bắt đầu'),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

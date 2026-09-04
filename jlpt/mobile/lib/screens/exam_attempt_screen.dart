import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/exam.dart';
import '../state/auth_provider.dart';
import '../widgets/question_card.dart';

final attemptProvider = FutureProvider.family<Attempt, int>((ref, attemptId) {
  return ref.watch(examApiProvider).fetchAttempt(attemptId);
});

class ExamAttemptScreen extends ConsumerStatefulWidget {
  final int attemptId;
  const ExamAttemptScreen({super.key, required this.attemptId});

  @override
  ConsumerState<ExamAttemptScreen> createState() => _ExamAttemptScreenState();
}

class _ExamAttemptScreenState extends ConsumerState<ExamAttemptScreen> {
  final Map<int, int> _answers = {};
  bool _submitting = false;

  void _select(int questionId, int choiceId) {
    setState(() => _answers[questionId] = choiceId);
    ref.read(examApiProvider).submitAnswer(widget.attemptId, questionId, choiceId);
  }

  Future<void> _submit() async {
    setState(() => _submitting = true);
    try {
      await ref.read(examApiProvider).submitAttempt(widget.attemptId);
      if (mounted) context.replace('/attempts/${widget.attemptId}/result');
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final attemptAsync = ref.watch(attemptProvider(widget.attemptId));

    return Scaffold(
      appBar: AppBar(title: const Text('Làm bài')),
      body: attemptAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Lỗi tải đề thi: $e')),
        data: (attempt) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(attempt.examTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text('Đã trả lời ${_answers.length}/${attempt.questions.length} câu'),
                        ],
                      ),
                    ),
                    FilledButton(
                      onPressed: _submitting ? null : _submit,
                      style: FilledButton.styleFrom(backgroundColor: Colors.green.shade700),
                      child: Text(_submitting ? 'Đang nộp...' : 'Nộp bài'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: attempt.questions.length,
                  itemBuilder: (context, index) {
                    final question = attempt.questions[index];
                    return QuestionCard(
                      index: index,
                      question: question,
                      selectedChoiceId: _answers[question.id],
                      onSelect: (choiceId) => _select(question.id, choiceId),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

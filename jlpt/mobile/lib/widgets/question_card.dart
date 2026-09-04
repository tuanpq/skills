import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/common.dart';
import '../models/exam.dart';
import '../state/auth_provider.dart';

final listeningAudioProvider = FutureProvider.family((ref, int audioId) {
  return ref.watch(contentApiProvider).fetchListeningAudio(audioId);
});

class QuestionResultInfo {
  final int? correctChoiceId;
  final bool correct;
  const QuestionResultInfo({required this.correctChoiceId, required this.correct});
}

class QuestionCard extends ConsumerWidget {
  final int index;
  final QuestionForAttempt question;
  final int? selectedChoiceId;
  final ValueChanged<int> onSelect;
  final QuestionResultInfo? result;

  const QuestionCard({
    super.key,
    required this.index,
    required this.question,
    required this.selectedChoiceId,
    required this.onSelect,
    this.result,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Chip(
                  label: Text(skillLabels[question.skillType] ?? question.skillType,
                      style: const TextStyle(fontSize: 11)),
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                const SizedBox(width: 8),
                Text('Câu ${index + 1}', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
              ],
            ),
            if (question.passageContent != null) ...[
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(6)),
                child: Text(question.passageContent!),
              ),
            ],
            if (question.listeningAudioId != null) ...[
              const SizedBox(height: 8),
              _ListeningNotice(audioId: question.listeningAudioId!),
            ],
            const SizedBox(height: 8),
            Text(question.questionText, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            RadioGroup<int>(
              groupValue: selectedChoiceId,
              onChanged: result != null ? (_) {} : (value) => onSelect(value!),
              child: Column(
                children: question.choices.map((choice) {
                  Color? tileColor;
                  if (result != null) {
                    if (choice.id == result!.correctChoiceId) {
                      tileColor = Colors.green.shade50;
                    } else if (choice.id == selectedChoiceId && !result!.correct) {
                      tileColor = Colors.red.shade50;
                    }
                  }
                  return RadioListTile<int>(
                    dense: true,
                    tileColor: tileColor,
                    value: choice.id,
                    title: Text(choice.choiceText),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListeningNotice extends ConsumerWidget {
  final int audioId;
  const _ListeningNotice({required this.audioId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioAsync = ref.watch(listeningAudioProvider(audioId));
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(6)),
      child: audioAsync.when(
        data: (audio) => Text(
          audio.audioUrl != null
              ? 'Audio: ${audio.audioUrl}'
              : 'Audio chưa được tải lên cho câu hỏi này.',
          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey.shade600),
        ),
        loading: () => const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2)),
        error: (_, __) => const Text('Không tải được thông tin audio.'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/study.dart';
import '../state/auth_provider.dart';
import '../widgets/study_card_content.dart';

const Map<String, String> _reviewItemTypes = {
  'vocabulary': 'VOCABULARY',
  'kanji': 'KANJI',
  'grammar': 'GRAMMAR',
};

const Map<String, String> _reviewTitles = {
  'vocabulary': 'Từ vựng',
  'kanji': 'Kanji',
  'grammar': 'Ngữ pháp',
};

final reviewQueueProvider =
    FutureProvider.family<List<dynamic>, ({String type, String level})>((ref, params) async {
  final api = ref.watch(studyApiProvider);
  switch (params.type) {
    case 'kanji':
      return api.fetchKanjiDue(params.level);
    case 'grammar':
      return api.fetchGrammarDue(params.level);
    default:
      return api.fetchVocabularyDue(params.level);
  }
});

int _itemIdOf(String type, dynamic entry) {
  switch (type) {
    case 'kanji':
      return (entry as KanjiStudy).item.id;
    case 'grammar':
      return (entry as GrammarStudy).item.id;
    default:
      return (entry as VocabularyStudy).item.id;
  }
}

StudyCardContent _cardOf(String type, dynamic entry) {
  switch (type) {
    case 'kanji':
      return buildKanjiCard((entry as KanjiStudy).item);
    case 'grammar':
      return buildGrammarCard((entry as GrammarStudy).item);
    default:
      return buildVocabularyCard((entry as VocabularyStudy).item);
  }
}

class _RatingOption {
  final String label;
  final int quality;
  final Color color;
  const _RatingOption(this.label, this.quality, this.color);
}

const _ratingOptions = [
  _RatingOption('Lại', 0, Colors.red),
  _RatingOption('Khó', 3, Colors.orange),
  _RatingOption('Tốt', 4, Colors.green),
  _RatingOption('Dễ', 5, Colors.blue),
];

class ReviewScreen extends ConsumerStatefulWidget {
  final String reviewType;
  const ReviewScreen({super.key, required this.reviewType});

  @override
  ConsumerState<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {
  int _index = 0;
  bool _flipped = false;
  bool _submitting = false;

  Future<void> _rate(String level, dynamic entry, int quality) async {
    setState(() => _submitting = true);
    try {
      await ref.read(studyApiProvider).submitReview(
            _reviewItemTypes[widget.reviewType]!,
            _itemIdOf(widget.reviewType, entry),
            quality,
          );
      setState(() {
        _index += 1;
        _flipped = false;
      });
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final level = ref.watch(selectedLevelProvider);
    final title = _reviewTitles[widget.reviewType] ?? widget.reviewType;
    final queueAsync = ref.watch(reviewQueueProvider((type: widget.reviewType, level: level)));

    return Scaffold(
      appBar: AppBar(title: Text('Ôn tập · $title')),
      body: queueAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Lỗi tải dữ liệu: $e')),
        data: (queue) {
          if (_index >= queue.length) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('🎉', style: TextStyle(fontSize: 48)),
                    const SizedBox(height: 12),
                    Text(
                      queue.isEmpty
                          ? 'Không có thẻ nào đến hạn hôm nay'
                          : 'Hoàn thành! Không còn thẻ nào đến hạn hôm nay',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () => context.go('/'),
                      child: Text('Quay lại $title'),
                    ),
                  ],
                ),
              ),
            );
          }

          final entry = queue[_index];
          final card = _cardOf(widget.reviewType, entry);

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('${_index + 1}/${queue.length}', style: TextStyle(color: Colors.grey.shade600)),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () => setState(() => _flipped = !_flipped),
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 180),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _flipped ? card.back : card.front,
                          if (!_flipped) ...[
                            const SizedBox(height: 12),
                            Text('(chạm để xem đáp án)', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (_flipped)
                  Row(
                    children: _ratingOptions.map((option) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: FilledButton(
                            style: FilledButton.styleFrom(backgroundColor: option.color),
                            onPressed: _submitting ? null : () => _rate(level, entry, option.quality),
                            child: Text(option.label),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

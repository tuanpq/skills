import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/study.dart';
import '../state/auth_provider.dart';
import '../widgets/flashcard.dart';
import '../widgets/level_dropdown.dart';
import '../widgets/study_card_content.dart';

final vocabularyStudyProvider =
    FutureProvider.family<List<VocabularyStudy>, String>((ref, level) {
  return ref.watch(studyApiProvider).fetchVocabularyStudy(level);
});

final kanjiStudyProvider = FutureProvider.family<List<KanjiStudy>, String>((ref, level) {
  return ref.watch(studyApiProvider).fetchKanjiStudy(level);
});

final grammarStudyProvider = FutureProvider.family<List<GrammarStudy>, String>((ref, level) {
  return ref.watch(studyApiProvider).fetchGrammarStudy(level);
});

final vocabularyDueCountProvider = FutureProvider.family<int, String>((ref, level) async {
  return (await ref.watch(studyApiProvider).fetchVocabularyDue(level)).length;
});

final kanjiDueCountProvider = FutureProvider.family<int, String>((ref, level) async {
  return (await ref.watch(studyApiProvider).fetchKanjiDue(level)).length;
});

final grammarDueCountProvider = FutureProvider.family<int, String>((ref, level) async {
  return (await ref.watch(studyApiProvider).fetchGrammarDue(level)).length;
});

class StudyScreen extends ConsumerStatefulWidget {
  const StudyScreen({super.key});

  @override
  ConsumerState<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends ConsumerState<StudyScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final level = ref.watch(selectedLevelProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Học tập', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              LevelDropdown(
                value: level,
                onChanged: (l) => ref.read(selectedLevelProvider.notifier).setLevel(l),
              ),
            ],
          ),
        ),
        TabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'Từ vựng'), Tab(text: 'Kanji'), Tab(text: 'Ngữ pháp')],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _VocabularyTab(level: level),
              _KanjiTab(level: level),
              _GrammarTab(level: level),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReviewButton extends ConsumerWidget {
  final AsyncValue<int> dueCount;
  final String reviewType;

  const _ReviewButton({required this.dueCount, required this.reviewType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Material(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => context.push('/review/$reviewType'),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('🔁 Ôn tập ngay',
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.indigo)),
                Text(
                  dueCount.when(
                    data: (n) => '$n thẻ đến hạn',
                    loading: () => '…',
                    error: (_, __) => '—',
                  ),
                  style: const TextStyle(color: Colors.indigo),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _VocabularyTab extends ConsumerWidget {
  final String level;
  const _VocabularyTab({required this.level});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(vocabularyStudyProvider(level));
    final dueCount = ref.watch(vocabularyDueCountProvider(level));
    return Column(
      children: [
        _ReviewButton(dueCount: dueCount, reviewType: 'vocabulary'),
        Expanded(
          child: entries.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Lỗi tải dữ liệu: $e')),
            data: (items) {
              if (items.isEmpty) return const Center(child: Text('Chưa có dữ liệu cho cấp độ này.'));
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final entry = items[index];
                  final card = buildVocabularyCard(entry.item);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Flashcard(
                      front: card.front,
                      back: card.back,
                      status: entry.status,
                      onStatusChange: (status) async {
                        await ref.read(studyApiProvider).updateProgress('VOCABULARY', entry.item.id, status);
                        ref.invalidate(vocabularyStudyProvider(level));
                      },
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

class _KanjiTab extends ConsumerWidget {
  final String level;
  const _KanjiTab({required this.level});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(kanjiStudyProvider(level));
    final dueCount = ref.watch(kanjiDueCountProvider(level));
    return Column(
      children: [
        _ReviewButton(dueCount: dueCount, reviewType: 'kanji'),
        Expanded(
          child: entries.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Lỗi tải dữ liệu: $e')),
            data: (items) {
              if (items.isEmpty) return const Center(child: Text('Chưa có dữ liệu cho cấp độ này.'));
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final entry = items[index];
                  final card = buildKanjiCard(entry.item);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Flashcard(
                      front: card.front,
                      back: card.back,
                      status: entry.status,
                      onStatusChange: (status) async {
                        await ref.read(studyApiProvider).updateProgress('KANJI', entry.item.id, status);
                        ref.invalidate(kanjiStudyProvider(level));
                      },
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

class _GrammarTab extends ConsumerWidget {
  final String level;
  const _GrammarTab({required this.level});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(grammarStudyProvider(level));
    final dueCount = ref.watch(grammarDueCountProvider(level));
    return Column(
      children: [
        _ReviewButton(dueCount: dueCount, reviewType: 'grammar'),
        Expanded(
          child: entries.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Lỗi tải dữ liệu: $e')),
            data: (items) {
              if (items.isEmpty) return const Center(child: Text('Chưa có dữ liệu cho cấp độ này.'));
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final entry = items[index];
                  final card = buildGrammarCard(entry.item);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Flashcard(
                      front: card.front,
                      back: card.back,
                      status: entry.status,
                      onStatusChange: (status) async {
                        await ref.read(studyApiProvider).updateProgress('GRAMMAR', entry.item.id, status);
                        ref.invalidate(grammarStudyProvider(level));
                      },
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

import 'content.dart';

class VocabularyStudy {
  final VocabularyItem item;
  final String status;

  VocabularyStudy({required this.item, required this.status});

  factory VocabularyStudy.fromJson(Map<String, dynamic> json) => VocabularyStudy(
        item: VocabularyItem.fromJson(json['item'] as Map<String, dynamic>),
        status: json['status'] as String,
      );
}

class KanjiStudy {
  final KanjiItem item;
  final String status;

  KanjiStudy({required this.item, required this.status});

  factory KanjiStudy.fromJson(Map<String, dynamic> json) => KanjiStudy(
        item: KanjiItem.fromJson(json['item'] as Map<String, dynamic>),
        status: json['status'] as String,
      );
}

class GrammarStudy {
  final GrammarPoint item;
  final String status;

  GrammarStudy({required this.item, required this.status});

  factory GrammarStudy.fromJson(Map<String, dynamic> json) => GrammarStudy(
        item: GrammarPoint.fromJson(json['item'] as Map<String, dynamic>),
        status: json['status'] as String,
      );
}

class ProgressSummary {
  /// itemType -> status -> count
  final Map<String, Map<String, int>> countsByItemTypeAndStatus;

  ProgressSummary({required this.countsByItemTypeAndStatus});

  factory ProgressSummary.fromJson(Map<String, dynamic> json) {
    final raw = json['countsByItemTypeAndStatus'] as Map<String, dynamic>? ?? {};
    final result = <String, Map<String, int>>{};
    raw.forEach((itemType, statusCounts) {
      final counts = <String, int>{};
      (statusCounts as Map<String, dynamic>).forEach((status, count) {
        counts[status] = (count as num).toInt();
      });
      result[itemType] = counts;
    });
    return ProgressSummary(countsByItemTypeAndStatus: result);
  }

  int countFor(String itemType, String status) => countsByItemTypeAndStatus[itemType]?[status] ?? 0;
}

class ReviewResult {
  final String status;
  final int intervalDays;
  final String nextReviewAt;

  ReviewResult({required this.status, required this.intervalDays, required this.nextReviewAt});

  factory ReviewResult.fromJson(Map<String, dynamic> json) => ReviewResult(
        status: json['status'] as String,
        intervalDays: json['intervalDays'] as int,
        nextReviewAt: json['nextReviewAt'] as String,
      );
}

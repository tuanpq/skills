import 'package:dio/dio.dart';

import '../models/study.dart';

class StudyApi {
  final Dio dio;
  StudyApi(this.dio);

  static const _pageSize = 50;

  Future<List<VocabularyStudy>> fetchVocabularyStudy(String level) async {
    final response =
        await dio.get('/api/study/vocabulary', queryParameters: {'level': level, 'size': _pageSize});
    return (response.data as List<dynamic>)
        .map((e) => VocabularyStudy.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<KanjiStudy>> fetchKanjiStudy(String level) async {
    final response = await dio.get('/api/study/kanji', queryParameters: {'level': level, 'size': _pageSize});
    return (response.data as List<dynamic>)
        .map((e) => KanjiStudy.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<GrammarStudy>> fetchGrammarStudy(String level) async {
    final response =
        await dio.get('/api/study/grammar', queryParameters: {'level': level, 'size': _pageSize});
    return (response.data as List<dynamic>)
        .map((e) => GrammarStudy.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateProgress(String itemType, int itemId, String status) async {
    await dio.post('/api/study/progress', data: {
      'itemType': itemType,
      'itemId': itemId,
      'status': status,
    });
  }

  Future<ProgressSummary> fetchMyProgress() async {
    final response = await dio.get('/api/users/me/progress');
    return ProgressSummary.fromJson(response.data as Map<String, dynamic>);
  }

  Future<List<VocabularyStudy>> fetchVocabularyDue(String level) async {
    final response =
        await dio.get('/api/study/vocabulary/due', queryParameters: {'level': level, 'size': _pageSize});
    return (response.data as List<dynamic>)
        .map((e) => VocabularyStudy.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<KanjiStudy>> fetchKanjiDue(String level) async {
    final response =
        await dio.get('/api/study/kanji/due', queryParameters: {'level': level, 'size': _pageSize});
    return (response.data as List<dynamic>)
        .map((e) => KanjiStudy.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<GrammarStudy>> fetchGrammarDue(String level) async {
    final response =
        await dio.get('/api/study/grammar/due', queryParameters: {'level': level, 'size': _pageSize});
    return (response.data as List<dynamic>)
        .map((e) => GrammarStudy.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ReviewResult> submitReview(String itemType, int itemId, int quality) async {
    final response = await dio.post('/api/study/review', data: {
      'itemType': itemType,
      'itemId': itemId,
      'quality': quality,
    });
    return ReviewResult.fromJson(response.data as Map<String, dynamic>);
  }
}

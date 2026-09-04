import 'package:dio/dio.dart';

import '../models/common.dart';
import '../models/content.dart';

class ContentApi {
  final Dio dio;
  ContentApi(this.dio);

  static const _pageSize = 50;

  Future<List<VocabularyItem>> fetchVocabulary(String level) async {
    final response = await dio.get('/api/vocabulary', queryParameters: {'level': level, 'size': _pageSize});
    return ApiPage.fromJson(response.data as Map<String, dynamic>, VocabularyItem.fromJson).content;
  }

  Future<List<KanjiItem>> fetchKanji(String level) async {
    final response = await dio.get('/api/kanji', queryParameters: {'level': level, 'size': _pageSize});
    return ApiPage.fromJson(response.data as Map<String, dynamic>, KanjiItem.fromJson).content;
  }

  Future<List<GrammarPoint>> fetchGrammar(String level) async {
    final response = await dio.get('/api/grammar', queryParameters: {'level': level, 'size': _pageSize});
    return ApiPage.fromJson(response.data as Map<String, dynamic>, GrammarPoint.fromJson).content;
  }

  Future<ListeningAudio> fetchListeningAudio(int id) async {
    final response = await dio.get('/api/listening-audios/$id');
    return ListeningAudio.fromJson(response.data as Map<String, dynamic>);
  }
}

import 'package:dio/dio.dart';

import '../models/exam.dart';

class ExamApi {
  final Dio dio;
  ExamApi(this.dio);

  Future<List<ExamSummary>> fetchExams(String level, {String? skill}) async {
    final response = await dio.get('/api/exams', queryParameters: {
      'level': level,
      if (skill != null) 'skill': skill,
    });
    return (response.data as List<dynamic>)
        .map((e) => ExamSummary.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Attempt> startAttempt(int examId) async {
    final response = await dio.post('/api/exams/$examId/attempts');
    return Attempt.fromJson(response.data as Map<String, dynamic>);
  }

  Future<Attempt> fetchAttempt(int attemptId) async {
    final response = await dio.get('/api/attempts/$attemptId');
    return Attempt.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> submitAnswer(int attemptId, int questionId, int? selectedChoiceId) async {
    await dio.put('/api/attempts/$attemptId/answers', data: {
      'questionId': questionId,
      'selectedChoiceId': selectedChoiceId,
    });
  }

  Future<AttemptResult> submitAttempt(int attemptId) async {
    final response = await dio.post('/api/attempts/$attemptId/submit');
    return AttemptResult.fromJson(response.data as Map<String, dynamic>);
  }

  Future<AttemptResult> fetchAttemptResult(int attemptId) async {
    final response = await dio.get('/api/attempts/$attemptId/result');
    return AttemptResult.fromJson(response.data as Map<String, dynamic>);
  }

  Future<List<Attempt>> fetchMyAttempts() async {
    final response = await dio.get('/api/users/me/attempts');
    return (response.data as List<dynamic>)
        .map((e) => Attempt.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

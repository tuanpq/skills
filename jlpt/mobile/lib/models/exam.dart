class ChoiceOption {
  final int id;
  final String choiceText;
  final int displayOrder;

  ChoiceOption({required this.id, required this.choiceText, required this.displayOrder});

  factory ChoiceOption.fromJson(Map<String, dynamic> json) => ChoiceOption(
        id: json['id'] as int,
        choiceText: json['choiceText'] as String,
        displayOrder: json['displayOrder'] as int,
      );
}

class QuestionForAttempt {
  final int id;
  final String skillType;
  final String questionText;
  final String? passageContent;
  final int? listeningAudioId;
  final List<ChoiceOption> choices;

  QuestionForAttempt({
    required this.id,
    required this.skillType,
    required this.questionText,
    this.passageContent,
    this.listeningAudioId,
    required this.choices,
  });

  factory QuestionForAttempt.fromJson(Map<String, dynamic> json) => QuestionForAttempt(
        id: json['id'] as int,
        skillType: json['skillType'] as String,
        questionText: json['questionText'] as String,
        passageContent: json['passageContent'] as String?,
        listeningAudioId: json['listeningAudioId'] as int?,
        choices: (json['choices'] as List<dynamic>)
            .map((e) => ChoiceOption.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

class ExamSummary {
  final int id;
  final String level;
  final String title;
  final String examType;
  final String? skillType;
  final int timeLimitMinutes;
  final int questionCount;

  ExamSummary({
    required this.id,
    required this.level,
    required this.title,
    required this.examType,
    this.skillType,
    required this.timeLimitMinutes,
    required this.questionCount,
  });

  factory ExamSummary.fromJson(Map<String, dynamic> json) => ExamSummary(
        id: json['id'] as int,
        level: json['level'] as String,
        title: json['title'] as String,
        examType: json['examType'] as String,
        skillType: json['skillType'] as String?,
        timeLimitMinutes: json['timeLimitMinutes'] as int,
        questionCount: json['questionCount'] as int,
      );
}

class Attempt {
  final int id;
  final int examId;
  final String examTitle;
  final String status;
  final String startedAt;
  final String? submittedAt;
  final int? score;
  final int? maxScore;
  final List<QuestionForAttempt> questions;

  Attempt({
    required this.id,
    required this.examId,
    required this.examTitle,
    required this.status,
    required this.startedAt,
    this.submittedAt,
    this.score,
    this.maxScore,
    required this.questions,
  });

  factory Attempt.fromJson(Map<String, dynamic> json) => Attempt(
        id: json['id'] as int,
        examId: json['examId'] as int,
        examTitle: json['examTitle'] as String,
        status: json['status'] as String,
        startedAt: json['startedAt'] as String,
        submittedAt: json['submittedAt'] as String?,
        score: json['score'] as int?,
        maxScore: json['maxScore'] as int?,
        questions: (json['questions'] as List<dynamic>)
            .map((e) => QuestionForAttempt.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

class AnswerResult {
  final int questionId;
  final String questionText;
  final int? selectedChoiceId;
  final int? correctChoiceId;
  final bool correct;
  final String? explanation;

  AnswerResult({
    required this.questionId,
    required this.questionText,
    this.selectedChoiceId,
    this.correctChoiceId,
    required this.correct,
    this.explanation,
  });

  factory AnswerResult.fromJson(Map<String, dynamic> json) => AnswerResult(
        questionId: json['questionId'] as int,
        questionText: json['questionText'] as String,
        selectedChoiceId: json['selectedChoiceId'] as int?,
        correctChoiceId: json['correctChoiceId'] as int?,
        correct: json['correct'] as bool,
        explanation: json['explanation'] as String?,
      );
}

class AttemptResult {
  final int attemptId;
  final int examId;
  final int score;
  final int maxScore;
  final String submittedAt;
  final List<AnswerResult> answers;

  AttemptResult({
    required this.attemptId,
    required this.examId,
    required this.score,
    required this.maxScore,
    required this.submittedAt,
    required this.answers,
  });

  factory AttemptResult.fromJson(Map<String, dynamic> json) => AttemptResult(
        attemptId: json['attemptId'] as int,
        examId: json['examId'] as int,
        score: json['score'] as int,
        maxScore: json['maxScore'] as int,
        submittedAt: json['submittedAt'] as String,
        answers: (json['answers'] as List<dynamic>)
            .map((e) => AnswerResult.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

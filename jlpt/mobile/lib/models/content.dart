class VocabularyItem {
  final int id;
  final String level;
  final String word;
  final String reading;
  final String meaningVi;
  final String? meaningEn;
  final String? partOfSpeech;
  final String? exampleSentence;
  final String? exampleReading;
  final String? exampleMeaning;

  VocabularyItem({
    required this.id,
    required this.level,
    required this.word,
    required this.reading,
    required this.meaningVi,
    this.meaningEn,
    this.partOfSpeech,
    this.exampleSentence,
    this.exampleReading,
    this.exampleMeaning,
  });

  factory VocabularyItem.fromJson(Map<String, dynamic> json) => VocabularyItem(
        id: json['id'] as int,
        level: json['level'] as String,
        word: json['word'] as String,
        reading: json['reading'] as String,
        meaningVi: json['meaningVi'] as String,
        meaningEn: json['meaningEn'] as String?,
        partOfSpeech: json['partOfSpeech'] as String?,
        exampleSentence: json['exampleSentence'] as String?,
        exampleReading: json['exampleReading'] as String?,
        exampleMeaning: json['exampleMeaning'] as String?,
      );
}

class KanjiItem {
  final int id;
  final String level;
  final String character;
  final String? onyomi;
  final String? kunyomi;
  final String meaningVi;
  final int? strokeCount;
  final String? exampleWords;

  KanjiItem({
    required this.id,
    required this.level,
    required this.character,
    this.onyomi,
    this.kunyomi,
    required this.meaningVi,
    this.strokeCount,
    this.exampleWords,
  });

  factory KanjiItem.fromJson(Map<String, dynamic> json) => KanjiItem(
        id: json['id'] as int,
        level: json['level'] as String,
        character: json['character'] as String,
        onyomi: json['onyomi'] as String?,
        kunyomi: json['kunyomi'] as String?,
        meaningVi: json['meaningVi'] as String,
        strokeCount: json['strokeCount'] as int?,
        exampleWords: json['exampleWords'] as String?,
      );
}

class GrammarPoint {
  final int id;
  final String level;
  final String pattern;
  final String meaningVi;
  final String? meaningEn;
  final String? usageNote;
  final String? exampleSentence;
  final String? exampleMeaning;

  GrammarPoint({
    required this.id,
    required this.level,
    required this.pattern,
    required this.meaningVi,
    this.meaningEn,
    this.usageNote,
    this.exampleSentence,
    this.exampleMeaning,
  });

  factory GrammarPoint.fromJson(Map<String, dynamic> json) => GrammarPoint(
        id: json['id'] as int,
        level: json['level'] as String,
        pattern: json['pattern'] as String,
        meaningVi: json['meaningVi'] as String,
        meaningEn: json['meaningEn'] as String?,
        usageNote: json['usageNote'] as String?,
        exampleSentence: json['exampleSentence'] as String?,
        exampleMeaning: json['exampleMeaning'] as String?,
      );
}

class ListeningAudio {
  final int id;
  final String level;
  final String title;
  final String? audioUrl;
  final String? transcript;
  final int? durationSeconds;

  ListeningAudio({
    required this.id,
    required this.level,
    required this.title,
    this.audioUrl,
    this.transcript,
    this.durationSeconds,
  });

  factory ListeningAudio.fromJson(Map<String, dynamic> json) => ListeningAudio(
        id: json['id'] as int,
        level: json['level'] as String,
        title: json['title'] as String,
        audioUrl: json['audioUrl'] as String?,
        transcript: json['transcript'] as String?,
        durationSeconds: json['durationSeconds'] as int?,
      );
}

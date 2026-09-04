import 'package:flutter/material.dart';

import '../models/content.dart';

class StudyCardContent {
  final Widget front;
  final Widget back;
  StudyCardContent({required this.front, required this.back});
}

StudyCardContent buildVocabularyCard(VocabularyItem item) {
  return StudyCardContent(
    front: Column(mainAxisSize: MainAxisSize.min, children: [
      Text(item.word, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
      Text(item.reading, style: TextStyle(color: Colors.grey.shade600)),
    ]),
    back: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
      Text(item.meaningVi, style: const TextStyle(fontWeight: FontWeight.w600)),
      if (item.meaningEn != null) Text(item.meaningEn!),
      if (item.exampleSentence != null) ...[
        const Divider(),
        Text(item.exampleSentence!),
        Text(item.exampleReading ?? '', style: TextStyle(color: Colors.grey.shade500)),
        Text(item.exampleMeaning ?? ''),
      ],
    ]),
  );
}

StudyCardContent buildKanjiCard(KanjiItem item) {
  return StudyCardContent(
    front: Text(item.character, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
    back: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
      Text(item.meaningVi, style: const TextStyle(fontWeight: FontWeight.w600)),
      Text('音: ${item.onyomi ?? "—"}'),
      Text('訓: ${item.kunyomi ?? "—"}'),
      if (item.strokeCount != null) Text('${item.strokeCount} nét'),
      if (item.exampleWords != null) ...[const Divider(), Text(item.exampleWords!)],
    ]),
  );
}

StudyCardContent buildGrammarCard(GrammarPoint item) {
  return StudyCardContent(
    front: Text(item.pattern,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
    back: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
      Text(item.meaningVi, style: const TextStyle(fontWeight: FontWeight.w600)),
      if (item.usageNote != null) Text(item.usageNote!),
      if (item.exampleSentence != null) ...[
        const Divider(),
        Text(item.exampleSentence!),
        Text(item.exampleMeaning ?? ''),
      ],
    ]),
  );
}

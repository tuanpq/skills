package com.jlpt.backend.dto.content;

import com.jlpt.backend.entity.JlptLevel;
import com.jlpt.backend.entity.VocabularyItem;

public record VocabularyResponse(
        Long id,
        JlptLevel level,
        String word,
        String reading,
        String meaningVi,
        String meaningEn,
        String partOfSpeech,
        String exampleSentence,
        String exampleReading,
        String exampleMeaning
) {
    public static VocabularyResponse from(VocabularyItem item) {
        return new VocabularyResponse(item.getId(), item.getLevel(), item.getWord(), item.getReading(),
                item.getMeaningVi(), item.getMeaningEn(), item.getPartOfSpeech(),
                item.getExampleSentence(), item.getExampleReading(), item.getExampleMeaning());
    }
}

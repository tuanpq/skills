package com.jlpt.backend.dto.content;

import com.jlpt.backend.entity.GrammarPoint;
import com.jlpt.backend.entity.JlptLevel;

public record GrammarResponse(
        Long id,
        JlptLevel level,
        String pattern,
        String meaningVi,
        String meaningEn,
        String usageNote,
        String exampleSentence,
        String exampleMeaning
) {
    public static GrammarResponse from(GrammarPoint item) {
        return new GrammarResponse(item.getId(), item.getLevel(), item.getPattern(), item.getMeaningVi(),
                item.getMeaningEn(), item.getUsageNote(), item.getExampleSentence(), item.getExampleMeaning());
    }
}

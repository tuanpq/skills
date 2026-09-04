package com.jlpt.backend.dto.content;

import com.jlpt.backend.entity.JlptLevel;
import com.jlpt.backend.entity.KanjiItem;

public record KanjiResponse(
        Long id,
        JlptLevel level,
        String character,
        String onyomi,
        String kunyomi,
        String meaningVi,
        Integer strokeCount,
        String exampleWords
) {
    public static KanjiResponse from(KanjiItem item) {
        return new KanjiResponse(item.getId(), item.getLevel(), item.getCharacter(), item.getOnyomi(),
                item.getKunyomi(), item.getMeaningVi(), item.getStrokeCount(), item.getExampleWords());
    }
}

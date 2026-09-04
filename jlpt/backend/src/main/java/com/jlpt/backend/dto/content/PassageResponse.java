package com.jlpt.backend.dto.content;

import com.jlpt.backend.entity.JlptLevel;
import com.jlpt.backend.entity.Passage;

public record PassageResponse(
        Long id,
        JlptLevel level,
        String title,
        String content
) {
    public static PassageResponse from(Passage passage) {
        return new PassageResponse(passage.getId(), passage.getLevel(), passage.getTitle(), passage.getContent());
    }
}

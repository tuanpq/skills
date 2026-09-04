package com.jlpt.backend.dto.study;

import com.jlpt.backend.dto.content.GrammarResponse;
import com.jlpt.backend.entity.StudyStatus;

public record GrammarStudyResponse(
        GrammarResponse item,
        StudyStatus status
) {
}

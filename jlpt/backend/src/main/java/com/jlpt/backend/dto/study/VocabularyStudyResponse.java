package com.jlpt.backend.dto.study;

import com.jlpt.backend.dto.content.VocabularyResponse;
import com.jlpt.backend.entity.StudyStatus;

public record VocabularyStudyResponse(
        VocabularyResponse item,
        StudyStatus status
) {
}

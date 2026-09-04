package com.jlpt.backend.dto.study;

import com.jlpt.backend.dto.content.KanjiResponse;
import com.jlpt.backend.entity.StudyStatus;

public record KanjiStudyResponse(
        KanjiResponse item,
        StudyStatus status
) {
}

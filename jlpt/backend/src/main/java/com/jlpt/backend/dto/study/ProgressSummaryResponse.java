package com.jlpt.backend.dto.study;

import com.jlpt.backend.entity.StudyItemType;
import com.jlpt.backend.entity.StudyStatus;

import java.util.Map;

public record ProgressSummaryResponse(
        Map<StudyItemType, Map<StudyStatus, Long>> countsByItemTypeAndStatus
) {
}

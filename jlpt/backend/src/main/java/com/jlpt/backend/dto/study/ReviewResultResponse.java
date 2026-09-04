package com.jlpt.backend.dto.study;

import com.jlpt.backend.entity.StudyStatus;

import java.time.Instant;

public record ReviewResultResponse(
        StudyStatus status,
        int intervalDays,
        Instant nextReviewAt
) {
}

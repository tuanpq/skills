package com.jlpt.backend.dto.exam;

import java.time.Instant;
import java.util.List;

public record AttemptResultResponse(
        Long attemptId,
        Long examId,
        Integer score,
        Integer maxScore,
        Instant submittedAt,
        List<AnswerResultResponse> answers
) {
}

package com.jlpt.backend.dto.exam;

import com.jlpt.backend.entity.Attempt;
import com.jlpt.backend.entity.AttemptStatus;

import java.time.Instant;
import java.util.List;

public record AttemptResponse(
        Long id,
        Long examId,
        String examTitle,
        AttemptStatus status,
        Instant startedAt,
        Instant submittedAt,
        Integer score,
        Integer maxScore,
        List<QuestionForAttemptResponse> questions
) {
    public static AttemptResponse from(Attempt attempt, List<QuestionForAttemptResponse> questions) {
        return new AttemptResponse(attempt.getId(), attempt.getExam().getId(), attempt.getExam().getTitle(),
                attempt.getStatus(), attempt.getStartedAt(), attempt.getSubmittedAt(),
                attempt.getScore(), attempt.getMaxScore(), questions);
    }
}

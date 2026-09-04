package com.jlpt.backend.dto.exam;

public record AnswerResultResponse(
        Long questionId,
        String questionText,
        Long selectedChoiceId,
        Long correctChoiceId,
        boolean correct,
        String explanation
) {
}

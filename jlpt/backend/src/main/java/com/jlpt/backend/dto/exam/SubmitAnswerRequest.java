package com.jlpt.backend.dto.exam;

import jakarta.validation.constraints.NotNull;

public record SubmitAnswerRequest(
        @NotNull Long questionId,
        Long selectedChoiceId
) {
}

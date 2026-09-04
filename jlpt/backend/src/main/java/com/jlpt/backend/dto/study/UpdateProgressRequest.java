package com.jlpt.backend.dto.study;

import com.jlpt.backend.entity.StudyItemType;
import com.jlpt.backend.entity.StudyStatus;
import jakarta.validation.constraints.NotNull;

public record UpdateProgressRequest(
        @NotNull StudyItemType itemType,
        @NotNull Long itemId,
        @NotNull StudyStatus status
) {
}

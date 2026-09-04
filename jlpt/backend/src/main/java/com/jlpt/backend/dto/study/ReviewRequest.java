package com.jlpt.backend.dto.study;

import com.jlpt.backend.entity.StudyItemType;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

public record ReviewRequest(
        @NotNull StudyItemType itemType,
        @NotNull Long itemId,
        @NotNull @Min(0) @Max(5) Integer quality
) {
}

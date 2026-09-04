package com.jlpt.backend.dto.exam;

import com.jlpt.backend.entity.Choice;

public record ChoiceOptionResponse(
        Long id,
        String choiceText,
        int displayOrder
) {
    public static ChoiceOptionResponse from(Choice choice) {
        return new ChoiceOptionResponse(choice.getId(), choice.getChoiceText(), choice.getDisplayOrder());
    }
}

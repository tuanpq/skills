package com.jlpt.backend.dto.exam;

import com.jlpt.backend.entity.Question;
import com.jlpt.backend.entity.SkillType;

import java.util.Comparator;
import java.util.List;

public record QuestionForAttemptResponse(
        Long id,
        SkillType skillType,
        String questionText,
        String passageContent,
        Long listeningAudioId,
        List<ChoiceOptionResponse> choices
) {
    public static QuestionForAttemptResponse from(Question question) {
        List<ChoiceOptionResponse> choices = question.getChoices().stream()
                .sorted(Comparator.comparingInt(com.jlpt.backend.entity.Choice::getDisplayOrder))
                .map(ChoiceOptionResponse::from)
                .toList();
        return new QuestionForAttemptResponse(
                question.getId(),
                question.getSkillType(),
                question.getQuestionText(),
                question.getPassage() != null ? question.getPassage().getContent() : null,
                question.getListeningAudio() != null ? question.getListeningAudio().getId() : null,
                choices);
    }
}

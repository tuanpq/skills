package com.jlpt.backend.dto.exam;

import com.jlpt.backend.entity.Exam;
import com.jlpt.backend.entity.ExamType;
import com.jlpt.backend.entity.JlptLevel;
import com.jlpt.backend.entity.SkillType;

import java.util.List;

public record ExamDetailResponse(
        Long id,
        JlptLevel level,
        String title,
        ExamType examType,
        SkillType skillType,
        int timeLimitMinutes,
        List<QuestionForAttemptResponse> questions
) {
    public static ExamDetailResponse from(Exam exam, List<QuestionForAttemptResponse> questions) {
        return new ExamDetailResponse(exam.getId(), exam.getLevel(), exam.getTitle(), exam.getExamType(),
                exam.getSkillType(), exam.getTimeLimitMinutes(), questions);
    }
}

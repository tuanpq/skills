package com.jlpt.backend.dto.exam;

import com.jlpt.backend.entity.Exam;
import com.jlpt.backend.entity.ExamType;
import com.jlpt.backend.entity.JlptLevel;
import com.jlpt.backend.entity.SkillType;

public record ExamSummaryResponse(
        Long id,
        JlptLevel level,
        String title,
        ExamType examType,
        SkillType skillType,
        int timeLimitMinutes,
        int questionCount
) {
    public static ExamSummaryResponse from(Exam exam, int questionCount) {
        return new ExamSummaryResponse(exam.getId(), exam.getLevel(), exam.getTitle(), exam.getExamType(),
                exam.getSkillType(), exam.getTimeLimitMinutes(), questionCount);
    }
}

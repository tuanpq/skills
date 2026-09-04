package com.jlpt.backend.repository;

import com.jlpt.backend.entity.Exam;
import com.jlpt.backend.entity.JlptLevel;
import com.jlpt.backend.entity.SkillType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ExamRepository extends JpaRepository<Exam, Long> {
    List<Exam> findByLevel(JlptLevel level);

    List<Exam> findByLevelAndSkillType(JlptLevel level, SkillType skillType);
}

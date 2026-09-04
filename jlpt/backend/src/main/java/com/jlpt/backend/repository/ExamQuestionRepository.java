package com.jlpt.backend.repository;

import com.jlpt.backend.entity.ExamQuestion;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ExamQuestionRepository extends JpaRepository<ExamQuestion, Long> {
    List<ExamQuestion> findByExamIdOrderByDisplayOrderAsc(Long examId);
}

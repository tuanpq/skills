package com.jlpt.backend.repository;

import com.jlpt.backend.entity.Attempt;
import com.jlpt.backend.entity.AttemptAnswer;
import com.jlpt.backend.entity.Question;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface AttemptAnswerRepository extends JpaRepository<AttemptAnswer, Long> {
    List<AttemptAnswer> findByAttemptId(Long attemptId);

    Optional<AttemptAnswer> findByAttemptAndQuestion(Attempt attempt, Question question);
}

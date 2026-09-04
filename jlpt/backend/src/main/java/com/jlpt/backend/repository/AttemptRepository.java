package com.jlpt.backend.repository;

import com.jlpt.backend.entity.Attempt;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AttemptRepository extends JpaRepository<Attempt, Long> {
    List<Attempt> findByUserIdOrderByStartedAtDesc(Long userId);
}

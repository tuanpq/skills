package com.jlpt.backend.repository;

import com.jlpt.backend.entity.GrammarPoint;
import com.jlpt.backend.entity.JlptLevel;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GrammarPointRepository extends JpaRepository<GrammarPoint, Long> {
    Page<GrammarPoint> findByLevel(JlptLevel level, Pageable pageable);
}

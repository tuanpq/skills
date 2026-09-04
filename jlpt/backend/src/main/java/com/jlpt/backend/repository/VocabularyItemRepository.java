package com.jlpt.backend.repository;

import com.jlpt.backend.entity.JlptLevel;
import com.jlpt.backend.entity.VocabularyItem;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VocabularyItemRepository extends JpaRepository<VocabularyItem, Long> {
    Page<VocabularyItem> findByLevel(JlptLevel level, Pageable pageable);
}

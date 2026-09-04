package com.jlpt.backend.repository;

import com.jlpt.backend.entity.JlptLevel;
import com.jlpt.backend.entity.KanjiItem;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface KanjiItemRepository extends JpaRepository<KanjiItem, Long> {
    Page<KanjiItem> findByLevel(JlptLevel level, Pageable pageable);
}

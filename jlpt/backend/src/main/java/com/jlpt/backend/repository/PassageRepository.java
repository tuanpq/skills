package com.jlpt.backend.repository;

import com.jlpt.backend.entity.Passage;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PassageRepository extends JpaRepository<Passage, Long> {
}

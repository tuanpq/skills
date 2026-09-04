package com.jlpt.backend.repository;

import com.jlpt.backend.entity.StudyItemType;
import com.jlpt.backend.entity.StudyProgress;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface StudyProgressRepository extends JpaRepository<StudyProgress, Long> {
    List<StudyProgress> findByUserId(Long userId);

    List<StudyProgress> findByUserIdAndItemType(Long userId, StudyItemType itemType);

    Optional<StudyProgress> findByUserIdAndItemTypeAndItemId(Long userId, StudyItemType itemType, Long itemId);
}

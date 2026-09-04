package com.jlpt.backend.service;

import com.jlpt.backend.dto.content.GrammarResponse;
import com.jlpt.backend.dto.content.KanjiResponse;
import com.jlpt.backend.dto.content.VocabularyResponse;
import com.jlpt.backend.dto.study.*;
import com.jlpt.backend.entity.*;
import com.jlpt.backend.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class StudyService {

    private final VocabularyItemRepository vocabularyItemRepository;
    private final KanjiItemRepository kanjiItemRepository;
    private final GrammarPointRepository grammarPointRepository;
    private final StudyProgressRepository studyProgressRepository;

    public List<VocabularyStudyResponse> getVocabularyProgress(JlptLevel level, User user, Pageable pageable, boolean dueOnly) {
        Map<Long, StudyProgress> progressByItemId = progressByItemId(user, StudyItemType.VOCABULARY);
        return vocabularyItemRepository.findByLevel(level, pageable).stream()
                .filter(item -> !dueOnly || isDue(progressByItemId.get(item.getId())))
                .map(item -> new VocabularyStudyResponse(VocabularyResponse.from(item), statusOf(progressByItemId.get(item.getId()))))
                .toList();
    }

    public List<KanjiStudyResponse> getKanjiProgress(JlptLevel level, User user, Pageable pageable, boolean dueOnly) {
        Map<Long, StudyProgress> progressByItemId = progressByItemId(user, StudyItemType.KANJI);
        return kanjiItemRepository.findByLevel(level, pageable).stream()
                .filter(item -> !dueOnly || isDue(progressByItemId.get(item.getId())))
                .map(item -> new KanjiStudyResponse(KanjiResponse.from(item), statusOf(progressByItemId.get(item.getId()))))
                .toList();
    }

    public List<GrammarStudyResponse> getGrammarProgress(JlptLevel level, User user, Pageable pageable, boolean dueOnly) {
        Map<Long, StudyProgress> progressByItemId = progressByItemId(user, StudyItemType.GRAMMAR);
        return grammarPointRepository.findByLevel(level, pageable).stream()
                .filter(item -> !dueOnly || isDue(progressByItemId.get(item.getId())))
                .map(item -> new GrammarStudyResponse(GrammarResponse.from(item), statusOf(progressByItemId.get(item.getId()))))
                .toList();
    }

    @Transactional
    public void updateProgress(User user, UpdateProgressRequest request) {
        StudyProgress progress = findOrCreate(user, request.itemType(), request.itemId());
        progress.setStatus(request.status());
        studyProgressRepository.save(progress);
    }

    public ProgressSummaryResponse getProgressSummary(User user) {
        Map<StudyItemType, Map<StudyStatus, Long>> counts = studyProgressRepository.findByUserId(user.getId()).stream()
                .collect(Collectors.groupingBy(StudyProgress::getItemType,
                        Collectors.groupingBy(StudyProgress::getStatus, Collectors.counting())));
        return new ProgressSummaryResponse(counts);
    }

    /**
     * Records a review (SM-2 spaced repetition, quality 0-5) and reschedules the item's next
     * review date. See https://en.wikipedia.org/wiki/SuperMemo#SM-2_algorithm.
     */
    @Transactional
    public ReviewResultResponse review(User user, ReviewRequest request) {
        StudyProgress progress = findOrCreate(user, request.itemType(), request.itemId());
        int quality = request.quality();

        if (quality < 3) {
            progress.setRepetitions(0);
            progress.setIntervalDays(1);
        } else {
            int repetitions = progress.getRepetitions();
            int intervalDays;
            if (repetitions == 0) {
                intervalDays = 1;
            } else if (repetitions == 1) {
                intervalDays = 6;
            } else {
                intervalDays = (int) Math.round(progress.getIntervalDays() * progress.getEaseFactor());
            }
            progress.setIntervalDays(intervalDays);
            progress.setRepetitions(repetitions + 1);
        }

        double easeFactor = progress.getEaseFactor()
                + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));
        progress.setEaseFactor(Math.max(1.3, easeFactor));
        progress.setNextReviewAt(Instant.now().plus(progress.getIntervalDays(), ChronoUnit.DAYS));
        progress.setStatus(deriveStatus(progress.getIntervalDays()));

        studyProgressRepository.save(progress);
        return new ReviewResultResponse(progress.getStatus(), progress.getIntervalDays(), progress.getNextReviewAt());
    }

    private StudyProgress findOrCreate(User user, StudyItemType itemType, Long itemId) {
        return studyProgressRepository.findByUserIdAndItemTypeAndItemId(user.getId(), itemType, itemId)
                .orElseGet(() -> StudyProgress.builder()
                        .user(user)
                        .itemType(itemType)
                        .itemId(itemId)
                        .build());
    }

    private StudyStatus deriveStatus(int intervalDays) {
        if (intervalDays == 0) return StudyStatus.NEW;
        if (intervalDays < 21) return StudyStatus.LEARNING;
        return StudyStatus.MASTERED;
    }

    private boolean isDue(StudyProgress progress) {
        return progress == null || progress.getNextReviewAt() == null || !progress.getNextReviewAt().isAfter(Instant.now());
    }

    private StudyStatus statusOf(StudyProgress progress) {
        return progress != null ? progress.getStatus() : StudyStatus.NEW;
    }

    private Map<Long, StudyProgress> progressByItemId(User user, StudyItemType itemType) {
        return studyProgressRepository.findByUserIdAndItemType(user.getId(), itemType).stream()
                .collect(Collectors.toMap(StudyProgress::getItemId, p -> p));
    }
}

package com.jlpt.backend.service;

import com.jlpt.backend.dto.study.ReviewRequest;
import com.jlpt.backend.dto.study.ReviewResultResponse;
import com.jlpt.backend.entity.*;
import com.jlpt.backend.repository.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class StudyServiceTest {

    @Mock private VocabularyItemRepository vocabularyItemRepository;
    @Mock private KanjiItemRepository kanjiItemRepository;
    @Mock private GrammarPointRepository grammarPointRepository;
    @Mock private StudyProgressRepository studyProgressRepository;

    @InjectMocks
    private StudyService studyService;

    private User user;

    @BeforeEach
    void setUp() {
        user = User.builder().id(1L).email("test@example.com").displayName("Test").role(UserRole.USER).build();
        when(studyProgressRepository.save(any(StudyProgress.class))).thenAnswer(inv -> inv.getArgument(0));
    }

    @Test
    void review_firstGoodReview_schedulesOneDayLater() {
        when(studyProgressRepository.findByUserIdAndItemTypeAndItemId(1L, StudyItemType.VOCABULARY, 10L))
                .thenReturn(Optional.empty());

        ReviewResultResponse result = studyService.review(user, new ReviewRequest(StudyItemType.VOCABULARY, 10L, 4));

        assertThat(result.intervalDays()).isEqualTo(1);
        assertThat(result.status()).isEqualTo(StudyStatus.LEARNING);
    }

    @Test
    void review_secondGoodReview_schedulesSixDaysLater() {
        StudyProgress existing = StudyProgress.builder()
                .user(user).itemType(StudyItemType.VOCABULARY).itemId(10L)
                .repetitions(1).intervalDays(1).easeFactor(2.5)
                .build();
        when(studyProgressRepository.findByUserIdAndItemTypeAndItemId(1L, StudyItemType.VOCABULARY, 10L))
                .thenReturn(Optional.of(existing));

        ReviewResultResponse result = studyService.review(user, new ReviewRequest(StudyItemType.VOCABULARY, 10L, 4));

        assertThat(result.intervalDays()).isEqualTo(6);
    }

    @Test
    void review_thirdGoodReview_scalesByEaseFactor() {
        StudyProgress existing = StudyProgress.builder()
                .user(user).itemType(StudyItemType.VOCABULARY).itemId(10L)
                .repetitions(2).intervalDays(6).easeFactor(2.5)
                .build();
        when(studyProgressRepository.findByUserIdAndItemTypeAndItemId(1L, StudyItemType.VOCABULARY, 10L))
                .thenReturn(Optional.of(existing));

        ReviewResultResponse result = studyService.review(user, new ReviewRequest(StudyItemType.VOCABULARY, 10L, 4));

        // round(6 * 2.5) = 15
        assertThat(result.intervalDays()).isEqualTo(15);
        assertThat(result.status()).isEqualTo(StudyStatus.LEARNING);
    }

    @Test
    void review_lowQuality_resetsRepetitionsAndInterval() {
        StudyProgress existing = StudyProgress.builder()
                .user(user).itemType(StudyItemType.VOCABULARY).itemId(10L)
                .repetitions(4).intervalDays(30).easeFactor(2.6)
                .build();
        when(studyProgressRepository.findByUserIdAndItemTypeAndItemId(1L, StudyItemType.VOCABULARY, 10L))
                .thenReturn(Optional.of(existing));

        ReviewResultResponse result = studyService.review(user, new ReviewRequest(StudyItemType.VOCABULARY, 10L, 1));

        assertThat(result.intervalDays()).isEqualTo(1);
        assertThat(existing.getRepetitions()).isEqualTo(0);
        assertThat(result.status()).isEqualTo(StudyStatus.LEARNING);
    }

    @Test
    void review_easeFactor_neverDropsBelowFloor() {
        StudyProgress existing = StudyProgress.builder()
                .user(user).itemType(StudyItemType.VOCABULARY).itemId(10L)
                .repetitions(3).intervalDays(10).easeFactor(1.3)
                .build();
        when(studyProgressRepository.findByUserIdAndItemTypeAndItemId(1L, StudyItemType.VOCABULARY, 10L))
                .thenReturn(Optional.of(existing));

        studyService.review(user, new ReviewRequest(StudyItemType.VOCABULARY, 10L, 0));

        assertThat(existing.getEaseFactor()).isGreaterThanOrEqualTo(1.3);
    }

    @Test
    void review_highInterval_derivesMasteredStatus() {
        StudyProgress existing = StudyProgress.builder()
                .user(user).itemType(StudyItemType.VOCABULARY).itemId(10L)
                .repetitions(3).intervalDays(20).easeFactor(2.5)
                .build();
        when(studyProgressRepository.findByUserIdAndItemTypeAndItemId(1L, StudyItemType.VOCABULARY, 10L))
                .thenReturn(Optional.of(existing));

        ReviewResultResponse result = studyService.review(user, new ReviewRequest(StudyItemType.VOCABULARY, 10L, 5));

        // round(20 * 2.5) = 50 >= 21 -> MASTERED
        assertThat(result.status()).isEqualTo(StudyStatus.MASTERED);
    }
}

package com.jlpt.backend.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.Instant;

@Entity
@Table(name = "study_progress", uniqueConstraints = @UniqueConstraint(columnNames = {"user_id", "item_type", "item_id"}))
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StudyProgress {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Enumerated(EnumType.STRING)
    @Column(name = "item_type", nullable = false)
    private StudyItemType itemType;

    @Column(name = "item_id", nullable = false)
    private Long itemId;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    @Builder.Default
    private StudyStatus status = StudyStatus.NEW;

    @Column(name = "last_reviewed_at")
    private Instant lastReviewedAt;

    @Column(name = "ease_factor", nullable = false)
    @Builder.Default
    private double easeFactor = 2.5;

    @Column(name = "interval_days", nullable = false)
    @Builder.Default
    private int intervalDays = 0;

    @Column(nullable = false)
    @Builder.Default
    private int repetitions = 0;

    /** Null means "never reviewed" — treated as due immediately. */
    @Column(name = "next_review_at")
    private Instant nextReviewAt;

    @PrePersist
    @PreUpdate
    void onSave() {
        this.lastReviewedAt = Instant.now();
    }
}

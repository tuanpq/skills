package com.jlpt.backend.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "grammar_points")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GrammarPoint {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private JlptLevel level;

    @Column(nullable = false)
    private String pattern;

    @Column(name = "meaning_vi", nullable = false)
    private String meaningVi;

    @Column(name = "meaning_en")
    private String meaningEn;

    @Column(name = "usage_note", columnDefinition = "TEXT")
    private String usageNote;

    @Column(name = "example_sentence")
    private String exampleSentence;

    @Column(name = "example_meaning")
    private String exampleMeaning;
}

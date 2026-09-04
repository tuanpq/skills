package com.jlpt.backend.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "vocabulary_items")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class VocabularyItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private JlptLevel level;

    @Column(nullable = false)
    private String word;

    @Column(nullable = false)
    private String reading;

    @Column(name = "meaning_vi", nullable = false)
    private String meaningVi;

    @Column(name = "meaning_en")
    private String meaningEn;

    @Column(name = "part_of_speech")
    private String partOfSpeech;

    @Column(name = "example_sentence")
    private String exampleSentence;

    @Column(name = "example_reading")
    private String exampleReading;

    @Column(name = "example_meaning")
    private String exampleMeaning;
}

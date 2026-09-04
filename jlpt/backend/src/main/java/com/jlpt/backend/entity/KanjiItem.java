package com.jlpt.backend.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "kanji_items")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class KanjiItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private JlptLevel level;

    @Column(nullable = false)
    private String character;

    @Column(name = "onyomi")
    private String onyomi;

    @Column(name = "kunyomi")
    private String kunyomi;

    @Column(name = "meaning_vi", nullable = false)
    private String meaningVi;

    @Column(name = "stroke_count")
    private Integer strokeCount;

    @Column(name = "example_words")
    private String exampleWords;
}

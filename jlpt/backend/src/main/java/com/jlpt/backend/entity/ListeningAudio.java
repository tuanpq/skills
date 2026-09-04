package com.jlpt.backend.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "listening_audios")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ListeningAudio {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private JlptLevel level;

    @Column(nullable = false)
    private String title;

    @Column(name = "audio_object_key")
    private String audioObjectKey;

    @Column(columnDefinition = "TEXT")
    private String transcript;

    @Column(name = "duration_seconds")
    private Integer durationSeconds;
}

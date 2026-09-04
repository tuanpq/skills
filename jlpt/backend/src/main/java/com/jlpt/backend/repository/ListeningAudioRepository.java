package com.jlpt.backend.repository;

import com.jlpt.backend.entity.ListeningAudio;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ListeningAudioRepository extends JpaRepository<ListeningAudio, Long> {
}

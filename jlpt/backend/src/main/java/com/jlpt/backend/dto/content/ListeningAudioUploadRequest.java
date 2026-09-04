package com.jlpt.backend.dto.content;

import com.jlpt.backend.entity.JlptLevel;

public record ListeningAudioUploadRequest(
        JlptLevel level,
        String title,
        String transcript,
        Integer durationSeconds
) {
}

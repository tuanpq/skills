package com.jlpt.backend.dto.content;

import com.jlpt.backend.entity.JlptLevel;
import com.jlpt.backend.entity.ListeningAudio;

public record ListeningAudioResponse(
        Long id,
        JlptLevel level,
        String title,
        String audioUrl,
        String transcript,
        Integer durationSeconds
) {
    public static ListeningAudioResponse from(ListeningAudio audio, String presignedUrl) {
        return new ListeningAudioResponse(audio.getId(), audio.getLevel(), audio.getTitle(),
                presignedUrl, audio.getTranscript(), audio.getDurationSeconds());
    }
}

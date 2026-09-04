package com.jlpt.backend.controller;

import com.jlpt.backend.dto.content.*;
import com.jlpt.backend.entity.JlptLevel;
import com.jlpt.backend.service.ContentService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class ContentController {

    private final ContentService contentService;

    @GetMapping("/vocabulary")
    public Page<VocabularyResponse> getVocabulary(@RequestParam JlptLevel level, Pageable pageable) {
        return contentService.getVocabulary(level, pageable);
    }

    @GetMapping("/kanji")
    public Page<KanjiResponse> getKanji(@RequestParam JlptLevel level, Pageable pageable) {
        return contentService.getKanji(level, pageable);
    }

    @GetMapping("/grammar")
    public Page<GrammarResponse> getGrammar(@RequestParam JlptLevel level, Pageable pageable) {
        return contentService.getGrammar(level, pageable);
    }

    @GetMapping("/passages/{id}")
    public PassageResponse getPassage(@PathVariable Long id) {
        return contentService.getPassage(id);
    }

    @GetMapping("/listening-audios/{id}")
    public ListeningAudioResponse getListeningAudio(@PathVariable Long id) {
        return contentService.getListeningAudio(id);
    }
}

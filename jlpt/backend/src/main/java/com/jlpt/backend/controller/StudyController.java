package com.jlpt.backend.controller;

import com.jlpt.backend.dto.study.*;
import com.jlpt.backend.entity.JlptLevel;
import com.jlpt.backend.security.CurrentUserProvider;
import com.jlpt.backend.service.StudyService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/study")
@RequiredArgsConstructor
public class StudyController {

    private final StudyService studyService;
    private final CurrentUserProvider currentUserProvider;

    @GetMapping("/vocabulary")
    public List<VocabularyStudyResponse> getVocabulary(@RequestParam JlptLevel level, Pageable pageable) {
        return studyService.getVocabularyProgress(level, currentUserProvider.getCurrentUser(), pageable, false);
    }

    @GetMapping("/kanji")
    public List<KanjiStudyResponse> getKanji(@RequestParam JlptLevel level, Pageable pageable) {
        return studyService.getKanjiProgress(level, currentUserProvider.getCurrentUser(), pageable, false);
    }

    @GetMapping("/grammar")
    public List<GrammarStudyResponse> getGrammar(@RequestParam JlptLevel level, Pageable pageable) {
        return studyService.getGrammarProgress(level, currentUserProvider.getCurrentUser(), pageable, false);
    }

    @GetMapping("/vocabulary/due")
    public List<VocabularyStudyResponse> getVocabularyDue(@RequestParam JlptLevel level, Pageable pageable) {
        return studyService.getVocabularyProgress(level, currentUserProvider.getCurrentUser(), pageable, true);
    }

    @GetMapping("/kanji/due")
    public List<KanjiStudyResponse> getKanjiDue(@RequestParam JlptLevel level, Pageable pageable) {
        return studyService.getKanjiProgress(level, currentUserProvider.getCurrentUser(), pageable, true);
    }

    @GetMapping("/grammar/due")
    public List<GrammarStudyResponse> getGrammarDue(@RequestParam JlptLevel level, Pageable pageable) {
        return studyService.getGrammarProgress(level, currentUserProvider.getCurrentUser(), pageable, true);
    }

    @PostMapping("/progress")
    public void updateProgress(@Valid @RequestBody UpdateProgressRequest request) {
        studyService.updateProgress(currentUserProvider.getCurrentUser(), request);
    }

    @PostMapping("/review")
    public ReviewResultResponse review(@Valid @RequestBody ReviewRequest request) {
        return studyService.review(currentUserProvider.getCurrentUser(), request);
    }
}

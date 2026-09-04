package com.jlpt.backend.service;

import com.jlpt.backend.dto.content.*;
import com.jlpt.backend.entity.JlptLevel;
import com.jlpt.backend.entity.ListeningAudio;
import com.jlpt.backend.exception.ResourceNotFoundException;
import com.jlpt.backend.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
@RequiredArgsConstructor
public class ContentService {

    private final VocabularyItemRepository vocabularyItemRepository;
    private final KanjiItemRepository kanjiItemRepository;
    private final GrammarPointRepository grammarPointRepository;
    private final PassageRepository passageRepository;
    private final ListeningAudioRepository listeningAudioRepository;
    private final StorageService storageService;

    public Page<VocabularyResponse> getVocabulary(JlptLevel level, Pageable pageable) {
        return vocabularyItemRepository.findByLevel(level, pageable).map(VocabularyResponse::from);
    }

    public Page<KanjiResponse> getKanji(JlptLevel level, Pageable pageable) {
        return kanjiItemRepository.findByLevel(level, pageable).map(KanjiResponse::from);
    }

    public Page<GrammarResponse> getGrammar(JlptLevel level, Pageable pageable) {
        return grammarPointRepository.findByLevel(level, pageable).map(GrammarResponse::from);
    }

    public PassageResponse getPassage(Long id) {
        return passageRepository.findById(id)
                .map(PassageResponse::from)
                .orElseThrow(() -> new ResourceNotFoundException("Passage not found: " + id));
    }

    public ListeningAudioResponse getListeningAudio(Long id) {
        ListeningAudio audio = listeningAudioRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Listening audio not found: " + id));
        String url = storageService.getPresignedUrl(audio.getAudioObjectKey());
        return ListeningAudioResponse.from(audio, url);
    }

    @Transactional
    public ListeningAudioResponse uploadListeningAudio(ListeningAudioUploadRequest request, MultipartFile file) {
        String objectKey = storageService.uploadAudio(file);
        ListeningAudio audio = ListeningAudio.builder()
                .level(request.level())
                .title(request.title())
                .transcript(request.transcript())
                .durationSeconds(request.durationSeconds())
                .audioObjectKey(objectKey)
                .build();
        listeningAudioRepository.save(audio);
        String url = storageService.getPresignedUrl(objectKey);
        return ListeningAudioResponse.from(audio, url);
    }

    @Transactional
    public ListeningAudioResponse replaceListeningAudioFile(Long id, MultipartFile file) {
        ListeningAudio audio = listeningAudioRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Listening audio not found: " + id));
        String objectKey = storageService.uploadAudio(file);
        audio.setAudioObjectKey(objectKey);
        listeningAudioRepository.save(audio);
        String url = storageService.getPresignedUrl(objectKey);
        return ListeningAudioResponse.from(audio, url);
    }
}

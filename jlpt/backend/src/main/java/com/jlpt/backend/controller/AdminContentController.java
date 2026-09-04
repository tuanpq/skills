package com.jlpt.backend.controller;

import com.jlpt.backend.dto.content.ListeningAudioResponse;
import com.jlpt.backend.dto.content.ListeningAudioUploadRequest;
import com.jlpt.backend.entity.JlptLevel;
import com.jlpt.backend.service.ContentService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class AdminContentController {

    private final ContentService contentService;

    @PostMapping(value = "/listening-audios", consumes = "multipart/form-data")
    public ResponseEntity<ListeningAudioResponse> uploadListeningAudio(
            @RequestParam JlptLevel level,
            @RequestParam String title,
            @RequestParam(required = false) String transcript,
            @RequestParam(required = false) Integer durationSeconds,
            @RequestParam("file") MultipartFile file) {
        ListeningAudioUploadRequest request = new ListeningAudioUploadRequest(level, title, transcript, durationSeconds);
        return ResponseEntity.status(HttpStatus.CREATED).body(contentService.uploadListeningAudio(request, file));
    }

    @PutMapping(value = "/listening-audios/{id}/audio", consumes = "multipart/form-data")
    public ListeningAudioResponse replaceListeningAudioFile(
            @PathVariable Long id,
            @RequestParam("file") MultipartFile file) {
        return contentService.replaceListeningAudioFile(id, file);
    }
}

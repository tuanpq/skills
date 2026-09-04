package com.jlpt.backend.controller;

import com.jlpt.backend.dto.exam.AttemptResponse;
import com.jlpt.backend.dto.exam.AttemptResultResponse;
import com.jlpt.backend.dto.exam.SubmitAnswerRequest;
import com.jlpt.backend.entity.User;
import com.jlpt.backend.security.CurrentUserProvider;
import com.jlpt.backend.service.ExamService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class AttemptController {

    private final ExamService examService;
    private final CurrentUserProvider currentUserProvider;

    @GetMapping("/api/attempts/{id}")
    public AttemptResponse getAttempt(@PathVariable Long id) {
        User user = currentUserProvider.getCurrentUser();
        return examService.getAttempt(id, user);
    }

    @PutMapping("/api/attempts/{id}/answers")
    public void submitAnswer(@PathVariable Long id, @Valid @RequestBody SubmitAnswerRequest request) {
        User user = currentUserProvider.getCurrentUser();
        examService.submitAnswer(id, user, request);
    }

    @PostMapping("/api/attempts/{id}/submit")
    public AttemptResultResponse submitAttempt(@PathVariable Long id) {
        User user = currentUserProvider.getCurrentUser();
        return examService.submitAttempt(id, user);
    }

    @GetMapping("/api/attempts/{id}/result")
    public AttemptResultResponse getResult(@PathVariable Long id) {
        User user = currentUserProvider.getCurrentUser();
        return examService.getAttemptResult(id, user);
    }

    @GetMapping("/api/users/me/attempts")
    public List<AttemptResponse> getMyAttempts() {
        User user = currentUserProvider.getCurrentUser();
        return examService.getUserAttempts(user);
    }
}

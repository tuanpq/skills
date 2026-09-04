package com.jlpt.backend.controller;

import com.jlpt.backend.dto.study.ProgressSummaryResponse;
import com.jlpt.backend.security.CurrentUserProvider;
import com.jlpt.backend.service.StudyService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/users/me")
@RequiredArgsConstructor
public class UserController {

    private final StudyService studyService;
    private final CurrentUserProvider currentUserProvider;

    @GetMapping("/progress")
    public ProgressSummaryResponse getMyProgress() {
        return studyService.getProgressSummary(currentUserProvider.getCurrentUser());
    }
}

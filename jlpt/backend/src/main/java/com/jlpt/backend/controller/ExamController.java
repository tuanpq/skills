package com.jlpt.backend.controller;

import com.jlpt.backend.dto.exam.AttemptResponse;
import com.jlpt.backend.dto.exam.ExamDetailResponse;
import com.jlpt.backend.dto.exam.ExamSummaryResponse;
import com.jlpt.backend.entity.JlptLevel;
import com.jlpt.backend.entity.SkillType;
import com.jlpt.backend.entity.User;
import com.jlpt.backend.security.CurrentUserProvider;
import com.jlpt.backend.service.ExamService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/exams")
@RequiredArgsConstructor
public class ExamController {

    private final ExamService examService;
    private final CurrentUserProvider currentUserProvider;

    @GetMapping
    public List<ExamSummaryResponse> listExams(@RequestParam JlptLevel level,
                                                @RequestParam(required = false) SkillType skill) {
        return examService.listExams(level, skill);
    }

    @GetMapping("/{id}")
    public ExamDetailResponse getExam(@PathVariable Long id) {
        return examService.getExam(id);
    }

    @PostMapping("/{id}/attempts")
    public ResponseEntity<AttemptResponse> startAttempt(@PathVariable Long id) {
        User user = currentUserProvider.getCurrentUser();
        return ResponseEntity.status(HttpStatus.CREATED).body(examService.startAttempt(id, user));
    }
}

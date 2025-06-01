package com.quiz.viewmodels;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;
import java.math.BigDecimal;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.validation.constraints.Null;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CourseProgressDetailViewModel {
    private String summaryId;
    private String userId;
    private String username;
    private String courseId;
    private String courseName;
    private BigDecimal overallProgressPercentage;
    private int completedModules;
    private int totalModules;
    private int completedQuizzes;
    private int totalQuizzes;
    private int totalPointsEarned;
    private LocalDateTime lastActivity;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private List<ModuleProgressDetailViewModel> moduleProgress;
}
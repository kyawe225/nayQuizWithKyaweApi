package com.quiz.viewmodels;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CustomerCourseProgressViewModel {
    private String courseId;
    private String courseName;
    private BigDecimal overallProgressPercentage;
    private int completedModules;
    private int totalModules;
    private int completedQuizzes;
    private int totalQuizzes;
    private LocalDateTime lastActivity;
}

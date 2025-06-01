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
public class CustomerAchievementViewModel {
    private String achievementId;
    private String quizId;
    private String quizName;
    private String courseId;
    private String courseName;
    private BigDecimal score;
    private LocalDateTime achievedAt;
}
package com.quiz.viewmodels;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

import com.quiz.models.Achievement;

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
public class AchievementListViewModel {
    private String achievementId;
    private String userId;
    private String name;
    private String username;
    private String quizId;
    private BigDecimal score;
    private LocalDateTime achievedAt;
    
    public AchievementListViewModel(Achievement achievement) {
    	achievementId = achievement.getAchievementId();
    	userId = achievement.getUser().getUserId();
    	name = achievement.getName();
    	username = achievement.getUser().getUsername();
    	quizId = achievement.getQuiz().getQuizId();
    	score = new BigDecimal(achievement.getScore());
    	achievedAt = achievement.getCreatedAt();
    }
}
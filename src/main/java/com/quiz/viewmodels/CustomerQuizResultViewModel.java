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
public class CustomerQuizResultViewModel {
    private String submissionId;
    private String quizId;
    private String quizName;
    private BigDecimal score;
    private int totalPoints;
    private int pointsEarned;
    private int correctAnswers;
    private int totalQuestions;
    private boolean passed;
    private List<CustomerQuizAnswerResultViewModel> questionResults;
}
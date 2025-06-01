package com.quiz.viewmodels;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CustomerQuizAnswerResultViewModel {
    private String questionId;
    private String questionContent;
    private boolean isCorrect;
    private String selectedChoiceId;
    private String selectedChoiceContent;
    private String correctAnswer;
    private String explanation;
}
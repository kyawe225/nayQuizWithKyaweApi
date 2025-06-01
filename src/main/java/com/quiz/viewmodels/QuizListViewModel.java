package com.quiz.viewmodels;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

import com.quiz.models.Quiz;

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
public class QuizListViewModel {
    private String quizId;
    private String courseId;
    private String courseName;
    private String levelId;
    private String levelName;
    private boolean isFinal;
    private int timeInMinutes;
    private int questionCount;
    private int totalPoints;
    public QuizListViewModel(Quiz quiz) {
    	quizId = quiz.getQuizId();
    	courseId = quiz.getCourse().getCourseId();
    	courseName= quiz.getCourse().getName();
    	levelId = quiz.getLevel().getLevelId();
    	levelName= quiz.getLevel().getName();
    	isFinal = quiz.getIsFinal();
    	timeInMinutes = quiz.getTimeInMinutes();
    	questionCount = quiz.getQuestions().size();
    	int points = 0;
    	for(var i : quiz.getQuestions()) {
    		 points += i.getPoints();
    	}
    	totalPoints = points; 
    }
}

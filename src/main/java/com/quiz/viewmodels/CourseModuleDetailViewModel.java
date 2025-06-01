package com.quiz.viewmodels;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

import com.quiz.models.CourseModule;

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
public class CourseModuleDetailViewModel {
    private String moduleId;
    private String courseId;
    private String courseName;
    private String levelId;
    private String levelName;
    private String title;
    private String description;
    private int sequenceOrder;
    private String contentType;
    private String contentUrl;
    private int estimatedDurationMinutes;
    private boolean isRequired;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private int completionCount;
    private BigDecimal averageTimeSpentSeconds;
    private List<QuizListViewModel> quiz;
    
    public CourseModuleDetailViewModel(CourseModule model) {
    	moduleId = model.getModuleId();
    	courseId = model.getCourse().getCourseId();
    	courseName = model.getCourse().getName();
    	levelId = model.getLevel().getLevelId();
    	levelName = model.getLevel().getName();
    	title = model.getTitle();
    	description = model.getDescription();
    	sequenceOrder = model.getSequenceOrder();
    	contentType = model.getContentType();
    	contentUrl = model.getContentUrl();
    	estimatedDurationMinutes = model.getEstimatedDurationMinutes();
    	isRequired = model.getIsRequired();
    	createdAt = model.getCreatedAt();
    	updatedAt = model.getUpdatedAt();
    	completionCount = 0;
    	averageTimeSpentSeconds = new BigDecimal(0);
    }
}
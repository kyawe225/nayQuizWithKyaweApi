package com.quiz.viewmodels;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

import com.quiz.models.Course;

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
public class CourseListViewModel {
    private String courseId;
    private String description;
    private String welcomeMode;
    private String welcomeTemplateId;
    private String welcomeTemplateName;
    private LocalDateTime createdAt;
    private int enrollmentCount;
    private int levelCount;
    private int moduleCount;
    
    public CourseListViewModel(Course course) {
    	courseId = course.getCourseId();
    	description = course.getDescription();
    	welcomeMode = course.getWelcomeMode();
    	createdAt = course.getCreatedAt();
    	enrollmentCount= course.getEnrollments().size();
    	levelCount = course.getLevels().size();
    	moduleCount = course.getLevels().size();
    }
}

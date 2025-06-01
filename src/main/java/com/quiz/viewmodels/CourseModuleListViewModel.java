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
public class CourseModuleListViewModel {
    private String moduleId;
    private String courseId;
    private String courseTitle;
    private String levelId;
    private String levelName;
    private String title;
    private String contentType;
    private int sequenceOrder;
    private int estimatedDurationMinutes;
    private boolean isRequired;
    
    public CourseModuleListViewModel(CourseModule module) {
    	moduleId = module.getModuleId();
    	courseId = module.getCourse().getCourseId();
    	courseTitle = module.getCourse().getName();
    	levelId = module.getLevel().getLevelId();
    	levelName = module.getLevel().getName();
    	title = module.getTitle();
    	contentType = module.getContentType();
    	sequenceOrder = module.getSequenceOrder();
    	estimatedDurationMinutes = module.getEstimatedDurationMinutes();
    	isRequired= module.getIsRequired();
    }
}

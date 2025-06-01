package com.quiz.viewmodels;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

import com.quiz.models.Course;

import jakarta.validation.constraints.Null;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CourseDetailViewModel {
    private String courseId;
    private String description;
    private String welcomeTemplateId;
    private String welcomeMode;
    private String welcomeStylesheet;
    private String welcomeTemplateName;
    private String welcomeTemplateContent;
    @Null
    private LocalDateTime createdAt;
    @Null
    private LocalDateTime updatedAt;
    private List<CourseLevelListViewModel> levels;
    private List<CourseContentBlockDetailViewModel> contentBlocks;
    private int totalEnrollments;
    private int totalModules;
    private int totalQuizzes;
    
    public CourseDetailViewModel(Course course, String userId,boolean isWelcomePage) {
    	courseId = course.getCourseId();
    	description = course.getDescription();
    	welcomeMode = "custom";
    	createdAt = course.getCreatedAt();
    	updatedAt = course.getUpdatedAt();
    	if(isWelcomePage == false && userId != null) {
    		if(!userId.trim().isEmpty() || !userId.trim().isBlank() || userId != null) {
        		var user = course.getEnrollments().stream().filter(e-> e.getUser().getUserId() == userId);
        		if(user != null) {
        			levels = course.getLevels().stream().map(e-> CourseLevelListViewModel.toEnrolledCustomer(e)).collect(Collectors.toList());
        		}else {
        			levels = course.getLevels().stream().map(e-> CourseLevelListViewModel.toNotEnrolledCustomer(e)).collect(Collectors.toList());
        		}
        	}
    	}else {
    		levels = course.getLevels().stream().map(e-> CourseLevelListViewModel.toNotEnrolledCustomer(e)).collect(Collectors.toList());
    	}
    	
    	contentBlocks = course.getContentBlocks().stream().map(e-> new CourseContentBlockDetailViewModel(e)).collect(Collectors.toList());
    	totalEnrollments = course.getEnrollments().size();
    	totalModules = course.getModules().size();
    	totalQuizzes = course.getQuizzes().size();
    }
}
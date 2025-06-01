package com.quiz.viewmodels;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

import com.quiz.models.CourseContentBlock;

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
public class CourseContentBlockDetailViewModel {
    private String contentId;
    private String courseId;
    private String blockId;
    private String blockName;
    private String blockDescription;
    private int position;
    private String file;
    private String description;
    private String baseUrl;
    private String welcomeFilePath;
    private boolean isEnabled;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
    public CourseContentBlockDetailViewModel(CourseContentBlock model) {
    	contentId = model.getContentId();
    	courseId = model.getCourse().getCourseId();
    	blockId = model.getContentBlock().getBlockId();
    	blockName = model.getContentBlock().getName();
    	blockDescription = model.getContentBlock().getDescription();
    	position = model.getPosition();
    	file = model.getFile(); // this is s3 url or sthg
    	description = model.getDescription();
    	baseUrl = model.getBaseUrl();
    	welcomeFilePath = model.getWelcomeFilePath();
    	isEnabled = model.getIsEnabled();
    	createdAt = model.getCreatedAt();
    	updatedAt = model.getUpdatedAt();
    }
}
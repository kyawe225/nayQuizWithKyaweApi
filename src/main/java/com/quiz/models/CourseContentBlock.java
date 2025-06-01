package com.quiz.models;

// CourseContentBlock.java
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "course_content_blocks")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CourseContentBlock {
    @Id
    private String contentId; // Prefixed UUID with 56 char length
    
    @ManyToOne
    @JoinColumn(name = "course_fk")
    private Course course;
    
    @ManyToOne
    @JoinColumn(name = "block_id")
    private ContentBlock contentBlock;
    
    private Integer position;
    private String file;
    private String description;
    private String baseUrl;
    private String welcomeFilePath;
    private Boolean isEnabled;
    
    @Column(name = "created_at")
    @CreationTimestamp
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    @UpdateTimestamp
    private LocalDateTime updatedAt;
}
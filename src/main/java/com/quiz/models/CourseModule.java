package com.quiz.models;

// CourseModule.java
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "course_modules")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CourseModule {
    @Id
    private String moduleId; // Prefixed UUID with 56 char length
    
    @ManyToOne
    @JoinColumn(name = "course_id")
    private Course course;
    
    @ManyToOne
    @JoinColumn(name = "level_id")
    private CourseLevel level;
    
    private String title;
    private String description;
    private Integer sequenceOrder;
    private String contentType;
    private String contentUrl;
    private Integer estimatedDurationMinutes;
    private Boolean isRequired;
    
    @Column(name = "created_at")
    @CreationTimestamp
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    @UpdateTimestamp
    private LocalDateTime updatedAt;
    
    @OneToMany(mappedBy = "module")
    private List<UserModuleProgress> progresses = new ArrayList<>();
}
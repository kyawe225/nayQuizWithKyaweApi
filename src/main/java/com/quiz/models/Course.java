package com.quiz.models;

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
@Table(name = "courses")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Course {
    @Id
    private String courseId; // Prefixed UUID with 56 char length
    
    private String name;
    private String description;
    private String welcomeFk;
    private String welcomeMode;
    private String welcomeStylesheet;
    
    @ManyToOne
    @JoinColumn(name = "welcome_template_id")
    private WelcomeTemplate welcomeTemplate;
    
    @Column(name = "created_at")
    @CreationTimestamp
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    @UpdateTimestamp
    private LocalDateTime updatedAt;
    
    @OneToMany(mappedBy = "course")
    private List<CourseEnrollment> enrollments = new ArrayList<>();
    
    @OneToMany(mappedBy = "course")
    private List<CourseLevel> levels = new ArrayList<>();
    
    @OneToMany(mappedBy = "course")
    private List<CourseContentBlock> contentBlocks = new ArrayList<>();
    
    @OneToMany(mappedBy = "course")
    private List<CourseModule> modules = new ArrayList<>();
    
    @OneToMany(mappedBy = "course")
    private List<Quiz> quizzes = new ArrayList<>();
    
    @OneToMany(mappedBy = "course")
    private List<CourseAccessLog> accessLogs = new ArrayList<>();
    
    @OneToMany(mappedBy = "course")
    private List<CourseProgressSummary> progressSummaries = new ArrayList<>();
}

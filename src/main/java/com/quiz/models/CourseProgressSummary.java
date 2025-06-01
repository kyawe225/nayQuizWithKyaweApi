package com.quiz.models;

// CourseProgressSummary.java
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "course_progress_summary")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CourseProgressSummary {
    @Id
    private String summaryId; // Prefixed UUID with 56 char length
    
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    
    @ManyToOne
    @JoinColumn(name = "course_id")
    private Course course;
    
    private Integer overallProgressPercentage;
    private Integer completedModules;
    private Integer totalModules;
    private Integer completedQuizzes;
    private Integer totalQuizzes;
    private Integer totalPointsEarned;
    
    @Column(name = "last_activity")
    private LocalDateTime lastActivity;
    
    @Column(name = "created_at")
    @CreationTimestamp
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    @UpdateTimestamp
    private LocalDateTime updatedAt;
}
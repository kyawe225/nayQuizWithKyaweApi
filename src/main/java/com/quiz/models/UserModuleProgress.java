package com.quiz.models;

// UserModuleProgress.java
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "user_module_progress")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserModuleProgress {
    @Id
    private String progressId; // Prefixed UUID with 56 char length
    
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    
    @ManyToOne
    @JoinColumn(name = "module_id")
    private CourseModule module;
    
    private Boolean isCompleted;
    private Integer progressPercentage;
    
    @Column(name = "completion_date")
    private LocalDateTime completionDate;
    
    private Integer timeSpentSeconds;
    
    @Column(name = "last_accessed")
    private LocalDateTime lastAccessed;
    
    @Column(name = "created_at")
    @CreationTimestamp
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    @UpdateTimestamp
    private LocalDateTime updatedAt;
}

package com.quiz.models;

// CourseAccessLog.java
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "course_access_log")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CourseAccessLog {
    @Id
    private String logId; // Prefixed UUID with 56 char length
    
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    
    @ManyToOne
    @JoinColumn(name = "course_id")
    private Course course;
    
    @Column(name = "access_time")
    private LocalDateTime accessTime;
    
    private String ipAddress;
    private String browserInfo;
    
    @Column(name = "created_at")
    @CreationTimestamp
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    @UpdateTimestamp
    private LocalDateTime updatedAt;
}

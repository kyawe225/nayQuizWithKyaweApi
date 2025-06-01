package com.quiz.models;

// AdminAccessLog.java
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "admin_access_log")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminAccessLog {
    @Id
    private String logId;
    
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    
    private String action;
    private String details;
    
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


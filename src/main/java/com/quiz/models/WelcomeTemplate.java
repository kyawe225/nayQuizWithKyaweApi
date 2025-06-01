package com.quiz.models;

// this will update later
// WelcomeTemplate.java
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
@Table(name = "welcome_templates")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class WelcomeTemplate {
    @Id
    private String templateId; // Prefixed UUID with 56 char length
    
    private String description;
    private String baseContent;
    
    @Column(name = "created_at")
    @CreationTimestamp
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    @UpdateTimestamp
    private LocalDateTime updatedAt;
    
    @OneToMany(mappedBy = "welcomeTemplate")
    private List<Course> courses = new ArrayList<>();
}


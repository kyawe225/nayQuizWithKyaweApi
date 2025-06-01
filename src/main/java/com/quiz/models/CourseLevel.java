package com.quiz.models;

// CourseLevel.java
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
@Table(name = "course_levels")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CourseLevel {
    @Id
    private String levelId; // Prefixed UUID with 56 char length
    
    @ManyToOne
    @JoinColumn(name = "course_id")
    private Course course;
    
    private String name;
    @Column(name="ranks")
    private Integer rank;
    
    @Column(name = "created_at")
    @CreationTimestamp
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    @UpdateTimestamp
    private LocalDateTime updatedAt;
    
    @OneToMany(mappedBy = "level")
    private List<CourseModule> modules = new ArrayList<>();
    
    @OneToMany(mappedBy = "level")
    private List<Quiz> quizzes = new ArrayList<>();
}

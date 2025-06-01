package com.quiz.models;

// Quiz.java
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
@Table(name = "quizzes")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Quiz {
    @Id
    private String quizId; // Prefixed UUID with 56 char length
    
    @ManyToOne
    @JoinColumn(name = "course_id")
    private Course course;
    
    @ManyToOne
    @JoinColumn(name = "level_id")
    private CourseLevel level;
    
    private String file;
    private Boolean isFinal;
    private Integer timeInMinutes;
    
    @Column(name = "created_at")
    @CreationTimestamp
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    @UpdateTimestamp
    private LocalDateTime updatedAt;
    
    @OneToMany(mappedBy = "quiz")
    private List<Question> questions = new ArrayList<>();
    
    @OneToMany(mappedBy = "quiz")
    private List<QuizSubmission> submissions = new ArrayList<>();
    
    @OneToMany(mappedBy = "quiz")
    private List<Achievement> achievements = new ArrayList<>();
}

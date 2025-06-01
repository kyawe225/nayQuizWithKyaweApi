package com.quiz.models;

// Choice.java
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
@Table(name = "choices")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Choice {
    @Id
    private String choiceId; // Prefixed UUID with 56 char length
    
    @ManyToOne
    @JoinColumn(name = "question_id")
    private Question question;
    
    private String content;
    private Boolean isCorrect;
    
    @Column(name = "created_at")
    @CreationTimestamp
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    @UpdateTimestamp
    private LocalDateTime updatedAt;
    
    @OneToMany(mappedBy = "choice")
    private List<UserAnswer> userAnswers = new ArrayList<>();
}
package com.quiz.models;

// ContentBlock.java
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
@Table(name = "content_blocks")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ContentBlock {
    @Id
    private String blockId; // Prefixed UUID with 56 char length
    
    private String name;
    private String description;
    
    @Column(name = "created_at")
    @CreationTimestamp
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    @UpdateTimestamp
    private LocalDateTime updatedAt;
    
    @OneToMany(mappedBy = "contentBlock")
    private List<CourseContentBlock> courseContentBlocks = new ArrayList<>();
}
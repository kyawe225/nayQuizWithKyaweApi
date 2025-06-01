package com.quiz.viewmodels;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ContentBlockListViewModel {
    private String blockId;
    private String name;
    private String description;
    private LocalDateTime createdAt;
    private int usageCount;
}
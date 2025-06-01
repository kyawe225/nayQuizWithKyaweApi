package com.quiz.viewmodels;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CustomerProfileViewModel {
    private String userId;
    private String username;
    private String email;
    private int enrolledCoursesCount;
    private int completedCoursesCount;
    private List<CustomerAchievementViewModel> recentAchievements;
    private List<CustomerCourseProgressViewModel> courseProgress;
}
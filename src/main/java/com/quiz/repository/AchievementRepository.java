package com.quiz.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.quiz.models.Achievement;

// Achievement (for completed courses or milestones)
@Repository
public interface AchievementRepository extends PagingAndSortingRepository<Achievement, String> , JpaRepository<Achievement, String> {}

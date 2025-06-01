package com.quiz.repository;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.quiz.models.CourseLevel;

public interface CourseLevelRepository extends PagingAndSortingRepository<CourseLevel, String> {

}

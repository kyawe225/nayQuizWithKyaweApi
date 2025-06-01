package com.quiz.repository;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.quiz.models.CourseModule;

public interface CourseModuleRepository extends PagingAndSortingRepository<CourseModule, String> {

}

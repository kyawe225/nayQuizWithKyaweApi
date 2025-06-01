package com.quiz.repository;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.quiz.models.CourseAccessLog;

@Repository
public interface UserAccessLogRepository extends PagingAndSortingRepository<CourseAccessLog, String> {
}


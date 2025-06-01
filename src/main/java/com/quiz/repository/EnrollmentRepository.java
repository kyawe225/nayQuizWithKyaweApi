package com.quiz.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.quiz.models.CourseEnrollment;

// Enrollment (user starts course)
@Repository
public interface EnrollmentRepository extends PagingAndSortingRepository<CourseEnrollment, String>,JpaRepository<CourseEnrollment, String> {}

package com.quiz.repository;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.quiz.models.QuizSubmission;

public interface QuizSubmissionRepository extends PagingAndSortingRepository<QuizSubmission, String> {

    
}

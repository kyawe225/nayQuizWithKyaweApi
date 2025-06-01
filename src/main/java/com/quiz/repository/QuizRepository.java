package com.quiz.repository;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.quiz.models.Quiz;

public interface QuizRepository extends PagingAndSortingRepository<Quiz, String> {

}

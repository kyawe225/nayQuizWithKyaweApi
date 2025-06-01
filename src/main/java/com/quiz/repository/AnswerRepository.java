package com.quiz.repository;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.quiz.models.UserAnswer;

// Answer (user's answer to question)
// not frequently used
@Repository
public interface AnswerRepository extends PagingAndSortingRepository<UserAnswer, String> {}
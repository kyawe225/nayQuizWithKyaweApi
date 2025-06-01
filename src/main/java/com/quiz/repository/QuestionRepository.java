package com.quiz.repository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.quiz.models.Question;

// Question
@Repository
public interface QuestionRepository extends PagingAndSortingRepository<Question, String> {}
package com.quiz.repository;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.quiz.models.Choice;

// Choice (for multiple choice)
// not frequently used
@Repository
public interface ChoiceRepository extends PagingAndSortingRepository<Choice, String> {}
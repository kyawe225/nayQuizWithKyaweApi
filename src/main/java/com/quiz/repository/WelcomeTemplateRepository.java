package com.quiz.repository;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.quiz.models.WelcomeTemplate;

public interface WelcomeTemplateRepository extends PagingAndSortingRepository<WelcomeTemplate, String> {

}

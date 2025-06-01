package com.quiz.repository;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.quiz.models.UserModuleProgress;

public interface UserModuleProgressSummaryRepository  extends PagingAndSortingRepository<UserModuleProgress, String>{

}

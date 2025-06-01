package com.quiz.repository;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.quiz.models.User;

// Student/User
@Repository
public interface TutorRepository extends PagingAndSortingRepository<User, String> {}

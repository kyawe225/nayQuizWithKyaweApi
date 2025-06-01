package com.quiz.repository;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.quiz.models.User;

// Admin
@Repository
public interface AdminRepository extends PagingAndSortingRepository<User, String> {}
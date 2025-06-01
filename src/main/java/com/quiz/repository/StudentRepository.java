package com.quiz.repository;

import java.util.Optional;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.quiz.models.User;

public interface StudentRepository extends PagingAndSortingRepository<User, String> {
	public Optional<User> findByEmail(String email);
}

package com.quiz.repository;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.quiz.models.AdminAccessLog;

// AdminAccessLog (log for admin actions)
@Repository
public interface AdminAccessLogRepository extends PagingAndSortingRepository<AdminAccessLog, String> {}
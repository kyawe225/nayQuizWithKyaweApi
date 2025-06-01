package com.quiz.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.quiz.models.CourseContentBlock;

// CourseBlock (e.g. welcome, content blocks)
@Repository
public interface CourseBlockRepository extends JpaRepository<CourseContentBlock, String> {}

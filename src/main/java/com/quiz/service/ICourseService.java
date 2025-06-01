package com.quiz.service;

import java.util.List;

import com.quiz.viewmodels.CourseDetailViewModel;
import com.quiz.viewmodels.CourseListViewModel;

public interface ICourseService {
	List<CourseListViewModel> getList();
	CourseDetailViewModel getDetail(String Id, boolean isWelcomePage);
}

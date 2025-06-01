package com.quiz.service;

import java.util.List;

import com.quiz.viewmodels.EnrollmentCreateViewModel;
import com.quiz.viewmodels.EnrollmentListViewModel;

public interface ICourseEnrollmentService {
	public List<EnrollmentListViewModel> getList();
	public boolean createEnrollment(EnrollmentCreateViewModel viewModel);
	public boolean cancelEnrollment(EnrollmentCreateViewModel viewModel);
}

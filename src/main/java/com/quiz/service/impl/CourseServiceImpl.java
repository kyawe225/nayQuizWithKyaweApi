package com.quiz.service.impl;

import java.security.Principal;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import org.springframework.security.core.Authentication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import com.quiz.models.Course;
import com.quiz.models.User;
import com.quiz.repository.CourseRepository;
import com.quiz.service.ICourseService;
import com.quiz.viewmodels.CourseDetailViewModel;
import com.quiz.viewmodels.CourseListViewModel;

@Service
public class CourseServiceImpl implements ICourseService {
	private CourseRepository _repository;

	public CourseServiceImpl(CourseRepository repository) {
		_repository = repository;
	}

	@Override
	public List<CourseListViewModel> getList() {
		var models = _repository.findAll(Sort.by(Sort.Direction.DESC, "updatedAt"));
		var modelList = StreamSupport.stream(models.spliterator(), false).map((e) -> new CourseListViewModel(e))
				.collect(Collectors.toList());
		return modelList;
	}

	@Override
	public CourseDetailViewModel getDetail(String Id, boolean isWelcomePage) {
		String s = getCurrentUserId();
		Course course = _repository.getReferenceById(Id);
		if (course == null) {
			return null;
		}
		var enrolled = course.getEnrollments().stream().filter(e -> e.getUser().getUserId().equalsIgnoreCase(s));
		// TODO Auto-generated method stub
		if (isWelcomePage == false) {
			if (enrolled == null) {
				return null;
			}
		}
		return new CourseDetailViewModel(course, s, isWelcomePage);
	}

	private String getCurrentUserId() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		if (authentication != null && authentication.isAuthenticated()) {
			// You'd need to convert this to userId or lookup from database

			// Option B: If using custom UserDetails with userId
			Object principal = authentication.getPrincipal();
			if (principal instanceof UserDetails) {
				return ((User) principal).getUserId();
			}

			// Option C: If userId is stored as a claim/authority
			// return Long.parseLong(authentication.getName()); // if name is userId
		}

		return null;
	}

}

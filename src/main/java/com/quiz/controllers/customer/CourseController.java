package com.quiz.controllers.customer;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.quiz.service.ICourseService;
import com.quiz.service.impl.CourseServiceImpl;
import com.quiz.viewmodels.CourseDetailViewModel;
import com.quiz.viewmodels.CourseListViewModel;

@RestController
@RequestMapping("/app/v1/course")
public class CourseController {
	
	@Autowired
	private ICourseService service;
	
	@GetMapping("")
	public ResponseEntity<List<CourseListViewModel>> getList(){
		return ResponseEntity.ok(service.getList());
	}
	
	@GetMapping("detail/{id}")
	public ResponseEntity<CourseDetailViewModel> getDetail(@PathVariable("id") String courseId){
		return ResponseEntity.ok(service.getDetail(courseId, false));
	}
	
	@GetMapping("enrolled")
	public ResponseEntity<List<CourseListViewModel>> getEnrolledCourses(){
		return ResponseEntity.ok(service.getList());
	}
	
	@GetMapping("enrolled/{id}")
	public ResponseEntity<CourseDetailViewModel> getEnrolledCourseDetail(@PathVariable("id") String courseId){
		return ResponseEntity.ok(service.getDetail(courseId, true));
	}
}

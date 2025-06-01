package com.quiz.controllers.customer;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.quiz.service.IAchievementService;
import com.quiz.viewmodels.AchievementListViewModel;

@RestController
@RequestMapping("/app/v1/achievement")
public class AchievementController {
	
	@Autowired
	private IAchievementService service;
	
	@GetMapping("list")
	public ResponseEntity<List<AchievementListViewModel>> getList(){
		return ResponseEntity.ok(service.getAllList());
	}
	
	
}

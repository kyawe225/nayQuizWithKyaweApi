package com.quiz.controllers.admin;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("app/v1")
public class AdminDashboardController {
	@GetMapping("dashboard")
	public ResponseEntity<String> index(){
		return ResponseEntity.ok("This is dashboard");
	}
}

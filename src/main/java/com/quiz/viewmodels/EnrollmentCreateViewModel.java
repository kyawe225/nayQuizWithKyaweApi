package com.quiz.viewmodels;


import com.quiz.models.CourseEnrollment;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EnrollmentCreateViewModel {
	@NotBlank
	private String courseId;
}

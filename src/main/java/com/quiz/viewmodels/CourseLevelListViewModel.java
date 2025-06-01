package com.quiz.viewmodels;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

import com.quiz.models.Course;
import com.quiz.models.CourseLevel;

import java.math.BigDecimal;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.validation.constraints.Null;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CourseLevelListViewModel {
    private String levelId;
    private String courseId;
    private String courseName;
    private String name;
    private int rank;
    private int moduleCount;
    private int quizCount;
    private List<CourseModuleListViewModel> moduleLists;
    private List<CourseModuleDetailViewModel> moduleDetail;
    private List<QuizListViewModel> quizLists;
    
    public static CourseLevelListViewModel toEnrolledCustomer(CourseLevel model) {
    	var course =  new CourseLevelListViewModel();
    	course.setLevelId(model.getLevelId());
    	course.setCourseId(model.getCourse().getCourseId());
    	course.setCourseName(model.getCourse().getName());
    	course.setName(model.getName());
    	course.setRank(model.getRank());
    	course.setModuleCount(model.getModules().size());
    	course.setQuizCount(model.getQuizzes().size());
    	course.setModuleDetail(model.getModules().stream().map(e-> new CourseModuleDetailViewModel(e)).toList());
    	course.setQuizLists(model.getQuizzes().stream().map(e-> new QuizListViewModel(e)).toList());
    	return course;
    }
    public static CourseLevelListViewModel toNotEnrolledCustomer(CourseLevel model) {
    	var course =  new CourseLevelListViewModel();
    	course.setLevelId(model.getLevelId());
    	course.setCourseId(model.getCourse().getCourseId());
    	course.setCourseName(model.getCourse().getName());
    	course.setName(model.getName());
    	course.setRank(model.getRank());
    	course.setModuleCount(model.getModules().size());
    	course.setQuizCount(model.getQuizzes().size());
    	course.setModuleLists(model.getModules().stream().map(e-> new CourseModuleListViewModel(e)).toList());
    	course.setQuizLists(model.getQuizzes().stream().map(e-> new QuizListViewModel(e)).toList());
    	return course;
    }
}
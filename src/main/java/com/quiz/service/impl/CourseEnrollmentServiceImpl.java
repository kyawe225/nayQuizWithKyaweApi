package com.quiz.service.impl;

import java.util.List;
import java.util.stream.StreamSupport;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import com.quiz.common.Utils;
import com.quiz.models.CourseEnrollment;
import com.quiz.models.User;
import com.quiz.models.enums.DatabasePrefix;
import com.quiz.models.enums.Enums.CourseEnrollmentStatus;
import com.quiz.repository.CourseRepository;
import com.quiz.repository.EnrollmentRepository;
import com.quiz.repository.StudentRepository;
import com.quiz.service.ICourseEnrollmentService;
import com.quiz.viewmodels.EnrollmentCreateViewModel;
import com.quiz.viewmodels.EnrollmentListViewModel;

@Service
public class CourseEnrollmentServiceImpl implements ICourseEnrollmentService {
	@Autowired
	private EnrollmentRepository _repository;
	@Autowired
	private CourseRepository _crepository;
	@Autowired
	private StudentRepository _urepository;
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public CourseEnrollmentServiceImpl(EnrollmentRepository repository) {
		_repository = repository;
	}
	
	@Override
	public List<EnrollmentListViewModel> getList() {
		// TODO Auto-generated method stub
		var models = _repository.findAll(Sort.by(Sort.Direction.DESC,"updatedAt"));
		var enrollments = StreamSupport.stream(models.spliterator(), false).map(e-> new EnrollmentListViewModel()).toList();
		if(enrollments.size() > 0) {
			return enrollments;
		}
		return null;
	}

	@Override
	public boolean createEnrollment(EnrollmentCreateViewModel viewModel) {
		// TODO Auto-generated method stub
		try {
			var enrollment = new CourseEnrollment();
			enrollment.setEnrollmentId(Utils.GetGuid(DatabasePrefix.ENROLLMENT));
			enrollment.setUser(null);
			enrollment.setStatus(CourseEnrollmentStatus.enrolled);
			enrollment = _repository.save(enrollment);
			return true;
		}catch(Exception e){
			logger.error("CourseEnrollmentServiceImpl.createEnrollment => ",e);
			return false;
		}
		
	}

	@Override
	public boolean cancelEnrollment(EnrollmentCreateViewModel viewModel) {
		// TODO Auto-generated method stub
		try {
			var enrollment = new CourseEnrollment();
			enrollment.setEnrollmentId(Utils.GetGuid(DatabasePrefix.ENROLLMENT));
			enrollment.setUser(null);
			enrollment.setStatus(CourseEnrollmentStatus.dropped);
			enrollment = _repository.save(enrollment);
			return true;
		}catch(Exception e){
			logger.error("CourseEnrollmentServiceImpl.createEnrollment => ",e);
			return false;
		}
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

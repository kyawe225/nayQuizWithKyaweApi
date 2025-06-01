package com.quiz.service.impl;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.quiz.repository.AchievementRepository;
import com.quiz.service.IAchievementService;
import com.quiz.viewmodels.AchievementDetailViewModel;
import com.quiz.viewmodels.AchievementListViewModel;

@Service
public class AchievementServiceImpl implements IAchievementService {
	
	private AchievementRepository _repository;

	public AchievementServiceImpl(AchievementRepository repository) {
		_repository = repository;
	}
	
	@Override
	public List<AchievementListViewModel> getAllList() {
		// TODO Auto-generated method stub
		var models= _repository.findAll(Sort.by(Sort.Direction.DESC, "createdAt"));
		var viewModels = StreamSupport.stream(models.spliterator(),false).map((p)-> new AchievementListViewModel()).collect(Collectors.toList());
		return viewModels;
	}

	@Override
	public AchievementDetailViewModel getDetail(String Id) {
		var model = _repository.getReferenceById(Id);
		if(model == null) {
			return new AchievementDetailViewModel(model);
		}
		return null;
	}

}

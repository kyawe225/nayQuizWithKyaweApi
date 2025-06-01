package com.quiz.service;

import java.util.List;

import com.quiz.viewmodels.AchievementDetailViewModel;
import com.quiz.viewmodels.AchievementListViewModel;

public interface IAchievementService {
	List<AchievementListViewModel> getAllList();
	AchievementDetailViewModel getDetail(String Id);
}

package com.kkbERP.erp.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kkbERP.erp.dao.JobGradeDao;
import com.kkbERP.erp.vo.jobGrade;
@Service
public class jobGradeServiceImpl implements JobGradeService{

	@Autowired
	private JobGradeDao jobGradeDao;
	
	
	@Override
	public List<jobGrade> searchGradeByOption(Map<String, Object> criteria) {	
		return jobGradeDao.searchGradeByOption(criteria);
	}

}

package com.kkbERP.erp.dao;

import java.util.List;
import java.util.Map;

import com.kkbERP.erp.vo.jobGrade;

public interface JobGradeDao {
	
	List<jobGrade> searchGradeByOption(Map<String, Object> criteria);
}

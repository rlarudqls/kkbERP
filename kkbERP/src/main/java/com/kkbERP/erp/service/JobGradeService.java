package com.kkbERP.erp.service;

import java.util.List;
import java.util.Map;

import com.kkbERP.erp.vo.jobGrade;

public interface JobGradeService {

	List<jobGrade> searchGradeByOption(Map<String, Object> criteria);

}

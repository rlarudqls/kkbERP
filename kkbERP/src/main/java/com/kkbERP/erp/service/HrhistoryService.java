package com.kkbERP.erp.service;

import java.util.Map;

import com.kkbERP.erp.form.InternalMobilityAddForm;

public interface HrhistoryService {

	void addInternalMobility(InternalMobilityAddForm forms);
	Map<String, Object> searchHrHistories(Map<String, Object> criteria);
}

package com.kkbERP.erp.dao;

import java.util.List;
import java.util.Map;

import com.kkbERP.erp.vo.HrHistory;

public interface HrHistoryDao {

	void addHrHistory(HrHistory hrHistory);

	List<HrHistory> searchHrHistories(Map<String, Object> criteria);

	int getTotalPageSize(Map<String, Object> criteria);

}

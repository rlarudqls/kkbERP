package com.kkbERP.erp.dao;

import java.util.List;
import java.util.Map;

import com.kkbERP.erp.vo.PayrollTable;

public interface PayrollTableDao {

	void addPayrollTable(PayrollTable payrollTable);

	List<PayrollTable> searchPayrollTable(Map<String, Object> criteria);

	int getTotalPageSize(Map<String, Object> criteria);
	
	
}

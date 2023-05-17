package com.kkbERP.erp.service;

import java.util.Map;

import com.kkbERP.erp.vo.PayrollTable;

public interface PayrollTableService {

	void addPayrollTable(PayrollTable payrollTable);

	Map<String, Object> searchPayrollTable(Map<String, Object> criteria);

}

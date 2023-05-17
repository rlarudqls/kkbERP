package com.kkbERP.erp.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kkbERP.erp.dao.PayrollTableDao;
import com.kkbERP.erp.vo.HrPagination;
import com.kkbERP.erp.vo.PayrollTable;

@Service
public class PayrollTableServiceImpl implements PayrollTableService{
	
	@Autowired
	private PayrollTableDao payrollTableDao;
	
	@Override
	public void addPayrollTable(PayrollTable payrollTable) {
		payrollTableDao.addPayrollTable(payrollTable);
	}

	@Override
	public Map<String, Object> searchPayrollTable(Map<String, Object> criteria) {
		
		int totalSize = payrollTableDao.getTotalPageSize(criteria);
		
		Map<String, Object> payrollTableByPage = new HashMap<String, Object>();
		if(criteria.get("pageNo") == null || criteria.get("pageNo").equals(1)) {
			HrPagination pagination = new HrPagination(1, totalSize);
			criteria.put("beginIndex", pagination.getBeginIndex());
			criteria.put("endIndex", pagination.getEndIndex());
			payrollTableByPage.put("pagination", pagination);
		} else {
			HrPagination pagination = new HrPagination((Integer) criteria.get("pageNo"), totalSize);
			criteria.put("beginIndex", pagination.getBeginIndex());
			criteria.put("endIndex", pagination.getEndIndex());
			payrollTableByPage.put("pagination", pagination);
		}
		List<PayrollTable> payrollTables = payrollTableDao.searchPayrollTable(criteria);
		payrollTableByPage.put("payrollTables", payrollTables);
		
		return payrollTableByPage;
	}
}

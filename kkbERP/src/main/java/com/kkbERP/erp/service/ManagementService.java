package com.kkbERP.erp.service;

import java.util.Map;

import com.kkbERP.erp.form.ManagementAddForm;

public interface ManagementService {

	void addManagement(ManagementAddForm managementAddForm);

	Map<String, Object> searchManagment(Map<String, Object> criteria);

	int getTotalPayment(String payMonth, String[] selectedEmpNos, String paymentType);

}

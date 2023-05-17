package com.kkbERP.erp.service;

import java.util.List;
import java.util.Map;

import com.kkbERP.erp.vo.Department;

public interface DepartmentSerivce {

	List<Department>getAllDepartments();

	List<Department> searchDepartmentByOption(Map<String, Object> criteria);

	void addDepartment(Department department);

	void delteDepartmentByNo(int departmentNo);

	void updateDepartment(Department department);
	
}

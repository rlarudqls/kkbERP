package com.kkbERP.erp.dao;

import java.util.List;
import java.util.Map;

import com.kkbERP.erp.vo.Department;

public interface DepartmentDao {

	List<Department> getAllDepartments();

	List<Department> getDepartmentByOption(Map<String, Object> criteria);

	void addDepartment(Department department);

	void deleteDepartmentByNo(int departmentNo);

	void updateDepartment(Department department);
}

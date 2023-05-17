package com.kkbERP.erp.dao;

import java.util.List;
import java.util.Map;

import com.kkbERP.erp.dto.EmployeeDetailDto;
import com.kkbERP.erp.dto.EmployeeExcelDto;
import com.kkbERP.erp.dto.TotalStatusDto;
import com.kkbERP.erp.dto.TotalStatusByDeptDto;
import com.kkbERP.erp.dto.TotalStatusByGradeDto;
import com.kkbERP.erp.vo.Employee;

public interface EmployeeDao {

	EmployeeDetailDto getMyInfoByNo(int employeeNo);
	Employee getEmployeeByNo(int employeeNo);
	List<EmployeeDetailDto> getAllEmployees();
	List<EmployeeDetailDto> searchByOption(Map<String, Object> criteria);
	void updateEmployee(Employee employee);
	void addOneEmployee(Employee employee);
	void deleteEmployeeByNo(int employeeNo);
	List<EmployeeDetailDto> getEmployeesByDepartmentNo(int no);
	void addExcelEmployee(EmployeeExcelDto employeeExcelDto);
	int getTotalPageSize(Map<String, Object> criteria);
	EmployeeDetailDto getEmployeeDetailByNo(int employeeNo);
	List<EmployeeDetailDto> getSelectEmployees(Map<String, Object> criteria);
	TotalStatusDto getTotalStatus(String year);
	TotalStatusByGradeDto getTotalStatusByGrade(String year);
	List<TotalStatusByDeptDto> getTotalStatusByDept(String year);
	List<EmployeeDetailDto>getAllEmployeesName();
}

package com.kkbERP.erp.service;

import java.util.List;
import java.util.Map;

import com.kkbERP.erp.dto.EmployeeDetailDto;
import com.kkbERP.erp.dto.EmployeeExcelDto;
import com.kkbERP.erp.vo.Employee;

public interface EmployeeService {

	EmployeeDetailDto getMyInfoByNo(int employeeNo);
	List<EmployeeDetailDto> getAllEmployees();
	Map<String, Object> searchByoption(Map<String, Object> criteria);
	void updateEmployee(Employee employee);
	void addOneEmployee(Employee employee);
	void deleteEmployeeByNo(int[] employeeNos);
	List<EmployeeDetailDto> getEmployeesByDepartmentNo(int no);
	void addExcelEmployee(EmployeeExcelDto employeeExcelDto);
	EmployeeDetailDto getEmployeeDetailByNo(int employeeNo);
	List<EmployeeDetailDto> getSelectEmployees(Map<String, Object> criteria);
	Map<String, Object> getPersonnelStatus(String year);
	List<EmployeeDetailDto>getAllEmployeesName();
	
}

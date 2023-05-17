package com.kkbERP.erp.service;

import com.kkbERP.erp.dto.EmployeeDetailDto;
import com.kkbERP.erp.vo.Employee;

public interface LoginService {

	/**
	 * 입력한 직원번호와 비밀번호로 로그인한다.
	 * @param employeeNo 직원번호
	 * @param password 비밀번호
	 */
	Employee login(int employeeNo, String password);
	
	/**
	 * 아이디 비밀번호가 확인된 직원의 상세정보를 조회한다.
	 * @param employeeNo 직원번호
	 * @return EmpDetailDto 직원 상세정보
	 */
	EmployeeDetailDto getEmployeeDto(int employeeNo);
}

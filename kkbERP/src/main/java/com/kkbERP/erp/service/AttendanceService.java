package com.kkbERP.erp.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.kkbERP.erp.vo.Attendance;
import com.kkbERP.erp.vo.Management;

public interface AttendanceService {

	void addEmployeeAttendance(int employeeNo, String employeeName, Date intime) throws Exception;

	Attendance getAttendanceTodayByEmpNo(int employeeNo);

	void updateEmployeeAttendance(int employeeNo, Date outtime);

	Map<String, Object> searchAttendances(Map<String, Object> criteria);

	List<Management> attendanceFixed(String payMonth);

}

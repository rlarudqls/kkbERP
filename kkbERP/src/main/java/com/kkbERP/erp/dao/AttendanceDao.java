package com.kkbERP.erp.dao;

import java.util.List;
import java.util.Map;
import com.kkbERP.erp.vo.Attendance;

public interface AttendanceDao {

	void addEmployeeAttendance(Attendance attendance);

	Attendance getAttendanceTodayByEmpNo(int employeeNo);

	void updateEmployeeAttendance(Attendance attendance);

	int getTotalPageSize(Map<String, Object> criteria);

	List<Attendance> searchAttendances(Map<String, Object> criteria);

	List<Attendance> getAllAttendanceByStatus(String payMonth);

}

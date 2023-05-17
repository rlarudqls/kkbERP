package com.kkbERP.erp.web.controller;

import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.kkbERP.erp.dto.EmployeeDetailDto;
import com.kkbERP.erp.dto.NoticeListDto;
import com.kkbERP.erp.service.AttendanceService;
import com.kkbERP.erp.service.NoticeService;
import com.kkbERP.erp.vo.Attendance;

@Controller
public class HomeController {
	
	@Autowired
	private NoticeService noticeService;
	@Autowired
	private AttendanceService attendanceService;
	

	@GetMapping("/home.erp")
	public String home() {
		
		return "home";
	}
	
	@RequestMapping("/main.erp") 
	public String main(Model model, HttpSession session) {
		EmployeeDetailDto employee = (EmployeeDetailDto) session.getAttribute("LE_detail");
		if(employee == null) {
			return "redirect:/home.erp";
		}
		int deptNo = employee.getDepartmentNo();
		List<NoticeListDto> notices = noticeService.getMainNoticeLists(deptNo);
		
		Attendance attendance = attendanceService.getAttendanceTodayByEmpNo(employee.getNo());
		model.addAttribute("attendance", attendance);
		model.addAttribute("notices", notices);
		return "main";
	}
	
	@RequestMapping("/intimeUser.erp")
	public String intimeUser(@RequestParam("empNo") int employeeNo,@RequestParam("empName") String employeeName ,@RequestParam("times") long intime) throws Exception {
		Date intimeDate = new Date(intime);
		attendanceService.addEmployeeAttendance(employeeNo, employeeName, intimeDate);
		return "redirect:/main.erp";
	}
	@RequestMapping("/outtimeUser.erp")
	public String outtimeUser(@RequestParam("empNo") int employeeNo, @RequestParam("empName") String employeeName, @RequestParam("times") long outtime) {
		Date outtimeDate = new Date(outtime);
		attendanceService.updateEmployeeAttendance(employeeNo, outtimeDate);
		return "redirect:/main.erp";
	}
}

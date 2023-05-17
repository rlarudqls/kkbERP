package com.kkbERP.erp.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kkbERP.erp.dto.ApprovalDetail;
import com.kkbERP.erp.dto.FactoryOrderItemDto;
import com.kkbERP.erp.dto.OrderItemDto;
import com.kkbERP.erp.service.ApprovalService;
import com.kkbERP.erp.vo.Employee;

@Controller
@RequestMapping("/approvals")
public class ApprovalController {
	
	@Autowired
	private ApprovalService approvalService;
	
	@RequestMapping("/main.erp")
	public String main() {
		return "approvals/main";
	}
	
	@RequestMapping("/myapprovals.erp")
	public String myApproval() {
		return "approvals/approval";
	}
	
	@RequestMapping("/allapprovals.erp")
	public String allApproval() {
		return "approvals/all_approvals";
	}
	
	@RequestMapping("/toSignApproval.erp")
	public String tosignApprovals() {
		return "approvals/tosign_approvals";
	}
	
	@RequestMapping("/signedApproval.erp")
	public String signedApproval() {
		return "approvals/signed_approval";
	}
	
	@RequestMapping("/getAllApprovals.erp")
	@ResponseBody
	public List<ApprovalDetail> getAllApprovals(@RequestParam("option") String option) {
		Map<String, Object> criteria = new HashMap<String, Object>();
		criteria.put("option", option);
		
		List<ApprovalDetail> approvals = approvalService.getAllApprovals(criteria);
		
		return approvals;
	}

	@RequestMapping("/getmyapprovals.erp")
	@ResponseBody
	public List<ApprovalDetail> getMyAllApprovals(@RequestParam("option") String option, HttpSession session) {
		Employee employee = (Employee)session.getAttribute("LE");
		int employeeNo = employee.getNo();
		Map<String, Object> criteria = new HashMap<String, Object>();
		criteria.put("employeeNo", employeeNo);
		criteria.put("option", option);
		
		List<ApprovalDetail> approvals = approvalService.getMyApprovals(criteria);
		
		return approvals;
	}
	
	@RequestMapping("/getToSignapprovals.erp")
	@ResponseBody
	public List<ApprovalDetail> getToSignApprovals(HttpSession session) {
		Employee employee = (Employee)session.getAttribute("LE");
		int employeeNo = employee.getNo();
		Map<String, Object> criteria = new HashMap<String, Object>();
		criteria.put("employeeNo", employeeNo);
		criteria.put("option", "ready");
		
		List<ApprovalDetail> approvals = approvalService.getToSignApprovals(criteria);
		
		return approvals;
	}
	
	@RequestMapping("/getSignedApprovals.erp")
	@ResponseBody
	public List<ApprovalDetail> getSignedApprovals(HttpSession session) {
		Employee employee = (Employee)session.getAttribute("LE");
		int employeeNo = employee.getNo();
		Map<String, Object> criteria = new HashMap<String, Object>();
		criteria.put("employeeNo", employeeNo);
		criteria.put("option", "signed");
		
		List<ApprovalDetail> approvals = approvalService.getToSignApprovals(criteria);
		
		return approvals;
	}
	
	@RequestMapping("/getFactoryOrderItem.erp")
	@ResponseBody
	public List<FactoryOrderItemDto> getFactoryOrderItems(@RequestParam("factoryOrderNo") int factoryOrderNo) {
		
		return approvalService.getFactoryOrderItemsByOrderNo(factoryOrderNo);
	}
	
	@RequestMapping("/getOrderItem.erp")
	@ResponseBody
	public List<OrderItemDto> getOrderItems(@RequestParam("orderNo") int orderNo) {
		
		return approvalService.getOrderItemDetailsByOrderNo(orderNo);
	}
	
	@RequestMapping("/sign.erp")
	@ResponseBody
	public String signApproval(@RequestParam("note") String note, @RequestParam("approvalNo") int approvalNo,
											@RequestParam("orderNo") int orderNo, @RequestParam("factoryOrderNo") int factoryOrderNo) {
		
		Map<String, Object> approvalInfo = new HashMap<String, Object>();
		approvalInfo.put("approvalNo", approvalNo);
		approvalInfo.put("note", note);
		if(orderNo == 0) {
			approvalInfo.put("factoryOrderNo", factoryOrderNo);
		}else {
			approvalInfo.put("orderNo", orderNo);
		}
		approvalService.signApproval(approvalInfo);
		
		return "";
	}
}

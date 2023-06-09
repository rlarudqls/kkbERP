package com.kkbERP.erp.web.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kkbERP.erp.dto.EmployeeDetailDto;
import com.kkbERP.erp.dto.MessageDto;
import com.kkbERP.erp.service.EmployeeService;
import com.kkbERP.erp.service.MessageService;
import com.kkbERP.erp.vo.Employee;

@Controller
@RequestMapping("/my")
public class MessageController {

	@Autowired
	private MessageService messageService;
	@Autowired
	private EmployeeService employeeService;
	
	@RequestMapping("/getmessage.erp")
	public String getMessge(HttpSession session, Model model) {
		
		Employee employee = (Employee)session.getAttribute("LE");
		
		List<EmployeeDetailDto> allEmployees = employeeService.getAllEmployeesName();
		List<MessageDto> getMessages =  messageService.getMessage(employee.getNo());
		int isReadCount = messageService.isReadCount(employee.getNo());
		/*
		 * for(MessageDto messages : getMessages) {
		 * if("N".equals(messages.getIsRead())){
		 * 
		 * 
		 * } }
		 */
		model.addAttribute("getMessages", getMessages);
		model.addAttribute("allEmployees", allEmployees);
		model.addAttribute("isReadCount", isReadCount);
		return "my/getmessage";
	}
	@RequestMapping("/detailmessage.erp")
	public String detailMessage(@RequestParam("messageno") int messageNo, Model model) {
		
		MessageDto detailMessage = messageService.detailMessage(messageNo);
		
		model.addAttribute("detailMessage", detailMessage);
		
		return "my/detailmessage";
	}
	
	@RequestMapping("/send_detailmessage.erp")
	public String sendDetailMessage(@RequestParam("messageno") int messageNo, Model model) {
		
		MessageDto detailMessage = messageService.detailMessage(messageNo);
		
		model.addAttribute("detailMessage", detailMessage);
		
		return "my/send_detailmessage";
	}
	
	@PostMapping("/reply.erp")
	public String sendMessage(MessageDto messageDto, @RequestParam("messageno") int messageno , HttpSession session) {
		
		Employee employee = (Employee)session.getAttribute("LE");
		int senderNo = employee.getNo();
		messageDto.setSenderNo(senderNo);
		
		messageService.sendEmail(messageDto);
		
		return "redirect:/my/detailmessage.erp?result=sendmessagesuccess&messageno="+messageno;
	}
	@PostMapping("/sendmessage.erp")
	public String sendMessage(MessageDto messageDto, HttpSession session) {
		
		Employee employee = (Employee)session.getAttribute("LE");
		int senderNo = employee.getNo();
		messageDto.setSenderNo(senderNo);
		
		messageService.sendEmail(messageDto);
		
		return "redirect:/my/getmessage.erp";
	}
	@PostMapping("/sendemployeemessage.erp")
	public String sendemployeeMessage(MessageDto messageDto, HttpSession session) {
		
		Employee employee = (Employee)session.getAttribute("LE");
		int senderNo = employee.getNo();
		messageDto.setSenderNo(senderNo);
		
		messageService.sendEmail(messageDto);
		
		return "redirect:/my/searchemployee.erp"; //발신메세지함으로 보내기 발신메세지에서 보낸 메세지 확인
	}
	@GetMapping("/deletemessage.erp")
	public String deleteMessage(@RequestParam("messageno") int messageNo) {
		
		messageService.deleteMessage(messageNo);
		
		return "redirect:/my/getmessage.erp?result=deletemessage";
	}
	@GetMapping("/deletesendmessage.erp")
	public String deleteSendMessage(@RequestParam("messageno") int messageNo) {
		
		messageService.deleteMessage(messageNo);
		
		return "redirect:/my/sendmessages.erp?result=deletemessage";
	}
	
	@GetMapping("/deleteSelectedMessages.erp")
	public String deleteSelectedMessages(@RequestParam("messageno") int [] messageNo) {
		
		messageService.deleteSelectMessage(messageNo);
		return "redirect:/my/getmessage.erp";
	}
	
	@GetMapping("/deleteSelectedSendMessages.erp")
	public String deleteSelectedSendMessages(@RequestParam("messageno") int [] messageNo) {
		
		messageService.deleteSelectMessage(messageNo);
		return "redirect:/my/sendmessages.erp";
	}
	
	@RequestMapping("/sendmessages.erp")
	public String sendMessgess(HttpSession session, Model model) {
		
		Employee employee = (Employee)session.getAttribute("LE");
		List<MessageDto> getMessages =  messageService.sendMessage(employee.getNo());
		
		model.addAttribute("getMessages", getMessages);
		
		return "my/sendmessages";
	}
}

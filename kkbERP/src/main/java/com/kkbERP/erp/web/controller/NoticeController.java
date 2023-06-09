package com.kkbERP.erp.web.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


import com.kkbERP.erp.dto.NoticeListDto;
import com.kkbERP.erp.form.NoticesAddForm;
import com.kkbERP.erp.form.NoticesModifyForm;
import com.kkbERP.erp.service.DepartmentSerivce;

import com.kkbERP.erp.service.NoticeService;
import com.kkbERP.erp.vo.Department;
import com.kkbERP.erp.vo.Notices;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Value("${employeeSource.source.directory}")
	private String employeeExcelFileDirectory;
	
	@Autowired
	private NoticeService noticeListService;
	
	@Autowired
	private DepartmentSerivce departmentService;

	@RequestMapping("/notice.erp")
	public String getNoticesByNo(Model model) {
		
		List<Department> departments = departmentService.getAllDepartments();
		model.addAttribute("departments", departments);
		
		return "notice/notice";
	}
	@GetMapping("/search.erp")
	@ResponseBody
	public Map<String, Object> getAllNotice(@RequestParam(value = "deptno", required = false ) int deptNo ,
											@RequestParam(value = "pageno", required= false, defaultValue = "1") Integer pageNo) {
		
		Map<String, Object> criteria = new HashMap<String, Object>();
		criteria.put("deptno", deptNo);
		criteria.put("pageno", pageNo);
		Map<String, Object> lists = noticeListService.getNoticeLists(criteria); //고치기
		return lists;
	}
	@RequestMapping("/detail.erp")
	public String getDetailNotice(@RequestParam("noticeno") int noticeNo, @RequestParam("deptno") int deptNo,
									@RequestParam("pageno") int pageno, Model model) {
		
		noticeListService.updateView(noticeNo);
		
		Notices notices = new Notices();
		notices.setNo(noticeNo);
		notices.setDeptNo(deptNo);
		
		NoticeListDto noticeDetail = noticeListService.getNoticeByNo(noticeNo);
		NoticeListDto nextArticle = noticeListService.nextArticle(notices);
		NoticeListDto prevArticle = noticeListService.prevArticle(notices);
		
		model.addAttribute("noticeDetail", noticeDetail);
		model.addAttribute("nextArticle", nextArticle);
		model.addAttribute("prevArticle", prevArticle);
		model.addAttribute("pageno", pageno);
		
		return "notice/detail";
	}
	@GetMapping("/download.erp")
	public String downlaodNotice (@RequestParam("noticeno") int noticeNo, Model model) throws Exception {
		
		NoticeListDto noticeListDto = noticeListService.getNoticeByNo(noticeNo);
		String filename = noticeListDto.getSource();
		
		model.addAttribute("filename", filename);
		model.addAttribute("directory", employeeExcelFileDirectory);
		
		return "fileDownloadView";
	}
	
	@GetMapping("/notice-addform.erp")
	public String noticeaddForm(Model model) {
		
		List<Department> Departments = departmentService.getAllDepartments();
		model.addAttribute("Departments", Departments);
		
		return "notice/notice-addform";
	}
	@PostMapping("/notice-addform.erp")
	public String addNotice(NoticesAddForm form) throws Exception{
		 Notices notices = new Notices();
		 BeanUtils.copyProperties(form, notices);
		 System.out.println(notices.getDeptNo());
		 MultipartFile source = form.getSource();
		 if(!source.isEmpty()) {
			 String filename = source.getOriginalFilename();
			 notices.setSource(filename);
			 
			 FileCopyUtils.copy(source.getBytes(), new File(employeeExcelFileDirectory, filename));
		 }
		 noticeListService.addNotice(notices);
		 
		 return "redirect:/notice/notice.erp";
	}
	
	@GetMapping("/modifyform.erp")
	public String modify(Model model) {
		List<Department> departments = departmentService.getAllDepartments();
		model.addAttribute("departments", departments);
		return "notice/modifyform";
	}
	
	@GetMapping("/modify.erp")
	@ResponseBody
	public List<NoticeListDto> modifyNoticeList(@RequestParam("deptno") int deptNo) {
		
		List<NoticeListDto> lists = noticeListService.getModifyNoticeLists(deptNo);
		return lists;
	}
	@RequestMapping("/modifynotice.erp")
	@ResponseBody
	public NoticeListDto modifyNotice(@RequestParam("noticeno") int noticeNo) {
		return noticeListService.getNoticeByNo(noticeNo);
	}
	
	@PostMapping("/modifyUpdateNotice.erp")
	public String modifyUpdateNotice(NoticesModifyForm modifyForm ) throws Exception {
		
		Notices changeNotice = new Notices();
		
		BeanUtils.copyProperties(modifyForm, changeNotice);
		
		MultipartFile source = modifyForm.getSource();
		 
		if(!source.isEmpty()) {
			 String filename = source.getOriginalFilename();
			 changeNotice.setSource(filename);
			 
			 FileCopyUtils.copy(source.getBytes(), new File(employeeExcelFileDirectory, filename));
		 }
		
		noticeListService.updateNotice(changeNotice);
		int pagedeptNo = modifyForm.getPagedeptno();
		
		return "redirect:/notice/modifyform.erp?result=modifysuccess&deptno="+pagedeptNo;
		
		}
	
	@GetMapping("/deleteNotice.erp")
	public String deleteNotice(@RequestParam("noticeno") int noticeNo, @RequestParam("deptno") int deptNo) {
		
		noticeListService.deleteNoticeByNo(noticeNo);

		
		return "redirect:/notice/modifyform.erp?deptno="+deptNo;
	}
	
	@GetMapping("/selectDeleteNotice.erp")
	@ResponseBody
	public List<NoticeListDto> deleteSelectNotice(@RequestParam("noticeno") int[] noticeNo, @RequestParam("deptno") int deptNo) {
		noticeListService.deleteSelectNotice(noticeNo);
		List<NoticeListDto> noticeList = noticeListService.getModifyNoticeLists(deptNo);
		System.out.println(noticeList.size());
		return noticeList;
	}
}


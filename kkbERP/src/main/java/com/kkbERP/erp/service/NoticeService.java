package com.kkbERP.erp.service;

import java.util.List;
import java.util.Map;

import com.kkbERP.erp.dto.NoticeListDto;
import com.kkbERP.erp.vo.Notices;

public interface NoticeService {

	Map<String, Object> getNoticeLists(Map<String, Object> criteria);
	NoticeListDto getNoticeByNo(int noticeNo);
	void updateView(int noticeNo);
	NoticeListDto nextArticle(Notices notice);
	NoticeListDto prevArticle(Notices notice);
	void addNotice(Notices notice);
	void updateNotice(Notices notice);
	void deleteNoticeByNo(int noticeNo);
	void deleteSelectNotice(int[] noticeNo);
	List<NoticeListDto> getMainNoticeLists(int deptNo);
	List<NoticeListDto> getModifyNoticeLists(int deptNo);
}

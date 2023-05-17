package com.kkbERP.erp.dao;

import java.util.List;
import java.util.Map;

import com.kkbERP.erp.dto.NoticeListDto;
import com.kkbERP.erp.vo.Notices;

public interface NoticeDao {

	List<NoticeListDto> getNoticeLists(Map<String, Object> criteria);
	NoticeListDto getNoticeByNo(int noticeNo);
	void updateView(int noticeNo);
	NoticeListDto nextArticle(Notices notice);
	NoticeListDto prevArticle(Notices notice);
	void addNotice(Notices notice);
	void updateNotice(Notices notice);
	void deleteNoticeByNo(int noticeNo);
	List<NoticeListDto> getMainNoticeLists(int deptNo);
	int getNoticeCount(int deptNo);
	List<NoticeListDto> getModifyNoticeLists(int deptNo);
}

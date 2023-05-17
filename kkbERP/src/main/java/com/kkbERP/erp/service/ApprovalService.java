package com.kkbERP.erp.service;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import com.kkbERP.erp.dto.ApprovalDetail;
import com.kkbERP.erp.dto.FactoryOrderItemDto;
import com.kkbERP.erp.dto.OrderItemDto;
import com.kkbERP.erp.vo.OrderItem;


public interface ApprovalService {

	List<ApprovalDetail> getAllApprovals(Map<String, Object> criteria);
	List<ApprovalDetail> getMyApprovals(Map<String, Object> criteria);
	List<ApprovalDetail> getToSignApprovals(Map<String, Object> criteria);
	List<FactoryOrderItemDto> getFactoryOrderItemsByOrderNo(int factoryOrderNo);
	List<OrderItem> getOrderItemsByOrderNo(int orderNo);
	List<OrderItemDto> getOrderItemDetailsByOrderNo(int orderNo);
	
	@Transactional
	void signApproval(Map<String, Object> approvalInfo);
}

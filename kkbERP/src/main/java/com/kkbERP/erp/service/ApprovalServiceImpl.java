package com.kkbERP.erp.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kkbERP.erp.dao.FactoryOrderDao;
import com.kkbERP.erp.dao.OrderDao;
import com.kkbERP.erp.dao.ProductApprovalDao;
import com.kkbERP.erp.dao.StorageDao;
import com.kkbERP.erp.dao.StoreStockDao;
import com.kkbERP.erp.dto.ApprovalDetail;
import com.kkbERP.erp.dto.FactoryOrderItemDto;
import com.kkbERP.erp.dto.OrderItemDto;
import com.kkbERP.erp.dto.StorageStockDto;
import com.kkbERP.erp.dto.StoreStockDto;
import com.kkbERP.erp.vo.FactoryOrder;
import com.kkbERP.erp.vo.Order;
import com.kkbERP.erp.vo.OrderItem;
import com.kkbERP.erp.vo.StorageStock;
import com.kkbERP.erp.vo.StoreStock;

@Service
public class ApprovalServiceImpl implements ApprovalService{

	@Autowired
	private ProductApprovalDao approvalDao;
	
	@Autowired
	private FactoryOrderDao factoryOrderDao;
	
	@Autowired
	private StorageDao storageDao;
	
	@Autowired
	private OrderDao orderDao;
	
	@Autowired
	private StoreStockDao storeStockDao;
	
	@Override
	public List<ApprovalDetail> getAllApprovals(Map<String, Object> criteria) {
		return approvalDao.getAllApprovals(criteria);
	}

	@Override
	public List<ApprovalDetail> getMyApprovals(Map<String, Object> criteria) {
		return approvalDao.getApprovalsByRequesterNo(criteria);
	}

	@Override
	public List<ApprovalDetail> getToSignApprovals(Map<String, Object> criteria) {
		return approvalDao.getApprovalsByResponserNo(criteria);
	}

	@Override
	public List<FactoryOrderItemDto> getFactoryOrderItemsByOrderNo(int factoryOrderNo) {
		return factoryOrderDao.getFactoryOrderItemsByOrderNo(factoryOrderNo);
	}
	
	@Override
	public List<OrderItem> getOrderItemsByOrderNo(int orderNo) {
		return orderDao.getOrderItemsByOrderNo(orderNo);
	}
	
	@Override
	public List<OrderItemDto> getOrderItemDetailsByOrderNo(int orderNo) {
		return orderDao.getOrderItemDetailsByOrderNo(orderNo);
	}

	@Override
	public void signApproval(Map<String, Object> approvalInfo) {
		// 결재테이블의 승인일자, 상태, 비고 내용을 변경한다.
		// 상태는 결재 완료로 처리된다.
		
		approvalInfo.put("status", "결재완료");
		approvalDao.updateApproval(approvalInfo);
		// orderNo, factoryOrderNo 를 구분하여 
		// 해당 order,factoryOrder의 승인일자를 선택하고 상태를 주문완료로 변경한다.
		if(approvalInfo.get("orderNo") == null) {
			// 발주번호에 해당하는 생산의뢰
			int orderNo = (Integer) approvalInfo.get("factoryOrderNo");
			factoryOrderDao.signFactoryOrder(orderNo); 
			
			// 결재 승인이 되었으므로, 해당 창고의 재고를 늘린다.
			List<FactoryOrderItemDto> items = factoryOrderDao.getFactoryOrderItemsByOrderNo(orderNo);
			FactoryOrder order = factoryOrderDao.getFactoryOrderByNo(orderNo);
			
			int storageNo = order.getStorageNo();
			List<StorageStockDto> stocks = storageDao.getStorageStockDetailsByStorageNo(storageNo);
			StorageStock storageStock = new StorageStock();
			storageStock.setStorageNo(storageNo);
			
			for(FactoryOrderItemDto item : items) {
				boolean isExist = false;
				int orderProductNo = item.getProductNo();
				storageStock.setProductNo(orderProductNo);
				
				for(StorageStockDto stock : stocks) {
					int stockProductNo = stock.getProductNo();
					
					if(orderProductNo == stockProductNo) {
						isExist = true;
					}
					
				}
				int amount = item.getAmount();
				if(isExist) {
					int prevAmount = storageDao.getStockAmountByStorageNoAndProductNo(storageStock);
					System.out.println(prevAmount);
					storageStock.setAmount(prevAmount + amount);
					storageDao.updateStockAmountByStorageNoAndProductNo(storageStock);
				}else {
					storageStock.setAmount(amount);
					storageDao.insertStock(storageStock);
				}
			}
			
		}else {
			// 발주 번호에 해당하는 발주 의뢰
			int orderNo = (Integer) approvalInfo.get("orderNo"); 
			orderDao.signOrder(orderNo);
			
			// 결재 승인이 되었으므로, 해당 매장의 재고를 늘린다.
				List<OrderItem> items = orderDao.getOrderItemsByOrderNo(orderNo);
				Order order = orderDao.getOrderByOrderNo(orderNo);
				
				int storeNo = order.getStoreNo();
				List<StoreStockDto> stocks = storeStockDao.getStoreStockDetailsByStoreNo(storeNo);
				StoreStock storeStock = new StoreStock();
				storeStock.setStoreNo(storeNo);
				
				for(OrderItem item : items) {
					boolean isExist = false;
					int orderProductNo = item.getProductNo();
					storeStock.setProductNo(orderProductNo);
					
					for(StoreStockDto stock : stocks) {
						int stockProductNo = stock.getProductNo();
						
						if(orderProductNo == stockProductNo) {
							isExist = true;
						}
						
					}
					int amount = item.getAmount();
					if(isExist) {
						int prevAmount = storeStockDao.getStockAmountByStoreNoAndProductNo(storeStock);
						System.out.println(prevAmount);
						storeStock.setAmount(prevAmount + amount);
						storeStockDao.updateStockAmountByStoreNoAndProductNo(storeStock);
					}else {
						storeStock.setAmount(amount);
						storeStockDao.insertStock(storeStock);
					}
				}
		}
		
	}

}

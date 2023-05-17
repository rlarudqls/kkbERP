package com.kkbERP.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kkbERP.erp.dao.EmployeeDao;
import com.kkbERP.erp.dao.FactoryOrderDao;
import com.kkbERP.erp.dao.ProductApprovalDao;
import com.kkbERP.erp.dao.StorageDao;
import com.kkbERP.erp.dto.StorageStockDto;
import com.kkbERP.erp.form.FactoryOrderAddForm;
import com.kkbERP.erp.vo.Employee;
import com.kkbERP.erp.vo.FactoryOrderItem;
import com.kkbERP.erp.vo.ProductApproval;
import com.kkbERP.erp.vo.Storage;

@Service
public class StorageServiceImpl implements StorageService{

	@Autowired
	private StorageDao storageDao;
	
	@Autowired
	private FactoryOrderDao factoryOrderDao;
	
	@Autowired
	private EmployeeDao employeeDao;
	
	@Autowired
	private ProductApprovalDao approvalDao;
	
	@Override
	public List<Storage> getAllStorages() {
		return storageDao.getAllStorages();
	}

	@Override
	public List<StorageStockDto> getStorageStockDetailsByStorageNo(int storageNo) {
		return storageDao.getStorageStockDetailsByStorageNo(storageNo);
	}

	@Override
	public Storage getStorageByNo(int storageNo) {
		return storageDao.getStorageByNo(storageNo);
	}

	@Override
	public void addNewFactoryOrder(FactoryOrderAddForm orderForm) {
		factoryOrderDao.insertOrder(orderForm);
		System.out.println(orderForm.getNo());
		
		FactoryOrderItem orderItem = new FactoryOrderItem();
		int[] productNos = orderForm.getProductNos();
		int[] amounts = orderForm.getAmounts();
		
		orderItem.setOrderNo(orderForm.getNo());
		 for(int i=0; i<productNos.length; i++) {
			 int productNo = productNos[i];
			 int amount = amounts[i];
			 orderItem.setProductNo(productNo); 
			 orderItem.setAmount(amount);
		 
			 factoryOrderDao.insertOrderItem(orderItem); 
		 }
		 
		 ProductApproval approval = new ProductApproval();
		 approval.setTypeNo(20);
		 approval.setRequesterNo(orderForm.getEmployeeNo());
		 Employee emp = employeeDao.getEmployeeByNo(orderForm.getEmployeeNo());		 
		 approval.setResponserNo(emp.getManagerNo());
		 approval.setFactoryOrderNo(orderForm.getNo());
		 
		 approvalDao.insertFactoryApproval(approval);
	}
	
}

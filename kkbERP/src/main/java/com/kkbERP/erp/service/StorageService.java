package com.kkbERP.erp.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.kkbERP.erp.dto.StorageStockDto;
import com.kkbERP.erp.form.FactoryOrderAddForm;
import com.kkbERP.erp.vo.Storage;


public interface StorageService {

	List<Storage> getAllStorages();
	List<StorageStockDto> getStorageStockDetailsByStorageNo(int storageNo);
	Storage getStorageByNo(int storageNo);
	
	@Transactional
	void addNewFactoryOrder(FactoryOrderAddForm orderForm);
}

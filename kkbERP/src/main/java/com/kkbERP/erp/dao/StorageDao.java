package com.kkbERP.erp.dao;

import java.util.List;

import com.kkbERP.erp.dto.StorageStockDto;
import com.kkbERP.erp.vo.Storage;
import com.kkbERP.erp.vo.StorageStock;

public interface StorageDao {

	List<Storage> getAllStorages();
	List<StorageStockDto> getStorageStockDetailsByStorageNo(int storageNo);
	Storage getStorageByNo(int storageNo);
	StorageStock getStorageStockByNo(int storageNo);
	void insertStock(StorageStock storageStock);
	int getStockAmountByStorageNoAndProductNo(StorageStock storageStock);
	void updateStockAmountByStorageNoAndProductNo(StorageStock storageStock);
	
}

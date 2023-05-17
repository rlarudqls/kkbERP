package com.kkbERP.erp.service;

import java.util.List;

import com.kkbERP.erp.dto.StoreManagementDto;
import com.kkbERP.erp.vo.Store;

public interface StoreManagementService {

	List<Store> getAllStores();
	Store getStoreByNo(int storeNo);
	void updateStore(Store store);
	void updateStoreManager(Store store);
	StoreManagementDto getStoreDetailByNo(int storeNo);
	List<StoreManagementDto> getAllStoreDetails();
}

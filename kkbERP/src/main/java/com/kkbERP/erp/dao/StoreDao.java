package com.kkbERP.erp.dao;

import java.util.List;

import com.kkbERP.erp.dto.StoreFindDto;
import com.kkbERP.erp.dto.StoreManagementDto;
import com.kkbERP.erp.vo.Store;

public interface StoreDao {
	List<StoreFindDto> getStoreFinds(String keyword);
	List<Store> getAllStores();
	Store getStoreByNo(int storeNo);
	void updateStore(Store store);
	StoreManagementDto getStoreDetailByNo(int storeNo);
	List<StoreManagementDto> getAllStoreDetails();
}

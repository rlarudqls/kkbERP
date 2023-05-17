package com.kkbERP.erp.dao;

import java.util.List;
import java.util.Map;

import com.kkbERP.erp.dto.ProductStockDto;
import com.kkbERP.erp.dto.StoreStockDto;
import com.kkbERP.erp.vo.StoreStock;

public interface StoreStockDao {

	List<StoreStockDto> getStoreStockDetailsByStoreNo(int storeNo);
	List<ProductStockDto> getProductStockDetailsByProductNo(int productNo);
	StoreStockDto getStoreStockDetail(Map<String, Object> criteria);
	int getStockAmountByStoreNoAndProductNo(StoreStock storeStock);
	void updateStockAmountByStoreNoAndProductNo(StoreStock storeStock);
	void insertStock(StoreStock storeStock);
	
}
package com.kkbERP.erp.service;

import java.util.List;
import java.util.Map;

import com.kkbERP.erp.dto.ProductStockDto;
import com.kkbERP.erp.dto.StoreStockDto;

public interface StockService {

	List<StoreStockDto> getStoreStockDetailsByStoreNo(int storeNo);
	List<ProductStockDto> getProductStockDetailsByProductNo(int productNo);
	StoreStockDto getStoreStockDetail(Map<String, Object> criteria);
}

package com.kkbERP.erp.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kkbERP.erp.dao.StoreStockDao;
import com.kkbERP.erp.dto.ProductStockDto;
import com.kkbERP.erp.dto.StoreStockDto;

@Service
public class StockServiceImpl implements StockService{

	@Autowired
	private StoreStockDao storeStockDao;
	
	@Override
	public List<StoreStockDto> getStoreStockDetailsByStoreNo(int storeNo) {
		return storeStockDao.getStoreStockDetailsByStoreNo(storeNo);
	}

	@Override
	public List<ProductStockDto> getProductStockDetailsByProductNo(int productNo) {
		return storeStockDao.getProductStockDetailsByProductNo(productNo);
	}

	@Override
	public StoreStockDto getStoreStockDetail(Map<String, Object> criteria) {
		return storeStockDao.getStoreStockDetail(criteria);
		 
	}
	
}

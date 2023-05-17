package com.kkbERP.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kkbERP.erp.dao.StoreDao;
import com.kkbERP.erp.dto.StoreFindDto;

@Service
public class StoreServiceImpl implements StoreService{

	@Autowired
	private StoreDao storeDao;
	
	@Override
	public List<StoreFindDto> getStoreFinds(String keyword) {
		return storeDao.getStoreFinds(keyword);
	}

}

package com.kkbERP.erp.service;

import java.util.List;

import com.kkbERP.erp.dto.StoreFindDto;

public interface StoreService {

	List<StoreFindDto> getStoreFinds(String keyword);
}

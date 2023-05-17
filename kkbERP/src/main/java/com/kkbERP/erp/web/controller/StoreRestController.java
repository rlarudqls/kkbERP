package com.kkbERP.erp.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kkbERP.erp.dto.StoreFindDto;
import com.kkbERP.erp.service.StoreService;

@RestController
public class StoreRestController {

	@Autowired
	StoreService storeService;
	
	@RequestMapping("/restStore")
	public List<StoreFindDto> restStore(String keyword) {
		
		System.out.println(keyword);
		return storeService.getStoreFinds(keyword);
	}

}
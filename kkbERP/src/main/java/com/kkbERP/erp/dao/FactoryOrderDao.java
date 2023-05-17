package com.kkbERP.erp.dao;

import java.util.List;

import com.kkbERP.erp.dto.FactoryOrderItemDto;
import com.kkbERP.erp.form.FactoryOrderAddForm;
import com.kkbERP.erp.vo.FactoryOrder;
import com.kkbERP.erp.vo.FactoryOrderItem;

public interface FactoryOrderDao {

	void insertOrder(FactoryOrderAddForm orderForm);
	void insertOrderItem(FactoryOrderItem orderItem);
	List<FactoryOrderItemDto> getFactoryOrderItemsByOrderNo(int factoryOrderNo);
	void signFactoryOrder(int orderNo);
	FactoryOrder getFactoryOrderByNo(int factoryOrderNo);
}

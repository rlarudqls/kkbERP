package com.kkbERP.erp.service;

import java.util.List;

import com.kkbERP.erp.dto.OrderProductDto;
import com.kkbERP.erp.form.OrderRegisterForm;
import com.kkbERP.erp.vo.Order;

public interface OrderService {

	List<Order> getOrderByNo(int orderNo);
	void updateOrder(Order order);
	void deleteProduct(int orderNo);
	void insertOrder(OrderRegisterForm orderRegisterForm);
	OrderProductDto getAllOrderProduct(int orderProductNo);
}

package com.kkbERP.erp.dao;

import java.util.List;

import com.kkbERP.erp.dto.OrderItemDto;
import com.kkbERP.erp.dto.OrderProductDto;
import com.kkbERP.erp.form.OrderRegisterForm;
import com.kkbERP.erp.vo.Order;
import com.kkbERP.erp.vo.OrderItem;

public interface OrderDao {

	void insertOrder(OrderRegisterForm orderRegisertForm);
	void insertOrderItem(OrderItem orderItem);
	List<Order> getOrderByNo(int orderNo);
	void updateOrder(Order order);
	void deleteOrder(int orderNo);
	OrderProductDto getAllOrderProduct();
	void signOrder(int orderNo);
	List<OrderItem> getOrderItemsByOrderNo(int orderNo);
	List<OrderItemDto> getOrderItemDetailsByOrderNo(int orderNo);
	Order getOrderByOrderNo(int orderNo);
	//List<Order> searchOrders(); 발주내역 조회    매장? - 발주내역 확인?
	
}

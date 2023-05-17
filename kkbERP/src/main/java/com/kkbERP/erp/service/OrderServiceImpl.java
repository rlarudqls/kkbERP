package com.kkbERP.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kkbERP.erp.dao.EmployeeDao;
import com.kkbERP.erp.dao.OrderDao;
import com.kkbERP.erp.dao.ProductApprovalDao;
import com.kkbERP.erp.dto.OrderProductDto;
import com.kkbERP.erp.form.OrderRegisterForm;
import com.kkbERP.erp.vo.Employee;
import com.kkbERP.erp.vo.Order;
import com.kkbERP.erp.vo.OrderItem;
import com.kkbERP.erp.vo.ProductApproval;

@Service
public class OrderServiceImpl implements OrderService{

	@Autowired
	private OrderDao orderDao;
	
	@Autowired
	private EmployeeDao employeeDao;
	
	@Autowired
	private ProductApprovalDao approvalDao;
	
	@Override
	public List<Order> getOrderByNo(int orderNo) {
		List<Order> orders = orderDao.getOrderByNo(orderNo);
		return orders;
	}

	@Override
	public void updateOrder(Order order) {
		orderDao.updateOrder(order);
	}

	@Override
	public void deleteProduct(int orderNo) {
		orderDao.deleteOrder(orderNo);
	}
	
	@Override
	public OrderProductDto getAllOrderProduct(int orderProductNo) {
		return orderDao.getAllOrderProduct();
	}

	@Override
	public void insertOrder(OrderRegisterForm orderRegisterForm) {
		orderDao.insertOrder(orderRegisterForm);
		System.out.println(orderRegisterForm.getNo());
		
		OrderItem orderItem = new OrderItem();
		int[] productNos = orderRegisterForm.getProductNos();
		int[] amounts = orderRegisterForm.getAmounts();
		
		orderItem.setOrderNo(orderRegisterForm.getNo());
		for(int i=0; i<productNos.length; i++) {
			int productNo = productNos[i];
			int amount = amounts[i];
			orderItem.setProductNo(productNo); 
			orderItem.setAmount(amount);
		 
			orderDao.insertOrderItem(orderItem); 
		}
		
		 ProductApproval approval = new ProductApproval();
		 approval.setTypeNo(10);
		 approval.setRequesterNo(orderRegisterForm.getEmployeeNo());
		 Employee emp = employeeDao.getEmployeeByNo(orderRegisterForm.getEmployeeNo());		 
		 approval.setResponserNo(emp.getManagerNo());
		 approval.setOrderNo(orderRegisterForm.getNo());
		 approvalDao.insertOrderApproval(approval);
	}
}

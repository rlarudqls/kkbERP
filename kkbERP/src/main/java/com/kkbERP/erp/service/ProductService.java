package com.kkbERP.erp.service;

import java.util.List;
import java.util.Map;

import com.kkbERP.erp.dto.ProductDto;
import com.kkbERP.erp.vo.Product;

public interface ProductService {

	boolean insertProduct(Product product);
	List<Product> getProductsByCategoryNo(int categoryNo);
	Product getProductByNo(int productNo);
	void updateProduct(Product product);
	void deleteProduct(int productNo);
	Map<String, Object> searchProducts(Map<String, Object> criteria);
	ProductDto getProductDetailByProductNo(int productNo);
}

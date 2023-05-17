package com.kkbERP.erp.dao;

import java.util.List;
import java.util.Map;

import com.kkbERP.erp.dto.ProductDto;
import com.kkbERP.erp.vo.Product;

public interface ProductDao {

	Product getProductByName(String productName);
	void insertNewProduct(Product product);
	List<Product> getProductsByCategoryNo(int categoryNo);
	Product getProductByNo(int productNo);
	void updateProduct(Product product);
	void deleteProduct(int productNo);
	List<ProductDto> searchProducts(Map<String, Object> criteria);
	ProductDto getProductDetailByProductNo(int productNo);
	List<Product> getCategoiesByProductsNo(int productNo);
	int getSearchedProductsCount(Map<String, Object> criteria);
}

package com.kkbERP.erp.service;

import java.util.List;

import com.kkbERP.erp.vo.Category;

public interface CategoryService {

	List<Category> getAllUpperCategories();
	List<Category> getSubCategoriesByUpperCateNo(int upperCateNo);
	Category getUpperCategoryBySubcategoryNo(int categoryNo);
	List<Category> getCategoiesByProductsNo(int productNo);
}

package com.kkbERP.erp.dao;

import java.util.List;

import com.kkbERP.erp.vo.Category;

public interface CategoryDao {

	List<Category> getAllUpperCategories();
	List<Category> getSubCategoriesByUpperCateNo(int upperCateNo);
	Category getUpperCategoryBySubcategoryNo(int categoryNo);
}

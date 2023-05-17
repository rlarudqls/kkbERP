package com.kkbERP.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kkbERP.erp.dao.CategoryDao;
import com.kkbERP.erp.vo.Category;

@Service
public class CategoryServiceImpl implements CategoryService{

	@Autowired
	private CategoryDao categoryDao;

	@Override
	public List<Category> getAllUpperCategories() {
		return categoryDao.getAllUpperCategories();
	}

	@Override
	public List<Category> getSubCategoriesByUpperCateNo(int upperCateNo) {
		return categoryDao.getSubCategoriesByUpperCateNo(upperCateNo);
	}

	@Override
	public Category getUpperCategoryBySubcategoryNo(int categoryNo) {
		return categoryDao.getUpperCategoryBySubcategoryNo(categoryNo);
	}

	@Override
	public List<Category> getCategoiesByProductsNo(int productNo) {
		return getCategoiesByProductsNo(productNo);
	}
	
}

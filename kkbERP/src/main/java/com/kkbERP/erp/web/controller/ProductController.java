package com.kkbERP.erp.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kkbERP.erp.dto.ProductDto;
import com.kkbERP.erp.form.ProductRegisterForm;
import com.kkbERP.erp.service.CategoryService;
import com.kkbERP.erp.service.ProductService;
import com.kkbERP.erp.vo.Category;
import com.kkbERP.erp.vo.Product;

@Controller
@RequestMapping("/products")
public class ProductController {
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private ProductService productService;

	// 등록화면으로 이동
	@GetMapping("/register.erp")
	public String register(Model model) {
		
		List<Category> upperCategories = categoryService.getAllUpperCategories();		
		model.addAttribute("upperCategories", upperCategories);
		
		return "products/registerform";
	}
	
	// 제품관리 메인으로 이동
	@GetMapping("/main.erp")
	public String productMain() {
		
		return "products/main";
	}
	
	// 새로운 제품을 등록한다.
	@PostMapping("/register.erp")
	public String addNewProduct(ProductRegisterForm productRegisterForm) {
		
		Product product = new Product();
		BeanUtils.copyProperties(productRegisterForm, product);
		
		boolean isSeccess = productService.insertProduct(product);
		if(!isSeccess) {
			throw new RuntimeException("제품을 등록함에 있어 문제가 발생했습니다.");
		}
		
		return "redirect:/products/register.erp?result=success";
	}
	
	// 상위카테고리 번호를 전달받아 하위카테고리 리스트를 JSON으로 받는다.
	@GetMapping("/subcategory.erp")
	@ResponseBody
	public List<Category> getSubCategories(@RequestParam("uppercateno") int upperCateNo) {
		List<Category> subCategories = categoryService.getSubCategoriesByUpperCateNo(upperCateNo);
		return subCategories;	
	}
	
	// 카테고리 번호에 해당하는 제품 리스트를 JSON으로 받는다.
	@GetMapping("/categoryproducts.erp")
	@ResponseBody
	public List<Product> getproducts(@RequestParam("categoryno") int categoryNo) {
		List<Product> products = productService.getProductsByCategoryNo(categoryNo);
		return products;
	}
	
	// 수정/삭제 화면으로 이동한다.
	@GetMapping("/modify.erp")
	public String modify(Model model) {
		List<Category> upperCategories = categoryService.getAllUpperCategories();		
		model.addAttribute("upperCategories", upperCategories);
		return "products/modifyform";
	}
	
	
	// 제품번호에 해당하는 제품 상세정보를 JSON으로 반환한다.
	@GetMapping("/productdetail.erp")
	@ResponseBody
	public ProductDto getProduct(@RequestParam("productno") int productNo) {
		ProductDto product = productService.getProductDetailByProductNo(productNo);
		
		return product;
	}
	
	// 상위카테고리 번호에 해당하는 카테고리를 JSON으로 반환한다.
	@GetMapping("/uppercategory.erp")
	@ResponseBody
	public Category getUpperCategory(@RequestParam("categoryno") int categoryNo) {
		Category category = categoryService.getUpperCategoryBySubcategoryNo(categoryNo);
		
		return category;
	}
	
	// 선택한 제품 + 변경내용으로 제품정보 수정
	@PostMapping("/modifyproduct.erp")
	public String modifyProduct(Product product) {
		Product changedProduct = new Product();
		BeanUtils.copyProperties(product, changedProduct);
		
		productService.updateProduct(changedProduct);
		
		return "redirect:/products/modify.erp?result=modifysuccess";
	}
	
	// 선택한 제품을 삭제한다.
	@PostMapping("/deleteproduct.erp")
	public String deleteProduct(Product product) {
		productService.deleteProduct(product.getNo());
		
		return "redirect:/products/modify.erp?result=deletesuccess";
	}
	
	@GetMapping("/inquiry.erp")
	public String inquiryProduct() {
		
		return "products/inquiry";
	}
	
	// 선택한 검색조건에 해당하는 제품을 검색해서 조회한다.
	@RequestMapping("/inquiryproducts.erp")
	@ResponseBody
	public Map<String, Object> inquiryProducts(@RequestParam(value = "option") String option, 
								  @RequestParam(value = "opt1", required = false) String opt1,
								  @RequestParam(value = "opt2", required = false) String opt2,
								  @RequestParam(value="pageno", required = false) Integer pageNo) {
		Map<String, Object> criteria = new HashMap<String, Object>();
		criteria.put("opt", option);
		criteria.put("opt1", opt1);
		criteria.put("opt2", opt2);
		criteria.put("pageNo", pageNo);
		
		Map<String, Object> pagedProducts = productService.searchProducts(criteria);
		
		return pagedProducts;
	}
	
	// 선택한 제품명에 해당하는 제품 상세정보를 검색해서 조회한다.
	@GetMapping("/productDetail.erp")
	@ResponseBody
	public ProductDto productDetail(@RequestParam("productNo") int productNo) {
		ProductDto product =productService.getProductDetailByProductNo(productNo);
		return product;
	}
	
	@RequestMapping("/approval.erp")
	public String approvalMain() {
		
		return "products/approval";
	}
	
}

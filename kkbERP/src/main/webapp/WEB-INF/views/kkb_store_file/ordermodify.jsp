<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>발주(구매) 수정 | JHTA ERP</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	<script src="/resources/js/datepicker.js"></script>
	<style type="text/css">
		.order-new-add th {
		 	background: #f7f7f7;
		 	width: 120px;
		 	height: 45px;
		}
		.order-new-add td {
			width: 320px;
		}
	</style>
</head>
<body>
<%@ include file="../kkb_common_file/nav.jsp" %>
<%@ include file="storesidebar.jsp" %>
<div class="container-fluid col-sm-8" style="margin-left:250px; padding: 50px 0px;">
	<div class="page-header">
		<h1>발주(구매) 수정</h1>
	</div>
	<div class="row">
		<div class="col-sm-12" id="orderModifyVue"> 
			<div>
				<h3 style="display: inline-block; margin-top: 0px;">발주서수정</h3>
				<div class="" style="float: right; display: inline-block;">
	                <button class="btn btn-info" type="button" data-toggle="modal" data-target="#store-search" id="btn-store-modify">발주처수정</button>
	                <a href="ordermodify.erp"><button type="reset" class="btn btn-danger">전체삭제</button></a>
	                <button class="btn btn-default" id="buy_print">인쇄</button>
	                <button class="btn btn-default" id="buy_xls">엑셀</button>
	            </div>
			</div>
            <div class="order-new-add" style="margin-top: 10px;">
            	<form>
	            	<table class="table table-bordered"> 
	            		<thead>
			            	<tr>
			            		<th>발주번호</th>
			            		<td>1000001</td>
			            		<th>발주일자</th>
			            		<td><input type="date" id="input-order-form-date"></td>
			            		<th>납품예정일자</th>
			            		<td id="changeDeliveryDate"></td>
			            	</tr>
			            	<tr>
			            		<th>발주처명</th>
			            		<td>{{store.storeName}}</td>
			            		<th>발주담당자</th>
			            		<td>{{store.employeeName}}</td>
			            		<th>전화</th>
			            		<td>{{store.storeTel}}</td>
			            	</tr>
			            	<tr>
			            		<th>주소</th>
			            		<td colspan="5">{{store.storeAddress}}</td>
			            	</tr>
			            	<tr>
			            		<th>발주건수</th>
			            		<td>{{rows}}</td>
			            		<th>수량</th>
			            		<td>{{amount}}</td>
			            		<th>합계금액</th>
			            		<td>{{listTotalPrice | currency}}원</td>
			            	</tr>
	            		</thead>
	            		<tbody>
	            		</tbody> 
	            	</table>
            	</form>
            </div>
           	
           	<div class="order-add-list ">
            	<h3 style="display: inline-block; margin-top: 0px;">상품발주</h3>
				<div class="" style="float: right; display: inline-block;">
	                <button class="btn btn-success" id="order-add-list-btn">상품내역 닫기</button> 
	            </div>
	            <div style="margin-top: 5px;" id="select-add-product"> 
	            	<form id="add-form-list">
	            		<table class="table table-bordered">
	            			<thead>
	            				<tr>
					                <td>
				                    <div class="col-sm-4" id="select-sub-category">
				                    	<label> 대분류 : 
					                        <select style="margin: 3px; text-align-last: center; width: 300px" v-model="selectedUpperCategoryNo" id="select-upper-category">
					                            <option disabled selected value="0">----- 상위 카테고리 -----</option>
												<option v-bind:value="upcate.no" v-for="upcate in uppercategories">{{upcate.name}}</option>
					                        </select>
				                        </label>
				                        <label> 소분류 :
					                        <select style="margin: 3px; text-align-last: center; width: 300px" v-model="selectedLowerCategoryNo" id="select-category">
					                            <option disabled selected value="0" id="sub-default">----- 하위 카테고리 -----</option>
					                            <option v-bind:value="cate.no" v-for="cate in categories">{{cate.name}}</option>
					                        </select> 
				                        </label> 
				                        <label> 제　품 :
					                        <select style="margin: 3px; text-align-last: center; width: 300px" id="select-product">
					                            <option disabled selected id="cate-default">----- 상품 선택하기 -----</option>
					                            <option v-bind:value="product.no" v-for="product in products">{{product.name}}</option>
					                        </select>
				                        </label>
				                    </div>
				                    <div class="col-sm-4" id="form-add-order">
				                       	<label> 금액: 
				                       		<input type="text" v-bind:value="product.price | currency" name="price" style="width: 300px;"/> 
				                       	</label>
				                        <label> 재고: 
					                       	<input type="text" v-bind:value="stock.amount" style="width: 300px;" />
				                       	</label> 
				                        <label> 수량: 
					                       	<input type="number" v-model="product.amount" style="width: 300px;" id="order-product-volume"/>
				                       	</label> 
				                    </div> 
				                    <div class="col-sm-4">
				                        <label> 합계 금액: 
				                       		<input type="text" v-bind:value="product.amount * product.price || 0 | currency" class=""/> 
				                       	</label> 
				                    </div>
				                    <div>
				                       	<div style="float: right; margin-top: 30px; margin-right: 10px;">
						                    <button type="button" id="btn-productList-add">추가</button>
						                    <button type="button">취소</button>  
				                       	</div> 
				                    </div>
					                </td>
					          	</tr> 
						    </thead>
						</table>
		            </form>
            	</div>
            </div>
            <form id="order-product-modify-form" method="post" action="ordermodify.erp">
	           	<div class="order-list-sheet" id="order-product-add-list" style="height: 248px; overflow: scroll;">
		            <table class="table category-sheet" id="product-add-sheet-list">
		                <thead>
			                <tr>
			                    <th>
			                    	<input type="checkbox" id="checkbox-productALL" class="product-checkbox" style="margin-left: 15px;" />
			                    	<label class="" hidden=""></label>
			                    </th>
			                    <th>대분류</th>
			                    <th>소분류</th>
			                    <th>제품명</th>
			                    <th>수량</th>
			                    <th>금액</th>
			                    <th>합계</th>
			                    <th>기타</th>  
			                </tr>
		                </thead>
		                <tbody>  
							<tr v-for="(product, index) in products">
								<td><input type='checkbox' style='margin-left: 15px'/></td>
								<td>{{product.upperCategoryName}}</td>
								<td>{{product.lowerCategoryName}}</td>
								<td><input type="hidden" name="productNo" v-bind:value="product.no">{{product.name}}</td>
								<td><input type="hidden" name="amount" v-bind:value="product.amount">{{product.amount}}</td>
								<td>{{product.price}}원</td>
								<td>{{product.amount * product.price}}원</td>
								<td><button id="btn-product-delete" @click="removeProduct(index)">삭제</button></td>
							</tr>
		                </tbody>
		            </table>
	                <input type="hidden" name="storeNo" v-bind:value="store.storeNo"/>
	           	</div>
           	</form>
           	<div style="float: right; display: inline-block; margin-top: 10px;">
           		<input type="button" class="btn btn-warning" value="수정" id="btn-order-modify"/>
           		<input type="reset" class="btn btn-default" value="취소" onClick="window.location.reload()">
          	</div>
           	
		</div>
	</div>
</div>

<!-- Modal -->
<div id="store-search" class="modal fade" role="dialog">
	<div class="modal-dialog modal-lg">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">발주(구매) 발주처등록</h4>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-sm-12" id="store-detail">
						<form id="" class="form-horizontal" action="" method="post" enctype="">
							<div class="form-group">
							<label class="control-label col-sm-2" for="serach-store-no">매장명</label>
								<div class="col-sm-10">
									<select id="select-stores" class="form-control">
										<option disabled selected > --지점을 선택하세요 -- </option>
										<option v-bind:value="store.storeNo" v-for="store in stores">{{store.storeName }} </option>
									</select>
								</div>	
							</div>
							<div class="form-group">
								<label class="control-label col-sm-2" for="serach-store-empNo">발주담당자</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" name="storeEmp" placeholder="ex) 김아무개" v-bind:value="store.employeeName" readonly>
								</div>
							</div> 
							<div class="form-group">
								<label class="control-label col-sm-2">전화번호</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" name="storeTel" placeholder="ex) 02-1234-5678" v-bind:value="store.storeTel" readonly>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-2">주소</label>
								<div class="col-sm-10">
									<input class="form-control" type="text" name="storeAddress" v-bind:value="store.storeAddress" readonly>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" id="btn-store-add" class="btn btn-info" data-dismiss="modal">등록</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

</body>
<script type="text/javascript">

	// 발주등록 열기/닫기 정의
	$(".order-add-list #order-add-list-btn").click(function() {
		if($(this).text()=="상품내역 닫기") {
			$(".order-add-list #add-form-list").hide();
			$(this).text("상품내역 열기");
		} else {
			$(".order-add-list #add-form-list").show();
			$(this).text("상품내역 닫기") ;
		}
	});
	
	var storeNo = 0;
	
	/* Modal에 적용하도록 정의 */
	var storeApp = new Vue({
		el:"#store-search",
		data: {
			stores:[],
			store:{}
		}
	});
	
	var vueApp = new Vue({
		el:"#orderModifyVue",
		data: {
			stores:[],
			store:{},
			uppercategories:[],
			categories:[],
			products:[],
			product:{},
			stock:{},
			selectedUpperCategoryNo:"0",
			selectedLowerCategoryNo:"0",
			rows:0,
			amount:0,
			listTotalPrice:0
		},
		methods: {
			getTotalOrderPrice: function() {
				var totalOrderPrice = 0;
				this.product.price * this.product.amount
				
				return totalOrderPrice;
			},
			getUpperCategory: function() {
				var upperCategory;
				this.uppercategories.forEach(function(item, index) {
					if (item.no == vueApp.selectedUpperCategoryNo) {
						upperCategory = item;
					}
				});
				return upperCategory;
			},
			getLowerCategory: function() {
				var lowerCategory;
				this.categories.forEach(function(item, index) {
					if (item.no == vueApp.selectedLowerCategoryNo) {
						lowerCategory = item;
					}
				});
				return lowerCategory;
			},
			removeProduct: function(index) {
				vueApp.products.splice(index, 1);
			},
			productCount: function() {
				return this.products.length;
			}
		},
		filters: {
			currency: function(value) {
				if(isNaN(value)) {
					return value;
				}
				return new Number(value).toLocaleString();
			}
		}
	});
	
	// 발주 수정 정의
	$("#btn-order-modify").on('click', function() {
		$("#order-product-modify-form").submit();
		alert("발주가 수정되었습니다.")
	});
	
	//지점 선택시 ajax로 지점 정보, 매니저 정보를 불러온다.
	$("#select-stores").change(function() {
		var no = this.value;
		storeNo = no;
		
		$.getJSON("/store/storeseachdetail.erp", {no:no}, function(result) {
			storeApp.store = result;
			vueApp.store = result;
		});
	});
	
	$("#btn-store-modify").click(function() {
		$.getJSON("/store/orderstoremodal.erp", function(result) {
			storeApp.stores = result;
		});
	});
	
	// 모달에서 발주처 등록을 하면 상품발주에 해당하는 카테고리 지정
	$("#btn-store-add").click(function() {
		vueApp.store = vueApp.store;
		$.getJSON("/store/orderCategories.erp", function(result) {
			vueApp.uppercategories = result;
		});
	});
	// 소분류 카테고리	
	$("#select-upper-category").change(function() {
		var no = this.value;
		$("#sub-default").prop("selected", true);
		vueApp.product={};
		vueApp.stock={};
		
		$.getJSON("/products/subcategory.erp", {uppercateno:no}, function(result) {
			vueApp.categories = result;
		});
	});
	// 제품 카테고리
	$("#select-category").change(function() {
		var no = this.value;
		$("cate-default").prop("selected", true);
		vueApp.product={};
		vueApp.stock={};
		
		$.getJSON("/products/categoryproducts.erp", {categoryno:no}, function(result) {
			vueApp.products = result;
		});
	});
	// 금액, 재고
	$("#select-product").change(function() {
		var no = this.value;
		var storeNo = vueApp.store.storeNo;
		vueApp.product={};
		vueApp.stock={};
		
		$.getJSON("/products/productdetail.erp", {productno:no}, function(result) {
			vueApp.product = result;
		}); 
		
		$.getJSON("/store/getstock.erp", {storeNo:storeNo, productNo:no})
			.done(function(result) {
				vueApp.stock = result;
			});
	});

	// 추가 버튼 누르면 아래에 리스트 생성하기
	$("#btn-productList-add").click(function() {
		var upperCategory = vueApp.getUpperCategory();
		vueApp.product.upperCategoryNo = upperCategory.no;
		vueApp.product.upperCategoryName = upperCategory.name;
		
		var lowerCategory = vueApp.getLowerCategory();
		vueApp.product.lowerCategoryNo = lowerCategory.no;
		vueApp.product.lowerCategoryName = lowerCategory.name;
		
		var selectedProduct = clone(vueApp.product);
		vueApp.products.push(selectedProduct);
		
		$("#add-form-list").each(function() {
			this.reset();
		})
		
		vueApp.rows = vueApp.products.length;
		
		var totalAmount = 0;	
		vueApp.products.forEach(function(item, index) {
			totalAmount += parseInt(item.amount);
		});
		orderApp.amount = totalAmount;
		
		var totalPrice = 0;	
		vueApp.products.forEach(function(item, index) {
			totalPrice += parseInt(item.price * item.amount);
		});
		vueApp.listTotalPrice = totalPrice;
	});
	
	function clone(obj) {
		if (null == obj || "object" != typeof obj) return obj;
		var copy = obj.constructor();
		for (var attr in obj) {
			if (obj.hasOwnProperty(attr)) copy[attr] = obj[attr];
		}
		return copy;
	}
	
	
</script>
</html>
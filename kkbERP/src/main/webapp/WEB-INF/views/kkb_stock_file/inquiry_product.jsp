<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title></title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.0/themes/smoothness/jquery-ui.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	<script src="/resources/js/datepicker.js"></script>
	<style type="text/css">
		.table th {
			 text-align: center;
			 background-color: #f2f2f2;
		}
		#table-products td, #tr-stocks td {
			text-align: right;
		}
		#table-products a {
			color: #5273fa;
			font-weight: bold;
			cursor: pointer;
		}
		.leftname {
			text-align: left !important;
		}
		.modal-dialog.modal-fullsize {
		  width: 80%;
		  height: 100%;
		  align-content;
		  padding: 0;
		}
		.modal-content.modal-fullsize {
		  height: auto;
		  min-height: 100%;
		  border-radius: 0; 
		}
		
	</style>
</head>
<body>
<%@ include file="../kkb_common_file/nav.jsp" %>
<%@ include file="stocksidebar.jsp" %>
<div class="container-fluid col-sm-9" style="margin-left:250px; padding: 50px 0px;">
	<div class="page-header">
		<h1>제품별 재고 조회</h1>
	</div>

	<div class="row">
		<div class="col-sm-11">
			<div id="div-search" class="pull-right" style="margin-bottom: 30px;">
				<form class="form-inline" action="inquiry.erp" method="post">
					<select class="form-control"  style="margin: 0px 30px 0px -30px;" id="select-option" name="option">
						<option selected disabled> -- 검색옵션 --</option>
						<option id="option-search-all" value="all">전체 조회</option>
						<option id="option-search-category" value="categoryname">카테고리명 검색</option>
						<option id="option-search-name" value="productname">제품명 검색</option>
						<option id="option-search-createDate" value="searchdate">출시일 검색</option>
						<option id="option-search-price" value="searchprice">가격  검색</option>
					</select>
					<input type="text" class="form-control" id="input-normal" name="opt1" readonly>
						<button type="button" class="btn btn-sm btn-info" id="btn-search"> 검색</button><br>
					<div style="margin:-10px 0px 0px 140px;" id="div-input-sub">		
						<br> ~ <input type="text" class="form-control" id="input-sub" name="opt2">
					</div>
				</form>
			</div>
			<div id="div-products">
				<table class="table table-bordered table-hover" id="table-products">
					<colgroup>
						<col width="7%">
						<col width="35%">
						<col width="18%">
						<col width="15%">
						<col width="25%">
					</colgroup>
					<thead>
						<tr>
							<th></th>
							<th>제품 명</th>
							<th>제품 가격</th>
							<th>제품 출시일</th>
							<th>제품 카테고리</th>
						</tr>
					</thead>
					<tbody>
						<tr v-for="(product, index) in products">
							<td>{{index +1}}</td>
							<td><a data-toggle="modal" data-target="#modal-product-stocks" 
							     @click="showStores(product.no)">{{product.name}}</a></td>
							<td>{{product.numberWithComma}} 원</td>
							<td>{{product.fmtDate}}</td>
							<td>{{product.categoryName}} ({{product.categoryNo}})</td>
						</tr>
					</tbody>
				</table>
				<div class="text-center pagination-box">
					<ul class="pagination pagination-lg">				
						<li v-if="page.pageNo > 1">
							<a href="#" class="glyphicon glyphicon-backward" @click="prevPage()"></a>
						</li>
						<li v-for="(page, index) in page.totalPageCount" @click="paginate(index+1)" :class="getActiveClass(index+1)"><a href="#" >{{index +1}}</a></li>
						<li v-if="page.pageNo < page.endPage">
							<a href="#" class="glyphicon glyphicon-forward" @click="nextPage()"></a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="modal-product-stocks" role="dialog">
    <div class="modal-dialog modal-fullsize">
    	<div class="modal-content">
        	<div class="modal-header">
          		<button type="button" class="close" data-dismiss="modal">&times;</button>
         			<h4 class="modal-title">재고 조회</h4>
       		</div>
       		<div class="modal-body">
	       		<table class="table table-bordered" id="table-stocks">
					<colgroup>
							<col width="35%">
							<col width="15%">
							<col width="29%">
							<col width="13%">
							<col width="8%">
						</colgroup>
					<thead>
						<tr>
							<th>지점 이름</th>
							<th>지점 전화번호</th>
							<th>제품명</th>
							<th>제품 가격</th>
							<th>재고량</th>
						</tr>
					</thead>
					<tbody>
						<tr id="tr-stocks" v-for="stock in stocks">
							<td class="leftname">{{stock.storeName}}</td>
							<td>{{stock.storeTel}}</td>
							<td>{{stock.productName}}</td>
							<td>{{stock.productPrice | currency}} 원</td>
							<td>{{stock.amount | currency}} 개</td>
						</tr>
						<tr v-if="stocks.length == 0">
								<td colspan="5" class="text-center">재고가 존재하지 않습니다.</td>
							</tr>
					</tbody>
				</table>
       		</div>
        	<div class="modal-footer">
          		<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
        	</div>
      	</div>
   	</div>
</div>

<script type="text/javascript">
	var stocksApp = new Vue({
		el: "#modal-product-stocks",
		data: {
			stocks:[]
		},
		filters: {
			currency: function(value) {
				if(isNaN(value)) {
					return value;
				}
				return new Number(value).toLocaleString();
			}
		}
	})

	var productsApp = new Vue({
		el:"#div-products",
		data: {
			products:[],
			page:{},
			currentPageNo:1
		},
		
		methods: {
			showStores: function(no) {
				$.getJSON("/stock/productStocks.erp", {no:no}, function(result) {
					stocksApp.stocks = result;
				}); 
			},
			paginate: function(pageno) {
				getProducts(pageno);
				this.currentPageNo = pageno;
				
			},
			 prevPage: function() {
				if(this.currentPageNo == 1) {
					return false;
				}
				this.currentPageNo --;
				this.paginate(this.currentPageNo);
			},
			nextPage: function() {
				this.currentPageNo ++;
				this.paginate(this.currentPageNo);
			}, 
			getActiveClass: function(pageno) {
				return pageno == this.currentPageNo ? 'active' : '';
			}
		}
		
	}); 
	
	// 검색 옵션 셀렉트박스 변경시 수행
	$("#select-option").change(function() {
		var selected = $(this).val();
		if(selected == "searchprice") {
			$("#div-input-sub").prop("hidden", false);
			$("#input-normal").prop("disabled", false);
			numberOnly(event);
			removeDatePicker();
	
		}else if(selected == "searchdate") {
			$("#div-input-sub").prop("hidden", false);
			$("#input-normal").prop("disabled", false);
			$("#input-normal").val("시작일을 선택하세요").prop("readonly", true);
			datepicker.init("#input-normal");
			$("#input-sub").val("종료일을 선택하세요").prop("readonly", true);
			datepicker.init("#input-sub");
		}else if(selected == "all") {
			$("#input-normal").val("1").prop("disabled", true);
			hiddenPriceBox();
			removeDatePicker();
		}else {
			$("#input-normal").prop("disabled", false);
			hiddenPriceBox();
			removeDatePicker();
			inputAll(event);
		}
	});
	
	// 해당없는 셀렉트 박스일 시, 가격 입력폼을 숨긴다.
	function hiddenPriceBox() {
		$("#div-input-sub").prop("hidden", true );
	};
	
	// 해당없는 셀렉트 박스일 시, 날짜 입력형식을 제거한다.
	function removeDatePicker() {
		$("#input-normal").val("").prop("readonly", false).datepicker("destroy");
		$("#input-sub").val("").prop("readonly", false).datepicker("destroy");	
	}
	
	// 검색버튼 클릭시 
	$("#btn-search").click(function() { 
		
		var selected = $("#select-option").val();
		if(selected == null) {
			alert("검색옵션을 선택하세요.");
			return false;
		}
		if("categoryname" == selected && $("#input-normal").val() == "") {
			alert("검색할 카테고리명을 입력하세요.");
			return false;
		}
		if("productname" == selected && $("#input-normal").val() == "") {
			alert("검색할 제품명을 입력하세요.");
			return false;
		}
		if("searchdate" == selected) {
			var startDate = $("#input-normal").val();
			var endDate = $("#input-sub").val();
			if(startDate == "시작일을 선택하세요" && endDate == "종료일을 선택하세요") {
				alert("시작일 또는 종료일 중 하나를 선택하세요.");
				return false;
			}
		}
		if("searchprice" == selected) {
			if($("#input-normal").val() == "" && $("#input-sub").val() == "") {
				alert("최저가격 혹은 최고가격 중 최소 하나를 입력하세요.");
				return false;
			}
		}
		
		getProducts();
	})
	
	function getProducts (pageno) {
		var option = $("#select-option").val();
		var opt1 = $("#input-normal").val();
		var opt2 = $("#input-sub").val();
		pageno = pageno || 1;
		
		$.getJSON("/products/inquiryproducts.erp", {option:option, opt1:opt1, opt2:opt2, pageno:pageno}, function(result) {
			productsApp.products = result.products;
			productsApp.page = result.pagination;
		}); 
	};
	
	// 숫자만 입력 가능하게 막기
	function numberOnly(event) {
		$("#input-normal").keypress(function(event) {
			if(event.keyCode < 48 || event.keyCode > 57) return false;
		});
		$("#input-normal").keyup(function(e) {
			if(!(e.keyCode >= 37 && e.keyCode <= 40)) {
				var value = $(this).val();
				$(this).val(value.replace(/[^a-z0-9]/gi,''));
			}
		}) 
		$("#input-sub").keypress(function(event) {
			if(event.keyCode < 48 || event.keyCode > 57) return false;
		});
		$("#input-sub").keyup(function(e) {
			if(!(e.keyCode >= 37 && e.keyCode <= 40)) {
				var value = $(this).val();
				$(this).val(value.replace(/[^a-z0-9]/gi,''));
			}
		}) 
	}
	
	function inputAll(event) {
		$("#input-normal").off("keypress");
		$("#input-normal").off("keyup");
		$("#input-sub").off("keypress");
		$("#input-sub").off("keyup");
	}
	
	hiddenPriceBox();
	
	// 화면 실행시 전체조회가 자동으로 수행되어지도록  
	$.getJSON("/products/inquiryproducts.erp", {option:"all", opt1:"", opt2:""}, function(result) {
		productsApp.products = result.products;
		productsApp.page = result.pagination;
	});
</script>
</body>
</html>
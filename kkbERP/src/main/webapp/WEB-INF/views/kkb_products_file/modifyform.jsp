<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>products</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.0/themes/smoothness/jquery-ui.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	<script src="/resources/js/datepicker.js"></script>
</head>
<body>
<%@ include file="../kkb_common_file/nav.jsp" %>
<%@ include file="productsidebar.jsp" %>
<div class="container-fluid col-sm-9" style="margin-left:250px; padding: 50px 0px;">
	<div class="page-header">
		<h1>제품 수정/삭제</h1>
	</div>
	<c:if test="${param.result eq 'modifysuccess' }">
		<div class="row">
			<div class="col-sm-12">
				<div class="alert alert-success">
					<h4>성공적으로 수정되었습니다.</h4>
				</div>
			</div>
		</div>	
	</c:if>
	<c:if test="${param.result eq 'deletesuccess' }">
			<div class="row">
				<div class="col-sm-12">
					<div class="alert alert-success">
						<h4>성공적으로 삭제되었습니다.</h4>
					</div>
				</div>
			</div>	
		</c:if>
	
	<div class="row">
		<div class="col-sm-12">
			<form method="post" class="well" id="modify-form">
				<div class="form-group">
					<label>상위 카테고리 선택</label>
					<select id="select-upper-category" class="form-control">
							<option disabled selected>-- 상위 카테고리를 선택하세요 --</option>
						<c:forEach var="upcat" items="${upperCategories }">
							<option value="${upcat.no }" >${upcat.name }</option>
						</c:forEach>
					</select>
				</div>
				<div class="form-group">
					<label>하위 카테고리 선택</label>
					<select id="select-sub-category" class="form-control">
						<option disabled selected id="sub-default">-- 하위 카테고리를 선택하세요 --</option>
						<option v-bind:value="cate.no" v-for="cate in categories">{{cate.name}}</option>
					</select>
				</div>
				<div class="form-group">
					<label>제품 선택</label>
					<select id="select-product" class="form-control">
						<option disabled selected id="product-default">-- 제품을 선택하세요 --</option>
						<option v-bind:value="product.no" v-for="product in products">{{product.name}}</option>
					</select>
				</div><hr/>
				<label>제품 상세정보</label>
				<hr/>
				<div id="product-detail">
					<div class="form-group">
						<label>제품 명</label>
						<input type="hidden" v-bind:value="detail.no" name="no" class="form-control" >
						<input type="text" v-bind:value="detail.name" name="name" class="form-control" readonly>
					</div>
					<div class="form-group">
						<label>제품 가격</label>
						<input type="text" v-bind:value="detail.priceWithComma" name="price" class="form-control" id="input-price" readonly>
					</div>
					<div class="form-group">
						<label>제품 출시일</label>
						<input type="text" v-bind:value="detail.fmtDate" name="createDate" class="form-control" 
						id="datepicker" autocomplete="off" readonly>
					</div>
					<div class="form-group">
						<label>변경할 카테고리</label>
						<select id="sub-category-change" class="form-control" v-model="selectedCategoryNo" name="categoryNo" disabled>
							<option v-bind:value="cate.no" v-for="cate in categories" >{{cate.name}}</option>
						</select>
					</div>
				</div>
				<button type="button" class="btn btn-warning" id="btn-active-modify">수정하기</button>
				<p class="text-info" style="font-weight:bold;">수정 - 제품 선택 후 수정하기 버튼을 클릭하고, 수정할 내용을 입력한 뒤 수정 버튼을 클릭</p>
				<p class="text-danger" style="font-weight:bold;">삭제 - 제품 선택 후 삭제 버튼을 클릭</p>
			</form>
				<button class="btn btn-primary pull-right" style="margin-right: 20px;" id="btn-modify">수정</button>
				<button class="btn btn-danger pull-right" style="margin-right: 20px;" id="btn-delete"
				 data-toggle="modal" data-target="#modal-delete-check">삭제</button>
		</div>
	</div>
</div>

<div class="modal fade" id="modal-delete-check" role="dialog">
    <div class="modal-dialog modal-lg">
    	<div class="modal-content">
        	<div class="modal-header">
          		<button type="button" class="close" data-dismiss="modal">&times;</button>
          		<h4 class="modal-title">삭제 확인 페이지</h4>
        		</div>
        		<div class="modal-body">
	          		<p>제품을 삭제하시려면 아래 문구를 입력하세요.</p>
	          		<p><strong class="text-danger"> 삭제합니다</strong></p>
		    		<input type="text" id="deletecheck">
		    		<button class="btn btn-sm" id="btn-check-word">확인</button>
		    		<p id="p-check-result"></p>     	
        		</div>
        	<div class="modal-footer">
          		<button type="button" class="btn btn-danger" data-dismiss="modal" id="btn-modal-delete">삭제</button>
          		<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
        	</div>
      	</div>
   	</div>
</div>

<script type="text/javascript">
	function resetProduct() {
		$("[name=name]").val("").prop("readonly", true);
		$("[name=price]").val("").prop("readonly", true);
		$("[name=createDate]").val("").prop("readonly", true);
		$("[name=categoryNo]").val("").prop("disabled", true);
	}

	// 상위 카테고리 선택시 하위 카테고리 AJAX로 받기
	var subcateApp = new Vue({
		el:"#select-sub-category",
		data: {
			categories:[]
		}
	})
	
	$("#select-upper-category").change(function() {
		var no = this.value;
		$("#sub-default").prop("selected", true);
		$("#product-default").prop("selected", true);
		
		resetProduct();
				
		
		 $.getJSON("/products/subcategory.erp", {uppercateno:no}, function(result) {
			 subcateApp.categories = result;
			 
			 productApp.products.splice(0, productApp.products.length);
		});
		
	})
	// 하위 카테고리 선택시 해당 제품들 AJAX로 받기
	var productApp = new Vue({
		el:"#select-product",
		data: {
			products:[]
		}
	})
	
	$("#select-sub-category").change(function() {
		var no = this.value;
		$("#product-default").prop("selected", true);
		resetProduct();
		productApp.products = [];
		
		$.getJSON("/products/categoryproducts.erp", {categoryno:no}, function(result) {
			productApp.products = result;
			
		});
	})
	// 해당 제품 선택시 상세정보 AJAX로 받기
	// 변경할 하위 카테고리 리스트를 같이 AJAX로 받는다.
	var detailApp = new Vue({
		el:"#product-detail",
		data: {
			selectedCategoryNo: "",
			detail:{},
			categories:[]
		}
	})
	
	$("#select-product").change(function() {
		var no = this.value;
		
		resetProduct();
		
		$.getJSON("/products/productdetail.erp", {productno:no}, function(result) {
			detailApp.detail = result;
			var categoryNo = result.categoryNo;
			detailApp.selectedCategoryNo = categoryNo;
			
			$.getJSON("/products/uppercategory.erp", {categoryno:categoryNo}, function(result) {
				console.log(result);
				var upperCategoryNo = result.no;
				
				$.getJSON("/products/subcategory.erp", {uppercateno:upperCategoryNo}, function(result) {
					detailApp.categories = result;
					
				}); 
				
			})
			
		});
	})
	
	// 수정할 inputbox 활성화
	$("#btn-active-modify").click(function() {
		if($("[name=name]").val() == "") {
			alert("수정할 제품을 선택하세요.");
			return false;
		}
		$("[name=name]").prop("readonly", false);
		$("[name=price]").prop("readonly", false);
		$("[name=createDate]").prop("readonly", false);
		$("[name=categoryNo]").prop("disabled", false);
	})
	
	// 수정 버튼 클릭시 수행
	$("#btn-modify").click(function() {
		if($("[name=name]").prop("readonly") == true) {
			alert("수정 사항이 없습니다.");
			return false;
		}
		if($("[name=name]").val() == "") {
			alert("변경할 이름을 입력하세요");
			return false;
		}
		if($("[name=price]").val() == "") {
			alert("변경할 가격을 입력하세요.");
			return false;
		}
		if($("[name=createDate]").val() == "") {
			alert("변경할 날짜를 입력하세요.");
			return false;
		}
		
		var price = $("[name=price]").val();
		price = price.replace(/,/g, '');
		$("[name=price]").val(price);
		
		
		$("#modify-form").attr("action", "modifyproduct.erp").submit();
	}) 
	
	// 폼 하단의 삭제버튼 클릭시 실행
	$("#btn-delete").click(function() {
		if($("[name=name]").val() == "") {
			alert("삭제할 제품을 선택하세요");
			return false;
		}
	}); 
	
	// 모달 내부의 확인 버튼 클릭시
	$("#btn-check-word").click(function() {
		var checkContent = $("#deletecheck").val();
		var correctContent = "삭제합니다";
		if(correctContent != checkContent) {
			$("#p-check-result").css("color", "red").text("정확히 입력하세요.");
			return false;
		}
		$("#p-check-result").css("color", "green").text("확인되었습니다.");
		$("#deletecheck").prop("disabled", true);
		$("#btn-check-word").prop("disabled", true);
		$("#btn-modal-delete").prop("disabled", false);
	});
	
	// 모달 내부의 최종 삭제버튼 클릭시 실행
	$("#btn-modal-delete").click(function() {
		var price = $("[name=price]").val();
		price = price.replace(/,/g, '');
		$("[name=price]").val(price);
		
		$("#modify-form").attr("action", "deleteproduct.erp").submit();
	}); 
	
	// 모달이 열릴 때 값을 초기화 시키기
	$(".modal").on("hidden.bs.modal", function(e) {
		$("#deletecheck").val("");
		$("#deletecheck").prop("disabled", false);
		$("#btn-check-word").prop("disabled", false);
		$("#btn-modal-delete").prop("disabled", true);
		$("#p-check-result").css("color", "black").text("");
	})
	
	// 날짜 선택에 사용되는 jquery-ui의 datepicker
	datepicker.init('#datepicker');
	
	function numberOnly(event) {
		$("#input-price").keypress(function(event) {
			if(event.keyCode < 48 || event.keyCode > 57) return false;
		});
		
		$("#input-price").keyup(function(e) {
			if(!(e.keyCode >= 37 && e.keyCode <= 40)) {
				var value = $(this).val();
				$(this).val(value.replace(/[^a-z0-9]/gi,''));
			}
		})  
	}
	numberOnly(event);
	
</script>
</body>
</html>
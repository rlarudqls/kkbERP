<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>product</title>
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
		<h1>제품 등록</h1>
	</div>
	<c:if test="${param.result eq 'success' }">
		<div class="row">
			<div class="col-sm-12">
				<div class="alert alert-success">
					<h4>성공적으로 등록되었습니다.</h4>
				</div>
			</div>
		</div>	
	</c:if>
	
	<div class="row">
		<div class="col-sm-12">
			<form action="register.erp" method="post" class="well" id="register-form">
				<div class="form-group">
					<label>상위 카테고리</label>
					<select id="select-upper-category" name="uppercategory" class="form-control">
							<option disabled selected>-- 상위 카테고리를 선택하세요 --</option>
						<c:forEach var="upcat" items="${upperCategories }">
							<option value="${upcat.no }" >${upcat.name }</option>
						</c:forEach>
					</select>
				</div>
				<div class="form-group">
					<label>하위 카테고리</label>
					<select id="select-sub-category" name="categoryNo" class="form-control">
						<option disabled selected id="sub-default">-- 하위 카테고리를 선택하세요 --</option>
						<option v-bind:value="cate.no" v-for="cate in categories">{{cate.name}}</option>
					</select>
				</div>
				<div class="form-group">
					<label>제품명</label>
					<input type="text" class="form-control" name="name" class="form-control">
				</div>
				<div class="form-group">
					<label>제품 가격</label>
					<input type="number" class="form-control" name="price" class="form-control">
				</div>
				<div class="form-group">
					<label>제품 출시일</label>
					<input type="text" class="form-control" name="createDate" id="datepicker" class="form-control" 
					autocomplete="off" readonly>
				</div>
				<div class="text-right">
					<button type="button" class="btn btn-primary" id="btn-register" disabled>등록하기</button>				
				</div>
			</form>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-sm-12">
		<a><button>실험용</button></a>
	</div>
</div>

<script type="text/javascript">
	/* $("#select-upper-category").change(function() {
		var no = this.value;
		var $subcate = $("#select-sub-category").empty();
		
		var row = "<option disabled selected>-- 하위 카테고리를 선택하세요 --</option>";
		$subcate.append(row);
		
		 $.getJSON("/products/subcategory.erp", {uppercateno:no}, function(result) {
			$.each(result, function(index, item) {
				
				var option = "";
				option +="<option value='"+item.no+"' >";
				option += item.name ;
				option += "</option>";
				
				$subcate.append(option); 
			}) 
			
		});
		
	}); */
	
	// 상위 카테고리 선택시 하위 카테고리 AJAX로 받기
	var app = new Vue({
		el:"#select-sub-category",
		data: {
			categories:[]
		}
	})
	
	$("#select-upper-category").change(function() {
		var no = this.value;
		$("#sub-default").prop("selected", true);
		
		$.getJSON("/products/subcategory.erp", {uppercateno:no}, function(result) {
			app.categories = result;
		});
		 $("#btn-register").prop("disabled", true);
	})
	
	// 하위카테고리까지 선택했을 때, 등록버튼 활성화
	$("#select-sub-category").change(function() {
		$("#btn-register").prop("disabled", false);
	});
	
	// 값이 비어있을 때, 등록버튼 누를시 제한걸기
	$("#btn-register").click(function(event) {
		if($("[name=name]").val() == "") {
			alert("제품 명을 입력하세요.");
			return false;
		}
		if($("[name=price]").val() == "") {
			alert("제품 가격을 입력하세요.");
			return false;
		}
		
		var date = $("[name=createDate]").val();
		var datatimeRegexp = /[0-9]{4}-[0-9]{2}-[0-9]{2}/;
		if(date == "") {
			alert("제품 출시일을 선택하세요.");
			return false;
		}
		if(!datatimeRegexp.test(date)) {
			alert("날짜는 yyyy-MM-dd 형식으로 입력해야 합니다.");
			return false;
		}
		
		$("#register-form").submit();
	});
	
	datepicker.init('#datepicker');
	
</script>
</body>
</html>
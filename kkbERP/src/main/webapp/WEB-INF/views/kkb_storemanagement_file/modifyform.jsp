<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title></title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
</head>
<body>
<%@ include file="../kkb_common_file/nav.jsp" %>
<%@ include file="smsidebar.jsp" %>
<div class="container-fluid col-sm-9" style="margin-left:250px; padding: 50px 0px;">
	<div class="page-header">
		<h1>지점 정보 수정</h1>
	</div>
	
	<c:if test="${param.result eq 'success' }">
		<div class="row">
			<div class="col-sm-12">
				<div class="alert alert-success">
					<h4>성공적으로 수정되었습니다.</h4>
				</div>
			</div>
		</div>	
	</c:if>
	
	<div class="row">
		<div class="col-sm-12">
			<select id="select-stores" class="form-control">
				<option disabled selected> --지점을 선택하세요 -- </option>
				<c:forEach var="store" items="${stores }">
					<option value="${store.no }" >${store.name }</option>
				</c:forEach>
			</select>
		</div>
	</div>
	<hr/>
	
	<div class="row">
		<div class="col-sm-12">
			<div class="form-group" id="div-modify-store">
				<form action="modify.erp" method="post" class="well" id="form-modify-store">
					<input type="text" name="no" class="hidden" v-bind:value="store.no">
					<div class="form-group">
						<label>지점명 수정</label>
						<input type="text" name="name" class="form-control" v-bind:value="store.name">
					</div>
					<div class="form-group">
						<label>매장주소 수정</label>
						<input type="text" name="address" class="form-control" v-bind:value="store.address">
					</div>
					<div class="form-group">
						<label>매장 연락처 수정</label>
						<input type="text" name="tel" class="form-control" v-bind:value="store.tel">
					</div>
					<div class="text-right">
						<button class="btn btn-primary">수정</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	// input 박스들을 처음에 readonly로 선언
	$("#div-modify-store input").prop("readonly", true);
	
	// 지점을 선택하면 해당 지점의 상세정보가 ajax로 반환되는 뷰 설정
	var storesApp = new Vue({
		el:"#div-modify-store",
		data: {
			store:{}
		}
	});
	
	$("#select-stores").change(function() {
		var no = $(this).val();
		$("#div-modify-store input").prop("readonly", false);
		
		$.getJSON("/storemanagement/storedetail.erp", {no:no}, function(result) {
			storesApp.store = result;
		})
	})
</script>
</body>
</html>
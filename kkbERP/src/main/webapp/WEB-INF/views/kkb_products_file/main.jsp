<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>product</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

</head>
<body>
<%@ include file="../kkb_common_file/nav.jsp" %>
<%@ include file="productsidebar.jsp" %>
<div class="container-fluid col-sm-9" style="margin-left:250px; padding: 50px 0px;">
	<div class="page-header">
		<h1>제품관리 메인화면</h1>	
	</div>
	
	<div class="row">
		<div class="col-sm-6">
			<img src="../resources/images/logo/productmain.jpg" class="img-rounded" style="width: 100%">
		</div>
		<div class="col-sm-5" style="margin-left:40px;">
			<div class="row">
				<div class="col-md-11" style="font-weight: bold">
					<div class="panel panel-default">
						<div class="panel-heading"> ERP 프로그램 사용자</div>
						<div class="media">
							<div class="media-left">
								<img class="media-object" style="width:110px; height:160px; margin: 0 10px 15px 15px;" src="../resources/images/employee/${LE.imageName }">
							</div>
							<div class="media-body">
								<p class="media-heading">[${LE_detail.no }] ${LE_detail.departmentName }-${LE_detail.name }</p>
								<p>${LE_detail.gradeName }</p>
								<p>${LE_detail.email }</p>
								<p>${LE_detail.tel }</p>
								<div class="btn-group">
									<button type="button">보낸메세지</button>
									<button type="button">받은메세지</button>									
									<button type="button">직원검색</button>
								</div>
							</div>
						</div>
					</div>
					<div class="panel panel-default" style="margin-top: -5px;">
						<div class="panel-heading">바로가기 메뉴</div>
						<div class="panel-body">
							<a href="inquiry.erp" class="w3-bar-item w3-button w3-right-align">제품 조회</a>
							<a href="register.erp" class="w3-bar-item w3-button w3-right-align">제품 등록</a>
							<a href="modify.erp" class="w3-bar-item w3-button w3-right-align">제품 수정/삭제</a>
							<a href="approval.erp" class="w3-bar-item w3-button">결재 처리</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
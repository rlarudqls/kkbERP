<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>발주내역 | JHTA ERP</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<style type="text/css">
		th {
		 	background: #f7f7f7;
		 	width: 160px;
		 	height: 45px;
		}
		.orderList th {
			text-align: center; 
		}
		.orderList td {
			text-align: center; 
		} 
		
	</style>
</head>
<body>
<%@ include file="../kkb_common_file/nav.jsp" %>
<%@ include file="storesidebar.jsp" %>
<div class="container-fluid col-sm-8" style="margin-left:250px; padding: 50px 0px;">
	<div class="page-header">
		<h1>발주내역</h1>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<div>
				<h3 style="display: inline-block; margin-top: 0px;">상세내역</h3>
				<div class="" style="float: right; display: inline-block;">
	                <button class="btn btn-success">결제하기</button>
	                <button class="btn btn-default" id="orderhistory_print">인쇄</button>
	                <button class="btn btn-default" id="orderhistory_xls">엑셀</button>
	            </div>
			</div>
            <div class="" style="margin-top: 10px;">
            	<form id="">
	            	<table class="table table-bordered">
	            		<thead>
			            	<tr>
			            		<th>발주번호</th>
			            		<td>1000001</td>
			            		<th>발주일자</th>
			            		<td>2020-02-27</td>
			            		<th>납품예정일자</th>
			            		<td>2020-02-29</td>
			            	</tr>
			            	<tr>
			            		<th>발주처명</th>
			            		<td>[삼성 디지털프라자] 논현SVC점</td>
			            		<th>발주담당자</th>
			            		<td>이준수</td>
			            		<th>전화</th>
			            		<td>02-3446-9313</td>
			            	</tr>
			            	<tr> 
			            		<th>주소</th>
			            		<td colspan="5">서울 강남구 강남대로 556</td>
			            	</tr>
			            	<tr>
			            		<th>발주건수</th>
			            		<td>2건</td>
			            		<th>발주수량</th>
			            		<td>3개</td>
			            		<th>합계금액</th>
			            		<td>2,995,000원</td>
			            	</tr>
			            	<tr>
			            		<th>발주진행현황</th>
			            		<td colspan="5">
			            			<div>
			            				<a class="step-prearrange" id="order_save_call" style="cursor:pointer;">신청 완료</a>
			            			</div>
			            		</td>
			            	</tr>
	            		</thead>
	            		<tbody>
	            		
	            		</tbody>
	            	</table>
            	</form>
            </div>
            <div class="order-history-list ">
            	<h3 style="display: inline-block; margin-top: 0px;">발주내역</h3>
				<div class="" style="float: right; display: inline-block;">
	                <button class="btn btn-success" id="order-history-list-btn">발주내역 닫기</button>
	            </div>
	            <div class="" style="margin-top: 5px;"> 
	            	<form id="">
	            		<table class="table table-bordered">
	            			<thead>
	            				<tr>
					                <th style="vertical-align: middle;" >발주내역검색</th>
					                <td>
					                    <div class="" id="">
					                        <select id="order_date" style="width: 100px;">
					                            <option value="1" selected="">주문일자</option>
					                            <option value="2">납품일자</option>
					                        </select>
						                    <button onclick="" style="margin-left: 10px;">3개월</button>
											<button onclick="">1개월</button>
											<button onclick="">1주일</button>
											<button onclick="">당일</button>
											<input type="date" id="" name="" value="" class="" style="margin-left: 20px;"> ~ <input type="date" id="" name="" size="" value="" class=" ">
											<a href="" class="btn btn-default" id="">검색</a>
					                    </div>
					                </td>
					          	</tr> 
						    </thead>
						</table>
		            </form>
		            <div class="orderList" id="sub-order-list">
		            	<form class="order-list-sheet">
						    <table class="">
						    	<colgroup>
						    		<col style="width: 170px;">
						    		<col style="width: 170px;">
						    		<col style="width: 170px;">
						    		<col style="width: 170px;">
						    		<col style="width: 170px;">
						    		<col style="width: 170px;">
						    	</colgroup>
						    	<thead>
							    	<tr>
							    		<th scope="col">발주번호</th> 
							    		<th scope="col">발주일자</th>
							    		<th scope="col">발주진행현황</th> 
							    		<th scope="col">납품예정일자</th>
							    		<th scope="col">발주건수</th>
							    		<th scope="col">전화</th>
							    		<th scope="col">비고</th>
							    	</tr>
							    </thead>
							    <tbody>
							    	<tr>
							    		<td>1000001</td>
							    		<td>2020-02-26</td>
							    		<td>신청완료</td>
							    		<td>2020-02-28</td>
							    		<td>4건</td>
							    		<td>02-3446-9313</td>
							    		<td></td>
							    	</tr>
							    	<tr>
							    		<td>1001011</td>
							    		<td>2020-02-25</td>
							    		<td>배송중</td>
							    		<td>2020-02-27</td>
							    		<td>6건</td>
							    		<td>02-3446-9313</td>
							    		<td></td>
							    	</tr> 
							    	<tr>
							    		<td>1001021</td>
							    		<td>2020-02-23</td>
							    		<td>배송완료</td>
							    		<td>2020-02-25</td>
							    		<td>2건</td>
							    		<td>02-3446-9313</td>
							    		<td></td>
							    	</tr> 
							    </tbody>
						    </table>
					    </form>
		            </div>
            	</div>
            </div>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
	// 발주내역 열기/닫기 정의
	$(".order-history-list #order-history-list-btn").click(function() {
		if($(this).text()=='발주내역 닫기') {
			$(".order-history-list .orderList .order-list-sheet").hide();
			$(this).text("발주내역 열기");
		} else {
			$(".order-history-list .orderList .order-list-sheet").show();
			$(this).text("발주내역 닫기") ;
		}
	});
	 
	$(".order-list-sheet").show();
	
</script>
</html>
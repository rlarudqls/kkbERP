<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>재고내역 | JHTA ERP</title>
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
		.stockList th {
			text-align: center; 
		}
		.stockList td {
			height: 35px;
			
			text-align: center; 
		} 
		
	</style>
</head>
<body>
<%@ include file="../kkb_common_file/nav.jsp" %>
<%@ include file="storesidebar.jsp" %>
<div class="container-fluid col-sm-8" style="margin-left:250px; padding: 50px 0px;">
	<div class="page-header">
		<h1>재고내역</h1>
	</div>
		
	<div class="row">
		<div class="col-sm-12">
            <div class="stock-information-list"> 
            	<h3 style="display: inline-block; margin-top: 0px;">재고내역</h3>
				<div class="" style="float: right; display: inline-block;">
	                <button class="btn btn-success" id="stock-information-list-btn">검색내역 닫기</button>
	                <button class="btn btn-default" id="stockinformation_print">인쇄</button>
	                <button class="btn btn-default" id="stockinformation_xls">엑셀</button>
	            </div>
	            <div class="" style="margin-top: 5px;"> 
	            	<form id="">
	            		<table class="table table-bordered">
	            			<thead>
	            				<tr>
					                <th style="vertical-align: middle;" >내역검색</th>
					                <td>
					                    <div class="" id="">
					                        <select id="stock_date" style="width: 100px;">
					                            <option value="1" selected="">일자</option>
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
		            <div class="stockList" id="sub-stock-list">
		            	<form class="stock-list-sheet">
						    <table class="">
						    	<colgroup>
						    		<col style="width: 170px;">
						    		<col style="width: 170px;">
						    		<col style="width: 170px;">
						    		<col style="width: 170px;">
						    		<col style="width: 170px;">
						    		<col style="width: 170px;">
						    		<col style="width: 170px;">
						    		<col style="width: 170px;">
						    		<col style="width: 170px;">
						    		<col style="width: 170px;">
						    		<col style="width: 170px;">
						    		<col style="width: 170px;">
						    	</colgroup>
						    	<thead> 
							    	<tr>
							    		<th scope="col">번호</th> 
							    		<th scope="col">일자</th> 
							    		<th scope="col">분류</th>
							    		<th scope="col">상품명</th>
							    		<th scope="col">재고수량</th>
							    		<th scope="col">발주수량</th>
							    		<th scope="col">입고수량</th>
							    		<th scope="col">판매수량</th>
							    		<th scope="col">반품수량</th>
							    		<th scope="col">폐기수량</th>
							    		<th scope="col">총 수량</th>
							    		<th scope="col">비고</th>
							    	</tr>
							    </thead>
							    <tbody>
							    	<tr>
							    		<td>1</td>
							    		<td>2020-01-01</td>
							    		<td>가전제품</td>
							    		<td>전자레인지</td>
							    		<td>10개</td>
							    		<td>5개</td>
							    		<td>3개</td>
							    		<td>3개</td>
							    		<td>1개</td>
							    		<td>0개</td>
							    		<td>13개</td>
							    		<td></td>
							    	</tr> 
							    	<tr>
							    		<td>2</td>
							    		<td>2020-01-13</td>
							    		<td>웨어러블</td>
							    		<td>갤럭시 Watch</td>
							    		<td>20개</td>
							    		<td>30개</td>
							    		<td>3개</td>
							    		<td>11개</td>
							    		<td>0개</td>
							    		<td>0개</td>
							    		<td>12개</td>
							    		<td></td>
							    	</tr> 
							    	<tr>
							    		<td>3</td>
							    		<td>2020-01-16</td>
							    		<td>스마트폰</td>
							    		<td>갤럭시 노트</td>
							    		<td>40개</td>
							    		<td>29개</td>
							    		<td>3개</td>
							    		<td>20개</td>
							    		<td>0개</td>
							    		<td>1개</td>
							    		<td>22개</td>
							    		<td></td>
							    	</tr> 
							    	<tr>
							    		<td>4</td>
							    		<td>2020-01-19</td>
							    		<td>주방가전</td>
							    		<td>냉장고</td>
							    		<td>30개</td>
							    		<td>9개</td>
							    		<td>3개</td>
							    		<td>20개</td>
							    		<td>1개</td>
							    		<td>1개</td>
							    		<td>18개</td>
							    		<td></td>
							    	</tr> 
							    	<tr>
							    		<td>5</td>
							    		<td>2020-01-29</td>
							    		<td>주방가전</td>
							    		<td>세탁기</td>
							    		<td>8개</td>
							    		<td>3개</td>
							    		<td>3개</td>
							    		<td>9개</td>
							    		<td>2개</td>
							    		<td>1개</td>
							    		<td>0개</td>
							    		<td></td>
							    	</tr> 
							    	<tr>
							    		<td>6</td>
							    		<td>2020-02-03</td>
							    		<td>IT</td>
							    		<td>PC</td>
							    		<td>40개</td>
							    		<td>21개</td>
							    		<td>3개</td>
							    		<td>10개</td>
							    		<td>2개</td>
							    		<td>3개</td>
							    		<td>28개</td>
							    		<td></td>
							    	</tr> 
							    	<tr>
							    		<td>7</td>
							    		<td>2020-02-10</td>
							    		<td>TV</td>
							    		<td>QLED 8k</td>
							    		<td>30개</td>
							    		<td>10개</td>
							    		<td>3개</td>
							    		<td>11개</td>
							    		<td>7개</td>
							    		<td>2개</td>
							    		<td>13개</td>
							    		<td></td>
							    	</tr> 
							    	<tr>
							    		<td>8</td>
							    		<td>2020-02-20</td>
							    		<td>태블릿</td>
							    		<td>갤럭시 탭S</td>
							    		<td>80개</td>
							    		<td>7개</td>
							    		<td>3개</td>
							    		<td>21개</td>
							    		<td>10개</td>
							    		<td>3개</td>
							    		<td>25개</td>
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
	$(".stock-information-list #stock-information-list-btn").click(function() {
		if($(this).text()=='검색내역 닫기') {
			$(".stock-information-list .table-bordered").hide();
			$(this).text("검색내역 열기");
		} else {
			$(".stock-information-list .table-bordered").show();
			$(this).text("검색내역 닫기") ;
		}
	});
	 
	
</script>
</html>
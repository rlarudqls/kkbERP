<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>근태조회</title>
  	<meta charset="UTF-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
  	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  	<script src="https://unpkg.com/vue@2.5.13/dist/vue.js"></script>
  	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
</head>
<body>
<%@include file="../kkb_common_file/nav.jsp" %>
<%@include file="hr_sidebar.jsp" %>
<div class="container" id="app">
	<div class="page-header">
		<h1>근태조회</h1>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<div class="row">
				<div class="col-sm-4">
				 	<div><h4>근태조회 검색결과: {{pagination.totalRows}}명</h4></div>
				</div>
				<div class="col-sm-8">
					<div class="row">
						<div class="col-sm-4">
							<div class="form-group">
								<select id="check-option" class="form-control" v-model="param.option">
									<option value="option" disabled selected >검색옵션</option>
									<option value="no" ${param.opt eq 'no' ? 'selected' :''}>근태번호</option>
									<option value="type" ${param.opt eq 'type' ? 'selected' :''} >근태타입</option>
									<option value="employeeNo" ${param.opt eq 'employeeNo' ? 'selected' :''} >사원번호</option>
									<option value="employeeName" ${param.opt eq 'employeeName' ? 'selected' :''} >사원명</option>
								</select>
							</div>
						</div>
						<div class="col-sm-6">
							<input  id="check-keyword" type="text" class="form-control" name="keyword" value="${param.keyword }" v-model="param.keyword" v-on:keyup.enter="serachKeywordBtn(param)">
						</div>
						<div class="col-sm-2">
							<button type="button" class="btn btn-primary" id="search-keyword" @click="serachKeywordBtn(param)">검색</button>
						</div>
					</div>
				</div>
			</div>
			<br/>
			<div>
				<form id="delete-form">
					<table id="management-list-table" class="table table-bordered table-hover">
						<thead>
							<tr>
								<th>근태번호</th>
								<th>일자</th>
								<th>근태타입</th>								
								<th>사원번호</th>
								<th>사원명</th>
								<th>근태량</th>
							</tr>
						</thead>
						<tbody>
							<tr v-for="manage in management">
								<td>{{manage.no}}</td>
								<td>{{manage.managementDate}}</td>
								<td>{{manage.type}}</td>
								<td>{{manage.employeeNo}}</td>
								<td>{{manage.employeeName}}</td>
								<td>{{manage.amount}}</td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>	
			<div>
				<div>
					<div class="pull-right">
						<div class="dropdown">
			  				<button class="btn btn-default" type="button">날짜입력</button>
							<input id="start-date" type="date" class="btn btn-default" value="2010-10-10" v-model="param.startDate"/> 
							<input id="end-date" type="date" class="btn btn-default" v-model="param.endDate"/>
							<button id="search-date" type="button" class="btn btn-primary" @click="searchDateBtn(param)">검색</button>
						</div>					
					</div>
				</div>
			</div>
	 	</div>
	</div>
	<br/>
	<div class="w3-center">
		<div class="w3-bar w3-border w3-round" id="pagination-box">
			<button class="w3-button w3-hover-blue" v-if="pagination.pageNo != 1" @click="prevPage(pagination.pageNo)" >&laquo;</button>
			<span class="page-count">{{pagination.pageNo}}/{{pagination.endPage}}</span>
			<button class="w3-button w3-hover-blue" v-if="pagination.pageNo != pagination.endPage" @click="nextPage(pagination.pageNo)">&raquo;</button>
		 </div>
	</div>	
</div>
</body>
<script type="text/javascript">
	var app = new Vue({
		el:"#app",
		data: {
			param: {
				option:"option",
				keyword: "",
				startDate: "2010-10-10",
				endDate: getFormatDate(new Date()),
				pageNo: 1
			},
			management: [],
			pagination: {}
		},
 		methods: {
 			searchManagement: function(param) {
				$.getJSON('/hr/searchManagementEmp.erp', param,function(result){
					var x = result.management;
					
					for(i=0; i<x.length; i++) {
						 
						x[i].managementDate = getFormatDate(new Date(x[i].managementDate));
					}
					app.management = x;
					app.pagination = result.pagination;
					
				})
			},
			serachKeywordBtn: function(param) {
				app.searchManagement(param)
			},
			searchDateBtn: function(param) {
				app.searchManagement(param)
			},
			nextPage: function(value) {
				var pageNo2 = value + 1;
				app.param.pageNo = pageNo2;
				app.searchManagement(app.param);
			},
			prevPage: function(value) {
				var pageNo2 = value + -1;
				app.param.pageNo = pageNo2;
				app.searchManagement(app.param);
			}
 		}
	});
	app.searchManagement();
	
	function getFormatDate(date){
		var year = date.getFullYear();             
		var month = (1 + date.getMonth());             
		month = month >= 10 ? month : '0' + month;     
		var day = date.getDate();                      
		day = day >= 10 ? day : '0' + day;             
		return  year + '-' + month + '-' + day;
	}	
</script>
</html>
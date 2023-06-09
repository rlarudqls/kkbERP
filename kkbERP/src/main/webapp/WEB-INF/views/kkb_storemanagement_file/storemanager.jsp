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
	<style type="text/css">
		th {
			background-color: #f2f2f2;	
		}
	</style>
</head>
<body>
<%@ include file="../kkb_common_file/nav.jsp" %>
<%@ include file="smsidebar.jsp" %>
<div class="container-fluid col-sm-9" style="margin-left:250px; padding: 50px 0px;">
	<div class="page-header">
		<h1>지점 관리자 등록/수정</h1>
	</div>
	
	<c:if test="${param.result eq 'success' }">
		<div class="row">
			<div class="col-sm-12">
				<div class="alert alert-success">
					<h4>성공적으로 등록/수정 되었습니다.</h4>
				</div>
			</div>
		</div>	
	</c:if>
	
	<div class="row">
		<div class="col-sm-12">
			<select id="select-stores" class="form-control">
				<option disabled selected> --지점을 선택하세요 -- </option>
				<c:forEach var="store" items="${stores }">
					<option value="${store.no }" data-sub="${store.employeeNo }" > ${store.name } </option>
				</c:forEach>
			</select>
		</div>
	</div>
	<hr/>
	
	<div class="row" id="div-store-detail">
		<div class="col-sm-12">
			<div id="div-store-table">
				<table class="table table-bordered">
					<tbody>
						<tr>
							<th class="col-sm-2">지점 명</th>
							<td class="col-sm-9">{{store.name}}</td>
						</tr>
						<tr>
							<th>주소</th>
							<td>{{store.address}}</td>
						</tr>
					</tbody>
				</table>
			</div><hr/>
			<div id="div-current-manager" class="form-group">
				<div>
					<label>현재 등록된 매니저</label>
					<div>
						<img style="width: 100px; height: 120px;" v-if="currentManager.imageName !== undefined"
						:src="'../resources/images/employee/' + currentManager.imageName">
					</div><br/>
					
					<table class="table table-bordered" id="table-current-manager">
						<tr>
							<th class="col-sm-1">이름</th>
							<td class="col-sm-2">{{currentManager.name}}</td>
							<th class="col-sm-1">부서명</th>
							<td class="col-sm-2">{{currentManager.departmentName}}</td>
						</tr>
						<tr>
							<th class="col-sm-1">직급</th>
							<td class="col-sm-2">{{currentManager.gradeName}}</td>
							<th class="col-sm-1">EMAIL</th>
							<td class="col-sm-2">{{currentManager.email}}</td>
						</tr>
						<tr>
							<th class="col-sm-1">입사일</th>
							<td class="col-sm-2">{{currentManager.fmtDate}}</td>
							<th class="col-sm-1">연락처</th>
							<td class="col-sm-2">{{currentManager.tel}}</td>
						</tr>
					</table>
					<label>변경할 매니저</label>
					<button class="btn btn-success btn-sm" id="btn-search-emp" style="margin-left: 20px;"
							data-toggle="modal">직원 조회</button>
				</div>
			</div>
			<div id="div-new-manager" class="form-group" v-if="changedManager.imageName !== undefined && currentManager.no !== changedManager.no">
				<div>
					<img style="width: 100px; height: 120px;" 
						:src="'../resources/images/employee/' + changedManager.imageName">
				</div><br/>
				<table class="table table-bordered">
					<tr>
						<th class="col-sm-1">이름</th>
						<td class="col-sm-2">{{changedManager.name}}</td>
						<th class="col-sm-1">부서명</th>
						<td class="col-sm-2">{{changedManager.departmentName}}</td>
					</tr>
					<tr>
						<th class="col-sm-1">직급</th>
						<td class="col-sm-2">{{changedManager.gradeName}}</td>
						<th class="col-sm-1">EMAIL</th>
						<td class="col-sm-2">{{changedManager.email}}</td>
					</tr>
					<tr>
						<th class="col-sm-1">입사일</th>
						<td class="col-sm-2">{{changedManager.fmtDate}}</td>
						<th class="col-sm-1">연락처</th>
						<td class="col-sm-2">{{changedManager.tel}}</td>
					</tr>
				</table>
				<div class="form-group text-right">
					<a class="btn btn-info" id="a-submit" @click="saveManager(changedManager.no)">등록/수정</a>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="modal-inquiry-emp" role="dialog">
    <div class="modal-dialog modal-lg">
    	<div class="modal-content">
        	<div class="modal-header">
          		<button type="button" class="close" data-dismiss="modal">&times;</button>
          		<h4 class="modal-title">직원 조회</h4>
        		</div>
        		<div class="modal-body">
        		<table class="table">
        			<thead>
        				<tr>
        					<th>사원이름</th>
        					<th>부서명</th>
        					<th>직급</th>
        					<th>연락처</th>
        					<th></th>
        				</tr>
        			</thead>
        			<tbody>
        				<tr v-for="employee in employees">
        					<td>{{employee.name}}</td>
        					<td>{{employee.departmentName}}</td>
        					<td>{{employee.gradeName}}</td>
        					<td>{{employee.tel}}</td>
        					<td><button class="btn btn-success btn-xs" @click="changeManager(employee)">변경</button></td>
        				</tr>
        			</tbody>
        		</table>
        		</div>
        	<div class="modal-footer">
          		<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
          		<button type="button" class="btn btn-default" data-dismiss="modal" @click="removeChange()">취소</button>
        	</div>
      	</div>
   	</div>
</div>
<script type="text/javascript">
	// 지점 선택시 보여줄 지점, 매니저 정보를 담을 뷰를 설정
	var storeApp = new Vue({
		el:"#div-store-detail",
		data: {
			store:{},
			currentManager:{},
			changedManager:{}
		},
		methods: {
			saveManager: function(employeeNo) {
				var no = this.store.no;
				$("#a-submit").attr("href", "changeManager.erp?no="+no+"&employeeNo="+employeeNo);
				$("#a-submit").click();
			}
		}
	})
	var selected;
	// 지점 선택시 ajax로 지점 정보, 매니저 정보를 불러온다.
	$("#select-stores").change(function() {
		var no = this.value;
		var empno = $(this).find("option:selected").data("sub");
		selected = no;
		
		$.getJSON("/storemanagement/storedetail.erp", {no:no}, function(result) {
			storeApp.store = result;
		}) 
		// ajax 실행 시 빈 값이 올 경우, .fail로 실행된다.
		$.getJSON("/hr/getEmployee.erp", {empno:empno})
			.done(function(result) {
				storeApp.currentManager = result;
				storeApp.changedManager = result;
			
			})
			.fail(function() {
				storeApp.currentManager = {"name":"등록된 매니저가 없습니다."};
				storeApp.changedManager = {"name":"등록된 매니저가 없습니다."};
			})
		
	})
	
	
	// 직원 조회를 누를 시 30번 부서인 영업관리부 부서원들이 조회된다.
	var managerApp = new Vue({
		el:"#modal-inquiry-emp",
		data: {
			employees:[]
		},
		methods:{
			changeManager: function(emp) {
				storeApp.changedManager = emp;
			},
			
			removeChange: function() {
				storeApp.changedManager = storeApp.currentManager;
			}
		}
	})
	
	// 직원조회 버튼을 클릭시, 매장이 선택되어 있지 않으면 경고를 보내고
	// 모달과의 연결을 활성화 시킨다. 모달페이지를 오픈하고, 모달에 띄울 JSON 값을 불러온다.
	$("#btn-search-emp").click(function() {
		var deptNo = 30;
		if(!selected) {
			alert("매장을 선택하세요.");
			return false;
		}
		$("#btn-search-emp").attr("data-target", "#modal-inquiry-emp");
		
		$.getJSON("/hr/getEmployeesByDepartmentNo.erp", {no:deptNo}, function(result) {
			managerApp.employees = result;
		}) 
	})
</script>
</body>
</html>
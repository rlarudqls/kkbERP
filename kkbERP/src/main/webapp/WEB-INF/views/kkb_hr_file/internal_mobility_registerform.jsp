<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>인사발령등록</title>
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
<div class="container-fluid col-sm-9" style="margin-left:250px; padding: 50px 0px;">
	<div class="page-header">
		<h1>인사발령 등록</h1>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<div class="row">
				<div class="col-sm-4">
					 <div><h4>인사발령</h4></div>
				</div>
			</div>
			<br>
			<div>
				<form id="internal-mobility-registerform" >
					<div class="table-responsive">
						<table class="table table-condensed" id="internal-table">
							<thead>
								<tr>
									<th>발령일자</th>
									<th>사번</th>
									<th>성명</th>
									<th>발령구분</th>
									<th>이전 직급코드</th>
									<th>이전 직급
									<th>발령 직급코드</th>
									<th>발령 직급</th>
									<th>이전 부서코드</th>
									<th>이전 부서</th>
									<th>발령 부서코드</th>
									<th>발령 부서</th>
								</tr>
							</thead>
							<tbody></tbody>
						 </table>
					 </div>
					 <br>
					 <button class="btn btn-default" type="reset" >초기화</button>
					 <button id="add-btn" class="btn btn-default" type="button">추가</button>
					 <button id="delete-btn" class="btn btn-default" type="button">삭제</button>
					 <button id="save-btn" class="btn btn-default" type="button">저장</button>
				 </form>
			 </div>
				 <form>
					 <div id="employee-list-modal" class="modal fade" role="dialog">
			 			<div id="app">
			  			 	<div class="modal-dialog modal-lg">
						     	<div class="modal-content">
						      		<div class="modal-header">
				        				<div class="input-group">
					        				<div class="input-group btn pull-right">
				        					<input v-on:keydown.enter.prevent="searchOneEmployeeByNo(no)" type="text" class="form-control" placeholder="사원번호 검색" v-model="no">
					        					<button class="btn btn-default" type="button" @click="searchOneEmployeeByNo(no)">
					        						<i class="glyphicon glyphicon-search"></i>
					        					</button>
					        				</div>
				        				</div>
						      		</div>
						      		<div class="modal-body">
										<table id="employee-list-table" class="table table-bordered table-hover">
											<thead>
												<tr>
													<th>사원번호</th>
													<th>성명</th>
													<th>이전 직급코드</th>
													<th>이전 직급</th>						
													<th>이전 부서코드</th>								
													<th>이전 부서</th>
													<th>선택</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>{{employee.no}}</td>
													<td>{{employee.name}}</td>
													<td>{{employee.gradeNo}}</td>
													<td>{{employee.gradeName}}</td>
													<td>{{employee.departmentNo}}</td>
													<td>{{employee.departmentName}}</td>
													<td>
														<button type="button" class="btn btn-default pull-right" @click="insertEmp()">선택</button>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="modal-footer">
						      				<button type="button" class="btn btn-default pull-right" data-dismiss="modal">닫기</button>
									</div>
						      	</div>
				    		</div>
					 	</div>
				  </div>
			 </form>
		</div>	
	</div>
</div>
<script type="text/javascript">
	var app = new Vue({
		el:"#app",
		data: {
			employee: {},
			no:"",
			selectedRowNo:""
		},
		methods: {
			searchOneEmployeeByNo: function(no){
				$.getJSON('/hr/searchOneEmployeeByNo.erp',{no:no},function(result){app.employee=result;})
			},
			insertEmp: function() {
				var $tr = $('#internal-table tbody tr').eq(app.selectedRowNo);
				$tr.find("td:eq(1) input").val(app.employee.no);
				$tr.find("td:eq(2) input").val(app.employee.name);
				$tr.find("td:eq(4) input").val(app.employee.gradeNo);
				$tr.find("td:eq(5) input").val(app.employee.gradeName);
				$tr.find("td:eq(8) input").val(app.employee.departmentNo);
				$tr.find("td:eq(9) input").val(app.employee.departmentName);
				$("#employee-list-modal").modal("hide");
				app.employee = "";
				app.no = "";$
			}
		}
	});
	//내가누른게 내부모에서 몇번쨰를계산 버튼이몇번째인지 알수없음.
	$("#add-btn").click(function(){
		var row = "";
		row += "<tr>"
		row += "<td><input type='date' name='historyDate' style='width: 150px;'></td>"
		row += "<td><input type='text' name='employeeNo' style='width: 100px;'></td>"
		row += "<td><input type='text' name='employeeName' style='width: 100px;'></td>"
		row += "<td><input type='text' name='historyType' style='width: 100px;'></td>"
		row += "<td><input type='text' name='prevGradeNo' style='width: 100px;'></td>"
		row += "<td><input type='text' name='prevGradeName' style='width: 100px;'></td>"		
		row += "<td><input type='text' name='gradeNo' style='width: 100px;'></td>"
		row += "<td><input type='text' name='gradeName' style='width: 100px;'></td>"
		row += "<td><input type='text' name='prevDepartmentNo' style='width: 100px;'></td>"
		row += "<td><input type='text' name='prevDepartmentName' style='width: 100px;'></td>"
		row += "<td><input type='text' name='departmentNo' style='width: 100px;'></td>"
		row += "<td><input type='text' name='departmentName' style='width: 100px;'></td>"
		row += "</tr>"
		
		$('#internal-table tbody').append(row);
	})
	$("#delete-btn").click(function(){
		$("tbody tr:last").remove();
	})
	
	$("#internal-table tbody").on('click', ":input[name='employeeNo']",function(){
		app.selectedRowNo = $(this).closest("tr").index();
		$("#employee-list-modal").modal("show");
	})	
	
	$("#save-btn").on('click',function (){
		var hasEmptyInput = false;
		$("#internal-mobility-registerform :input[type=text]").each(function(index, item) {
			console.log('값', $(item).val());
			if (!$(item).val()) {
				hasEmptyInput = true;
			}
		});
		console.log(hasEmptyInput);
		if (hasEmptyInput) {
			alert("입력되지 않은 필드가 있습니다.");
			return;
		} 
		$("#internal-mobility-registerform").attr('action','add_internal_mobility.erp')
		alert("등록 완료")			
		$("#internal-mobility-registerform").submit();
	})
</script>
</body>
</html>
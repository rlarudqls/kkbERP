<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title></title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
<%@ include file="../kkb_common_file/nav.jsp" %>
<%@ include file="../kkb_my_file/mysidebar.jsp" %>
<div class="container">
	<c:if test="${param.result eq 'modifysuccess' }">
		<div class="row">
			<div class="col-sm-12">
				<div class="alert alert-success">
					<h4>수정 되었습니다.</h4>
				</div>
			</div>
		</div>
	</c:if>
	<div class="row">
		<div class="col-sm-12">
			<div class="text-center" style="margin-top: 100px;">	
				<h1>공지사항 수정/삭제 </h1> 
				<hr>
				<div class="btn-group" role="group" id="search-notice">
	  				<a href="" class="btn  ${empty param.deptno  || param.deptno eq 0 ? 'btn-primary' : 'btn-default' }" data-value="0"  id="all-notice">전체보기</a>
	  				<c:forEach var="dept" items="${departments }">
	  					<a href="" class="btn ${param.deptno eq dept.no ? 'btn-primary' : 'btn-default' }" data-value="${dept.no }" >${dept.name }</a>	  				
	  				</c:forEach> 
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12" >
		<div id="notice-size">
			
		</div>
			<table class="table">
				<thead>
					<tr>
						<th></th>
						<th>번호</th>
						<th>분류</th>
						<th>제목</th>
						<th>등록일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody id="notice-list-table">
				</tbody>
			</table>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<div>
				<button type="button" class="btn btn-danger pull-right" id="btn-selected-del">선택삭제</button>
			</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
	<div class="modal-dialog modal-lg">
  	<!-- Modal content-->
		<div class="modal-content">
      		<div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal">&times;</button>
        		<h1>공지사항 수정</h1>
      		</div>
      		<div class="row">
      			<div class="col-sm-12">                                              
		     		<form id="modify-notice-form" method="post" class="well" enctype="multipart/form-data">
		     			<div class="form-group">
		     				<label>제목</label>
		     				<input type="text" class="form-control" name="title" id="notice-title">
		     				<input type="hidden" id="input-notice-no" name="no" class="form-control" >
		     				<input type="hidden" id="input-dept-no" name="pagedeptno" class="form-control" >
		     			</div>
		     			<div class="form-group">
							<label>부서명</label>
							<select id="select-option" name="deptNo" class="form-control">
								<option disabled selected id="select-dept">-- 부서를 선택하세요. --</option>
								<c:forEach var="departments" items="${departments }" >
									<option value="${departments.no }" >${departments.name }</option>	
								</c:forEach>
							</select>
						</div>
						<div class="form-group">
						  	<label>내용</label>
						  	<textarea class="form-control" rows="5" id="notice-comment" name="content"></textarea>
						</div>
						<div class="form-group">
							<label>첨부파일</label>
							<input type="file" class="form-control" name="source">
							<div class="row">
								<div class="col-sm-12" id="notice-source">
									<p id="file"></p>
								</div>
							</div>
						</div>
		     		</form>
      			</div>
      		</div>
      		
      		<div class="modal-footer">
        		<button type="button" class="btn btn-default pull-right" data-dismiss="modal">닫기</button>
        		<button type="button" class="btn btn-success pull-right" id="modify-notice-button">수정</button>
      		</div>
  			</div>
	</div>
</div>
<script type="text/javascript">
	var clickedDeptNo = 0;

	$("#btn-selected-del").click(function(){
		var checkedbox = $("input[type=checkbox]:checked");
	    if (checkedbox.length == 0) {
	        alert("삭제할 공지사항이 없습니다.");
	        return false;
	     }
	
		

		var checkedNotices = [];
		$("#notice-list-table [name=noticeno]:checked").each(function(index, checkbox) {
			checkedNotices.push($(checkbox).val());
		});
		var param = checkedNotices.map(function(item) {
			return "noticeno=" + item
		}).join("&")
		
		console.log(param);
		param = param+"&deptno="+clickedDeptNo;
		var $tbody = $("#notice-list-table").empty();
		
		$.getJSON("/notice/selectDeleteNotice.erp", param, function(result) {
			$("#notice-size").empty();
			var size = result.length;
			var sizeContent = "<p>" + size + " 개의 공지사항이 있습니다.</p>";
			$("#notice-size").prepend(sizeContent);
			
			$.each(result, function(index, item) {
				console.log(item);
				var row = "<tr>";
				row += "<td><input type='checkbox' name='noticeno' value='"+ item.no +"'></td>";
				row += "<td>" + (index + 1) + "</td>";
				row += "<td>" + item.departmentName + "</td>";
				row += "<td>" + item.title + "</td>";
				row += "<td>" + item.fmtDate + "</td>";
				row += "<td>" + item.viewCount + "</td>";
				row += "<td><button id='modify-notice-button-"+item.no+"' type='button' class='btn btn-warning btn-xs' data-no='"+item.no+"'>"+'수정'+"</button></td>";
				row += "<td><a href='deleteNotice.erp?deptno="+clickedDeptNo+"&noticeno="+item.no+"'>";
				row += "<button id='delete-delete-button-"+item.no+"' type='button' class='btn btn-danger btn-xs' data-no='"+item.no+"'>"+'삭제'+"</button>";
				row += "</a></td>";
				row += "</tr>"
				
				$tbody.append(row);
			
			})
		})
	});
	
	$("#modify-notice-button").click(function() {
		$("#modify-notice-form").attr('action', 'modifyUpdateNotice.erp');
		$("#modify-notice-form").submit();
	})
	
	
	$("#search-notice a").click(function(event) {
		event.preventDefault();
		
		$("#search-notice a").removeClass("btn-primary").addClass("btn-default");
		$(this).addClass('btn-primary');
		
		clickedDeptNo = $("#search-notice a.btn-primary").data('value');
		
		var $tbody = $("#notice-list-table").empty();
		
		$.getJSON("/notice/modify.erp", {deptno:clickedDeptNo}, function(result) {
			
			$("#notice-size").empty();
			var size = result.length;
			var sizeContent = "<p>" + size + " 개의 공지사항이 있습니다.</p>";
			$("#notice-size").prepend(sizeContent);
			
			$.each(result, function(index, item) {
				console.log(item);
				var row = "<tr>";
				row += "<td><input type='checkbox' name='noticeno' value='"+ item.no +"'></td>";
				row += "<td>" + (index + 1) + "</td>";
				row += "<td>" + item.departmentName + "</td>";
				row += "<td>" + item.title + "</td>";
				row += "<td>" + item.fmtDate + "</td>";
				row += "<td>" + item.viewCount + "</td>";
				row += "<td><button id='modify-notice-button-"+item.no+"' type='button' class='btn btn-warning btn-xs' data-no='"+item.no+"'>"+'수정'+"</button></td>";
				row += "<td><a href='deleteNotice.erp?deptno="+clickedDeptNo+"&noticeno="+item.no+"'>";
				row += "<button id='delete-delete-button-"+item.no+"' type='button' class='btn btn-danger btn-xs' data-no='"+item.no+"'>"+'삭제'+"</button>";
				row += "</a></td>";
				row += "</tr>"
				
				$tbody.append(row);
			})
		})
	})
	
	
	$("#notice-list-table").on('click', '[id^="modify-notice-button"]', function() {
		
		var noticeNo = $(this).data("no");
						
		$.getJSON("/notice/modifynotice.erp", {noticeno:noticeNo}, function(result){
			$("#input-notice-no").val(noticeNo);
			$("#input-dept-no").val(clickedDeptNo);
			$("#myModal #notice-title").val(result.title);
			$("#myModal #select-option").val(result.departmentNo);
			$("#myModal #notice-comment").val(result.content);
			var source = result.source
			if(source != null) {
				$("#file").text("첨부파일 : " + source);
			}
		})
		$("#myModal").modal("show");
	})
	
	$("#search-notice a.btn-primary").trigger('click');
	
	$(".modal").on("hidden.bs.modal", function() {
		$("#file").text("첨부파일 : 없음");
	});
		
	
</script>
</body>
</html>
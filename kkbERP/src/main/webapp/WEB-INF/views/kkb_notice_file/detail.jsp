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
	<div class="row">
		<h1>공지사항</h1>
		<table class="table table-bordered">
			<colgroup>
				<col width="15%">
				<col width="15%">
				<col width="16%">
				<col width="15%">
				<col width="15%">
				<col width="15%">
				<col width="15%">
				<col width="14%">
			</colgroup>
			<tr>
				<th>부서명</th>
				<td>${noticeDetail.departmentName }</td>
				<th>제목</th>
				<td>${noticeDetail.title }</td>
				<th>날짜</th>
				<td>${noticeDetail.fmtDate }</td>
				<th>조회수</th>
				<td>${noticeDetail.viewCount }</td>
			</tr>
			<tr>
				<th class="active">내용</th>
				<td colspan="10"><textarea rows="6" class="form-control" readonly ="readonly">${noticeDetail.content }</textarea> </td>
			</tr>
			<c:if test="${not empty noticeDetail.source }">
			<tr>
				<th>첨부파일</th>
				<td colspan="3">
					${noticeDetail.source }
						<a href="download.erp?noticeno=${noticeDetail.no }" class="btn btn-warning btn-xs">다운로드</a>
				</td>
			</tr>
			</c:if>
		</table>
		<table class="table table-hover">
			<tbody>
				<tr>
					<c:if test="${not empty nextArticle}">
							<td>이전글</td>
							<td><a href="detail.erp?deptno=${param.deptno }&noticeno=${nextArticle.no}&pageno=${param.pageno}">${nextArticle.title }</a></td>
							<td></td>
							<td></td>
							<td></td>
							<td align="right">${nextArticle.fmtDate }</td>
					</c:if>
					<c:if test="${empty nextArticle}">
						<td colspan="6" style="text-align: center;">다음글이 없습니다.</td>
					</c:if>
				</tr>
			</tbody>
			<tbody>
				<tr id="prev-article">
					<c:if test="${not empty prevArticle}">
							<td>다음글</td>
							<td><a href="detail.erp?deptno=${param.deptno}&noticeno=${prevArticle.no}&pageno=${param.pageno}">${prevArticle.title }</a></td>
							<td></td>
							<td></td>
							<td></td>
							<td align="right">${prevArticle.fmtDate }</td>
					</c:if>
					<c:if test="${empty prevArticle}">
						<td colspan="6" style="text-align: center;">이전글이 없습니다.</td>
					</c:if>
					
				</tr>
			</tbody>
		</table>
		<div>
			<a href="notice.erp?deptno=${param.deptno}&pageno=${param.pageno}" class="btn btn-default pull-right">목록</a>
		</div>
	</div>
</div>
<script type="text/javascript">

</script>
</body>
</html>
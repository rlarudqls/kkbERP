<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>erp</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<style type="text/css">
		.notice {
            table-layout: fixed;
            font-size: 13px;
        }

        .notice td {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            cursor: pointer;
        }

        .footer {
            background-color: #f5f5f5;
            padding: 20px;
            text-align: center;
            font-size: 14px;
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
        }

        .footer a {
            color: #777;
            text-decoration: none;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        .footer ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }

        .footer li {
            display: inline-block;
            margin-right: 10px;
        }

        .footer .footer-logo {
            display: inline-block;
            margin-right: 10px;
            font-weight: bold;
        }

        .footer .footer-logo img {
            vertical-align: middle;
            height: 20px;
        }
    </style>
</head>
<body>
<%@ include file="kkb_common_file/nav.jsp" %>
<div class="container-fluid" style="position:absolute; top: 80px; margin-left: 80px;">
	<div class="row">
		<div class="col-sm-6">
			<img src="resources/image/logo/kkbERP_logo.png" class="img-rounded" style="width: 100%">
		</div>
		<div class="col-sm-5" style="margin-left:40px;">
			<div class="row">
				<div class="col-md-11" style="font-weight: bold">
					<div class="panel panel-default">
						<div class="panel-heading"> ERP 프로그램 사용자
							<c:if test="${empty attendance }">
								<button id="intime-btn" type="button">출근</button>								
							</c:if>
							<c:if test="${attendance.status eq 'Y' }">					
								<button id="outtime-btn" type="button">퇴근</button>								
							</c:if>
				
							<form id="attendanceForm">
								<input id="employee-no" type="hidden" name="empNo" value="${LE_detail.no }">
								<input id="times" type="hidden" name="times" />
								<input id="employee-name" type="hidden" name="empName" value="${LE_detail.name }">
							</form>
						</div>
						<div class="media">
							<div class="media-left">
								<img class="media-object" style="width:110px; height:160px; margin: 0 10px 15px 15px;" src="resources/images/employee/${LE.imageName }">
							</div>
							<div class="media-body">
								<p class="media-heading">[${LE_detail.no }] ${LE_detail.departmentName }-${LE_detail.name }</p>
								<p>${LE_detail.gradeName }</p>
								<p>${LE_detail.email }</p>
								<p>${LE_detail.tel }</p>
								<div class="btn-group">
									<a href="my/sendmessages.erp"><button type="button">보낸메세지</button></a>
									<a href="my/getmessage.erp"><button type="button">받은메세지</button></a>								
									<a href="my/searchemployee.erp"><button type="button">직원검색</button></a>
								</div>
							</div>
						</div>
					</div>
					<div class="panel panel-default" style="margin-top: -5px;">
						<div class="panel-heading">공지사항 게시판</div>
						<div class="panel-body">
							<table class="table table-hover notice">
								<colgroup>
									<col width="45%">
									<col width="35%">
									<col width="20%">
								</colgroup>
								<thead>
									<tr>
										<th>제목</th>
										<th>부서</th>
										<th>조회수</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="notice" items="${notices }" varStatus="loop">
										<tr onclick="showNotice(${notice.no }, ${notice.departmentNo })">
											<td>${notice.title }</td>
											<td>${notice.departmentName }</td>
											<td>${notice.viewCount }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	function showNotice(noticeNo, deptNo) {
		var url = "notice/detail.erp?deptno="+deptNo+"&noticeno="+noticeNo;
		window.location = url;
	}
	
	$("#intime-btn").click(function(){
		var intime = new Date();
		$("#times").val(intime.getTime());
		$("#attendanceForm").attr('action', 'intimeUser.erp');
		$("#attendanceForm").submit();
	})
	
	$("#outtime-btn").click(function(){
		var outtime = new Date();
		$("#times").val(outtime.getTime());
		$("#attendanceForm").attr('action', 'outtimeUser.erp');
		$("#attendanceForm").submit();
	})
	
</script><footer id="footer" class="footer">
    <div class="full-w">
        <nav class="nav-links">
            <a class="m-show" href="https://bristle-house-c2d.notion.site/fbdf277b33984ffba1046be4320c2923">이용약관</a>
            <span class="m-show">|</span>
            <a class="m-show"href="https://bristle-house-c2d.notion.site/fbdf277b33984ffba1046be4320c2923"><strong>개인정보 처리방침</strong></a>
            <span class="m-show">|</span>
            <a class="m-show" href="https://bristle-house-c2d.notion.site/fbdf277b33984ffba1046be4320c2923">공지사항</a>
            <span class="m-show">|</span>
            <a href="https://bristle-house-c2d.notion.site/fbdf277b33984ffba1046be4320c2923">자주 묻는 질문</a>
            <span>|</span>
            <a href="/w/board/event">이벤트</a>
            <span>|</span>
            <a href="https://bristle-house-c2d.notion.site/fbdf277b33984ffba1046be4320c2923" target="blank">입점문의</a>
            <span>|</span>
            <a class="m-show" href="https://team.idus.com" target="blank">About kkbERP</a>
            <span>|</span>
            <a href="https://bristle-house-c2d.notion.site/fbdf277b33984ffba1046be4320c2923" target="blank">인재 영입</a>
        </nav>
    </div>

    <div class="inner-w clf" data-has-inquire-btn="false">
        <div class="logo-footer fl">
            <i class="sp-icon logo-gray"></i>
        </div>

        <div class="text-box fl">
            <strong>(주)김경빈 ERP System</strong>
            <ul>
                <li>대표이사 : 김경빈</li>
                <li>서울특별시 송파구 올림픽로135</li>
                <li>사업자 등록번호 : 000-00-00000
                    <a href="https://velog.io/@kkb3431" target="blank" class="btn-style-link">
                        사업자 벨로그확인
                        <i class="fa fa-caret-right"></i>
                    </a>
                </li>
                <li>판매업신고 : 2023-서울강남-0101</li>
                <li>호스팅서비스 제공자 : KKB WEB Service, Inc</li>
            </ul>
            <span class="mt-fix1">
               김경빈 ERP System은 상품 거래정보 및 거래에 대하여 책임을 지지 않습니다.
                <span class="copyright">Copyright  © 2023 KKB_ERP All right reserved.</span>
            </span>
        </div>

        <div class="text-box fl">
            <strong>고객센터</strong>
            <span style="display: inline-block; margin-top: 2px;">(평일 오전 10시 ~ 오후 6시)</span>
            <ul>
                <li>
                    <span class="fix-w">카카오톡</span>
                    <a href="https://www.kakaocorp.com/page/"><em style="font-size:12px;">김경빈 ERP System</em></a>
                </li>
                <li><span class="fix-w">대표번호</span> 010-6375-3431(발신자 부담전화)</li>
                <li><span class="fix-w">메일</span> kkb3431@gmail.com</li>
                <li><span class="fix-w">광고문의</span> kyeongbin3431@gmail.com</li>
            </ul>
            <span class="mt-fix2">
                김경빈 ERP System 이용 중 궁금하신 점이 있으신가요?<br>
                메일 또는 플러스친구 `김경빈 ERP System`로 연락해주세요.<br>
                최선을 다해 도와드리겠습니다.
            </span>
        </div>

        <div class="text-box fr">
            <strong>Follow Us</strong>
            
            <span class="mt-fix3">
                <span class="sp-icon award-reddot fl" style="margin-right: 24px"></span>
                <span class="sp-icon award-idea fr"></span>
            </span>
        </div>
    </div>

    <div class="inner-w clf safe-info">
        <hr class="divider" />
        <div class="empty fl"></div>
        <div class="text-box fl isms">
            <a href="https://isms.kisa.or.kr/main/ispims/issue/?certificationMode=list&crtfYear=&searchCondition=2&searchKeyword=%EB%B0%B1%ED%8C%A8%EC%BB%A4&__encrypted=U8oaEwTLg12yqNDZuCwRPMiDRLgcrZjlbxomU5uctoZc1kXWONBhXaf0KhG%2BaV6wpp2zSeTry6yKT1QpQPP4n6Wl4JbzPyTKSn7s1FoRr90UnnwTp%2BW928V1TpyMuwFVMU8D270RkIg564CRAF0bUnkvpnfyAxjhbyn0pSpjvw%2BMlXuoQnR3oJUfvVi%2B1dac8Gnd7jHhSmiDLOX09CuWhVRPx40RuMcaT%2FHbItyyZvQECWvcAvRb36C1zB%2FnwnWRJNfv74iaCKBgpNE%2BERnypNyBfcqQSKf%2BfDsW9aHcpTOO1K747YgBrg%3D%3D" target="blank">
                <span class="sp-icon logo-isms fl"></span>
            </a>
            <span class="txt fl">
                [김경빈 ERP System 인증범위] ERP System 운영(김경빈 ERP System) <br />
                [김경빈 ERP System 유효기간] 1999.09.27 - 3999.12.31
            </span>
        </div>
        <div class="text-box fl escrow">
                <span class="sp-icon escrow fl"></span>
                <span class="txt fl">
                    고객님은 현금 등으로 결제시 당사에서 가입한 <br />
                    구매안전서비스를 이용하실 수 없습니다.
                </span>
        </div>
    </div>
</footer>
</body>
</html>

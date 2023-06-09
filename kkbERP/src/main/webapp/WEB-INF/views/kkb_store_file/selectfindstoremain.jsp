<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>매장찾기 | JHTA ERP</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<!-- services 라이브러리 불러오기 -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c0fcdedc76abf142014d8fda2e25ce0f&libraries=services"></script>
	<style type="text/css">
	.store-sidebar {
		margin-top: 40px;
		width: 300px;
		max-height: 100%;
		position: absolute;
		left: 0;
		overflow: auto;
	}
	.sidebar-item {
		padding-top:10px;border-bottom: 1px solid
	}
	.sidebar-item.active {
		background: lightgray;
	}
	
    .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 16px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
    .wrap * {padding: 0;margin: 0;}
    .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 14px;font-weight: bold;}
    .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
    .info .close:hover {cursor: pointer;}
    .info .body {position: relative;overflow: hidden;}
    .info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .info .link {color: #5085BB;}
</style>
</head>
<body>
<%@ include file="../kkb_common_file/nav.jsp" %>
<div class="container-fluid" style="margin-top: 70px;">
	<div class="row">
		<div class="col-sm-2">
	    	<div class="search-menu">
	    		<input id="keyword" type="text" autocomplete="off">
	    		<button id="search-btn">검색</button>
	    	</div>
	    	<div id="sidebar-list" style="height:830px; overflow: scroll;" >
	    		<div class="sidebar-item" style="padding-top:10px;border-bottom: 1px solid;">
	    		</div>
	    	</div>
		</div>
		<div class="col-sm-9">
			<div id="map" style="width:1570px;height:850px;"></div>
		</div> 
	</div>
	<div class="store-sidebar">
    </div>
</div>
</body>
<script>
 	$(function() {
 		
 		//init
 		searchStores();
 		
 		var markers = [];
 		var overlay;
 		
 		/******************** 맵관련 ********************/
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(37.573025, 126.992224), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    }; 		
 		
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
		    
		    // 클릭한 위도, 경도 정보를 가져옵니다 
		    var latlng = mouseEvent.latLng;
		    
		    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
		    message += '경도는 ' + latlng.getLng() + ' 입니다';
		    
		    console.log(message);
		});
 		
 		// 엔터키 클릭 이벤트
 		$("#keyword").on("keydown",function(e) {
 			if(e.keyCode === 13)
 				$("#search-btn").trigger("click");
 		});
 		
 		// 사이드바 리스트 목록 클릭 이벤트
 		$("#sidebar-list").on("click",".sidebar-item",function() {
			
 			$(".sidebar-item").removeClass("active");
 			$(this).addClass("active");
 			
 			var marker = findMarker($(this).attr("id"));
 			displayOverlay(marker);
 			map.panTo(marker.getPosition());
 		});
 		
 		// 검색 버튼 클릭 시 데이터 불러오는 함수 실행
 		$("#search-btn").on('click',function() {
 			var keyword = $("#keyword").val();
 			searchStores(keyword);
 		});
 		
 		/**
 		키워드로 REST API 호출, 받아온 Store 정보로 마커 생성 함수 호출
 		및 사이드바 리스트 목록 추가
 		*/
 		function searchStores(keyword) {
 			$.ajax({
 				url: "/restStore.erp",
 				data: {keyword},
 				success: function(result) {
 					
 					console.log(result);
 					
					if(!result.length) {
						alert("검색 결과가 없습니다.");
						return;
					}
					
					removeMarker();
 					
					// 지도 범위를 재설정 하기 위한 객체
 					var bounds = new kakao.maps.LatLngBounds();
					
 					var text = '';
 					result.forEach(function(store,i) {
 						
 	 					text += '<div class="sidebar-item" id="' + store.no + '">';
 	 	    			text += '<p class="name">' + store.name + '</p>'
 	    				text += '<p class="address">주소: ' + store.address + '</p>'
 	   					text += '<p class="tel">전화번호: ' + store.tel + '</p>' 
 	   					text += '<p class="employeeName">담당자: ' + store.employeeName + '</p>' 
 	   					text += "</div>"
 	   					
 	   					// DB에 있는 위/경도를 postion으로 만든다.
 	   					var position = new kakao.maps.LatLng(store.lat, store.lon);
 	   					// 마커를 만든다.
 						addMarker(position, store.no);
 						bounds.extend(position);
 					});
 					
 					// 지도 범위 재설정
 					map.setBounds(bounds);
 					$("#sidebar-list").html(text);
 				}
 			});
 		}
 		
 		/**
 		마커 생성 및 마커 클릭 이벤트
 		클릭 시 오버레이 표출 함수 이벤트 호출
 		*/
 		function addMarker(position, no) {
 	
 			var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
 		 	var imageSize = new kakao.maps.Size(24, 35); 

 		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
 		    
 		 	var marker = new kakao.maps.Marker({
 		 		title: no,
	 	        map: map, // 마커를 표시할 지도
	 	        position: position, // 마커를 표시할 위치
	 	        image : markerImage // 마커 이미지 
 	    	});
 		 	
 		 	
 		 	// 마커 클릭 이벤트 생성
 		 	kakao.maps.event.addListener(marker, 'click', function() {
 		 		displayOverlay(this); // 오버레이 표시
 		 	});
 		 	
 			markers.push(marker);
 		}
 		
 		// 오바레이 생성 함수
 		function displayOverlay(marker) {
 			
 			// 오버레이가 있을 경우 화면에서 지움
 			if(overlay)
 				overlay.setMap(null);
 			
 			var no = marker.getTitle();
 			
 			var name = $("#" + no).find(".name").text();
 			var address = $("#" + no).find(".address").text();
 			var tel = $("#" + no).find(".tel").text();
 			var emp = $("#" + no).find(".employeeName").text();
 			
 		 	var content = '<div class="wrap">' + 
 		 	'<input class="no" type="hidden" value="' + no + '"/>' + 
            '    <div class="info">' + 
            '        <div class="title">' + name + 
            '            <div class="close" title="닫기"></div>' + 
            '        </div>' + 
            '        <div class="ellipsis">'+ address +'</div>' + 
            '        <div class="ellipsis">'+ tel +'</div>' + 
            '        <div class="ellipsis">'+ emp +'</div>' + 
            '    </div>' +    
            '</div>';

            // 오버레이 생성
			overlay = new kakao.maps.CustomOverlay({
				clickable: true, // 클릭 시 맵 이동 방지
			    position: marker.getPosition(), // 마커에서 보내준 위/경도
			    content: content, // 컨텐츠
			    map: map,
			});
				
		    overlay.setMap(map); // 오버레이 화면 표시
 		}
 		
 		// 마커 삭제
 		function removeMarker() {
 			markers.forEach(function(marker) {
 				marker.setMap(null);
 			});
 			markers = [];
 		}
 		
 		// 마커 검색
 		function findMarker(no) {
 			return markers.filter(marker => marker.getTitle() == no)[0];
 		}
 		
 		$("#map").on('click',".close",function() {
 			overlay.setMap(null);
 		});
 		
 		// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성을 한다.
 		var mapTypeControl = new kakao.maps.MapTypeControl();

 		// 지도에 컨트롤을 추가해야 지도위에 표시한다.
 		// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미한다.
 		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

 		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성한다.
 		var zoomControl = new kakao.maps.ZoomControl();
 		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
 		
 	})
 		
</script>
</html>
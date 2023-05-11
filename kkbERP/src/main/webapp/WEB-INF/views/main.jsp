<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>ERP 홈페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #333;
            color: #fff;
            padding: 10px;
        }

        nav ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }

        nav ul li {
            display: inline-block;
            margin-right: 10px;
        }

        nav ul li a {
            color: #fff;
            text-decoration: none;
        }

        section {
            padding: 20px;
            margin-bottom: 30px;
        }

        h1, h2 {
            margin-top: 0;
        }

        footer {
            background-color: #f4f4f4;
            padding: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    <header>
        <h1>우리 회사 ERP 시스템</h1>
        <nav>
            <ul>
                <li><a href="#about">소개</a></li>
                <li><a href="#features">기능</a></li>
                <li><a href="#contact">문의</a></li>
            </ul>
        </nav>
    </header>

    <section id="about">
        <h2>회사 ERP 시스템 소개</h2>
        <p>우리 회사 ERP 시스템은 효율적인 자원 관리를 위한 종합적인 솔루션입니다. 실시간 데이터 분석, 자동화된 프로세스, 통합된 정보 시스템을 통해 비즈니스 운영을 최적화합니다.</p>
        <img src="about_erp.jpg" alt="ERP 시스템 소개 이미지">
    </section>

    <section id="features">
        <h2>주요 기능</h2>
        <ul>
            <li>재고 관리</li>
            <li>생산 관리</li>
            <li>자금 관리</li>
            <li>인사 관리</li>
            <li>판매 및 구매 관리</li>
        </ul>
    </section>

    <section id="contact">
        <h2>문의</h2>
        <p>ERP 시스템에 대한 문의나 요청 사항이 있으시면 아래 연락처로 연락 주세요.</p>
        <p>전화: 123-456-7890</p>
        <p>이메일: info@example.com</p>
    </section>

    <footer>
        <p>© 2023 우리 회사. All rights reserved.</p>
    </footer>
</body>
</html>
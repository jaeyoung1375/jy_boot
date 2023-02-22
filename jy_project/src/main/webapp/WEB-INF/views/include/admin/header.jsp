<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/admin/main.css">
<link rel="stylesheet" href="/css/admin/memberManage.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Rubik+80s+Fade&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
<script src="/js/admin/main.js" defer></script>
</head>
<body>

	  <nav class="navbar">
        <div class="navbar__logo">
            <i class="fab fa-accusoft"></i>
            <a href="">치킨나라</a>
        </div>

        <ul class="navbar__menu">
           <li><a href="">게시판 관리</a></li>
           <li><a href="productManage">상품 관리</a></li>
           <li><a href="">주문 관리</a></li>
           <li><a href="memberManage">회원 관리</a></li>
           <li><a href="">환경설정</a></li>
        </ul>

        <ul class="navbar__icons">
          <li><i class="fab fa-twitter"></i></li>
            <li><i class="fab fa-facebook"></i></li>
        </ul>

        <a href="#" class="navbar__toogleBtn">
            <i class="fas fa-bars"></i>
        </a>
    </nav>

</body>
</html>
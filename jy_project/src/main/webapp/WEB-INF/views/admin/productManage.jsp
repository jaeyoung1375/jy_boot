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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"> 
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

        <div class="member_page">
            상품관리 페이지
        </div>

        <div class="container">
            <table class="table" border="1">
                <thead class="table-dark">	
                <tr>
                    <th>번호</th>
                    <th>상품명</th>
                    <th>상품가격</th>
                    <th>상품수량</th> 
                 </tr>
                </thead>
             	<c:forEach items="${list}" var="list">
             	<tbody>
             	<tr>
             	<td><c:out value="${list.productNo}"/></td>
             	<td><c:out value="${list.productName}"/></td>
             	<td><c:out value="${list.productPrice}"/></td>
             	<td><c:out value="${list.productStock}"/></td>           	
             	</tr>
             	</tbody>
             	</c:forEach>
            </table>
        </div>
        <!-- 
 
       <div class="page_wrap">
       	<div class="page_nation">
	       	<c:if test="${vo.startBlock != 1 }">
	       		<a class="arrow prev"href="productManage?page=${vo.prevPage}">&lt;</a>
	       	</c:if>
	       		<c:forEach var="i" begin="${vo.startBlock}" end="${vo.finishBlock}">
	       			<a href="productManage?page=${i}">${i}</a>
	       		</c:forEach>
	       	<c:if test="${vo.page != vo.totalPage}">
	       		<a class="arrow next" href="productManage?list=${vo.nextPage}">&gt;</a>
	       	</c:if>
	      </div> 	
       </div>
       -->
</body>
</html>
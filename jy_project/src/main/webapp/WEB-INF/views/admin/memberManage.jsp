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
           <li><a href="">상품 관리</a></li>
           <li><a href="">주문 관리</a></li>
           <li><a href="">회원 관리</a></li>
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
            회원관리 페이지
        </div>

        <div class="container">
            <table class="table" border="1">
                <thead class="table-dark">	
                <tr>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>닉네임</th>
                    <th>이메일</th> 
                    <th>가입일자</th>
                 </tr>
                </thead>
             	<c:forEach items="${list}" var="list">
             	<tbody>
             	<tr>
             	<td><a href="/admin/memberDetail?memberId=${list.memberId}" ><c:out value="${list.memberId}"/></a></td>
             	<td><c:out value="${list.memberName}"/></td>
             	<td><c:out value="${list.memberNickName}"/></td>
             	<td><c:out value="${list.memberEmail}"/></td>
             	<td><fmt:formatDate value="${list.createDt}" pattern="yyyy-MM-dd"/></td>
             	</tr>
             	</tbody>
             	</c:forEach>
            </table>
        </div>
        
        <!-- 페이지 네비게이션 -->
        <c:forEach var="i" begin="${beginPage}" end="${endPage}" step="1">
        	<c:choose>
        		<c:when test="${page ==i}">
        		${i}
        		</c:when>
        		<c:otherwise>
        			<a href="memberManage?page=${i}">${i}</a>
        		</c:otherwise>
        	</c:choose>
        </c:forEach>
        
      
</body>
</html>
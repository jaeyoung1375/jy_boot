<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/main.css">
    <link rel="stylesheet" href="/css/admin/commons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <title>메인 페이지</title>
</head>
<body>
   <header id="header">
        <div class="header_inner">
            <h1 class="logo">
                <a href="/">
                    <span class="blind">치킨나라</span>
                </a>
            </h1>

            <div class="util">
                <ul>
                <c:choose>
                	<c:when test="${member == null}">
                    <li>
                        <a href="/member/login">로그인</a>
                    </li>
                     <li>
                        <a href="/member/join">회원가입</a>
                    </li>
                    </c:when>
                    <c:otherwise>       
                    <li>
                        <a href="/member/logout">로그아웃</a>
                        <a href="/member/v1/user/logout">카카오 로그아웃</a>
                    </li>
                    <li>
                    	<a href="#">내정보</a>
                    </li>
                    </c:otherwise>
                   </c:choose>
                    <li>
                        <a href="#">주문조회</a>
                    </li>
                    <li>
                        <a href="#">고객센터</a>
                    </li>
                    <li>
                    	<a href="/board/list">게시판</a>
                    </li>
                </ul>
            </div>
            <div class="header_search">
                <div class="top_search">
                    <input type="search" class="input_search" placeholder="원하는 날짜에, 원하는 장소로 편리하게!">
                    <button type="button" class="btn_top_search" id="btnTopSearch"><i class="fas fa-search fa-lg"></i></button>
                    
                </div>
            </div>
            <div class="my_menu">
                <ul>
                    <li>
                        <a href="/member/mypage">
                            <span class="blind"><i class="far fa-user fa-lg"></i></span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span class="blind"><i class="fas fa-heart fa-lg"></i></span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span class="blind"><i class="fas fa-shopping-cart fa-lg"></i></span>
                        </a>
                    </li>

                </ul>
            </div>
        </div>

        <div class="gnb_wrap">
            <div class="inner">
                <div class="category_wrap">
                    <nav id="gnb" class="gnb">
                        <ul>
                            <li>
                                <a href="#">
                                    <i class="fas fa-bars"></i>
                                    <span>카테고리</span>
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <span>랭킹</span>
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <span>이달의 특가</span>
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <span>브랜드관</span>
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <span>1팩 담기</span>
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <span>이벤트</span>
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <span>특급배송</span>
                                </a>
                            </li>
                            
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </header>

</body>
</html>
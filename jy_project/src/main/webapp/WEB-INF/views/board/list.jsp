<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
 <style>
  a{
  	text-decoration : none;
  }
table {
  border-collapse: collapse;
  border-spacing: 0;
  margin-left:auto;
  margin-right:auto;
}


.table_wrap{
	text-align: center;
}

.board-table {
  font-size: 13px;
  width: 80%;
  border-top: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
}

.board-table a {
  color: #333;
  display: inline-block;
  line-height: 1.4;
  word-break: break-all;
  vertical-align: middle;
}
.board-table a:hover {
  text-decoration: underline;
}
.board-table th {
  text-align: center;
}

.board-table .th-num {
  width: 100px;
  text-align: center;
}
.board-table .th-writer {
  width: 400px;
}

.board-table .th-date {
  width: 200px;
}

.board-table .th-read {
  width: 200px;
}

.board-table th, .board-table td {
  padding: 14px 0;
}

.board-table tbody td {
  border-top: 1px solid #e7e7e7;
  text-align: center;
}

.board-table tbody th {
  padding-left: 28px;
  padding-right: 14px;
  border-top: 1px solid #e7e7e7;
  text-align: left;
}

.board-table tbody th p{
  display: none;
}



  .top_btn{
  	font-size: 20px;
    padding: 6px 12px;
    background-color: #fff;
    border: 1px solid #ddd;
    font-weight: 600;
  }
  .pageInfo_wrap{
  	display:flex;
  	justify-content: center;
  }
  .pageInfo{
  	list-style:none;
  	display:flex;
  	
  }
  
  .pageInfo li{
  	float:left;
  	font-size: 20px;
  	
  	padding : 7px;
  	font-weight : 500;
  }
  
  
  .search_area{
    display: inline-block;
    margin-top: 30px;
     
    
  }
  .search_area input{
      height: 30px;
    width: 250px;
   
  }
  .search_area button{
     width: 100px;
    height: 36px;
  }
  
  .search_area select{
  	height:35px;
  	text-align:center;
  }
  
  a:link {color:black; text-decoration: none;}
 a:visited {color:black; text-decoration: none;}
 a:hover {color:black; text-decoration: underline;}
 
   .active{
      background-color: #cdd5ec;
  }
  
  </style>  
</head>
<body>
	<%@include file="../include/header.jsp" %>


		<div class="table_wrap">
			<a href="/board/enroll" class="top_btn">게시판 등록</a>
			 <table class="board-table">
                <thead>
                <tr>
                    <th scope="col" class="th-num">번호</th>
                    <th scope="col" class="th-title">제목</th>
                    <th scope="col" class="th-writer">작성자</th>
                    <th scope="col" class="th-date">등록일</th>
                    <th scope="col" class="th-read">조회수</th>
                </tr>
                </thead>
					<c:forEach items="${list}" var="list">
						<tr>
							<td><c:out value="${list.bno}"/></td>
							<td>
							<a class="move" href='<c:out value="${list.bno}"/>'><c:out value="${list.title}"/></a>
							</td>
							 <td><c:out value="${list.writer}"/></td> 
							<td><fmt:formatDate pattern="yyyy/MM/dd" value="${list.regdate}"/></td>
							 <td><c:out value="${list.updateRead}"/></td> 
								
									
						</tr>
					</c:forEach>
			</table>
			
			<div class="search_wrap">
				<div class="search_area">
					    <select name="type">
              
                <option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목</option>
                <option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':'' }"/>>내용</option>
                <option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':'' }"/>>작성자</option>
                <option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':'' }"/>>제목 + 내용</option>
                <option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':'' }"/>>제목 + 작성자</option>
                <option value="TCW" <c:out value="${pageMaker.cri.type eq 'TCW'?'selected':'' }"/>>제목 + 내용 + 작성자</option>
          			  </select>   
				
					<input type="text" name="keyword" value="${pageMaker.cri.keyword}">
					<button>Search</button>
				</div>
			</div>
			
			
			<div class="pageInfo_wrap">
				<div class="pageInfo_area">
					<ul id="pageInfo" class="pageInfo">
					<!-- 이전페이지 버튼 -->
					<c:if test="${pageMaker.prev}">
						<li class="pageInfo_btn previous"><a href="${pageMaker.beginPage-1}">&lt</a></li>
					</c:if>
					
					<c:forEach var="num" begin="${pageMaker.beginPage}" end="${pageMaker.endPage}">
						<li class="pageInfo_btn ${pageMaker.cri.pageNum == num ? "active" : "" }"><a href="${num}">${num}</a></li>
					</c:forEach>
					<!-- 다음페이지 버튼 -->
					<c:if test="${pageMaker.next}">
						<li class="pageInfo_btn next"><a href="${pageMaker.endPage+1}">&gt</a></li>
					</c:if>
					</ul>
				</div>
			</div>
			
			<form id="moveForm" method="get">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
				<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
				<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
				<input type="hidden" name="type" value="${pageMaker.cri.type}">
			</form>
		</div>
		



		<script>
			$(document).ready(function(){
				let result = '<c:out value="${result}"/>';
				console.log(result);
				checkAlert(result);
				
				function checkAlert(result){
					if(result === ''){
						return;
					}
					
					if(result === 'enroll success'){
						alert("등록이 완료되었습니다.");
					}
					
					if(result === 'modify success'){
						alert("수정이 완료되었습니다.");
					}
					
					if(result === 'delete success'){
						alert("삭제가 완료되었습니다.");
					}
				}
			});
			
			let moveForm = $("#moveForm");
			
			$(".move").click(function(e){
				e.preventDefault();
				
				moveForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
				moveForm.attr("action","/board/get");
				moveForm.submit();
			});
			
			$(".pageInfo a").click(function(e){
				e.preventDefault();
				moveForm.find("input[name='pageNum']").val($(this).attr("href"));
				moveForm.attr("action","/board/list");
				moveForm.submit();
			});
			
			$(".search_area button").click(function(e){
				e.preventDefault();
				
				let type= $(".search_area select").val();
				let keyword = $(".search_area input[name='keyword']").val();
				
				if(!type){
					alert("검색 종류를 선택하세요.");
					return false;
				}
				
				if(!keyword){
					alert("키워드를 입력하세요.");
					return false;
				}
				
				moveForm.find("input[name='type']").val(type);
				moveForm.find("input[name='keyword']").val(keyword);
				moveForm.find("input[name='pageNum']").val(1);
				moveForm.submit();
			});
		
		</script>

</body>
</html>
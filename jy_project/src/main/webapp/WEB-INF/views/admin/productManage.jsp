<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/admin/header.jsp" %>
<link rel="stylesheet" href="/css/admin/commons.css">
<style>
table{
	border : 2px solid #16a085;
}
thead{
	background-color: #16a085;
}
.a_title{
	color:black;
}

</style>

        

        <div class="container-700">
        	<div class="row center">
           	<h2>상품관리 페이지</h2>
        </div>
        
        	<div class="row">
        		 <table border="1" class="auto">
                <thead>	
                <tr>
                    <th class="w-10">번호</th>
                    <th class="w-40">상품명</th>
                    <th class="w-40">상품가격</th>
                    <th class="w-10">상품수량</th> 
                 </tr>
                </thead>
             	<tbody>
             		<c:forEach items="${productDto}" var="productDto">
             		<tr>
             			<th>${productDto.productNo}</th>
             			<th>
             			<a class="a_title" href="/admin/productDetail?productNo=${productDto.productNo}">
             			${productDto.productName}</a>
             			</th>
             			<th>${productDto.productPrice}</th>
             			<th>${productDto.productStock}</th>
             		</tr>
             		</c:forEach>
             	</tbody>
            </table>
        	</div>
           
            <div class="row right">
            	<a class="form-btn neutral2" href="/admin/productEnroll">상품 등록</a>
            </div>
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
       
       <script>
       		$(document).ready(function(){
       			
       			let eResult = '<c:out value="${enroll_result}"/>';
       			
       			checkResult(eResult);
       			
       			function checkResult(result){
       				if(reslt === ''){
       					return;
       				}
       				alert("상품'"+eResult+"'을 등록하였습니다.");
       			}
       		});
       </script>
</body>
</html>
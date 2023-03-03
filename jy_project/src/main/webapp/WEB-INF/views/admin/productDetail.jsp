<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="../include/admin/header.jsp"%>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<link rel="stylesheet" href="/css/admin/commons.css">
<style>
	select{
	width: 100%;
    height: 35px;
    font-size: 20px;
    text-align-last: center;
    margin-left: 5px;
}

#result_card img{
		max-width: 100%;
	    height: auto;
	    display: block;
	    padding: 5px;
	    margin-top: 10px;
	    margin: auto;	
	}
</style>

	<div class="container-700">
		<div class="row center">
			<h2>상품 상세페이지</h2>
		</div>	
		<div class="row">
			<input name="productName" class="form-input w-100" value="${productDto.productName}" disabled>
		</div>
		<div class="row">
			<input name="productName" class="form-input w-100" value="${productDto.productPrice}" disabled>
		</div>
		<div class="row">
			<input name="productName" id="discount_interface" class="form-input w-100" value="${productDto.productDiscount}" disabled>
		</div>
		<div class="row">
			<input name="productName" class="form-input w-100" value="${productDto.productStock}" disabled>
		</div>
		<div class="row">
		<label>대분류</label>
		<select class="cate1" disabled>
			<option selected value="none">선택</option>
		</select>
		</div>
		<div class="row">
		<label>중분류</label>
		<select class="cate2" disabled>
			<option selected value="none">선택</option>
		</select>
		</div>
		<div class="row">
		<label>상품 이미지</label><br>
		<div id="uploadResult">
		
		</div>
		</div>
		<div class="row center">
			<a class="form-btn neutral2" href="/admin/productManage">목록으로</a>
			<a class="form-btn positive" href="/admin/productUpdate?productNo=${productDto.productNo}">수정하기</a>
		</div>
	</div>
	
	
	<script>
		$(document).ready(function(){
			/* 할인율 값 삽입 */
			let productDiscount = '<c:out value="${productDto.productDiscount}"/>' * 100;
			$("#discount_interface").attr("value",productDiscount);
			
			/* 카테고리 */
			let cateList = JSON.parse('${cateList}');
			
			let cate1Array = new Array();
			let cate2Array = new Array();
			let cate1Obj = new Object();
			let cate2Obj = new Object();
			
			// select 태그에 접근하기 위한 변수 선언
			let cateSelect1 = $(".cate1");
			let cateSelect2 = $(".cate2");
			
			
			/* 카테고리 배열 초기화 메서드 */
			function makeCateArray(obj,array,cateList,tier){
				for(let i = 0; i<cateList.length; i++){
					if(cateList[i].tier === tier){
						obj = new Object();
						
						obj.cateName = cateList[i].cateName;
						obj.cateCode = cateList[i].cateCode;
						obj.cateParent = cateList[i].cateParent;
						
						array.push(obj);
					}
				}
			}
			/* 배열 초기화 */
			makeCateArray(cate1Obj,cate1Array,cateList,1);
			makeCateArray(cate2Obj,cate2Array,cateList,2);
			
			let targetCate2 = '${productDto.productCateCode}';
			
			// 중분류
			for(let i = 0; i<cate2Array.length; i++){
				if(targetCate2 === cate2Array[i].cateCode){
					targetCate2 = cate2Array[i];
				}
			}
			
			for(let i = 0; i < cate2Array.length; i++){
				if(targetCate2.cateParent === cate2Array[i].cateParent){
					cateSelect2.append("<option value='"+cate2Array[i].cateCode+"'>" + cate2Array[i].cateName + "</option>");
				}
			}
			
			$(".cate2 option").each(function(i,obj){
				
				if(targetCate2.cateCode === obj.value){
					$(obj).attr("selected","selected");
				}
			});
			
			/* 이미지 정보 호출 */
			let productNo = '<c:out value="${productDto.productNo}"/>';
			let uploadReslut = $("#uploadResult");			
			
			$.getJSON("/admin/getAttachList", {productNo : productNo}, function(arr){	
				
				if(arr.length === 0){
					let str = "";
					str += "<div id='result_card'>";
					str += "<img src='/css/img/NoImage.png'>";
					str += "</div>";
					
					uploadReslut.html(str);	
				}
				
				let str = "";
				let obj = arr[0];	
				
				let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
				str += "<div id='result_card'";
				str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
				str += ">";
				str += "<img src='/admin/display?fileName=" + fileCallPath +"'>";
				str += "</div>";		
				
				uploadReslut.html(str);						
				
			});	
			
			
			// 대분류
			for(let i = 0; i<cate1Array.length; i++){
				if(targetCate2.cateParent === cate1Array[i].cateCode){
					targetCate1 = cate1Array[i];
				}
			}
			
			for(let i = 0; i<cate1Array.length; i++){
				if(targetCate1.cateParent === cate1Array[i].cateParent){
					cateSelect1.append("<option value='"+cate1Array[i].cateCode+"'>" + cate1Array[i].cateName + "</option>");

				}
			}
			

			$(".cate1 option").each(function(i,obj){
				
				if(targetCate1.cateCode === obj.value){
					$(obj).attr("selected","selected");
				}
			});
			
			/* 수졍 결과 */
			let updateResult = "${update_result}";
			if(updateResult == 1){
				alert("수정 완료");
			}
			
			
		
			
		});
		
		
		
	</script>
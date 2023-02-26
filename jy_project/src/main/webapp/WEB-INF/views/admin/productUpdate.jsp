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
</style>
		<form action="productUpdate" method="post">
		<input type="hidden" name="productNo" value="${productDto.productNo}">
	<div class="container-700">
		<div class="row center">
			<h2>상품 상세페이지</h2>
		</div>	
		<div class="row">
			<input name="productName" class="form-input w-100" value="${productDto.productName}">
		</div>
		<div class="row">
			<input name="productPrice" class="form-input w-100" value="${productDto.productPrice}">
		</div>
		<div class="row">
			<input name="productDiscount" id="discount_interface" class="form-input w-100" value="${productDto.productDiscount}">
		</div>
		<div class="row">
			<input name="productStock" class="form-input w-100" value="${productDto.productStock}">
		</div>
		<div class="row">
		<label>대분류</label>
		<select class="cate1">
			<option selected value="none">선택</option>
		</select>
		</div>
		<div class="row">
		<label>중분류</label>
		<select class="cate2" name="productCateCode">
			<option selected value="none">선택</option>
		</select>
		</div>
		<div class="row center">
			<a class="form-btn neutral2" href="/admin/productManage">목록으로</a>
			<button class="form-btn positive" type="submit">수정완료</button>
		</div>
	</div>
		</form>
	
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
			
			/* 중분류 <option> 태그 */
			$(cateSelect1).on("change",function(){
				let selectVal1 = $(this).find("option:selected").val();
				cateSelect2.children().remove();
				
				cateSelect2.append("<option value='none'>선택</option>");
				
				for(let i = 0; i<cate2Array.length; i++){
					if(selectVal1 === cate2Array[i].cateParent){
						cateSelect2.append("<option value='"+cate2Array[i].cateCode+"'>"+cate2Array[i].cateName+"</option>");
					}
				}
			});
			
			
			
			
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
			
			
		});
		
		
		
	</script>
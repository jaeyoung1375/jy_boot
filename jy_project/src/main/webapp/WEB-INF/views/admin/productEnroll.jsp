<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/admin/header.jsp"%>
<link rel="stylesheet" href="/css/admin/commons.css">
<script src="https://cdn.ckeditor.com/ckeditor5/36.0.1/classic/ckeditor.js"></script>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<style>
	/* ckeditor 높이 */
	.ck-content {
    height: 200px;
}
select{
	width: 100%;
    height: 35px;
    font-size: 20px;
    text-align-last: center;
    margin-left: 5px;
}
</style>
  
  
	<form id="enrollForm" action="/admin/productEnroll" method="post" autocomplete="off">
<div class="container-700 mt-50 mb-50">
	<div class="row center">
		<h1>상품 등록</h1>
	</div>
	<div class="row">
		<label>상품 이름</label>
		<input type="text" name="productName" class="form-input w-100">
	</div>
	<div class="row">
	<label>상품 가격</label>
		<input type="text" name="productPrice" class="form-input w-100">
	</div>
	<div class="row">
	<label>상품 수량</label>
		<input type="number" name="productStock" class="form-input w-100">
	</div>
	<div class="row">
	<label>상품 설명</label>
		<textarea class="form-input w-100" name="productDescription" id="productDescription"></textarea>
	</div>
	<div class="row">
	<label>대분류</label>
		<select class="cate1">
			<option selected value="none">선택</option>
		</select>
	</div>
	<div>
	<label>중분류</label>
		<select class="cate2" name="cateCode">
			<option selected value="none">선택</option>
		</select>
	</div>
	<div class="row right">
		<button class="form-btn positive" id="enrollBtn">등록</button>
	</div>
</div>
	</form>
	
<script>

	let enrollForm = $("#enrollForm");

	$("#enrollBtn").click(function(e){
		e.preventDefault();
		
		enrollForm.submit();
	});
	
	
	/* 위지윅 적용 */
		
		/* 상품 설명 */
		ClassicEditor
		.create(document.querySelector('#productDescription'))
		.catch(error=>{
			console.error(error);
		});
	
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
	

	$(document).ready(function(){
		console.log(cate1Array);
		console.log(cate2Array);
	});
	
	for(let i = 0; i<cate1Array.length; i++){
		cateSelect1.append("<option value='"+cate1Array[i].cateCode+"'>"+cate1Array[i].cateName+"</option>");
	}
	
	

</script>
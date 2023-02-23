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
.ck_warn{						/* 입력란 공란 경고 태그 */
	display: none;
    padding-top: 10px;
    text-align: center;
    color: #e05757;
    font-weight: 300;    
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
		<span class="ck_warn productName_warn">상품 이름을 입력해주세요.</span>
	</div>
	<div class="row">
	<label>상품 가격</label>
		<input type="text" name="productPrice" class="form-input w-100">
		<span class="ck_warn productPrice_warn">상품 가격을 입력해주세요.</span>
	</div>
	<div class="row">
	<label>상품 수량</label>
		<input type="number" name="productStock" class="form-input w-100">
		<span class="ck_warn productStock_warn">상품 수량을 입력해주세요.</span>
	</div>
	<div class="row">
	<label>상품 설명</label>
		<textarea class="form-input w-100" name="productDescription" id="productDescription"></textarea>
		<span class="ck_warn productDescription_warn">상품 설명을 입력해주세요.</span>
	</div>
	<div class="row">
	<label>대분류</label>
		<select class="cate1">
			<option selected value="none">선택</option>
		</select>
	</div>
	<div>
	<label>중분류</label>
		<select class="cate2" name="productCateCode">
			<option selected value="none">선택</option>
		</select>
		<span class="ck_warn productCateCode_warn">카테고리를 입력해주세요.</span>
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
		
		/* 체크 변수 */
		let produtNameCk = false;
		let productPriceCk = false;
		let productStockCk = false;
		let productDescriptionCk = false;
		let productCateCodeCk = false;
		
		/* 체크 대상 변수 */
		let productName = $("input[name='productName']").val();
		let productPrice = $("input[name='productPrice']").val();
		let productStock = $("input[name='productStock']").val();
		let productDescription = $("input[name='productDescription']").val();
		let productCateCode = $("select[name='productCateCode']").val();
		
		if(productName){
			$(".productName_warn").css("display","none");
			productNameCk = true;
		}else{
			$(".productName_warn").css("display","block");
			productNameCk = false;
		}
		
		if(productPrice){
			$(".productPrice_warn").css("display","none");
			productPriceCk = true;
		}else{
			$(".productPrice_warn").css("display","block");
			productPriceCk = false;
		}
		
		if(productStock){
			$(".productStock_warn").css("display","none");
			productStockCk = true;
		}else{
			$(".productStock_warn").css("display","block");
			productStockCk = false;
		}
		
		if(productDescription  != '<br data-cke-filler="true">'){
			$(".productDescription_warn").css("display","none");
			productDescriptionCk = true;
		}else{
			$(".productDescription_warn").css("display","block");
			productDescriptionCk = false;
		}
		
		if(productCateCode){
			$(".productCateCode_warn").css("display","none");
			productCateCodeCk = true;
		}else{
			$(".productCateCode_warn").css("display","block");
			productCateCodeCk = false;
		}
		
		
		if(productNameCk && productPriceCk && productStockCk && productDescriptionCk && productCateCodeCk){
			enrollForm.submit();
		}else{
			return false;
		}
		

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
	
	
	

</script>
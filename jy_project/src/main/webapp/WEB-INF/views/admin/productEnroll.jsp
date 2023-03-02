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
.step_val{						/* 할인 가격 문구 */
	display: block;
    padding-top: 5px;
    font-weight: 500;
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
	<label>상품 할인율</label>
	    <input id="discount_interface" maxlength="2" value="0" class="form-input w-100"> 
		<input type="hidden" name="productDiscount" value="0" class="form-input w-100">
		<span class="step_val">할인 가격 : <span class="span_discount"></span></span>
		<span class="ck_warn productDiscount_warn">1~99 사이의 숫자를 입력해주세요.</span>
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
	<div class="row">
		<label>상품 이미지</label>
		<input type="file" name="uploadFile" class="form-input" multiple>
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
		let discountCk = false;
		let productStockCk = false;
		let productDescriptionCk = false;
		let productCateCodeCk = false;
		
		/* 체크 대상 변수 */
		let productName = $("input[name='productName']").val();
		let productPrice = $("input[name='productPrice']").val();
		let productDiscount = $("#discount_interface").val();
		let productStock = $("input[name='productStock']").val();
		let productDescription = $("input[name='productDescription']").val();
		let productCateCode = $(".cate2").val();
		
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
		
		if(!isNaN(productDiscount)){ // isNan 메서드는 파라미터 값이 문자인경우 true를 반환
			$(".productDiscount_warn").css("display","none");
			discountCk = true;
		}else{
			$(".productDiscount_warn").css("display","block");
			discountCk = false;
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
		
		
		if(productNameCk && productPriceCk && discountCk && productStockCk && productDescriptionCk && productCateCodeCk){
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
	
	/* 할인율 input 설정 */
	$("#discount_interface").on("propertychange change keyup paste input",function(){
		
		let userInput = $("#discount_interface");
		let discountInput = $("input[name='productDiscount']");
		
		let discountRate = userInput.val(); // 사용자가 입력할 할인 값
		let sendDiscountRate = discountRate / 100; // 서버에 전송할 할인 값
		
		let goodsPrice = $("input[name='productPrice']").val(); // 원가
		let discountPrice = goodsPrice * (1-sendDiscountRate); // 할인가격
		
		if(!isNaN(discountRate)){
			$(".span_discount").html(discountPrice);		
			discountInput.val(sendDiscountRate);				
		}
		
	});
	
	$("input[name='productPrice']").on("propertychange change keyup paste input",function(){
		
		let userInput = $("#discount_interface");
		let discountInput = $("input[name='productDiscount']");
		
		let discountRate = userInput.val(); // 사용자가 입력할 할인 값
		let sendDiscountRate = discountRate / 100; // 서버에 전송할 할인 값
		
		let goodsPrice = $("input[name='productPrice']").val(); // 원가
		let discountPrice = goodsPrice * (1-sendDiscountRate); // 할인가격
		
		$(".span_discount").html(discountPrice);
	});
	
	/* 이미지 업로드 */
	$("input[type='file']").on("change",function(e){
		
		let formData = new FormData();
		
		let fileInput = $("input[name='uploadFile']");
		let fileList = fileInput[0].files;
		let fileObj = fileList[0];
		/*
		if(!fileCheck(fileObj.name, fileObj.size)){
			return false;
		}*/
		
		for(let i = 0; i<fileList.length; i++){
			formData.append("uploadFile",fileList[i]);
		}
		
		
		$.ajax({
			url: "/admin/uploadAjaxAction",
			processData : false, // 서버로 전송할 데이터를 쿼리스트링 형태로 변환할지 여부
			contentType : false, // 서버로 전송되는 데이터의 content-type
			data : formData, // 서버로 전송할 데이터
			type : "POST",  // 서버 요청 타입
			dataType : "json", // 서버로부터 반환받을 데이터 타입
			success : function(result){
					console.log(result);
			},
			error : function(result){
				alert("이미지 파일이 아닙니다.");
			}
		});
	});
	
	let regex = new RegExp("(.*?)\.(jpg|png)$");
	let maxSize = 1048576; // 1MB
	
	function fileCheck(fileName, fileSize){
		
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		if(!regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	}

	
	
	

</script>
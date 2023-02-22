<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/admin/header.jsp"%>
<link rel="stylesheet" href="/css/admin/commons.css">

	<form id="enrollForm" action="/admin/productEnroll" method="post" autocomplete="off">
<div class="container-700 mt-50 mb-50">
	<div class="row center">
		<h1>상품 등록</h1>
	</div>
	<div class="row">
		<input type="text" name="productName" class="form-input w-100">
	</div>
	<div class="row">
		<input type="text" name="productPrice" class="form-input w-100">
	</div>
	<div class="row">
		<input type="text" name="productStock" class="form-input w-100">
	</div>
	<div class="row">
		<input type="text" name="productDescription" class="form-input w-100">
	</div>
	<div class="row">
		<input type="text" name="productCateCode" class="form-input w-100">
	</div>
	<div class="row right">
		<button class="form-btn positive" id="enrollBtn">등록</button>
	</div>
</div>
	</form>
	
<script>
	$("#enrollBtn").click(function(e){
		e.preventDefault();
		
		enrollForm.submit();
	});
</script>
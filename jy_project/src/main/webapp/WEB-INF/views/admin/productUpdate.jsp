<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	#result_card {
		position: relative;
	}
	.imgDeleteBtn{
	    position: absolute;
	    top: 0;
	    right: 5%;
	    background-color: #ef7d7d;
	    color: wheat;
	    font-weight: 900;
	    width: 30px;
	    height: 30px;
	    border-radius: 50%;
	    line-height: 26px;
	    text-align: center;
	    border: none;
	    display: block;
	    cursor: pointer;	
	}
</style>
		<form action="productUpdate" method="post" id="updateForm">
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
		<div class="row">
			<label>상품 이미지</label>
		</div>
		<div class="row">
			<input type="file" id="fileItem" name="uploadFile" style="height:30px;">
			<div id="uploadResult">
			
			</div>
		</div>
		<div class="row center">
			<a class="form-btn neutral2" href="/admin/productManage">목록으로</a>
			<button class="form-btn positive" id="updateBtn">수정완료</button>
			<button class="form-btn negative" id="deleteBtn">삭 제</button>
		</div>
	</div>
		</form>
		<form id="moveForm" action="/admin/productDetail" method="get">
			<input type="hidden" name="productNo" value="${productDto.productNo}">
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
			
			
			/* 기존 이미지 정보 호출 */
			let productNo = '<c:out value="${productDto.productNo}"/>';
			let uploadReslut = $("#uploadResult");			
			
			$.getJSON("/admin/getAttachList", {productNo : productNo}, function(arr){	
				
				if(arr.length === 0){
					let str = "";
					str += "<div id='result_card'>";
					str += "<img src='/css/img/NoImage.png'>";
					str += "</div>";
					
					uploadReslut.html(str);
					return;
				}
				
				let str = "";
				let obj = arr[0];	
				
				let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
				str += "<div id='result_card'";
				str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
				str += ">";
				str += "<img src='/admin/display?fileName=" + fileCallPath +"'>";
				str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
				str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
				str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
				str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";
				str += "</div>";		
				
				uploadReslut.html(str);						
				
			});	
			
			/* 파일 삭제 메서드 */
			function deleteFile(){
				
				$("#result_card").remove();
			}
			
			/* 이미지 삭제 버튼 동작 */
			$("#uploadResult").on("click",".imgDeleteBtn", function(e){
				deleteFile();
			});
			
			/* 이미지 업로드 */
			$("input[type='file']").on("change",function(e){
				
				/* 이미지 존재 시 삭제 */
				if($("#result_card").length > 0){
					deleteFile();
				}
				
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
							showUploadImage(result);
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
			
			/* 이미지 출력 */
			function showUploadImage(uploadResultArr){
				
				/* 전달받은 데이터 검증 */
				if(!uploadResultArr || uploadResultArr.length == 0){return}
				
				let uploadResult = $("#uploadResult");
				
				let obj = uploadResultArr[0];
				
				let str = "";
				
				let fileCallPath = obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName;
				
				str += "<div id='result_card'>";
				str += "<img src='/admin/display?fileName=" + fileCallPath +"'>";
				str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
				str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
				str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
				str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";	
				str += "</div>";		
				
		   		uploadResult.append(str);     
			}
			
		
			
			
		});
		
		/* 수정 버튼 */
		$("#updateBtn").click(function(e){
			e.preventDefault();
			$("#updateForm").submit();
			
		});
		
		
		/* 삭제 버튼 */
		$("#deleteBtn").click(function(e){
			e.preventDefault();
			let moveForm = $("#moveForm");
			moveForm.find("input").remove();
			moveForm.append('<input type="hidden" name="productNo" value="${productDto.productNo}">');
			moveForm.attr("action","/admin/productDelete");
			moveForm.attr("method","post");
			
			moveForm.submit();
			
		});
		
		
		
		
		
		
	</script>
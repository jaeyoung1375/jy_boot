<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


	<form action="/board/enroll" method="post">
	  <div class="container-300">
        <div class="row center">
            <h2>게시판 등록</h2>
        </div>
        <div class="row">
            <input type="text" name="boardTitle" placeholder="제목" class="form-input w-100">
        </div>
        <div class="row">
            <input type="text" name="boardTitle" placeholder="내용" class="form-input w-100">
        </div>
        <div class="row">
            <input type="text" name="boardTitle" placeholder="작성자" class="form-input w-100">
        </div>
        <div class="row">
            <button class="form-btn positive w-100">등록</button>
        </div>
    </div>
	</form>

</body>
</html>
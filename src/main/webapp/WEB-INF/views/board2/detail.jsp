<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Detail view</title>
<script src="<c:url value="/resources/js/jquery-1.9.1.min.js"/>"></script>
	<script src="<c:url value="/resources/js/jquery.ui.widget.js"/>"></script>
	<script src="<c:url value="/resources/js/jquery.iframe-transport.js"/>"></script>
	<script src="<c:url value="/resources/js/jquery.fileupload.js"/>"></script>
	<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
	<script>
$(document).ready(function(){
   $("#replyBtn").on("click", function(){
	  var param = $("form").serialize();	// 넘길 정보
	  var url = $("form").attr("action");	// 처리할 URL
	  console.log(url+"?"+param);
	  
	  /*
	  * AJAX 문법으로 처리
	  */
	  $.ajax({
		  url : url,
		  data: param,
		  type: "POST",
		  dataType: "json"
	  }).done(function(json){
		 console.log(json);	// 작성 완료
		 
		 if(json.id > 1){ // 글작성 성공
			 window.location.replace("/board2");
		 }
	  });
   });
   $("#deleteBtn").on("click", function(){
		  
		  /*
		  * AJAX 문법으로 처리
		  */
		  $.ajax({
			  url : "/board2/delete",
			  data: {'id':'${board.id}'},
			  type: "POST",
			  dataType: "json"
		  }).done(function(){
				// console.log("done:"+ data);	// 작성 완료
				 
				window.location.replace("/board2");
				 
			  });
	});
   
});
</script>

</head>
<body>
					<table>
						<thead>
							<tr>
								<td>Board Detail</td>
								<td>
									<a href="<c:url value="/board2/list" />">
										Home
									</a>
								</td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									${board.id }
								</td>
								<td>
									${board.text }
								</td>
								<td>${board.writerName}</td>
								<td>${board.userLevel}</td>
								<td>${board.updatedTime}</td>
								<td>${board.accessLevel}</td>
							</tr>
							<tr>
								<td>
									<input type="button" value="글삭제" id="deleteBtn"/>
								</td>
							</tr>
							
							<tr>
								<td>--reply--</td>
							</tr>
						<c:forEach items="${reply }" var="item">
							<tr>
								<td>${item.id}</td>
								<td>${item.text}</td>
								<td>${item.writerId}</td>
								<td>${item.createdTime}</td>
							</tr>
						</c:forEach>
							
							
						
						</tbody>
					</table>
					
					<form action="/board2/insertReply">
					<table>
						<colgroup>
							<col width="30%">
							<col width="70%">
						</colgroup>
						<thead>
							<tr>
								<th colspan="2">
									답글쓰기								
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>글쓴이Id</td>
								<td><input type="text" name="writerId" placeholder="글쓴이Id" required/></td>
							</tr>
							<tr>
								<td>내용</td>
								<td><input type="text" name="text" placeholder="내용" required/></td>
							</tr>
							<tr>
								<td>글상태</td>
								<td><input type="text" name="status" placeholder="글상태" required/></td>
							</tr>
							
							
							
						</tbody>
					</table>
					<input type="hidden" value="${board.id }" name="boardId">
					<input type="button" value="답글쓰기" id="replyBtn"/>
   				</form>
					
			</body>
</html>
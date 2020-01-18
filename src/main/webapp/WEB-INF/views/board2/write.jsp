<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<c:set var="baseUrl" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="<c:url value="/resources/css/dropzone.css"/>" type="text/css" rel="stylesheet" />
	<link rel="stylesheet" type="text/css" media="all" href="<c:url value="/resources/css/table.css"/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/style.css"/>" />
	<script src="<c:url value="/resources/js/jquery-1.9.1.min.js"/>"></script>
	<script src="<c:url value="/resources/js/jquery.ui.widget.js"/>"></script>
	<script src="<c:url value="/resources/js/jquery.iframe-transport.js"/>"></script>
	<script src="<c:url value="/resources/js/jquery.fileupload.js"/>"></script>
	<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
	<script>
$(document).ready(function(){
   $("#submitBtn").on("click", function(){
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
   
});
</script>

</head>
<body>
	<div class="wrap">
		<c:import url="/inc/header"></c:import>
		<div class="container_wrap">
			<div class="container">
				<form action="/board2/insert">
					<table>
						<colgroup>
							<col width="30%">
							<col width="70%">
						</colgroup>
						<thead>
							<tr>
								<th colspan="2">
									글쓰기								
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>글쓴이Id</td>
								<td><input type="text" name="creatorId" placeholder="글쓴이Id" required/></td>
							</tr>
							<tr>
								<td>환자번호</td>
								<td><input type="text" name="patientId" placeholder="환자번호" required/></td>
							</tr>
							<tr>
								<td>status</td>
								<td><input type="text" name="status" placeholder="글상태" required/></td>
							</tr>
							<tr>
								<td>text</td>
								<td><input type="text" name="text" placeholder="내용"/></td>
							</tr>
							<tr>
								<td>type</td>
								<td><input type="text" name="type" placeholder="종류"/></td>
							</tr>
							<tr>
								<td>accessLevel</td>
								<td><input type="text" name="accessLevel" placeholder="열람등급"/></td>
							</tr>
							
							
						</tbody>
					</table>
						<input id="fileupload" type="file" name="files[]" 
						accept="image/x-png,image/gif,image/jpeg" data-url="<c:url value="/uploadPhoto"/>" multiple>
				    <div id="progress">
				        <div style="width: 0%;"></div>
				    </div>
				    <table id="uploaded-files">
				    	<thead>
				    		<tr>
								<th colspan="3">사진업로드</th>
							</tr>
						</thead>
						<tbody>
					        <tr>
					            <th>파일명</th>
					            <th>Size</th>
					            <th>Type</th>
					        </tr>
				        </tbody>
				    </table>
					<input type="hidden" value="<c:url value="/upload/get"/>" name="uploadUrl">
					<input type="hidden" value="<c:url value="/upload/clear"/>" name="clearUrl">
					<input type="button" value="전송" id="submitBtn"/>
   				</form>
	</div>
	</div>
	</div>
	
	<script type="text/javascript">
	$(function () {
	    $('#fileupload').fileupload({
	    	imageCrop: true,
	        dataType: 'json',
	        done: function (e, data) {
	        	var url = $("input[name='uploadUrl']").val();
	        	
	        	
	            $("#uploaded-files tr:has(td)").remove();
	            $.each(data.result, function (index, file) {
	                $("#uploaded-files").append(
	                        $('<tr/>')
	                        .append($('<td/>').text(file.fileName))
	                        .append($('<td/>').text(file.fileSize))
	                        .append($('<td/>').text(file.fileType))
	                        )//end $("#uploaded-files").append()
	            }); 
	        },
	 		
	        progressall: function (e, data) {
	            var progress = parseInt(data.loaded / data.total * 100, 10);
	            $('#progress .bar').css(
	                'width',
	                progress + '%'
	            );
	        },
	 
	        dropZone: $('#dropzone')
	    });
	});
	
	</script>
</body>
</html>
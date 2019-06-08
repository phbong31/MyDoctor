<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="baseUrl" value="${pageContext.request.contextPath}"></c:set>
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title>사진올리기</title>
	
	<link href="<c:url value="/resources/css/bootstrap.css"/>" type="text/css" rel="stylesheet" />
	<link href="<c:url value="/resources/css/dropzone.css"/>" type="text/css" rel="stylesheet" />
	<link rel="stylesheet" type="text/css" media="all" href="<c:url value="/resources/css/table.css"/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/style.css"/>" />
	
</head>
<body>
	<div class="wrap">
		<c:import url="/inc/header"></c:import>
		<div class="container_wrap">
			<div class="container">
				<form id="write" action="<c:url value="/photoInfo/insert"/>" method="post">
					<table>
						<colgroup>
							<col width="30%">
							<col width="70%">
						</colgroup>
						<thead>
							<tr>
								<th colspan="2">
									사진정보 업로드								
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>등록번호</td>
								<td><input type="text" name="patientId" placeholder="등록번호" required/></td>
							</tr>
							<tr>
								<td>주치의</td>
								<td><input type="text" name="doctor" placeholder="주치의" required/></td>
							</tr>
							<tr>
								<td>등록담당자</td>
								<td><input type="text" name="uploader" placeholder="등록담당자" value="${user.username }" required/></td>
							</tr>
							<tr>
								<td>분류</td>
								<td><input type="text" name="classification" placeholder="분류"/></td>
							</tr>
							<tr>
								<td>촬영일</td>
								<td><input type="text" name="date" placeholder="촬영일" value="${today }"/></td>
							</tr>
							<tr>
								<td>코멘트</td>
								<td><input type="text" name="comment" placeholder="코멘트"/></td>
							</tr>
							
						</tbody>
					</table>
					<input id="fileupload" type="file" name="files[]" 
						accept="image/x-png,image/gif,image/jpeg" data-url="<c:url value="/upload"/>" multiple>
				    <div id="progress">
				        <div style="width: 0%;"></div>
				    </div>
				    <table id="uploaded-files">
				    	<colgroup>
				    		<col width="25%">
				    		<col width="25%">
				    		<col width="25%">
				    		<col width="25%">
				    	</colgroup>
				    	<thead>
				    		<tr>
								<th colspan="4">사진업로드</th>
							</tr>
						</thead>
						<tbody>
					        <tr>
					            <th>파일명</th>
					            <th>Size</th>
					            <th>Type</th>
					            <th></th>
					        </tr>
				        </tbody>
				    </table>
					<input type="hidden" value="<c:url value="/upload/get"/>" name="uploadUrl">
					<input type="button" value="글작성" onclick="javascript:insertBoard();">
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	$(function () {
	    $('#fileupload')
	    	.fileupload({
		        dataType: 'json',
		        disableImageResize: /Android(?!.*Chrome)|Opera/
		            .test(window.navigator && navigator.userAgent),
		        imageMaxWidth: 100,
		        imageMaxHeight: 100,
		        previewCrop : true
	    	}).on('fileuploadadd', function (e, data) {
		        	var url = $("input[name='uploadUrl']").val();
		        	
		            // $("#uploaded-files tr:has(td)").remove();
		            $.each(data.files, function (index, file) {
		            	// console.log(file);
		                $("#uploaded-files").append(
		                        $('<tr/>')
		                        .append($('<td/>').text(file.name))
		                        .append($('<td/>').text(file.size))
		                        .append($('<td/>').text(file.type))
		                        .append($('<td/>').html(
		                        		"<input type='button' value='삭제' onclick='deleteThis("+index+")'/>"
		                        		+
		                        		"<input type='hidden' value='" + file.fileUri + "' name='fileUri'/>"
		                        		))
		                        )//end $("#uploaded-files").append()
		            }); 
		    }).on('progressall', function (e, data) {
	            var progress = parseInt(data.loaded / data.total * 100, 10);
	            console.log("progress: " + progress);
	            
	            $('#progress .bar').css(
	                'width',
	                progress + '%'
	            );
	        }).on('fileuploaddone', function (e, data) {
	        	console.log(data.result);
	            $.each(data.result.files, function (index, file) {
	            	console.log("index: " + index);
	                if (file.url) {
	                    var link = $('<a>')
	                        .attr('target', '_blank')
	                        .prop('href', file.url);
	                    
	                    console.log(link);
	                    //$(data.context.children()[index])
	                      //  .wrap(link);
	                } else if (file.error) {
	                    var error = $('<span class="text-danger"/>').text(file.error);
	                    $(data.context.children()[index])
	                        .append('<br>')
	                        .append(error);
	                }
	            });
	        }).prop('disabled', !$.support.fileInput)
        .parent().addClass($.support.fileInput ? undefined : 'disabled');
	    
	});
	function insertBoard(){
		$("#write").submit();
	}
	</script>
	<script src="<c:url value="/resources/js/jquery-1.9.1.min.js"/>"></script>
	<script src="<c:url value="/resources/js/jquery.ui.widget.js"/>"></script>
	<script src="<c:url value="/resources/js/jquery.iframe-transport.js"/>"></script>
	<script src="<c:url value="/resources/js/jquery.fileupload.js"/>"></script>
	<!-- The Load Image plugin is included for the preview images and image resizing functionality -->
	<script src="https://blueimp.github.io/JavaScript-Load-Image/js/load-image.all.min.js"></script> 
	<!-- The File Upload processing plugin -->
	<script src="<c:url value="/resources/js/jquery.fileupload-process.js"/>"></script>
	<!-- The File Upload image preview & resize plugin -->
	<script src="<c:url value="/resources/js/jquery.fileupload-image.js"/>"></script>
	<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
</body>
</html>
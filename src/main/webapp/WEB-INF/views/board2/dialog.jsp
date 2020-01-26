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
   <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css">
    <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>

	
<script>    
        //$(document.ready(function(){ .. });

        $(function(){
            //$("#dialog").dialog();
            $("#dialog").dialog({
                autoOpen:false, //자동으로 열리지않게
                position:[100,200], //x,y  값을 지정
                //"center", "left", "right", "top", "bottom"
                modal:true, //모달대화상자
                resizable:false, //크기 조절 못하게
                
                buttons:{
                    "확인":function(){
                        $(this).dialog("close");
                    },"취소":function(){
                        $(this).dialog("close");
                    }
                }
            });

            //창 열기 버튼을 클릭했을경우
            $("#btn").on("click",function(){
                $("#dialog").dialog("open"); //다이얼로그창 오픈                
            });
        });
    </script>

</head>
<body>

<input type="button" id="btn" value="창 열기"/>

<div id="dialog" title="공지사항">
    java 초급<br>
    java 중급<br>
    java 고급<br>
    강좌가 새롭게 업로드되었습니다.
</div>


</body>
</html>
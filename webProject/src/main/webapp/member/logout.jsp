<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jsp3/logout.jsp</title>
</head>
<body>
<h1>jsp3/logout.jsp</h1>
<%
//세션전체 기억장소 삭제
session.invalidate();
// 로그아웃, main.jsp이동
%>
<script type="text/javascript">
	alter("로그아웃");
	location.href="main.jsp";
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jsp1/login.jsp</title>
</head>
<body>
<h1>jsp1/login.jsp</h1>
<form action="loginPro.jsp" method="get" name="fr">
아이디 : <input type="text" name="id"><br>
비밀번호 : <input type="password" name="pass"><br>
<div id="divmsg"></div><br>
<input type="submit" value="로그인">
</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--     jsp페이지 설정  -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jsp1/form4.jsp</title>
</head>
<body>
<h1>jsp1/form4.jsp</h1>
<!-- html주석 -->
<%-- <%jsp주석%> --%>
<%
// java 주석  ctrl+shift+c
/* java 	 ctrl+shift+/
여러줄 
주석 */ 
%>
<form action="pro4.jsp" method="get">
아이디 : <input type="text" name="id"><br>
비밀번호 : <input type="password" name="pass"><br>
이름 : <input type="text" name="name"><br>
나이 : <input type="text" name="age"><br>
성별 : <input type="radio" name="gender" value="남">남성
	  <input type="radio" name="gender" value="여">여성<br>
취미 : <input type="checkbox" name="hobby" value="여행">여행
      <input type="checkbox" name="hobby" value="게임">게임
      <input type="checkbox" name="hobby" value="축구">축구<br>
등급 : <select name="grade">
		<option value="1등급">1등급</option>
		<option value="2등급">2등급</option>
		<option value="3등급">3등급</option>
	 </select><br>
메모 : <textarea name="memo" rows="10" cols="20"></textarea>
<input type="submit" value="전송">
</form>
</body>
</html>
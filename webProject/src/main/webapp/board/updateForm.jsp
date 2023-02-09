<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board/updateForm.jsp</title>
</head>
<body>
<%
//request에 저장된 num 파라미터값 가져오기
int num=Integer.parseInt(request.getParameter("num"));
//BoardDAO 객체생성
BoardDAO dao=new BoardDAO();
//리턴할형 BoardDTO getBoard(int num) 메서드 정의
//BoardDTO dto = dao.getBoard(num) 메서드 호출
BoardDTO dto=dao.getBoard(num);
%>
<h1>글수정</h1>
<form action="updatePro.jsp" method="post">
<input type="hidden" name="num" value="<%=dto.getNum() %>">
<table border="1">
<tr><td>글쓴이</td>
	<td><input type="text" name="name" value=<%=dto.getName() %> readonly></td></tr>
<tr><td>글제목</td>
	<td><input type="text" name="subject" value=<%=dto.getSubject() %>></td></tr>
<tr><td>글내용</td>
	<td><textarea name="content" rows="10" cols="20"><%=dto.getContent()%></textarea></td></tr>	
<tr><td colspan="2"><input type="submit" value="글수정"></td></tr>
</table>
</form>
</body>
</html>
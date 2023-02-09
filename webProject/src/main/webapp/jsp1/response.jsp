<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jsp1/response.jsp</title>
</head>
<body>
<h1>jsp1/response.jsp</h1>
<%
// 자바내장객체 HttpServletResponse
// 웹어플리케이션서버 => response 객체생성 기억장소 할당
// 서버에서 처리한 결과(html)를 저장하는 내장객체
// 메서드() setHeader() addCookie() setContentType()
//        sendReadirect()

// 서버에서 사용자 http Header값을 변경
// reponse.setHeader("user-agent", "크롬");
// 서버에서 사용자 컴퓨터에 문자값을 저장
// response.addCookie("쿠키값");
// 서버에서 사용자 내용 타입 변경
// response.setContentType("text/html; charset=UTF-8");

// response.jsp 내용을 전달하고 바로 request.jsp 페이지로 이동 (하이퍼링크)
response.sendRedirect("request.jsp");
%>
</body>
</html>
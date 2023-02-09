<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jsp2/updatePro.jsp</title>
</head>
<body>
<h1>jsp2/updatePro.jsp</h1>
<%
//폼에서 입력한 내용이 서버에 전달 => request 내장객체 저장
//request 한글처리
request.setCharacterEncoding("utf-8");
// request 태그이름에 해당하는 값을 가져오기 => 변수에 저장
int num=Integer.parseInt(request.getParameter("num"));
String name=request.getParameter("name");

//1단계 JDBC안에 있는 Driver 프로그램 불러오기
Class.forName("com.mysql.cj.jdbc.Driver") ;
//2단계 Driver 프로그램 이용해서 디비연결
String dbUrl="jdbc:mysql://localhost:3306/jspdb1";
String dbUser="root";
String dbPass="1234";
Connection con=DriverManager.getConnection(dbUrl, dbUser, dbPass);

// 3단계 SQL구문 만들어서 실행할 준비(update)
// String sql="update student set name='홍길자' where num =1";
String sql="update student set name=? where num =?";
PreparedStatement pstmt=con.prepareStatement(sql);
//? 채워넣기
pstmt.setString(1, name); //set 문자열(1번째 물음표, 값 name)
pstmt.setInt(2, num);  //set 정수형 (2번째 물음표, 값 num)

// 4단계 SQL구문을 실행(insert,update,delete)
pstmt.executeUpdate();
%>
수정성공 <%=pstmt %>
</body>
</html>


<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jsp3/list.jsp</title>
</head>
<body>
<h1>jsp3/list.jsp</h1>
<%
//1단계 JDBC안에 있는 Driver 프로그램 불러오기
Class.forName("com.mysql.cj.jdbc.Driver") ;
//2단계 Driver 프로그램 이용해서 디비연결
String dbUrl="jdbc:mysql://localhost:3306/jspdb1";
String dbUser="root";
String dbPass="1234";
Connection con=DriverManager.getConnection(dbUrl, dbUser, dbPass);
//3단계 SQL구문 만들어서 실행할 준비(select)
String sql="select * from members";
PreparedStatement pstmt=con.prepareStatement(sql);
//4단계 SQL구문을 실행(select) => 결과 저장
ResultSet rs=pstmt.executeQuery();
%>
<table border="1">
<tr><td>아이디</td><td>비밀번호</td><td>이름</td><td>가입날짜</td></tr>
<%
//5단계	//조건이 true 실행문=> 다음행 데이터 있으면 true =>  열접근 => 출력
while(rs.next()){
	%>
<tr><td><%=rs.getString("id") %></td>
    <td><%=rs.getString("pass") %></td>
    <td><%=rs.getString("name") %></td>
    <td><%=rs.getTimestamp("date") %></td></tr>	
	<%
}
%>
</table>
</body>
</html>




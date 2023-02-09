<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jsp2/selectPro.jsp</title>
</head>
<body>
<h1>jsp2/selectPro.jsp</h1>
<%
// request 태그이름에 해당하는 값을 가져오기 => 변수에 저장
int num=Integer.parseInt(request.getParameter("num"));

//1단계 JDBC안에 있는 Driver 프로그램 불러오기
Class.forName("com.mysql.cj.jdbc.Driver") ;
//2단계 Driver 프로그램 이용해서 디비연결
String dbUrl="jdbc:mysql://localhost:3306/jspdb1";
String dbUser="root";
String dbPass="1234";
Connection con=DriverManager.getConnection(dbUrl, dbUser, dbPass);
//3단계 SQL구문 만들어서 실행할 준비(select)
String sql="select * from student where num=?";
PreparedStatement pstmt=con.prepareStatement(sql);
pstmt.setInt(1, num);
//4단계 SQL구문을 실행(select) => 결과 저장
ResultSet rs=pstmt.executeQuery();
//5단계 결과를 출력, 데이터 담기 (select)
%>

<table border="1">
<tr><td>학생번호</td><td>학생이름</td></tr>
<%
if(rs.next()){
	%>
	<tr><td><%=rs.getInt("num") %></td><td><%=rs.getString("name") %></td></tr>
	<%
}
%>

</table>
</body>
</html>
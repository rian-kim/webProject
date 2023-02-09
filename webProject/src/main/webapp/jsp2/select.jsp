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
<title>jsp2/select.jsp</title>
</head>
<body>
<h1>jsp2/select.jsp</h1>
<%
//1단계 JDBC안에 있는 Driver 프로그램 불러오기
Class.forName("com.mysql.cj.jdbc.Driver") ;
//2단계 Driver 프로그램 이용해서 디비연결
String dbUrl="jdbc:mysql://localhost:3306/jspdb1";
String dbUser="root";
String dbPass="1234";
Connection con=DriverManager.getConnection(dbUrl, dbUser, dbPass);
//3단계 SQL구문 만들어서 실행할 준비(select)
String sql="select * from student";
PreparedStatement pstmt=con.prepareStatement(sql);

//4단계 SQL구문을 실행(select) => 결과 저장
// SQL구문을 실행(select) => 결과 저장 내장객체 생성
// java.sql.ResultSet 자바내장객체
// import="java.sql.ResultSet" => 위치 지정
ResultSet rs=pstmt.executeQuery();
//5단계 결과를 출력, 데이터 담기 (select)
// rs 접근하는 메서드  next() 다음행, previous() 이전행
//                  last() 마지막행, first() 첫번째행
// next() 다음행 => 리턴값 데이터 있으면 true/ 데이터 없으면 false
// out.println(rs.next()); // 다음행 첫번째 행 => 데이터 있음 true
// out.println(rs.next()); // 다음행 두번째 행 => 데이터 있음 true
// out.println(rs.next()); // 다음행 세번째 행 => 데이터 있음 true
// out.println(rs.next()); // 다음행 네번째 행 => 데이터 없음 false
// while(rs.next()){
// 	//조건이 true 실행문=> 다음행 데이터 있으면 true =>  열접근
// 		out.println(rs.getInt(1));	// 1열  num열
// 		out.println(rs.getString(2)); //2열 name열
// 		out.println("<br>");
// }
%>
<table border="1">
<tr><td>학생번호</td><td>학생이름</td></tr>
<%
while(rs.next()){
	%>
	<tr><td><%=rs.getInt("num") %></td><td><%=rs.getString("name") %></td></tr>
	<%
}
%>

</table>
</body>
</html>



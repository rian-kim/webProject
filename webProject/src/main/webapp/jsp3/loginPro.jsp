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
<title>jsp3/loginPro.jsp</title>
</head>
<body>
<h1>jsp3/loginPro.jsp</h1>
<%
//폼에서 입력한 내용이 서버에 전달 => request 내장객체 저장
//request 태그이름에 해당하는 값을 가져오기 => 변수에 저장
String id=request.getParameter("id");
String pass=request.getParameter("pass");

//1단계 JDBC안에 있는 Driver 프로그램 불러오기
Class.forName("com.mysql.cj.jdbc.Driver") ;
//2단계 Driver 프로그램 이용해서 디비연결
String dbUrl="jdbc:mysql://localhost:3306/jspdb1";
String dbUser="root";
String dbPass="1234";
Connection con=DriverManager.getConnection(dbUrl, dbUser, dbPass);
// 3단계 SQL구문 만들어서 실행할 준비(select    where id=? and pass=?)
String sql="select * from members where id=? and pass=?";
PreparedStatement pstmt=con.prepareStatement(sql);
pstmt.setString(1, id);
pstmt.setString(2, pass);
//4단계 SQL구문을 실행(select) => 결과 저장
ResultSet rs=pstmt.executeQuery();
//5단계 결과를 출력, 데이터 담기 (select)
// if next() 다음행 => 리턴값 데이터 있으면 true => 아이디 비밀번호 일치
//                 => 세션값 생성 "id",id , main.jsp 이동
//                         데이터 없으면 false => 아이디 비밀번호 틀림
//                 => script   "아이디 비밀번호 틀림" 뒤로이동
if(rs.next()){
	//next() 다음행 => 리턴값 데이터 있으면 true => 아이디 비밀번호 일치
    // => 세션값 생성 "id",id(페이지 상관없이 값을 유지) , main.jsp 이동
		session.setAttribute("id", id);
        response.sendRedirect("main.jsp");
}else{
	//next() 다음행 =>       데이터 없으면 false => 아이디 비밀번호 틀림
    // 	           => script   "아이디 비밀번호 틀림" 뒤로이동
    %>
    <script type="text/javascript">
		alert("아이디 비밀번호 틀림");
		history.back();
    </script>
    <%
}
%>
</body>
</html>




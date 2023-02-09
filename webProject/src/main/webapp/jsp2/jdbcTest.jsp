<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jsp2/jdbcTest.jsp</title>
</head>
<body>
<h1>jsp2/jdbcTest.jsp</h1>
<%
// JDBC(Java DataBase Connector) 
// => mysql-connector-j-8.0.31.jar  프로그램 설치
// 이클립스 => src - main - webapp - WEB-INF - lib 폴더에 넣기

// 1단계 JDBC안에 있는 Driver 프로그램 불러오기
// java.lang.Class 자바내장객체
// java.lang 기본폴더 => 자동으로 경로 인식
// JDBC 프로그램 안에 => com폴더 mysql폴더 cj폴더 jdbc폴더 Driver.class파일
Class.forName("com.mysql.cj.jdbc.Driver") ;

// 2단계 Driver 프로그램 이용해서 디비연결
// java.sql.DriverManager 자바내장객체 => Driver 프로그램 이용해서 디비연결
// import="java.sql.DriverManager" => 경로 설정
String dbUrl="jdbc:mysql://localhost:3306/jspdb1";
String dbUser="root";
String dbPass="1234";
// 디비연결해서 연결정보를 저장하는 변수 (Connection)
// java.sql.Connection 자바내장객체
// import="java.sql.Connection" => 경로 설정
Connection con=DriverManager.getConnection(dbUrl, dbUser, dbPass);
%>
연결성공 <%=con %>
</body>
</html>



<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// board/writePro.jsp
// request 한글처리
request.setCharacterEncoding("utf-8");
// requst name, subject, content 가져와서 변수에 저장
String name=request.getParameter("name");
String subject=request.getParameter("subject");
String content=request.getParameter("content");
int readcount=0;
Timestamp date=new Timestamp(System.currentTimeMillis());

// 패키지 board 파일 BoardDTO
// 멤버변수 num, name, subject, content, readcount, date
// set get 메서드 만들기

// BoardDTO 객체생성
BoardDTO dto=new BoardDTO();
// set 메서드 호출해서 값 저장
dto.setName(name);
dto.setSubject(subject);
dto.setContent(content);
dto.setReadcount(readcount);
dto.setDate(date);

// BoardDAO 객체생성
// 리턴할형없음 insertBoard(BoardDTO dto) 메서드 정의
// BoardDAO 객체생성
BoardDAO dao=new BoardDAO();
// insertBoard(dto) 메서드 호출 => pstmt.setInt(1, 1);
dao.insertBoard(dto);

// 글목록 list.jsp
response.sendRedirect("list.jsp");
%>
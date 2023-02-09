<%@page import="board.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board/list.jsp</title>
</head>
<body>
<%
//BoardDAO 객체생성
BoardDAO dao=new BoardDAO();
//한 페이지레 보여줄 글개수 설정
int pageSize=10;
//현 페이지 번호 가져오기 => 페이지번호가 없으면 1페이지 설정
//http://localhost:8080/webProject/board/list.jsp
//http://localhost:8080/webProject/board/list.jsp?pageNum=1
String pageNum=request.getParameter("pageNum");
if(pageNum==null){
	//=>페이지번호가 없으면 1페이지 설정
	pageNum="1";
}
// pageNum => 숫자변경
int currentPage=Integer.parseInt(pageNum);
// 시작하는 행번호 구하기
// pageNum(currentPage) pageSize => startRow
//	1					10		=>	->	(1-1)*10+1=>0*10+1=>0+1=>1~10
//	2					10		=>	->	(2-1)*10+1=>1*10+1=>10+1=>11~10
//	3					10		=>	->	(3-1)*10+1=>2*10+1=>20+1=>21~10
int startRow=(currentPage-1)*pageSize+1;
// 끝나는 행번호 구하기
// startRow	pageSize	=>		endRow
//		1		10		=>	1+10-1	=>10
//		1		10		=>	11+10-1	=>20
//		1		10		=>	21+10-1	=>30
int endRow =startRow+pageSize-1;

// select * from board order by num desc limit 시작행-1, 몇개
//리턴할형 ArrayList<MemberDTO> getMemberList(int startRow, int pageSize) 메서드 정의
//ArrayList<BoardDTO> boardList =dao.getBoardList(startRow,pageSize) 메서드 호출
ArrayList<BoardDTO> boardList =dao.getBoardList(startRow,pageSize);
%>
<h1>board/list.jsp</h1>
<h1><a href="writeForm.jsp">글쓰기</a></h1>
<table border="1">
<tr><td>글번호</td><td>글쓴이</td><td>글제목</td>
	<td>글쓴날짜</td><td>조회수</td></tr>
<%
//배열 접근 = for
for(int i=0;i<boardList.size();i++){
	// 배열 한 칸에 내용 가져오기 => BoardDTO 저장 => 출력
	BoardDTO dto=boardList.get(i);
	%>
	<tr><td><%=dto.getNum() %></td>
	<td><%=dto.getName() %></td>
	<td><a href="content.jsp?num=<%=dto.getNum() %>"><%=dto.getSubject() %></a></td>
	<td><%=dto.getDate() %></td>
	<td><%=dto.getReadcount() %></td></tr>
	<%
}
%>
</table>
<%
// 한 화면에 보여줄 페이지 개수 설정
int pageBlock=10;
// 시작하는 페이지 번호 구하기
// currentPage	pageBlock	=>		startPage
//	1~10(0~9)		10		=>		(-1)/10*10+1=>0*10+1=>0+1=>1
//	11~10(10~19)	10		=>		(-1)/10*10+1=>1*10+1=>10+1=>11
//	21~10(20~29)	10		=>		(-1)/10*10+1=>2*10+1=>20+1=>21

int startPage=(currentPage-1)/pageBlock*pageBlock+1;
// 끝나는 페이지 번호 구하기
// startPage pageBlock	=>	endPage
//		1		10		=>		1+10-1=>10
//		11		10		=>		11+10-1=>20
//		21		10		=>		21+10-1=>30
int endPage=startPage+pageBlock-1;
// 전체글 개수 select count(*) from board
// int 리턴할형 getBoardCount() 메서드 정의
int count = dao.getBoardCount();
// 끝나는 페이지(endPage) = 10 =< 전체페이지(pageCount) = 2
// 전체페이지(pageCount) 구하기 
// => 전체글의 개수 13 /글개수 10 => 1 페이지 + (0.3 글 남아있으면 1페이지 추가)
// 
int pageCount=count/pageSize+(count%pageSize==0?0:1);
if(endPage > pageCount){
	endPage = pageCount;
}

// 이전
if(currentPage > 1){
	%>
<%-- 	<a href="list.jsp?pageNum=<%=currentPage-1%>">[1페이지 이전]</a> --%>
	<%
}

// 10페이지 이전
if(startPage > pageBlock){
	%>
	<a href="list.jsp?pageNum=<%=startPage-pageBlock%>">[10페이지 이전]</a>
	<%
}

for(int i=startPage;i<=endPage;i++){
	%>
	<a href="list.jsp?pageNum=<%=i%>"><%=i %></a>
	<%
}

//다음
if(currentPage < pageCount){
	%>
<%-- 	<a href="list.jsp?pageNum=<%=currentPage+1%>">[1페이지 다음]</a> --%>
	<%
}

//10페이지 다음
if(endPage < pageCount){
	%>
	<a href="list.jsp?pageNum=<%=startPage+pageBlock%>">[10페이지 다음]</a>
	<%
}
%>
</body>
</html>
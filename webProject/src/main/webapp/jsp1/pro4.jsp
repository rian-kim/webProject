<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jsp1/pro4.jsp</title>
</head>
<body>
<h1>jsp1/pro4.jsp</h1>
<%
// p177
// 사용자가 입력한 내용을 http가 들고가서 서버에 전달
// 서버 request 저장공간에 요청정보 저장
// post 방식 일때 => request 한글처리
request.setCharacterEncoding("utf-8");
// 변수 = request 저장된 요청정보 가져오기
String id=request.getParameter("id");
String pass=request.getParameter("pass");
String name=request.getParameter("name");
String age=request.getParameter("age");
String gender=request.getParameter("gender");
// 이름 하나에 값을 여러개 받아와서 저장 => 배열변수
// String hobby[]=new String[]{"여행", "게임", "축구"};
// for(int i=0;i<hobby.length;i++){
// 	system.out.println(hobby[i]);
// }
String[] hobby=request.getParameterValues("hobby");

String grade=request.getParameter("grade");
String memo=request.getParameter("memo");
// 변수 = request 저장된 요청정보 가져오기
%>
아이디 : <%=id %><br>
비밀번호 : <%=pass %><br>
이름 : <%=name %><br>
나이 : <%=age %><br>
성별 : <%=gender %><br>
취미 : <%
	// hobby.length => null.length => 에러발생
	if(hobby!=null){
	 for(int i=0;i<hobby.length;i++){
	  %>
	  		<%=hobby[i] %>
	  <%	
		}
	}
	%><br>
등급 : <%=grade %><br>
메모 : <%=memo %><br>
</body>
</html>
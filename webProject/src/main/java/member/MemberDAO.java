package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	// 1,2 단계 디비연결 메서드
	// 예외처리를 메서드 호출한곳으로 뒤로 미루겠다
	public Connection getConnection() throws Exception{
//		//1단계 JDBC안에 있는 Driver 프로그램 불러오기
//		Class.forName("com.mysql.cj.jdbc.Driver") ;
//		//2단계 Driver 프로그램 이용해서 디비연결
//		String dbUrl="jdbc:mysql://localhost:3306/jspdb1";
//		String dbUser="root";
//		String dbPass="1234";
//		Connection con=DriverManager.getConnection(dbUrl, dbUser, dbPass);
//		return con;
		
		//서버에서 미리 1, 2 단계 => 디비연결 => 이름을 불러 연결정보를 가져오기
		// => 속도 향상, 디비연결 정보 수정 최소화
		// DataBase Connection Pool (DBCP)=> 디비 연결정보 서버 저장
		// 1. META-INF context.xml (디비연결정보)
		// 2. MemberDAO 디비연결정보 불러서 사용
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con=ds.getConnection();
		return con;
	}
	
	// insertMember() 메서드 정의해서 
	// String id,String pass,String name,Timestamp date 
	//   값이 저장된 바구니 주소를 저장할 변수 
	public void insertMember(MemberDTO dto) {
		System.out.println("MemberDAO insertMember()");
		System.out.println("MemberDTO 바구니 전달받은 주소 : " + dto);
		System.out.println("바구니주소에서 가져온 아이디 : " + dto.getId());
		System.out.println("바구니주소에서 가져온 비밀번호 : " + dto.getPass());
		System.out.println("바구니주소에서 가져온 이름 : " + dto.getName());
		System.out.println("바구니주소에서 가져온 가입날짜 : " + dto.getDate());
		
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			// 예외가 발생할 가능성이 높은 명령(1~4단계)
			// 1~2 단계
			con=getConnection();
			// 3단계 SQL구문 만들어서 실행할 준비(insert)
			String sql="insert into members(id,pass,name,date) values(?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			// ? 채워넣기
			pstmt.setString(1, dto.getId());  
			pstmt.setString(2, dto.getPass()); 
			pstmt.setString(3, dto.getName());
			pstmt.setTimestamp(4, dto.getDate());
			// 4단계 SQL구문을 실행(insert,update,delete)
			pstmt.executeUpdate();
		} catch (Exception e) {
			// 예외가 발생하면 처리하는 곳
			e.printStackTrace();
		}finally {
			// 예외 상관없이 마무리작업 => 객체생성한 기억장소 해제
			if(pstmt!=null) try { pstmt.close();} catch (Exception e2) {}
			if(con!=null) try { con.close();} catch (Exception e2) {}
		}
		return;
	}//insertMember() 메서드
	
	// 리턴할형(MemberDTO) userCheck(String id, String pass) 메서드 정의
	public MemberDTO userCheck(String id, String pass) {
		// 바구니 주소가 저장되는 변수에 null 초기화 
		MemberDTO dto=null;
		Connection con =null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1,2단계 디비연결 메서드 호출
			con = getConnection();
			// 3단계 SQL구문 만들어서 실행할 준비(select    where id=? and pass=?)
			String sql="select * from members where id=? and pass=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			//4단계 SQL구문을 실행(select) => 결과 저장
			rs=pstmt.executeQuery();
			//5단계 결과를 출력, 데이터 담기 (select)
			// if next() 다음행 => 리턴값 데이터 있으면 true => 아이디 비밀번호 일치
//			                 => 세션값 생성 "id",id , main.jsp 이동
//			                         데이터 없으면 false => 아이디 비밀번호 틀림
//			                 => script   "아이디 비밀번호 틀림" 뒤로이동
			if(rs.next()){
				//next() 다음행 => 리턴값 데이터 있으면 true => 아이디 비밀번호 일치
			    // => 세션값 생성 "id",id(페이지 상관없이 값을 유지) , main.jsp 이동
				// dto 바구니 객체생성 => 기억장소 할당
				dto=new MemberDTO();
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString("name"));
				dto.setDate(rs.getTimestamp("date"));
			}else{
				//next() 다음행 =>       데이터 없으면 false => 아이디 비밀번호 틀림
			    // 	           => script   "아이디 비밀번호 틀림" 뒤로이동
				// 바구니주소 null 초기값 설정
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 예외 상관없이 마무리작업 => 객체생성한 기억장소 해제
			if(rs!=null) try { rs.close();} catch (Exception e2) {}
			if(pstmt!=null) try { pstmt.close();} catch (Exception e2) {}
			if(con!=null) try { con.close();} catch (Exception e2) {}
		}
		return dto;
	}//userCheck()
	
	// MemberDTO 리턴할형 getMember(String id) 메서드 정의
	public MemberDTO getMember(String id) {
		MemberDTO dto=null;
		Connection con =null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1,2 디비연결 메서드
			con=getConnection();
			
			//3단계 SQL구문 만들어서 실행할 준비(select 조건 where id=?)
			String sql="select * from members where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);

			//4단계 SQL구문을 실행(select) => 결과 저장
			rs=pstmt.executeQuery();
			//5단계 결과를 출력, 데이터 담기 (select)
			// next() 다음행 => 리턴값 데이터 있으면 true/ 데이터 없으면 false
			//조건이 true 실행문=> 다음행 데이터 있으면 true =>  열접근 출력
			if(rs.next()){
				//next() 다음행 => 리턴값 데이터 있으면 true/ 아이디 일치
				// 바구니 객체생성 => 기억장소 할당
				dto=new MemberDTO();
				// set메서드호출 바구니에 디비에서 가져온 값 저장
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString("name"));
				dto.setDate(rs.getTimestamp("date"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			// 예외 상관없이 마무리작업 => 객체생성한 기억장소 해제
			if(rs!=null) try { rs.close();} catch (Exception e2) {}
			if(pstmt!=null) try { pstmt.close();} catch (Exception e2) {}
			if(con!=null) try { con.close();} catch (Exception e2) {}
		}
		return dto;
	}//getMember()
	
	// 리턴값없음 updateMember(MemberDTO updateDto) 메서드 정의
	public void updateMember(MemberDTO updateDto) {
		Connection con =null;
		PreparedStatement pstmt2=null;
		try {
			//1,2 디비연결 메서드
			con=getConnection();
			// if next() 다음행 => 리턴값 데이터 있으면 true => 아이디 비밀번호 일치
			// => 3단계 pstmt2 SQL구문 만들어서 실행할 준비 (update set name=? where id=?)
			String sql2="update members set name=? where id =?";
			pstmt2=con.prepareStatement(sql2);
			//? 채워넣기
			pstmt2.setString(1, updateDto.getName()); //set 문자열(1번째 물음표, 값 name)
			pstmt2.setString(2, updateDto.getId());  //set 문자열 (2번째 물음표, 값 id)
			
			// 4단계 SQL구문을 실행(insert,update,delete)
			pstmt2.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			// 예외 상관없이 마무리작업 => 객체생성한 기억장소 해제
			if(pstmt2!=null) try { pstmt2.close();} catch (Exception e2) {}
			if(con!=null) try { con.close();} catch (Exception e2) {}
		}
	}//updateMember()
	
	// 리턴값없음 deleteMember(String id) 메서드 정의 
	public void deleteMember(String id) {
		Connection con =null;
		PreparedStatement pstmt2=null;
		try {
			//1,2 디비연결 메서드
			con=getConnection();
			//3단계
			String sql2="delete from members where id =?";
			pstmt2=con.prepareStatement(sql2);
			//? 채워넣기
			pstmt2.setString(1, id);  //set 문자열 (1번째 물음표, 값 id)
			// 4단계 SQL구문을 실행(insert,update,delete)
			pstmt2.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			// 예외 상관없이 마무리작업 => 객체생성한 기억장소 해제
			if(pstmt2!=null) try { pstmt2.close();} catch (Exception e2) {}
			if(con!=null) try { con.close();} catch (Exception e2) {}
		}
	}//deleteMember()
	
	// 리턴할형 ArrayList<MemberDTO>  getMemberList() 메서드 정의 
	public ArrayList<MemberDTO> getMemberList(){
		ArrayList<MemberDTO> memberList=new ArrayList<MemberDTO>();
		Connection con =null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1,2 디비연결 메서드
			con=getConnection();
			//3단계 SQL구문 만들어서 실행할 준비(select)
			String sql="select * from members";
			pstmt=con.prepareStatement(sql);
			//4단계 SQL구문을 실행(select) => 결과 저장
			rs=pstmt.executeQuery();	
			//5단계	//조건이 true 실행문=> 다음행 데이터 있으면 true 
			//     =>  열접근 => 한 명 정보 MemberDTO 저장 => 배열한칸 저장 
			while(rs.next()) {
				// MemberDTO 객체생성
				MemberDTO dto=new MemberDTO();
				System.out.println("회원정보저장 주소 : "+dto);
				// set메서드 호출 <= 열접근
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString("name"));
				dto.setDate(rs.getTimestamp("date"));
				// 배열 한칸에 회원정보주소 저장
				memberList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			// 예외 상관없이 마무리작업 => 객체생성한 기억장소 해제
			if(rs!=null) try { rs.close();} catch (Exception e2) {}
			if(pstmt!=null) try { pstmt.close();} catch (Exception e2) {}
			if(con!=null) try { con.close();} catch (Exception e2) {}
		}
		return memberList;
	}//getMemberList()
	
}//클래스


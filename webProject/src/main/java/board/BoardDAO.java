package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.mysql.cj.jdbc.result.ResultSetInternalMethods;

import member.MemberDTO;

public class BoardDAO {
	public Connection getConnection() throws Exception{
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
	
	public void insertBoard(BoardDTO dto) {
		System.out.println("BoardDAO insertBoard()");
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			// 예외가 발생할 가능성이 높은 명령(1~4단계)
			// 1~2 단계
			con=getConnection();
			// num 구하기
			int num=1;
			// 3 최대num+1
			String sql="select max(num) from board";
			pstmt=con.prepareStatement(sql);
			// 4
			rs=pstmt.executeQuery();
			// 5
			if(rs.next()) {
				num=rs.getInt("max(num)")+1;
			}
			// 3단계 SQL구문 만들어서 실행할 준비(insert)
			sql="insert into board(num,name,subject,content,readcount,date) values(?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			// ? 채워넣기
			pstmt.setInt(1, num);  
			pstmt.setString(2, dto.getName()); 
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setInt(5, dto.getReadcount());
			pstmt.setTimestamp(6, dto.getDate());
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
	}//insertBoard()
	
	// 리턴할형 ArrayList<BoardDTO>  getBoardList() 메서드 정의 
		public ArrayList<BoardDTO> getBoardList(int startRow, int pageSize){
			ArrayList<BoardDTO> boardList=new ArrayList<BoardDTO>();
			Connection con =null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			try {
				// 1,2 디비연결 메서드
				con=getConnection();
				// 3단계 SQL 
				// 기본 num을 기준 오름차순 => 최근글 위로 올라오게 정렬(num 내림차순)
//				String sql="select * from board order by num desc";
//				String sql="select * from board order by num desc limit 시작행-1, 몇개";
				String sql="select * from board order by num desc limit ?, ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow-1);
				pstmt.setInt(2, pageSize);
				// 4 SQL구문을 실행(select) => 결과 저장
				rs=pstmt.executeQuery();	
				// 5단계	//조건이 true 실행문=> 다음행 데이터 있으면 true 
				//     =>  열접근 => 한 명 정보 MemberDTO 저장 => 배열한칸 저장 
				while(rs.next()) {
					// MemberDTO 객체생성
					BoardDTO dto=new BoardDTO();
					System.out.println("회원정보저장 주소 : "+dto);
					// set메서드 호출 <= 열접근
					dto.setNum(rs.getInt("num"));
					dto.setName(rs.getString("name"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setReadcount(rs.getInt("readcount"));
					dto.setDate(rs.getTimestamp("date"));
					// 배열 한칸에 회원정보주소 저장
					boardList.add(dto);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				// 예외 상관없이 마무리작업 => 객체생성한 기억장소 해제
				if(rs!=null) try { rs.close();} catch (Exception e2) {}
				if(pstmt!=null) try { pstmt.close();} catch (Exception e2) {}
				if(con!=null) try { con.close();} catch (Exception e2) {}
			}
			return boardList;
		}//getBoardList()
		
		// 리턴할형 BoardDTO getBoard(int num) 메서드 정의
		public BoardDTO getBoard(int num) {
			BoardDTO dto=null;
			Connection con =null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			try {
				//1,2 디비연결 메서드
				con=getConnection();
				
				//3단계 SQL구문 만들어서 실행할 준비(select 조건 where id=?)
				String sql="select * from board where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);

				//4단계 SQL구문을 실행(select) => 결과 저장
				rs=pstmt.executeQuery();
				//5단계 결과를 출력, 데이터 담기 (select)
				// next() 다음행 => 리턴값 데이터 있으면 true/ 데이터 없으면 false
				//조건이 true 실행문=> 다음행 데이터 있으면 true =>  열접근 출력
				if(rs.next()){
					//next() 다음행 => 리턴값 데이터 있으면 true/ 아이디 일치
					// 바구니 객체생성 => 기억장소 할당
					dto=new BoardDTO();
					// set메서드호출 바구니에 디비에서 가져온 값 저장
					dto.setNum(rs.getInt("num"));
					dto.setName(rs.getString("name"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setReadcount(rs.getInt("readcount"));
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
		}//getBoard
		
		public void updateBoard(BoardDTO dto) {
			System.out.println("BoardDAO updateBoard()");
			Connection con =null;
			PreparedStatement pstmt=null;
			try {
				//1,2 디비연결 메서드
				con=getConnection();
				// if next() 다음행 => 리턴값 데이터 있으면 true => 아이디 비밀번호 일치
				// => 3단계 pstmt2 SQL구문 만들어서 실행할 준비 (update set name=? where id=?)
				String sql="update board set subject=?, content=? where num=?";
				pstmt=con.prepareStatement(sql);
				//? 채워넣기
				pstmt.setString(1, dto.getSubject()); //set 문자열(1번째 물음표, 값 name)
				pstmt.setString(2, dto.getContent());  //set 문자열 (2번째 물음표, 값 id)
				pstmt.setInt(3, dto.getNum());
				// 4단계 SQL구문을 실행(insert,update,delete)
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				// 예외 상관없이 마무리작업 => 객체생성한 기억장소 해제
				if(pstmt!=null) try { pstmt.close();} catch (Exception e2) {}
				if(con!=null) try { con.close();} catch (Exception e2) {}
			}
		}//updateMember()
		
		public void deleteBoard(int num) {
			Connection con =null;
			PreparedStatement pstmt=null;
			try {
				//1,2 디비연결 메서드
				con=getConnection();
				//3단계
				String sql="delete from board where num =?";
				pstmt=con.prepareStatement(sql);
				//? 채워넣기
				pstmt.setInt(1, num);  //set 문자열 (1번째 물음표, 값 id)
				// 4단계 SQL구문을 실행(insert,update,delete)
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				// 예외 상관없이 마무리작업 => 객체생성한 기억장소 해제
				if(pstmt!=null) try { pstmt.close();} catch (Exception e2) {}
				if(con!=null) try { con.close();} catch (Exception e2) {}
			}
		}//deleteMember()
		
		// int 리턴할형 getBoardCount() 메서드 정의
		public int getBoardCount() {
			int count=0;
			Connection con =null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			try {
				//1,2 디비연결 메서드
				con=getConnection();
				
				//3단계 SQL구문 만들어서 실행할 준비(select 조건)
				String sql="select count(*) from board";
				pstmt=con.prepareStatement(sql);

				//4단계 SQL구문을 실행(select) => 결과 저장
				rs=pstmt.executeQuery();
				//5단계 결과를 출력, 데이터 담기 (select)
				// next() 다음행 => 리턴값 데이터 있으면 true/ 데이터 없으면 false
				//조건이 true 실행문=> 다음행 데이터 있으면 true =>  열접근 출력
				if(rs.next()){
					//next() 다음행 => 리턴값 데이터 있으면 true/ 아이디 일치
					count=rs.getInt("count(*)");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				// 예외 상관없이 마무리작업 => 객체생성한 기억장소 해제
				if(rs!=null) try { rs.close();} catch (Exception e2) {}
				if(pstmt!=null) try { pstmt.close();} catch (Exception e2) {}
				if(con!=null) try { con.close();} catch (Exception e2) {}
			}
			return count;
		}

}

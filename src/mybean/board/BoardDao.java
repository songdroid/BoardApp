package mybean.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDao {
	private	Connection con;
	private PreparedStatement stmt;
	private ResultSet rs;
	private DataSource ds;
	
	public BoardDao(){
		try{
			Context ctx = new InitialContext();
			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/testdb");
		}
		catch(Exception err){
			System.out.println("BoardDao : " + err);
		}
	}
	
	public void freeCon(){
		if(rs!=null){ try{ rs.close(); }catch(Exception err){} }
		if(stmt!=null){ try{ stmt.close(); }catch(Exception err){} }
		if(con!=null){ try{ con.close(); }catch(Exception err){} }
	}
	
	public List getBoardList(){
		String sql = "select * from tblboard";
		Vector vec = new Vector();
		
		try{
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			while(rs.next()){
				BoardDto dto = new BoardDto();
				dto.setB_content(rs.getString("b_content"));
				dto.setB_count(rs.getInt("b_count"));
				dto.setB_email(rs.getString("b_email"));
				dto.setB_homepage(rs.getString("b_homepage"));
				dto.setB_ip(rs.getString("b_ip"));
				dto.setB_name(rs.getString("b_name"));
				dto.setB_num(rs.getInt("b_num"));
				dto.setB_pass(rs.getString("b_pass"));
				dto.setB_regdate(rs.getString("b_regdate"));
				dto.setB_subject(rs.getString("b_subject"));
				dto.setDepth(rs.getInt("depth"));
				dto.setPos(rs.getInt("pos"));
				
				vec.add(dto);
			}
		}
		catch(Exception err){
			System.out.println("getBoardList() : " + err);
		}
		finally{
			freeCon();
		}
		return vec;
	}
	
	public void insertBoard(BoardDto dto){
		String sql = "insert into tblboard(b_num, b_name, b_email, " +
			"b_homepage, b_subject, b_content, b_regdate, b_pass, " +
			"b_count, b_ip, pos, depth) " +
			"values(seq_b_num.nextVal, ?,?,?,?,?, sysdate,?,0,?,0,0)";
		try{
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, dto.getB_name());
			stmt.setString(2, dto.getB_email());
			stmt.setString(3, dto.getB_homepage());
			stmt.setString(4, dto.getB_subject());
			stmt.setString(5, dto.getB_content());
			stmt.setString(6, dto.getB_pass());
			stmt.setString(7, dto.getB_ip());
			
			stmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("insertBoard() : " + err);
		}
		finally{
			freeCon();
		}
	}
}

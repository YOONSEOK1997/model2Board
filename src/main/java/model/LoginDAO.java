package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import dto.AdminDTO;

public class LoginDAO {

	private Connection getConnection() throws SQLException, ClassNotFoundException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "wkqk1234");
	}

	public boolean selectLogin(AdminDTO adminDto) throws SQLException, ClassNotFoundException {
		boolean isLogin = false;

		String sql = "SELECT admin_id FROM admin WHERE admin_id = ? AND admin_pw = ?";


		Connection conn = getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setString(1, adminDto.getAdminId());
		stmt.setString(2, adminDto.getAdminPw());

		ResultSet rs = stmt.executeQuery();
		if (rs.next()) 
			isLogin = true;

		return isLogin;
	}
	public void updatePassword(String adminId, String oldPw, String newPw) throws SQLException, ClassNotFoundException {
	    String sql = "UPDATE admin SET admin_pw = ? WHERE admin_id = ? AND admin_pw = ?";

	    
	        Connection conn = getConnection();
	        PreparedStatement stmt = conn.prepareStatement(sql);
	     
	        stmt.setString(1, newPw);      // 새 비밀번호
	        stmt.setString(2, adminId);    // 아이디
	        stmt.setString(3, oldPw);      // 현재 비밀번호

	        int rowsUpdated = stmt.executeUpdate();

	        if (rowsUpdated == 0) {
	          System.out.println("비밀번호가 변경되지 않았습니다");
	        }
	    
	}

}


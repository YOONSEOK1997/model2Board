package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.ReceiptDTO;

public class ReceiptDAO {

	private Connection getConnection() throws SQLException, ClassNotFoundException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "wkqk1234");
	}
	public ReceiptDTO selectReceiptByCashNo(int cashNo) throws ClassNotFoundException, SQLException {
	    ReceiptDTO receipt = null;
	    
	    Connection conn = getConnection();
	    String sql = "SELECT cash_no, filename, createdate FROM receipt WHERE cash_no = ?";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, cashNo);
	    
	    ResultSet rs = stmt.executeQuery();
	    if (rs.next()) {
	        receipt = new ReceiptDTO();
	        receipt.setCashNo(rs.getInt("cash_no"));
	        receipt.setFilename(rs.getString("filename"));
	        receipt.setCreateDate(rs.getTimestamp("createdate").toLocalDateTime());
	    
	    }

	    rs.close();
	    stmt.close();
	    conn.close();
	    
	    return receipt;
	}

	public void insertReceipt(ReceiptDTO receipt) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = getConnection();
		
		String sql = "insert into receipt(cash_no,filename,createdate) values(?,?,NOW())";
		
		stmt= conn.prepareStatement(sql); 
		stmt.setInt(1, receipt.getCashNo());
		stmt.setString(2, receipt.getFilename());
		int rowsUpdated = stmt.executeUpdate();

        if (rowsUpdated == 0) {
          System.out.println("등록되지 않았습니다.");
        }
		conn.close();		
	}
	
	public void deleteReceipt(int cashNo) throws ClassNotFoundException, SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		conn = getConnection();
		
		String sql = "delete from receipt where cash_no = ?";
		
	
		stmt = conn.prepareStatement(sql); 
		stmt.setInt(1, cashNo);
		stmt.executeUpdate();
		int rowsUpdated = stmt.executeUpdate();

        if (rowsUpdated == 0) {
          System.out.println("삭제된 항목이 없습니다.");
        }
		conn.close();	
	}
	
}



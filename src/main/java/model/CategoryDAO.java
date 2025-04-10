package model;

import java.sql.*;
import java.util.ArrayList;

import dto.*;

public class CategoryDAO {
	private Connection getConnection() throws SQLException, ClassNotFoundException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "wkqk1234");
	} 
	// 페이징
	public ArrayList<CategoryDTO> selectCategoryList(Paging p) throws ClassNotFoundException, SQLException {
		ArrayList<CategoryDTO> list = new ArrayList<>();
		Connection conn = getConnection();	
		ResultSet rs = null;

		//페이징 쿼리
		String sql = "SELECT category_no categoryNo, kind, title, createdate FROM category"
			   	  +  " ORDER BY categoryNo ASC LIMIT ?, ?";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, p.getBeginRow());
		stmt.setInt(2, p.getRowPerPage());
		rs = stmt.executeQuery();

		while(rs.next()) {
			CategoryDTO categoryDto = new CategoryDTO();
			categoryDto.setCategoryNo(rs.getInt("categoryNo"));
			categoryDto.setKind(rs.getString("kind"));
			categoryDto.setTitle(rs.getString("title"));
			categoryDto.setCreatedDate(rs.getTimestamp("createdate").toLocalDateTime());
	        list.add(categoryDto); 
		}
		if (stmt != null) stmt.close();
		if (conn != null) conn.close();

		return list;
	} //카테고리 별 전체 리스트 출력
	public ArrayList<CategoryDTO> selectAllCategory() {
	    ArrayList<CategoryDTO> list = new ArrayList<>();

	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;

	    try {
	        conn = getConnection();
	        String sql = "SELECT category_no, kind, title, color FROM category ORDER BY kind ASC, category_no ASC";
	        stmt = conn.prepareStatement(sql);
	        rs = stmt.executeQuery();

	        while (rs.next()) {
	            CategoryDTO category = new CategoryDTO();
	            category.setCategoryNo(rs.getInt("category_no"));
	            category.setKind(rs.getString("kind"));
	            category.setTitle(rs.getString("title"));
	            list.add(category);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (stmt != null) stmt.close();
	            if (conn != null) conn.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

	    return list;
	}

	//카테고리 등록 
	public void insertCategory(CategoryDTO category) throws ClassNotFoundException, SQLException {
	    Connection conn = null;
	    PreparedStatement stmt = null;

	  
	        conn = getConnection();
	        String sql = "INSERT INTO category (kind, title, createdate) VALUES (?, ?, NOW())";
	        stmt = conn.prepareStatement(sql);
	        stmt.setString(1, category.getKind());
	        stmt.setString(2, category.getTitle());
	        stmt.executeUpdate();
	 
	        if (stmt != null) stmt.close();
	        if (conn != null) conn.close();
	 
	}
	// 특정 카테고리 1개 조회
	public CategoryDTO selectCategoryByNo(int categoryNo) throws Exception {
	    CategoryDTO CategoryDto = new CategoryDTO();
	    Connection conn = getConnection();
	    String sql = "SELECT category_no, kind, title, createdate FROM category WHERE category_no = ?";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, categoryNo);
	    ResultSet rs = stmt.executeQuery();
	    if (rs.next()) {
	    	CategoryDto.setCategoryNo(rs.getInt("category_no"));
	    	CategoryDto.setKind(rs.getString("kind"));
	    	CategoryDto.setTitle(rs.getString("title"));
	    	CategoryDto.setCreatedDate(rs.getTimestamp("createdate").toLocalDateTime());
	    }
	    conn.close();
	    return CategoryDto;
	}

	// 수정
	public void updateCategory(CategoryDTO dto) throws Exception {
	    Connection conn = getConnection();
	    String sql = "UPDATE category SET kind = ?, title = ? WHERE category_no = ?";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setString(1, dto.getKind());
	    stmt.setString(2, dto.getTitle());
	    stmt.setInt(3, dto.getCategoryNo());
	    stmt.executeUpdate();
	    conn.close();
	}

	// 삭제
	public void deleteCategory(int categoryNo) throws Exception {
	    Connection conn = getConnection();
	    String sql = "DELETE FROM category WHERE category_no = ?";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, categoryNo);
	    stmt.executeUpdate();
	    conn.close();
	}


}

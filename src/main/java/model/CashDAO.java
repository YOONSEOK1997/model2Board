package model;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import dto.CashDTO;
import dto.CategoryDTO;
import dto.Paging;
public class CashDAO {
	private Connection getConnection() throws SQLException, ClassNotFoundException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "wkqk1234");
	}
	//달력 출력
	public HashMap<String, ArrayList<CashDTO>> selectMonthList(String yyyymm) {
	    HashMap<String, ArrayList<CashDTO>> map = new HashMap<>();

	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;

	    try {
	        conn = getConnection();

	        // 날짜 범위 계산
	        int year = Integer.parseInt(yyyymm.substring(0, 4));
	        int month = Integer.parseInt(yyyymm.substring(5)) - 1;

	        Calendar cal = Calendar.getInstance();
	        cal.set(year, month, 1);
	        String firstDay = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());

	        cal.add(Calendar.MONTH, 1); // 다음 달 1일
	        String nextMonthFirstDay = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());

	        // SQL 수정: 날짜 범위로 비교
	        String sql = "SELECT c.cash_no, c.category_no, c.amount, c.memo, c.cash_date, "
	                + "c.createdate AS cash_createdate, cat.createdate AS category_createdate, "
	                + "c.color , cat.kind, cat.title "
	                + "FROM cash c "
	                + "INNER JOIN category cat ON c.category_no = cat.category_no "
	                + "WHERE c.cash_date >= ? AND c.cash_date < ? "
	                + "ORDER BY c.cash_date ASC";

	        stmt = conn.prepareStatement(sql);
	        stmt.setString(1, firstDay);
	        stmt.setString(2, nextMonthFirstDay);

	        rs = stmt.executeQuery();
	        while (rs.next()) {
	            CashDTO cashDto = new CashDTO();
	            cashDto.setCashNo(rs.getInt("cash_no"));
	            cashDto.setCategoryNo(rs.getInt("category_no"));
	            cashDto.setAmount(rs.getInt("amount"));
	            cashDto.setMemo(rs.getString("memo"));
	            cashDto.setCashDate(rs.getString("cash_date"));
	            cashDto.setColor(rs.getString("color"));
	            cashDto.setCreatedDate(rs.getTimestamp("cash_createdate").toLocalDateTime());

	            CategoryDTO category = new CategoryDTO();
	            category.setCategoryNo(rs.getInt("category_no"));
	            category.setKind(rs.getString("kind"));
	            category.setTitle(rs.getString("title"));

	            cashDto.setCategoryDTO(category);

	            String dateKey = rs.getString("cash_date");
	            if (!map.containsKey(dateKey)) {
	                map.put(dateKey, new ArrayList<CashDTO>());
	            }
	            map.get(dateKey).add(cashDto);
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

	    return map;
	}
	//달력 등록
	public void insertCash(CashDTO dto) {
	    String sql = "INSERT INTO cash (category_no,  cash_date, amount, memo, color, updatedate, createdate) "
	               + "VALUES (?, ?, ?, ?, ?, NOW(), NOW())";

	    try (
	        Connection conn = getConnection();
	        PreparedStatement stmt = conn.prepareStatement(sql)
	    ) {
	        stmt.setInt(1, dto.getCategoryNo());       
	        stmt.setString(2, dto.getCashDate());
	        stmt.setInt(3, dto.getAmount());
	        stmt.setString(4, dto.getMemo());
	        stmt.setString(5,dto.getColor());
	        stmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

}
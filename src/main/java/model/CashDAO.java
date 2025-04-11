package model;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dto.CashDTO;
import dto.CategoryDTO;
import dto.Paging;

public class CashDAO {
	private Connection getConnection() throws SQLException, ClassNotFoundException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "wkqk1234");
	}
	//달력 출력
	public HashMap<String, ArrayList<CashDTO>> selectMonthList(String yyyymm) throws ClassNotFoundException, SQLException {
		HashMap<String, ArrayList<CashDTO>> map = new HashMap<>();

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;


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
			CashDTO cash = new CashDTO();
			cash.setCashNo(rs.getInt("cash_no"));
			cash.setCategoryNo(rs.getInt("category_no"));
			cash.setAmount(rs.getInt("amount"));
			cash.setMemo(rs.getString("memo"));
			cash.setCashDate(rs.getString("cash_date"));
			cash.setColor(rs.getString("color"));
			cash.setCreateDate(rs.getTimestamp("cash_createdate").toLocalDateTime());

			CategoryDTO category = new CategoryDTO();
			category.setCategoryNo(rs.getInt("category_no"));
			category.setKind(rs.getString("kind"));
			category.setTitle(rs.getString("title"));

			cash.setCategoryDTO(category);

			String dateKey = rs.getString("cash_date");
			if (!map.containsKey(dateKey)) {
				map.put(dateKey, new ArrayList<CashDTO>());
			}
			map.get(dateKey).add(cash);
		}

		if (rs != null) rs.close();
		if (stmt != null) stmt.close();
		if (conn != null) conn.close();

		return map;
	}
	//달력 등록
	public void insertCash(CashDTO dto) throws ClassNotFoundException, SQLException {
		String sql = "INSERT INTO cash (category_no,  cash_date, amount, memo, color, updatedate, createdate) "
				+ "VALUES (?, ?, ?, ?, ?, NOW(), NOW())";


		Connection conn = getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setInt(1, dto.getCategoryNo());       
		stmt.setString(2, dto.getCashDate());
		stmt.setInt(3, dto.getAmount());
		stmt.setString(4, dto.getMemo());
		stmt.setString(5,dto.getColor());
		stmt.executeUpdate();

	}
	//달력 상세
	public ArrayList<CashDTO> selectDateList(CashDTO inputDto) throws SQLException, ClassNotFoundException {
		ArrayList<CashDTO> list = new ArrayList<>();

		String sql = "SELECT c.cash_no, c.category_no, c.cash_date, c.amount, c.memo, c.color, "
				+ "c.createdate, c.updatedate, "
				+ "cat.kind, cat.title "
				+ "FROM cash c INNER JOIN category cat ON c.category_no = cat.category_no "
				+ "WHERE c.cash_date = ? "
				+ "ORDER BY c.cash_no ASC";


		Connection conn = getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setString(1, inputDto.getCashDate());
		ResultSet rs = stmt.executeQuery();

		while (rs.next()) {
			CashDTO cash = new CashDTO();
			cash.setCashNo(rs.getInt("cash_no"));
			cash.setCategoryNo(rs.getInt("category_no"));
			cash.setCashDate(rs.getString("cash_date"));
			cash.setAmount(rs.getInt("amount"));
			cash.setMemo(rs.getString("memo"));
			cash.setColor(rs.getString("color"));
			cash.setCreateDate(rs.getTimestamp("createdate").toLocalDateTime());
			cash.setUpdateDate(rs.getTimestamp("updatedate").toLocalDateTime());

			CategoryDTO category = new CategoryDTO();
			category.setKind(rs.getString("kind"));
			category.setTitle(rs.getString("title"));
			cash.setCategoryDTO(category);

			list.add(cash);
		}

		return list;
	}
	//cashOne select
	public CashDTO selectOne(int cashNo) throws SQLException, ClassNotFoundException {
		CashDTO cash = null;
		String sql = "SELECT c.cash_no, c.cash_date, c.amount, c.memo, c.createdate, "
				+ "cat.kind, cat.title "
				+ "FROM cash c "
				+ "INNER JOIN category cat ON c.category_no = cat.category_no "
				+ "WHERE c.cash_no = ?";

		Connection conn = getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setInt(1, cashNo);
		ResultSet rs = stmt.executeQuery();

		if (rs.next()) {
			cash = new CashDTO();
			cash.setCashNo(rs.getInt("cash_no"));
			cash.setCashDate(rs.getString("cash_date"));
			cash.setAmount(rs.getInt("amount"));
			cash.setMemo(rs.getString("memo"));
			cash.setCreateDate(rs.getTimestamp("createdate").toLocalDateTime());

			CategoryDTO cat = new CategoryDTO();
			cat.setKind(rs.getString("kind"));
			cat.setTitle(rs.getString("title"));
			cash.setCategoryDTO(cat);
		}

		rs.close();

		return cash;
	}
	//cashOne update
	public void updateCash(CashDTO cash) throws SQLException, ClassNotFoundException {
		String sql = "UPDATE cash SET cash_date=?, amount=?, memo=? WHERE cash_no=?";
		Connection conn = getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql); 
		stmt.setString(1, cash.getCashDate());
		stmt.setInt(2, cash.getAmount());
		stmt.setString(3, cash.getMemo());
		stmt.setInt(4, cash.getCashNo());
		stmt.executeUpdate();

	}
	//cashOne delete
	public void deleteCash(int cashNo) throws SQLException, ClassNotFoundException {
		Connection conn = getConnection();
		String sql = "DELETE FROM cash WHERE cash_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		stmt.executeUpdate();

	}
	
	///////////////////////////////////////통계자료////////////////////////////////////////////
		
	
	//전체 수입 / 지출 통계
	    public List<Map<String, Object>> getTotalIncomeExpense() throws Exception {
	        List<Map<String, Object>> list = new ArrayList<>();
	        Connection conn = getConnection();
	        String sql = "SELECT kind, COUNT(*) AS count, SUM(amount) AS sum " +
	        			 "FROM category ct " +
	                     "INNER JOIN cash cs ON ct.category_no = cs.category_no " +
	                     "GROUP BY ct.kind";     

	        PreparedStatement stmt = conn.prepareStatement(sql);
	        ResultSet rs = stmt.executeQuery();

	        while (rs.next()) {
	            Map<String, Object> map = new HashMap<>();
	            map.put("kind", rs.getString("kind"));
	            map.put("count", rs.getInt("count"));
	            map.put("sum", rs.getLong("sum"));
	            list.add(map);
	        }
	        conn.close();
	        return list;
	    }
	    //연도별 수입 / 지출 통계
	    public List<Map<String, Object>> getYearlyStats() throws Exception {
	        List<Map<String, Object>> list = new ArrayList<>();
	        Connection conn = getConnection();
	        String sql = "SELECT YEAR(cash_date) AS year, kind, COUNT(*) AS count, SUM(amount) AS sum " +
	                     "FROM category ct INNER JOIN cash cs ON ct.category_no = cs.category_no " +
	                     "GROUP BY YEAR(cash_date), ct.kind ORDER BY year";

	        PreparedStatement stmt = conn.prepareStatement(sql);
	        ResultSet rs = stmt.executeQuery();

	        while (rs.next()) {
	            Map<String, Object> map = new HashMap<>();
	            map.put("year", rs.getInt("year"));
	            map.put("kind", rs.getString("kind"));
	            map.put("count", rs.getInt("count"));
	            map.put("sum", rs.getLong("sum"));
	            list.add(map);
	        }
	        conn.close();
	        return list;
	    }
	    //월별 수입 / 지출 통계
	    public List<Map<String, Object>> getMonthlyStats() throws Exception {
	        List<Map<String, Object>> list = new ArrayList<>();
	        Connection conn = getConnection();

	        String sql = "SELECT MONTH(cash_date) AS month, kind, COUNT(*) AS count, SUM(amount) AS sum " +
	                     "FROM category ct INNER JOIN cash cs ON ct.category_no = cs.category_no " +
	                     "GROUP BY MONTH(cash_date), ct.kind ORDER BY month";

	        PreparedStatement stmt = conn.prepareStatement(sql);
	        ResultSet rs = stmt.executeQuery();

	        while (rs.next()) {
	            Map<String, Object> map = new HashMap<>();
	            map.put("month", rs.getInt("month"));
	            map.put("kind", rs.getString("kind"));
	            map.put("count", rs.getInt("count"));
	            map.put("sum", rs.getLong("sum"));
	            list.add(map);
	        }
	        conn.close();
	        return list;
	    }
	    
	    public List<Map<String, Object>> getMonthlyStatsByYear(int year) throws Exception {
	        List<Map<String, Object>> list = new ArrayList<>();
	        Connection conn = getConnection();
	        String sql = "SELECT MONTH(cash_date) AS month, kind, COUNT(*) AS count, SUM(amount) AS sum " +
	                     "FROM category ct INNER JOIN cash cs ON ct.category_no = cs.category_no " +
	                     "WHERE YEAR(cash_date) = ? " +
	                     "GROUP BY MONTH(cash_date), ct.kind ORDER BY month";

	        PreparedStatement stmt = conn.prepareStatement(sql);
	        stmt.setInt(1, year);
	        ResultSet rs = stmt.executeQuery();

	        while (rs.next()) {
	            Map<String, Object> map = new HashMap<>();
	            map.put("month", rs.getInt("month"));
	            map.put("kind", rs.getString("kind"));
	            map.put("count", rs.getInt("count"));
	            map.put("sum", rs.getLong("sum"));
	            list.add(map);
	        }
	        conn.close();
	        return list;
	    }

	    public List<Integer> getYearList() throws Exception {
	        List<Integer> list = new ArrayList<>();
	        Connection conn = getConnection();

	        String sql = "SELECT DISTINCT YEAR(cash_date) AS year FROM cash ORDER BY year DESC";
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        ResultSet rs = stmt.executeQuery();

	        while (rs.next()) {
	            list.add(rs.getInt("year"));
	        }
	        conn.close();
	        return list;
	    }
	} 

	






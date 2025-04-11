<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.*"%>

<%
    CashDAO cashDao = new CashDAO();

    List<Integer> yearList = cashDao.getYearList();
    String yearParam = request.getParameter("year");
    int selectedYear = yearParam != null ? Integer.parseInt(yearParam) : (yearList.size() > 0 ? yearList.get(0) : Calendar.getInstance().get(Calendar.YEAR));

    List<Map<String, Object>> totalStats = cashDao.getTotalIncomeExpense();
    List<Map<String, Object>> yearlyStats = cashDao.getYearlyStats();
    List<Map<String, Object>> monthlyStats = cashDao.getMonthlyStats();
    List<Map<String, Object>> statsByYear = cashDao.getMonthlyStatsByYear(selectedYear);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 통계</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body class="p-4 bg-light">
	<div class="container bg-white shadow p-4 rounded">
		<h3>전체 수입/지출 통계</h3>
		<table class="table table-bordered mt-3">
			<thead>
				<tr>
					<th>종류</th>
					<th>건수</th>
					<th>총액</th>
				</tr>
			</thead>
			<tbody>
				<%
                    for (Map<String, Object> row : totalStats) {
                        String kind = (String) row.get("kind");
                        long count = row.get("count") != null ? ((Number) row.get("count")).longValue() : 0; // 수정: "COUNT(*)" → "count"
                        long sum = row.get("sum") != null ? ((Number) row.get("sum")).longValue() : 0;

                %>
				<tr>
					<td><%= kind %></td>
					<td><%= count %></td>
					<td><%= sum %>원</td>
				</tr>
				<% } %>
			</tbody>
		</table>
		<h3><%= selectedYear %>년 월별 수입/지출 통계
		</h3>

		<!-- 연도 선택 -->
		<form method="get" class="mb-3">
			<div class="row g-2 align-items-center">
				<div class="col-auto">
					<label for="yearSelect" class="form-label">연도 선택:</label>
				</div>
				<div class="col-auto">
					<select name="year" id="yearSelect" class="form-select"
						onchange="this.form.submit()">
						<% for (int y : yearList) { %>
						<option value="<%= y %>"
							<%= (y == selectedYear ? "selected" : "") %>><%= y %>년
						</option>
						<% } %>
					</select>
				</div>
			</div>
		</form>

		<table class="table table-bordered">
			<thead>
				<tr>
					<th>월</th>
					<th>종류</th>
					<th>건수</th>
					<th>총액</th>
				</tr>
			</thead>
			<tbody>
				<%
                    for (Map<String, Object> row : statsByYear) {
                        int month = row.get("month") != null ? ((Number) row.get("month")).intValue() : 0; 
                        String kind = (String) row.get("kind");
                        long count = row.get("count") != null ? ((Number) row.get("count")).longValue() : 0; 
                        long sum = row.get("sum") != null ? ((Number) row.get("sum")).longValue() : 0; 
                %>
				<tr>
					<td><%= month %></td>
					<td><%= kind %></td>
					<td><%= count %></td>
					<td><%= sum %>원</td>
				</tr>
				<% } %>
			</tbody>
		</table>

		<h3>년도별 수입/지출 통계</h3>
		<table class="table table-bordered mt-3">
			<thead>
				<tr>
					<th>년도</th>
					<th>종류</th>
					<th>건수</th>
					<th>총액</th>
				</tr>
			</thead>
			<tbody>
				<%
                    for (Map<String, Object> row : yearlyStats) {
                        int year = row.get("year") != null ? ((Number) row.get("year")).intValue() : 0; // 
                        String kind = (String) row.get("kind");
                        long count = row.get("count") != null ? ((Number) row.get("count")).longValue() : 0; 
                        long sum = row.get("sum") != null ? ((Number) row.get("sum")).longValue() : 0; 

                %>
				<tr>
					<td><%= year %></td>
					<td><%= kind %></td>
					<td><%= count %></td>
					<td><%= sum %>원</td>
				</tr>
				<% } %>
			</tbody>
		</table>


		<h3>월별 수입/지출 통계</h3>
		<table class="table table-bordered mt-3">
			<thead>
				<tr>
					<th>월</th>
					<th>종류</th>
					<th>건수</th>
					<th>총액</th>
				</tr>
			</thead>
			<tbody>
				<%
                    for (Map<String, Object> row : monthlyStats) {
                        int month = row.get("month") != null ? ((Number) row.get("month")).intValue() : 0; 
                        String kind = (String) row.get("kind");
                        long count = row.get("count") != null ? ((Number) row.get("count")).longValue() : 0; 
                        long sum = row.get("sum") != null ? ((Number) row.get("sum")).longValue() : 0;

                %>
				<tr>
					<td><%= month %></td>
					<td><%= kind %></td>
					<td><%= count %></td>
					<td><%= sum %>원</td>
				</tr>
				<% } %>
			</tbody>
		</table>


	</div>
</body>
</html>

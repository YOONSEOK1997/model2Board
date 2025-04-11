<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*, model.*, dto.*"%>

<%
    // 파라미터 수집
    String y = request.getParameter("y");
    String m = request.getParameter("m");
    String d = request.getParameter("d");

    if (y == null || m == null || d == null) {
        response.sendRedirect("calendar.jsp");
        return;
    }

    // 날짜 문자열 만들기
    String targetDate = String.format("%s-%02d-%02d", y, Integer.parseInt(m), Integer.parseInt(d));

    // DAO 호출
    CashDAO cashDao = new CashDAO();
    CashDTO cashDto = new CashDTO();
    cashDto.setCashDate(targetDate);
    ArrayList<CashDTO> cashList = cashDao.selectDateList(cashDto); // 이 메서드는 selectMonthList처럼 하나 만들어야 함
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= targetDate %> 내역</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body class="p-5">
	<div class="container bg-white shadow rounded p-4">
		<h3><%= targetDate %>
			수입/지출 내역
		</h3>
		<table class="table table-hover mt-4 text-center">
			<thead class="table-primary">
				<tr>
					<th>수입</th>
					<th>금액</th>
					<th>메모</th>
				</tr>
			</thead>
			<tbody>
				<%
                    if (cashList.isEmpty()) {
                %>
				<tr>
					<td colspan="4">내역이 없습니다.</td>
				</tr>
				<%
                    } else {
                        for (CashDTO c : cashList) {
                %>
				<tr onclick="location.href='cash/cashOne.jsp?cashNo=<%= c.getCashNo() %>&y=<%= y %>&m=<%= m %>&d=<%= d %>'" style="cursor: pointer;">
				    <td><%= c.getCategoryDTO().getKind() %></td>
				    <td><%= c.getAmount() %>원</td>
				    <td><%= c.getMemo() %></td>
				</tr>

				<%
                        }
                    }
                %>
			</tbody>
		</table>
		<a href="monthList.jsp?targetMonth=<%= Integer.parseInt(m) %>"
			class="btn btn-outline-secondary">← 달력으로</a> 
		<a class="btn btn-outline-primary" 
   href="cash/insertCashForm.jsp?y=<%= y %>&m=<%= m %>&d=<%= d %>">
   <i class="fa-solid fa-plus"></i> 등록
</a>
	</div>
</body>
</html>

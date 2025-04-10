<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="model.CashDAO"%>
<%@ page import="dto.CashDTO"%>
<%@ page import="dto.CategoryDTO"%>
<%@ include file="/navbar.jsp"%>
<%
    Calendar firstDate = Calendar.getInstance();
    int targetYear = firstDate.get(Calendar.YEAR);
    int targetMonth = firstDate.get(Calendar.MONTH);

    if (request.getParameter("y") != null && request.getParameter("m") != null) {
        targetYear = Integer.parseInt(request.getParameter("y"));
        targetMonth = Integer.parseInt(request.getParameter("m")) - 1; 
    }

    firstDate.set(Calendar.YEAR, targetYear);
    firstDate.set(Calendar.MONTH, targetMonth);
    firstDate.set(Calendar.DATE, 1);

    int lastDate = firstDate.getActualMaximum(Calendar.DATE);
    int startBlank = firstDate.get(Calendar.DAY_OF_WEEK) - 1;
    int totalCell = startBlank + lastDate;
    int endBlank = (totalCell % 7 != 0) ? 7 - (totalCell % 7) : 0;
    totalCell += endBlank;

    // DAO에서 월별 데이터 가져오기
    String yyyymm = String.format("%04d-%02d", targetYear, targetMonth + 1);
    CashDAO cashDAO = new CashDAO();
    HashMap<String, ArrayList<CashDTO>> map = cashDAO.selectMonthList(yyyymm);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= targetYear %>년 <%= targetMonth + 1 %>월</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.calendar {
	width: 100%;
	text-align: center;
}

td {
	height: 120px;
	vertical-align: top;
}

.sunday {
	color: red;
}

.saturday {
	color: blue;
}

.income {
	color: green;
	font-size: 0.9em;
}

.expense {
	color: red;
	font-size: 0.9em;
}

.record {
	font-size: 0.85em;
	margin-bottom: 4px;
}
</style>
</head>
<body class="p-4">
	<h1><%= targetYear %>년
		<%= targetMonth + 1 %>월
	</h1>

	<table class="table table-bordered calendar">
		<thead>
			<tr>
				<th class="sunday">일</th>
				<th>월</th>
				<th>화</th>
				<th>수</th>
				<th>목</th>
				<th>금</th>
				<th class="saturday">토</th>
			</tr>
		</thead>
		<tbody>
			<%
            for (int i = 0; i < totalCell; i++) {
                if (i % 7 == 0) out.println("<tr>");

                int day = i - startBlank + 1;
                if (i < startBlank || day > lastDate) {
                    out.println("<td></td>");
                } else {
                    String key = String.format("%04d-%02d-%02d", targetYear, targetMonth + 1, day);
                    out.println("<td><strong>" + day + "</strong><br/>");

                    if (map.containsKey(key)) {
                        for (CashDTO cash : map.get(key)) {
                            CategoryDTO category = cash.getCategoryDTO();
                            String kind = category.getKind();                       
                            String title = category.getTitle();
                            String memo = cash.getMemo();
                            int amount = cash.getAmount();
                            String color = cash.getColor(); 

                            out.println("<div class='record' style='color:" + color + ";'>"
                                + "[" + kind + "] " + title + "<br/>"
                                + memo + " - " + amount + "원"
                                + "</div>");
                        }
                    }

                    out.println("</td>");
                }

                if (i % 7 == 6) out.println("</tr>");
            }
        %>
		</tbody>
	</table>

	<div class="d-flex justify-content-between">
		<a class="btn btn-outline-primary"
			href="?y=<%= targetYear %>&m=<%= targetMonth %>">이전 달</a> <a
			class="btn btn-outline-primary"
			href="?y=<%= targetYear %>&m=<%= targetMonth + 2 %>">다음 달</a>
	</div>
</body>
</html>

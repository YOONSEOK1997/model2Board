<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.*, dto.*" %>
<%
    int cashNo = Integer.parseInt(request.getParameter("cashNo"));
    CashDAO dao = new CashDAO();
    CashDTO cash = dao.selectOne(cashNo);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내역 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-5">
    <div class="container bg-white p-4 shadow rounded">
        <h3>내역 수정</h3>
        <form action="updateCashAction.jsp" method="post">
            <input type="hidden" name="cashNo" value="<%= cash.getCashNo() %>">
            <div class="mb-3">
                <label>날짜</label>
                <input type="date" name="cashDate" class="form-control" value="<%= cash.getCashDate() %>">
            </div>
            <div class="mb-3">
                <label>금액</label>
                <input type="number" name="amount" class="form-control" value="<%= cash.getAmount() %>">
            </div>
            <div class="mb-3">
                <label>메모</label>
                <input type="text" name="memo" class="form-control" value="<%= cash.getMemo() %>">
            </div>
            <button type="submit" class="btn btn-primary">수정 완료</button>
            <a href="cashOne.jsp?cashNo=<%= cash.getCashNo() %>" class="btn btn-secondary">취소</a>
        </form>
    </div>
</body>
</html>

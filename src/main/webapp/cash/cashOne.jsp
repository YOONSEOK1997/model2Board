<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*, model.*, dto.*"%>

<%
    int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	String y = request.getParameter("y");
	String m = request.getParameter("m");
	String d = request.getParameter("d");
    CashDAO cashDao = new CashDAO();
    CashDTO cash = cashDao.selectOne(cashNo);
    
   
    
    ReceiptDAO recepitDao = new ReceiptDAO();
    ReceiptDTO receipt = recepitDao.selectReceiptByCashNo(cashNo);
    String filename = null;
    if (receipt != null && receipt.getFilename() != null) {
        filename = receipt.getFilename();
    }
    
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내역 상세</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-5">
    <div class="container bg-white shadow p-4 rounded">
        <h3>내역 상세</h3>
        <table class="table mt-3">
            <tr><th>날짜</th><td><%= cash.getCashDate() %></td></tr>
            <tr><th>종류</th><td><%= cash.getCategoryDTO().getKind() %></td></tr>
            <tr><th>카테고리</th><td><%= cash.getCategoryDTO().getTitle() %></td></tr>
            <tr><th>금액</th><td><%= cash.getAmount() %>원</td></tr>
            <tr><th>메모</th><td><%= cash.getMemo() %></td></tr>
            <tr><th>등록일</th><td><%= cash.getCreateDate() %></td></tr>
           
        </table>
       
        <a href="/cashbook/dateList.jsp?y=<%= y %>&m=<%= m %>&d=<%= d %>" class="btn btn-secondary">목록</a>
       
    <a href="updateCashForm.jsp?cashNo=<%= cash.getCashNo() %>&y=<%= y %>&m=<%= m %>&d=<%= d %>" class="btn btn-outline-primary">수정</a>
    <a href="deleteCashAction.jsp?cashNo=<%= cash.getCashNo() %>&y=<%= y %>&m=<%= m %>&d=<%= d %>" class="btn btn-outline-danger"
       onclick="return confirm('삭제하시겠습니까?');">삭제</a>
<a href="insertReceiptForm.jsp?cashNo=<%= cash.getCashNo() %>&y=<%= y %>&m=<%= m %>&d=<%= d %>" class="btn btn-outline-danger"
     >영수증 등록</a>
     <% if (filename != null) { %>
    <a href="deleteReceiptAction.jsp?cashNo=<%= cash.getCashNo() %>&y=<%= y %>&m=<%= m %>&d=<%= d %>" 
       class="btn btn-outline-warning" 
       onclick="return confirm('영수증을 삭제하시겠습니까?');">
        영수증 삭제
    </a>
<% } %>
     <div>
   </div>
    </div>
 <div class="d-flex justify-content-center mt-4">
<% if (filename != null) { %>
    <img src="/cashbook/upload/<%= filename %>" alt="영수증 이미지" width="300" height="500">
<% } else { %>
    <p class="text-muted">등록된 영수증이 없습니다.</p>
<% } %>

</div>
    
 
   
</body>
</html>

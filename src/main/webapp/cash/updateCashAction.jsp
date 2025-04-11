<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.*, dto.*" %>
<%
    int cashNo = Integer.parseInt(request.getParameter("cashNo"));
    String cashDate = request.getParameter("cashDate");
    int amount = Integer.parseInt(request.getParameter("amount"));
    String memo = request.getParameter("memo");

    CashDTO cash = new CashDTO();
    cash.setCashNo(cashNo);
    cash.setCashDate(cashDate);
    cash.setAmount(amount);
    cash.setMemo(memo);

    CashDAO cashDao = new CashDAO();
    cashDao.updateCash(cash);

    response.sendRedirect("cashOne.jsp?cashNo=" + cashNo);
%>

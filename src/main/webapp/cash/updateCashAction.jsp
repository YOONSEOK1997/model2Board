<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.*, dto.*" %>
<%
    int cashNo = Integer.parseInt(request.getParameter("cashNo"));
    String cashDate = request.getParameter("cashDate");
    int amount = Integer.parseInt(request.getParameter("amount"));
    String memo = request.getParameter("memo");
	String y = request.getParameter("y");
	String m = request.getParameter("m");
	String d = request.getParameter("d");

    CashDTO cash = new CashDTO();
    cash.setCashNo(cashNo);
    cash.setCashDate(cashDate);
    cash.setAmount(amount);
    cash.setMemo(memo);

    CashDAO cashDao = new CashDAO();
    cashDao.updateCash(cash);

	response.sendRedirect("/cashbook/cash/cashOne.jsp?cashNo="+ cashNo + "&y=" + y + "&m=" + m + "&d=" + d);
%>

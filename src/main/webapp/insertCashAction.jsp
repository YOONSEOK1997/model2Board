<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="model.*, dto.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    String cashDate = request.getParameter("cashDate");
    int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
    int amount = Integer.parseInt(request.getParameter("amount"));
    String memo = request.getParameter("memo");
    String color = request.getParameter("color");
    
    CashDTO Cashdto = new CashDTO();
    Cashdto.setCashDate(cashDate);
    Cashdto.setCategoryNo(categoryNo);
    Cashdto.setAmount(amount);
    Cashdto.setMemo(memo);
    Cashdto.setColor(color);

    CashDAO dao = new CashDAO();
    dao.insertCash(Cashdto);

    // 다시 해당 날짜로 리다이렉트
    String[] dateParts = cashDate.split("-");
    response.sendRedirect("dateList.jsp?y=" + dateParts[0] + "&m=" + dateParts[1] + "&d=" + dateParts[2]);
%>

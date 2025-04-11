<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="model.*"%>
<%
    int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	String y = request.getParameter("y");
	String m = request.getParameter("m");
	String d = request.getParameter("d");
	
    ReceiptDAO receiptDao = new ReceiptDAO();  //영수증 삭제 
    receiptDao.deleteReceipt(cashNo); 
    CashDAO cashDao = new CashDAO(); //CASH삭제
    cashDao.deleteCash(cashNo);
    
    
    response.sendRedirect("/cashbook/dateList.jsp?y=" + y + "&m=" + m + "&d=" + d);

%>

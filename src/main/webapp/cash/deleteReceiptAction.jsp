<%@page import="java.io.File"%>
<%@page import="dto.ReceiptDTO"%>
<%@page import="model.ReceiptDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>


<%
    int cashNo = Integer.parseInt(request.getParameter("cashNo"));
    String y = request.getParameter("y");
    String m = request.getParameter("m");
    String d = request.getParameter("d");

    ReceiptDAO receiptDao = new ReceiptDAO();
    ReceiptDTO receipt = receiptDao.selectReceiptByCashNo(cashNo);

    if (receipt != null && receipt.getFilename() != null) {
        // 파일 경로 설정
        String saveDir = application.getRealPath("/upload"); // 실제 경로
        String filePath = saveDir + File.separator + receipt.getFilename();

        File file = new File(filePath);
        if (file.exists()) {
            file.delete(); // 파일 삭제
        }

        // DB에서 삭제
        receiptDao.deleteReceipt(cashNo);
    }

    // 상세 페이지로 리다이렉트
    response.sendRedirect("cashOne.jsp?cashNo=" + cashNo + "&y=" + y + "&m=" + m + "&d=" + d);
%>

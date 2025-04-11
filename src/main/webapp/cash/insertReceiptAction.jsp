<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	System.out.println("받은 cashNo: " + cashNo);

	String y = request.getParameter("y");
	String m = request.getParameter("m");
	String d = request.getParameter("d");
	
	Part part = request.getPart("receiptFile"); 
	String originalName = part.getSubmittedFileName(); 
	System.out.println("originalName: "+originalName);
	

	UUID uuid = UUID.randomUUID();
	String filename = uuid.toString();
	filename = filename.replace("-", "");
	System.out.println("uuid str: "+filename);

	// 확장자 추가
	int dotLastPos = originalName.lastIndexOf("."); // 마지막 . 의 인덱스값 반환
	System.out.println("dotLastPos: "+dotLastPos);
	String ext = originalName.substring(dotLastPos);
	
	// Request 입력값 유효성 검정
	/* if(!ext.equals(".png")) {
		response.sendRedirect("/cashbook/cash/insertReceiptForm.jsp?msg=ErrorNotPng");
		return; // JSP 코드진행을 종료
	} */
	
	filename = filename + ext;
	System.out.println("filename: "+filename);
	
	ReceiptDTO receipt = new ReceiptDTO();
	receipt.setFilename(filename);
	receipt.setCashNo(cashNo); 
	// 파일저장
	// 빈파일 생성
	// File emptyFile = new File("c:/upload/a.png");
	String path = request.getServletContext().getRealPath("upload"); 
	// 톰켓안에 poll 프로젝트안 upload폴더 실제 물리적주소를 반환
	System.out.println("path: "+path);
	File emptyFile = new File(path, filename);
	// 파일을 보낼 inputstram 설정
	InputStream is = part.getInputStream(); // 파트안의 스트림(이미지파일의 바이너리파일)
	// 파일을 받을 outputstream 설정
	OutputStream os = Files.newOutputStream(emptyFile.toPath());
	is.transferTo(os); // inputstream binary -> 반복(1byte씩) -> outputstream
	
	// db저장
	ReceiptDAO receiptDao = new ReceiptDAO();
	receiptDao.insertReceipt(receipt);
	response.sendRedirect("/cashbook/cash/cashOne.jsp?cashNo="+ cashNo + "&y=" + y + "&m=" + m + "&d=" + d);
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>이미지 올리기</title>
    </head>
    <body>
   
    <form action="/cashbook/cash/insertReceiptAction.jsp" method="post" enctype="multipart/form-data">
    			
		       	<div>
		       			<input type="hidden" name="cashNo" value="<%= request.getParameter("cashNo") %>">
						<input type="hidden" name="y" value="<%= request.getParameter("y") %>">
						<input type="hidden" name="m" value="<%= request.getParameter("m") %>">
						<input type="hidden" name="d" value="<%= request.getParameter("d") %>">
		       	이미지 :  <input type="file" name="receiptFile">			
		       	</div>
		<button type="submit">이미지 등록</button>
    </form>
    </body>
</html>

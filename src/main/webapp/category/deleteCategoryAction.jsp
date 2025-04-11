<%@ page import="java.sql.*, model.*" %>
<%
    int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));

    CategoryDAO dao = new CategoryDAO();
    boolean result = dao.deleteCategory(categoryNo);

    if (!result) {
%>
    
        System.out.println("이 카테고리는 이미 사용 중이므로 삭제할 수 없습니다.");
        location.href = "categoryList.jsp";
   
<%
    } else {
%>

	    System.out.println("카테고리가 성공적으로 삭제되었습니다.");
        location.href = "categoryList.jsp";

<%
    }
%>

<%@ page import="model.*" %>
<%
    int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
    CategoryDAO dao = new CategoryDAO();
    dao.deleteCategory(categoryNo);
    response.sendRedirect("categoryList.jsp");
%>

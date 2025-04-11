<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, model.*, dto.*" %>

<%
String kind = request.getParameter("kind");
String title = request.getParameter("title");

if (kind != null && title != null && !kind.isEmpty() && !title.isEmpty()) {
    CategoryDTO category = new CategoryDTO();
    category.setKind(kind);
    category.setTitle(title);
    
    CategoryDAO categoryDAO = new CategoryDAO();
    categoryDAO.insertCategory(category);
}

// 등록 후 목록으로 이동
response.sendRedirect("categoryList.jsp");
%>

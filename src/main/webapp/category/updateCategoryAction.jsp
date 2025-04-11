<%@ page import="model.*, dto.*" %>
<%
    int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
    String kind = request.getParameter("kind");
    String title = request.getParameter("title");

    CategoryDTO c = new CategoryDTO();
    c.setCategoryNo(categoryNo);
    c.setKind(kind);
    c.setTitle(title);

    CategoryDAO dao = new CategoryDAO();
    dao.updateCategory(c);

    response.sendRedirect("categoryList.jsp");
%>

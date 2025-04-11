<%@ page import="java.sql.*, model.*" %>
<%
    int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));

    CategoryDAO dao = new CategoryDAO();
    boolean result = dao.deleteCategory(categoryNo); // 삭제 시도

    if (!result) {
%>
    <script>
        alert("이 카테고리는 이미 사용 중이므로 삭제할 수 없습니다.");
        location.href = "categoryList.jsp";
    </script>
<%
    } else {
%>
    <script>
        alert("카테고리가 성공적으로 삭제되었습니다.");
        location.href = "categoryList.jsp";
    </script>
<%
    }
%>

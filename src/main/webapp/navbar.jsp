<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>
<%
    String adminId = (String) session.getAttribute("adminId");
    if (adminId == null) {
        response.sendRedirect("/cashbook/login/loginForm.jsp"); // 로그인 안 했으면 로그인 페이지로 리다이렉트
        return;
    }
%>

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm px-4 py-2 mb-4">
    <div class="container-fluid">
        <span class="navbar-text me-auto">
            <strong><%= adminId %></strong>님 반갑습니다.
        </span>
        <form action="/cashbook/login/logout.jsp" method="post" class="d-flex mb-0">
            <button type="submit" class="btn btn-outline-secondary btn-sm">로그아웃</button>
        </form>
    </div>
</nav>

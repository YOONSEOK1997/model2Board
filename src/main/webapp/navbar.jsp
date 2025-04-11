<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>
<%
    String adminId = (String) session.getAttribute("adminId");
    if (adminId == null) {
        response.sendRedirect("/cashbook/login/loginForm.jsp");
        return;
    }
%>

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm px-4 py-2 mb-4">
    <div class="container-fluid d-flex justify-content-between align-items-center">
        <!-- 메뉴 영역 (왼쪽) -->
        <ul class="navbar-nav flex-row">
            <li class="nav-item me-3">
                <a class="nav-link" href="/cashbook/monthList.jsp">월별 보기</a>
            </li>
            <li class="nav-item me-3">
                <a class="nav-link" href="/cashbook/dateList.jsp">일별 보기</a>
            </li>
            <li class="nav-item me-3">
                <a class="nav-link" href="/cashbook/stats.jsp">통계</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/cashbook/category/categoryList.jsp">카테고리 관리</a>
            </li>
        </ul>

        <!-- 로고 영역 (가운데) -->
        <a class="navbar-brand position-absolute start-50 translate-middle-x d-flex align-items-center" href="/cashbook/monthList.jsp">
            <img src="/cashbook/assets/logo.png" alt="Cashbook Logo" width="30" height="30" class="me-2">
            <strong>cashbook</strong>
        </a>

        <!-- 사용자 영역 (오른쪽) -->
        <div class="d-flex align-items-center">
            <span class="navbar-text me-2">
                <strong><%= adminId %></strong>님 반갑습니다.
            </span>
            <form action="/cashbook/login/logout.jsp" method="post" class="mb-0">
                <button type="submit" class="btn btn-outline-secondary btn-sm">로그아웃</button>
            </form>
        </div>
    </div>
</nav>

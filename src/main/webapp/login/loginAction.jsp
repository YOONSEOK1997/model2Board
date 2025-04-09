
<%@ page import="dto.AdminDTO, model.LoginDAO" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    // 1. 파라미터 수집
    String adminId = request.getParameter("adminId");
    String adminPw = request.getParameter("adminPw");

    // 2. DTO에 저장
    AdminDTO dto = new AdminDTO();
    dto.setAdminId(adminId);
    dto.setAdminPw(adminPw);

    // 3. DAO로 로그인 검사
    LoginDAO dao = new LoginDAO();
    boolean isLogin = dao.selectLogin(dto);

    // 4. 로그인 결과 처리
    if (isLogin) {
        // 로그인 성공: 세션 저장 + 메인으로 이동
        session.setAttribute("adminId", adminId);
        response.sendRedirect("/cashbook/category/categoryList.jsp");
        System.out.println(adminId + "로그인성공");
    } else {
        // 로그인 실패: 다시 로그인 페이지로 (에러 표시용 파라미터 포함)
        response.sendRedirect("loginForm.jsp?loginError=true");
    }
    
%>

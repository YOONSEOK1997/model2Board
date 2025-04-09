<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.LoginDAO" %>
<%@ page import="java.sql.*" %>
<%
    String adminId = request.getParameter("adminId");
    String oldPw = request.getParameter("oldPw");
    String newPw = request.getParameter("newPw");


        LoginDAO dao = new LoginDAO();
        dao.updatePassword(adminId, oldPw, newPw);
        response.sendRedirect("updatePasswordForm.jsp?msg=success");
        

%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>로그인</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex justify-content-center align-items-center vh-100">
	
    <div class="card shadow p-4" style="width: 400px;">
        <h2 class="text-center mb-4">로그인</h2>
		
        <form action="loginAction.jsp" method="post">
            <div class="mb-3">
                <label for="adminId" class="form-label">아이디</label>
                <input type="text" class="form-control" name="adminId" id="adminId" required>
            </div>

            <div class="mb-3">
                <label for="adminPw" class="form-label">비밀번호</label>
                <input type="password" class="form-control" name="adminPw" id="adminPw" required>
            </div>

            <button type="submit" class="btn btn-primary w-100">로그인</button>
            <a href ="updatePasswordForm.jsp" >비밀번호 변경</a>
        </form>

        <%
            String loginError = request.getParameter("loginError");
            if ("true".equals(loginError)) {
        %>
             <div class="alert alert-danger mt-3">아이디 또는 비밀번호가 일치하지 않습니다.</div>
        <%
            }
        %>
    </div>
<br>


  </body>
</html>

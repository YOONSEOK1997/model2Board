<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>비밀번호 변경</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex justify-content-center align-items-center vh-100">

    <div class="card shadow p-4" style="width: 400px;">
        <h2 class="text-center mb-4">비밀번호 변경</h2>

        <form action="updatePasswordAction.jsp" method="post">
            <div class="mb-3">
                <label for="adminId" class="form-label">아이디</label>
                <input type="text" class="form-control" name="adminId" id="adminId" required>
            </div>

            <div class="mb-3">
                <label for="oldPw" class="form-label">현재 비밀번호</label>
                <input type="password" class="form-control" name="oldPw" id="oldPw" required>
            </div>

            <div class="mb-3">
                <label for="newPw" class="form-label">새 비밀번호</label>
                <input type="password" class="form-control" name="newPw" id="newPw" required>
            </div>

            <button type="submit" class="btn btn-primary w-100">변경하기</button>
        </form>

        <%
            String msg = request.getParameter("msg");
            if ("fail".equals(msg)) {
        %>
            <div class="alert alert-danger mt-3">비밀번호 변경 실패. 아이디 또는 현재 비밀번호를 확인하세요.</div>
        <%
            } else if ("success".equals(msg)) {
        %>
            <div class="alert alert-success mt-3">
                비밀번호가 성공적으로 변경되었습니다.
                <div class="d-grid mt-3">
                    <a href="loginForm.jsp" class="btn btn-outline-primary">로그인 페이지로 돌아가기</a>
                </div>
            </div>
        <%
            }
        %>
    </div>
</body>
</html>

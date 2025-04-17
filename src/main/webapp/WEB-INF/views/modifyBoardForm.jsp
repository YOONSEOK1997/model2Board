<%@page import="dto.BoardDto"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%
    BoardDto board = (BoardDto)request.getAttribute("board");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>글 수정</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container py-5">
    <h1 class="text-center mb-4">글 수정</h1>

    <!-- 에러 메시지 -->
    <%
        String error = request.getParameter("error");
        if (error != null) {
            if (error.equals("1")) {
    %>
        <div class="alert alert-danger" role="alert">
            비밀번호가 일치하지 않습니다.
        </div>
    <%
            } else if (error.equals("2")) {
    %>
        <div class="alert alert-danger" role="alert">
            수정에 실패했습니다. 다시 시도하세요.
        </div>
    <%
            }
        }
    %>

    <div class="card shadow-sm">
        <div class="card-body">
            <form method="post" action="<%= request.getContextPath() %>/modifyBoard">
                <input type="hidden" name="boardNo" value="<%= board.getBoardNo() %>">

                <div class="mb-3">
                    <label for="boardTitle" class="form-label">제목</label>
                    <input type="text" class="form-control" id="boardTitle" name="boardTitle" value="<%= board.getBoardTitle() %>" required>
                </div>

                <div class="mb-3">
                    <label for="boardContent" class="form-label">내용</label>
                    <textarea class="form-control" id="boardContent" name="boardContent" rows="5" required><%= board.getBoardContent() %></textarea>
                </div>

                <div class="mb-3">
                    <label for="boardPw" class="form-label">비밀번호</label>
                    <input type="password" class="form-control" id="boardPw" name="boardPw" required>
                </div>

                <div class="d-flex justify-content-end gap-2">
                    <button type="submit" class="btn btn-primary">수정하기</button>
                    <button type="button" class="btn btn-secondary" onclick="history.back()">뒤로가기</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS (선택) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

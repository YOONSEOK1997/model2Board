<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="dto.BoardDto" %>
<%
    BoardDto board = (BoardDto)request.getAttribute("board");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>게시글 상세보기</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .custom-header {
            background-color: #D1E7DD;
            color: #000;
        }
    </style>

    <script>
    function goModify() {
        location.href = "<%= request.getContextPath() %>/modifyBoard?boardNo=<%= board.getBoardNo() %>";
    }

    function goDelete() {
        var pw = prompt("비밀번호를 입력하세요");
        if (pw != null && pw != "") {
            location.href = "<%= request.getContextPath() %>/deleteBoard?boardNo=<%= board.getBoardNo() %>&boardPw=" + encodeURIComponent(pw);
        }
    }
    </script>
</head>
<body class="bg-light">

<div class="container py-5">
    <h1 class="text-center mb-4"> 게시글 상세보기</h1>

    <!-- 에러 메시지 출력 -->
    <%
        String error = request.getParameter("error");
        if ("2".equals(error)) {
    %>
        <div class="alert alert-danger" role="alert">
            비밀번호가 일치하지 않습니다.
        </div>
    <%
        }
    %>

    <div class="card shadow-sm">
        <div class="card-header custom-header">
            <h4 class="mb-0"><%= board.getBoardTitle() %></h4>
        </div>
        <div class="card-body">
            <p><strong>작성자 :</strong> <%= board.getBoardUser() %></p>
            <p><strong>작성일 :</strong> <%= board.getBoardDate() %></p>
            <hr>
            <p class="fs-5"><%= board.getBoardContent() %></p>
        </div>
        <div class="card-footer d-flex justify-content-end gap-2">
            <button class="btn btn-primary" onclick="goModify()">수정</button>
            <button class="btn btn-danger" onclick="goDelete()">삭제</button>
            <button class="btn btn-secondary" onclick="location.href='<%= request.getContextPath() %>/boardList'">목록으로</button>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

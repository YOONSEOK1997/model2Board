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

    <script>
    // 수정 페이지로 이동
    function goModify() {
        location.href = "<%= request.getContextPath() %>/modifyBoard?boardNo=<%= board.getBoardNo() %>";
    }

    // 삭제 기능
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
    <h1 class="text-center mb-4">게시글 상세보기</h1>

    <!-- 에러 메시지 출력 -->
    <%
        String error = request.getParameter("error");
        if ("2".equals(error)) {
    %>
        <div class="alert alert-danger text-center" role="alert">
            비밀번호가 일치하지 않습니다.
        </div>
    <%
        }
    %>

    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h2 class="mb-0"><%= board.getBoardTitle() %></h2>
        </div>
        <div class="card-body">
            <p class="mb-2"><strong>작성자 :</strong> <%= board.getBoardUser() %></p>
            <p class="mb-2"><strong>작성일 :</strong> <%= board.getBoardDate() %></p>
            <hr>
            <p class="card-text" style="white-space: pre-wrap;"><%= board.getBoardContent() %></p>
        </div>
    </div>

    <div class="mt-4 d-flex justify-content-center

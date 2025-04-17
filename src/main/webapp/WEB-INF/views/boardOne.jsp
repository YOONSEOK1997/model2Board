<%@page import="dto.BoardDto"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%
    BoardDto board = (BoardDto)request.getAttribute("board");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>�Խñ� �󼼺���</title>

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
        var pw = prompt("��й�ȣ�� �Է��ϼ���");
        if (pw != null && pw != "") {
            location.href = "<%= request.getContextPath() %>/deleteBoard?boardNo=<%= board.getBoardNo() %>&boardPw=" + encodeURIComponent(pw);
        }
    }
    </script>
</head>
<body class="bg-light">

<div class="container py-5">
    <h1 class="text-center mb-4"> �Խñ� �󼼺���</h1>

    <!-- ���� �޽��� ��� -->
    <%
        String error = request.getParameter("error");
        if ("2".equals(error)) {
    %>
        <div class="alert alert-danger" role="alert">
            ��й�ȣ�� ��ġ���� �ʽ��ϴ�.
        </div>
    <%
        }
    %>

    <div class="card shadow-sm">
        <div class="card-header custom-header">
            <h4 class="mb-0"><%= board.getBoardTitle() %></h4>
        </div>
        <div class="card-body">
            <p><strong>�ۼ��� :</strong> <%= board.getBoardUser() %></p>
            <p><strong>�ۼ��� :</strong> <%= board.getBoardDate() %></p>
            <hr>
            <p class="fs-5"><%= board.getBoardContent() %></p>
        </div>
        <div class="card-footer d-flex justify-content-end gap-2">
            <button class="btn btn-primary" onclick="goModify()">����</button>
            <button class="btn btn-danger" onclick="goDelete()">����</button>
            <button class="btn btn-secondary" onclick="location.href='<%= request.getContextPath() %>/boardList'">�������</button>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

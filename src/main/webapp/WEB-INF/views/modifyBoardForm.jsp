<%@page import="dto.BoardDto"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%
    BoardDto board = (BoardDto)request.getAttribute("board");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>�� ����</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container py-5">
    <h1 class="text-center mb-4">�� ����</h1>

    <!-- ���� �޽��� -->
    <%
        String error = request.getParameter("error");
        if (error != null) {
            if (error.equals("1")) {
    %>
        <div class="alert alert-danger" role="alert">
            ��й�ȣ�� ��ġ���� �ʽ��ϴ�.
        </div>
    <%
            } else if (error.equals("2")) {
    %>
        <div class="alert alert-danger" role="alert">
            ������ �����߽��ϴ�. �ٽ� �õ��ϼ���.
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
                    <label for="boardTitle" class="form-label">����</label>
                    <input type="text" class="form-control" id="boardTitle" name="boardTitle" value="<%= board.getBoardTitle() %>" required>
                </div>

                <div class="mb-3">
                    <label for="boardContent" class="form-label">����</label>
                    <textarea class="form-control" id="boardContent" name="boardContent" rows="5" required><%= board.getBoardContent() %></textarea>
                </div>

                <div class="mb-3">
                    <label for="boardPw" class="form-label">��й�ȣ</label>
                    <input type="password" class="form-control" id="boardPw" name="boardPw" required>
                </div>

                <div class="d-flex justify-content-end gap-2">
                    <button type="submit" class="btn btn-primary">�����ϱ�</button>
                    <button type="button" class="btn btn-secondary" onclick="history.back()">�ڷΰ���</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS (����) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

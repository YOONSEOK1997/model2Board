<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*, model.*, dto.*" %>
<%@ include file="/navbar.jsp"%>
<%
    String y = request.getParameter("y");
    String m = request.getParameter("m");
    String d = request.getParameter("d");

    String cashDate = String.format("%s-%02d-%02d", y, Integer.parseInt(m), Integer.parseInt(d));

    // 카테고리 불러오기
    CategoryDAO categoryDAO = new CategoryDAO();
    ArrayList<CategoryDTO> categoryList = categoryDAO.selectAllCategory(); 
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내역 추가 - <%= cashDate %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-5">
    <div class="container bg-white p-4 rounded shadow">
        <h3><%= cashDate %> 가계부 내역 추가</h3>

        <form action="insertCashAction.jsp" method="post">
            <input type="hidden" name="cashDate" value="<%= cashDate %>">
			<div class="mb-3">
			    <label for="color" class="form-label">색상</label>
			    <input type="color" name="color" class="form-control"  required>
			</div>
            <div class="mb-3">
                <label for="kind" class="form-label">종류</label>
                <select name="kind" class="form-select" required>
                    <option value="">-- 선택 --</option>
                    <option value="수입">수입</option>
                    <option value="지출">지출</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="categoryNo" class="form-label">카테고리</label>
                <select name="categoryNo" class="form-select" required>
                    <option value="">-- 선택 --</option>
                    <% for (CategoryDTO c : categoryList) { %>
                        <option value="<%= c.getCategoryNo() %>">
                            [<%= c.getKind() %>] <%= c.getTitle() %>
                        </option>
                    <% } %>
                </select>
            </div>

            <div class="mb-3">
                <label for="amount" class="form-label">금액</label>
                <input type="number" name="amount" class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="memo" class="form-label">메모</label>
                <input type="text" name="memo" class="form-control">
            </div>

            <button type="submit" class="btn btn-primary">등록</button>
            <a href="cashbook/dateList.jsp?y=<%= y %>&m=<%= m %>&d=<%= d %>" class="btn btn-secondary">취소</a>
        </form>
    </div>
</body>
</html>

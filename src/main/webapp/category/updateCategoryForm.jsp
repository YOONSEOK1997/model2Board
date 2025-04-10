<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="dto.*, model.*, java.util.*" %>
<%
    int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
    CategoryDAO categoryDao = new CategoryDAO();
    CategoryDTO categoryDto = categoryDao.selectCategoryByNo(categoryNo);
%>
<!DOCTYPE html>
<html>
<head>
    <title>카테고리 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="/cashbook/css/cashbook.css?after">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card shadow-sm">
            <div class="card-header bg-warning text-white">
                <h4>카테고리 수정</h4>
            </div>
            <div class="card-body">
               <form action="updateCategoryAction.jsp" method="post">
    <input type="hidden" name="categoryNo" value="<%= categoryDto.getCategoryNo() %>">

    <div class="mb-3">
        <label class="form-label d-block">종류</label>
        <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="kind" value="수입" id="incomeRadio"
                <%= categoryDto.getKind().equals("수입") ? "checked" : "" %>>
            <label class="form-check-label" for="incomeRadio">수입</label>
        </div>
        <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="kind" value="지출" id="expenseRadio"
                <%= categoryDto.getKind().equals("지출") ? "checked" : "" %>>
            <label class="form-check-label" for="expenseRadio">지출</label>
        </div>
    </div>

    <div class="mb-3">
        <label class="form-label">제목</label>
        <input type="text" name="title" class="form-control" value="<%= categoryDto.getTitle() %>" required>
    </div>
    <button type="submit" class="btn btn-primary">수정</button>
    <a href="categoryList.jsp" class="btn btn-secondary">취소</a>
</form>

            </div>
        </div>
    </div>
</body>
</html>

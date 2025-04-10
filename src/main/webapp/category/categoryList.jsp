<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="dto.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*"%>
<%@ include file="/navbar.jsp"%>

<%
int currentPage = 1;
if (request.getParameter("currentPage") != null) {
    currentPage = Integer.parseInt(request.getParameter("currentPage"));
}
int rowPerPage = 10;
Paging paging = new Paging();
paging.setCurrentPage(currentPage);
paging.setRowPerPage(rowPerPage);

CategoryDAO categoryDAO = new CategoryDAO();
ArrayList<CategoryDTO> list = categoryDAO.selectCategoryList(paging);
%>

<!DOCTYPE html>
<html>
<head>
<title>카테고리 목록</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body {
	background-color: #f8f9fa;
}

.title-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.btn-add {
	font-size: 16px;
}
</style>
</head>
<body>

	<div class="container bg-white rounded shadow p-4">
		<div class="title-bar mb-4">
			<h2 class="text-primary">
				<i class="fa-solid fa-list-ul"></i> 카테고리 목록
			</h2>

			<button type="button"
				onclick="location.href='insertCategoryForm.jsp'"
				class="btn btn-primary btn-add">
				<i class="fa-solid fa-plus"></i> 카테고리 등록
			</button>

		</div>

		<table class="table table-hover text-center align-middle">
			<thead class="table-primary">
				<tr>
					<th scope="col"><i class="fa-solid fa-hashtag"></i> 번호</th>
					<th scope="col"><i class="fa-solid fa-layer-group"></i> 종류</th>
					<th scope="col"><i class="fa-solid fa-tag"></i> 제목</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<%
                for (CategoryDTO c : list) {
            %>
				<tr>
					<td><%= c.getCategoryNo() %></td>
					<td><%= c.getKind().equals("지출") ? "<i class='fa-solid fa-minus text-danger'></i> 지출" 
                                                      : "<i class='fa-solid fa-plus text-success'></i> 수입" %>
					</td>
					<td><%= c.getTitle() %></td>
					<td><a
						href="updateCategoryForm.jsp?categoryNo=<%= c.getCategoryNo() %>"
						class="btn btn-sm btn-secondary">수정</a> <a
						href="deleteCategoryAction.jsp?categoryNo=<%= c.getCategoryNo() %>"
						class="btn btn-sm btn-danger"
						onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a></td>

				</tr>
				<%
                }
            %>
			</tbody>
		</table>

		<nav class="d-flex justify-content-center mt-4">
			<ul class="pagination">
				<li class="page-item <%= currentPage == 1 ? "disabled" : "" %>">
					<a class="page-link"
					href="?currentPage=<%= currentPage > 1 ? currentPage - 1 : 1 %>">
						<i class="fa-solid fa-angle-left"></i> 이전
				</a>
				</li>
				<li class="page-item"><a class="page-link"
					href="?currentPage=<%= currentPage + 1 %>"> 다음 <i
						class="fa-solid fa-angle-right"></i>
				</a></li>
			</ul>

		</nav>
		<button type="button"
			onclick="location.href='/cashbook/monthList.jsp'"
			class="btn btn-primary btn-info">달력으로 이동하기</button>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>카테고리 등록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script> <!-- 아이콘 -->
<link rel="stylesheet" type="text/css" href="/cashbook/css/cashbook.css?after">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card shadow-sm">
            <div class="card-header bg-primary text-white">
                <h4><i class="fas fa-plus-circle"></i> 카테고리 등록</h4>
            </div>
            <div class="card-body">
              <form action="insertCategoryAction.jsp" method="post">
    <div class="mb-3">
        <label class="form-label d-block">종류</label>
        <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="kind" value="수입" id="incomeRadio" checked>
            <label class="form-check-label" for="incomeRadio">수입</label>
        </div>
        <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="kind" value="지출" id="expenseRadio">
            <label class="form-check-label" for="expenseRadio">지출</label>
        </div>
    </div>
    <div class="mb-3">
        <label class="form-label">제목</label>
        <input type="text" name="title" class="form-control" required>
    </div>
    <button type="submit" class="btn btn-success">등록</button>
    <a href="categoryList.jsp" class="btn btn-secondary">목록으로</a>
</form>

            </div>
        </div>
    </div>
</body>
</html>

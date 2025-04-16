<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>글쓰기</title>
</head>
<body>
    <h1>글쓰기</h1>
    <form method="post" action="${pageContext.request.contextPath}/insertBoard">
        비밀번호: <input type="password" name="boardPw" required><br>
        제목: <input type="text" name="boardTitle" required><br>
        내용: <textarea name="boardContent" rows="5" cols="50" required></textarea><br>
        작성자: <input type="text" name="boardUser" required><br>
        <input type="submit" value="등록">
    </form>
</body>
</html>

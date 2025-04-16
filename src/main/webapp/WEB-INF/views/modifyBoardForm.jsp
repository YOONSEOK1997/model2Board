<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="dto.BoardDto" %>
<%
    BoardDto board = (BoardDto)request.getAttribute("board");

%>
<%
    String error = request.getParameter("error");
    if (error != null) {
        if (error.equals("1")) {
%>
    <p style="color:red;">비밀번호가 일치하지 않습니다.</p>
<%
        } else if (error.equals("2")) {
%>
    <p style="color:red;">수정에 실패했습니다. 다시 시도하세요.</p>
<%
        }
    }
%>

<h1>글 수정</h1>
<form method="post" action="<%= request.getContextPath() %>/modifyBoard">
    <input type="hidden" name="boardNo" value="<%= board.getBoardNo() %>">
    제목: <input type="text" name="boardTitle" value="<%= board.getBoardTitle() %>"><br>
    내용: <textarea name="boardContent"><%= board.getBoardContent() %></textarea><br>
    비밀번호: <input type="password" name="boardPw"><br>
    <button type="submit">수정하기</button>
</form>

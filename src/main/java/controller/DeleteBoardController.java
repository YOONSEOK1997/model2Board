package controller;

import java.io.IOException;
import dao.BoardDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/deleteBoard")
public class DeleteBoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		String boardPw = request.getParameter("boardPw");

		BoardDao dao = new BoardDao();
		int row = dao.deleteBoard(boardNo, boardPw);

		if (row == 1) {
			// 삭제 성공
			response.sendRedirect(request.getContextPath() + "/boardList?delete=success");
		} else {
			// 삭제 실패 (비밀번호 틀림)
			response.sendRedirect(request.getContextPath() + "/boardOne?boardNo=" + boardNo + "&error=2");
		}
	}
}

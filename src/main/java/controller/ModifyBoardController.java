package controller;

import java.io.IOException;

import dao.BoardDao;
import dto.BoardDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/modifyBoard")
public class ModifyBoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// 수정 폼 페이지 이동 (GET)
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//	int boardNo = 11;
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		BoardDao dao = new BoardDao();
		BoardDto board = dao.selectBoardOne(boardNo);

		request.setAttribute("board", board);
		request.getRequestDispatcher("/WEB-INF/views/modifyBoardForm.jsp").forward(request, response);

	}


	// 수정 처리 (POST)
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("EUC-KR");

		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		String boardPw = request.getParameter("boardPw");
		String boardTitle = request.getParameter("boardTitle");
		String boardContent = request.getParameter("boardContent");

		BoardDto board = new BoardDto();
		board.setBoardNo(boardNo);
		board.setBoardPw(boardPw);
		board.setBoardTitle(boardTitle);
		board.setBoardContent(boardContent);

		BoardDao boardDao = new BoardDao();

		// 비밀번호 확인
		boolean pwCheck = boardDao.checkBoardPw(boardNo, boardPw);
		if (pwCheck) {
			// 비밀번호 맞으면 수정
			int row = boardDao.updateBoard(board);
			if (row == 1) {
				response.sendRedirect(request.getContextPath() + "/boardList");
			} else {
				response.sendRedirect(request.getContextPath() + "/modifyBoard?boardNo=" + boardNo + "&error=2");
			}
		} else {
			// 비밀번호 틀림
			response.sendRedirect(request.getContextPath() + "/modifyBoard?boardNo=" + boardNo + "&error=1");
		}
	}

}
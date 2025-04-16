package controller;

import java.io.IOException;

import dao.BoardDao;
import dto.BoardDto;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/boardOne")
public class BoardOneController extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int boardNo = Integer.parseInt(request.getParameter("boardNo"));

        BoardDao dao = new BoardDao();
        BoardDto board = dao.selectBoardOne(boardNo);

        request.setAttribute("board", board);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/boardOne.jsp");
        dispatcher.forward(request, response);
    }
}

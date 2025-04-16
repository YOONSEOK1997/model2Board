package controller;

import java.io.IOException;
import dao.BoardDao;
import dto.BoardDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/insertBoard")
public class InsertBoardController extends HttpServlet {
    private static final long serialVersionUID = 1L;

   
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/insertBoardForm.jsp").forward(request, response);
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	request.setCharacterEncoding("EUC-KR");
        String boardPw = request.getParameter("boardPw");
        String boardTitle = request.getParameter("boardTitle");
        String boardContent = request.getParameter("boardContent");
        String boardUser = request.getParameter("boardUser");

        BoardDto board = new BoardDto();
        board.setBoardPw(boardPw);
        board.setBoardTitle(boardTitle);
        board.setBoardContent(boardContent);
        board.setBoardUser(boardUser);

        BoardDao dao = new BoardDao();
        int row = dao.insertBoard(board);

        if (row == 1) {
            response.sendRedirect(request.getContextPath() + "/boardList");
        } else {
            response.sendRedirect(request.getContextPath() + "/insertBoardForm?error=1");
        }
    }
}

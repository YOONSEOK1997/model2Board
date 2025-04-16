package controller;

import java.io.IOException;
import java.util.ArrayList;

import dao.BoardDao;
import dto.BoardDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/boardList")
public class BoardListController extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int currentPage = 1;
        int pagePerRow = 5;

        if (request.getParameter("currentPage") != null) {
            currentPage = Integer.parseInt(request.getParameter("currentPage"));
        }

        BoardDao dao = new BoardDao();
        ArrayList<BoardDto> list = dao.selectBoardList(currentPage, pagePerRow);
        int totalRow = dao.selectBoardCount();
        int lastPage = totalRow / pagePerRow;
        if (totalRow % pagePerRow != 0) {
            lastPage++;
        
        }
     
        request.setAttribute("list", list);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("lastPage", lastPage);
        request.setAttribute("list", list);
        request.getRequestDispatcher("/WEB-INF/views/boardList.jsp").forward(request, response);
    
    }
}

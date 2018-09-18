package user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/JoinCheckServlet")
public class JoinCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		String userID = request.getParameter("userID");
		String userEmail = request.getParameter("userEmail");
		
		if(userEmail == null) {
			System.out.println(new UserDAO().joinCheck(userID));
			response.getWriter().write(new UserDAO().joinCheck(userID) + "");
		}
		else if(userID == null) {
			boolean email_result = new UserDAO().getExistEmailChecked(userEmail);
			if(email_result == false)
				response.getWriter().write("1");
			else
				response.getWriter().write("0");
		}
	}
}

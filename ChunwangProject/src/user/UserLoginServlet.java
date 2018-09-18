package user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String userID = request.getParameter("userID");
		String userPassword = request.getParameter("userPassword");
		
		if(userID == null || userPassword == null || userID.equals("") || userPassword.equals("")) {
			request.getSession().setAttribute("msgType", "2");
			request.getSession().setAttribute("msgContent", "아이디와 비밀번호를 입력해주세요.");
			response.sendRedirect("userLogin.jsp");
			return;
		}
		
		int result = new UserDAO().login(userID, userPassword);
		
		if(result == 1) {
			request.getSession().setAttribute("userID", userID);
			request.getSession().setAttribute("nickName", new UserDAO().getNickname(userID));
			
			request.getSession().setAttribute("msgType", "1");
			request.getSession().setAttribute("msgContent", "로그인 되었습니다.");
			response.sendRedirect("userLogin.jsp");
			return;
		}
		else if(result == 0 || result == -1) {
			request.getSession().setAttribute("msgType", "2");
			request.getSession().setAttribute("msgContent", "아이디나 비밀번호가 틀립니다.");
			response.sendRedirect("userLogin.jsp");
			return;
		}
		else {
			request.getSession().setAttribute("msgType", "3");
			request.getSession().setAttribute("msgContent", "데이터베이스 오류입니다. 관리자에게 문의하십시오.");
			response.sendRedirect("userLogin.jsp");
			return;
		}
	}
}

package user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/NicknameServlet")
public class NicknameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String nickName = request. getParameter("nickName");
		HttpSession session= request.getSession(true);
		String userID = (String)session.getAttribute("userID");
		
		// 닉네임 칸에 입력이 없을 떄
		if(nickName == null) {
			response.getWriter().write("2");
			return;
		}
		
		UserDAO userdao = new UserDAO();
		String result1 = userdao.isExistNickname(nickName);
		
		// 닉네임이 이미 사용중일 때
		if(result1 != null) {
			response.getWriter().write("3");
			return;
		}
		
		int result2 = userdao.changeNickName(userID, nickName);

		if(result2 == 1) {
			session.setAttribute("nickName", nickName);
			response.getWriter().write("1");
			return;
		} else {
			response.getWriter().write("4");
			return;
		}
	}
}

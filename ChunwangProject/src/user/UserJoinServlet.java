package user;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class UserJoinServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String userID = request.getParameter("userID");
		String userPassword = request.getParameter("userPassword");
		String userPasswordCheck = request. getParameter("userPasswordCheck");
		String userName = request. getParameter("userName");
		String userEmail = request. getParameter("userEmail");
		
		String secretkey = "6LeaNGoUAAAAAPmAgP8Wr-QWafwcyIs-v4ROHqQE";
		String captcha = request.getParameter("g-recaptcha-response");
		
		URL url = new URL("https://www.google.com/recaptcha/api/siteverify?secret="+secretkey+"&response="+captcha+"&remoteip="+request.getRemoteAddr());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		String line, outputString = "";
		BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		
		while ((line = reader.readLine()) != null) {
		    outputString += line;
		}
		JsonParser jsonParser = new JsonParser();
		JsonObject jsonObject = (JsonObject) jsonParser.parse(outputString);
		boolean verify = jsonObject.get("success").getAsBoolean();
		
		if(verify == false) {
			request.getSession().setAttribute("msgType", "2");
			request.getSession().setAttribute("msgContent", "�ڵ����Թ����� üũ���ּ���.");
			response.sendRedirect("userJoin.jsp");
			return;
		}
		
		if(userID == null || userPassword == null || userPasswordCheck == null || userName == null ||
				userEmail == null || userID.equals("") || userPassword.equals("") || userPasswordCheck.equals("") ||
				userName.equals("") || userEmail.equals("")) {
			request.getSession().setAttribute("msgType", "2");
			request.getSession().setAttribute("msgContent", "��� ������ �Է����ּ���.");
			response.sendRedirect("userJoin.jsp");
			return;
		}
		if(!userPassword.equals(userPasswordCheck)) {
			request.getSession().setAttribute("msgType", "2");
			request.getSession().setAttribute("msgContent", "��й�ȣ�� ���� �ٸ��ϴ�.");
			response.sendRedirect("userJoin.jsp");
			return;
		}
		
		String email_result = new UserDAO().isExistEmail(userEmail);
		
	 	if(email_result != null ) {
			boolean checked = new UserDAO().getExistEmailChecked(userEmail);
			
			if(checked == true) {
				request.getSession().setAttribute("msgType", "2");
				request.getSession().setAttribute("msgContent", "�̹� ������ ����� �̸��� �Դϴ�.");
				response.sendRedirect("userJoin.jsp");
				return;
			}
		}
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		String time = dateFormat.format(cal.getTime());
		
		int result = new UserDAO().join(userID, userPassword, userName, userEmail, time);
		if(result == 1) {
			request.getSession().setAttribute("userID", userID);
			request.getSession().setAttribute("nickName", new UserDAO().getNickname(userID));
			
			request.getSession().setAttribute("msgType", "1");
			request.getSession().setAttribute("msgContent", "ȸ�������� �Ϸ�Ǿ����ϴ�.");
			response.sendRedirect("emailSendAction.jsp");
			return;
		}
		else if(result == -2) {
			request.getSession().setAttribute("msgType", "2");
			request.getSession().setAttribute("msgContent", "�̹� �����ϴ� ���̵��Դϴ�.");
			response.sendRedirect("userJoin.jsp");
			return;
		}
		else {
			request.getSession().setAttribute("msgType", "3");
			request.getSession().setAttribute("msgContent", "�����ͺ��̽� �����Դϴ�. �����ڿ��� �����Ͻʽÿ�.");
			response.sendRedirect("userJoin.jsp");
			return;
		}
	}
}

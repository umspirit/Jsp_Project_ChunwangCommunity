<%@page import="contents.ContentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>

<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	
	if(session.getAttribute("userID") != null) {
		userID = (String)session.getAttribute("userID");
	}
	
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.')");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
	String passwd = null;
	String passwdcheck = null;
	
	if(request.getParameter("passwd") != null) {
		passwd = request.getParameter("passwd");
	}
	if(request.getParameter("passwdcheck") != null) {
		passwdcheck = request.getParameter("passwdcheck");
	}
	
	if(passwd == null || passwdcheck == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("'history.back()';");
		script.println("</script>");
		script.close();
		return;
	}
	if(!passwd.equals(passwdcheck)) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 서로 다릅니다.')");
		script.println("'history.back()';");
		script.println("</script>");
		script.close();
		return; 
	}
	
	UserDAO userdao = new UserDAO();
	boolean result = userdao.changePw(userID, passwd);

	if(result == false) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호 변경에 실패하였습니다.')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 정상적으로 변경되었습니다..')");
		script.println("location.href = 'myPage.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>
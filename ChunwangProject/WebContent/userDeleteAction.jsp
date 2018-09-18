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
	
	UserDAO userdao = new UserDAO();
	boolean result = userdao.deleteUser(userID);

	if(result == false) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('회원탈퇴에 실패하였습니다.')");
		script.println("location.href = 'index.jsp'");
		script.println("<script>");
		script.close();
		return;
	} else {
		session.invalidate();
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('정상적으로 탈퇴처리되었습니다..')");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>
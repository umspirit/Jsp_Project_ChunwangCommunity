<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.TimeZone"%>

<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	
	if(session.getAttribute("userID") != null) {
		userID = (String)session.getAttribute("userID");
	}
	if(userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 된 상태입니다.')");
		script.println("location.href = 'index.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
	String userName = null;
	String userEmail = null;
	
	if(request.getParameter("userName") != null) {
		userName = request.getParameter("userName");
	}
	if(request.getParameter("userEmail") != null) {
		userEmail = request.getParameter("userEmail").toLowerCase();
	}
	if(userName == null || userEmail == null || userName.equals("") || userEmail.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	String tmpid = new UserDAO().getIdFind(userName, userEmail);
	
	if(tmpid == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('가입되어 있지 않은 정보입니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	else {
		session.setAttribute("tmpid", tmpid.toLowerCase());
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'idShowPage.jsp';");
		script.println("</script>");
		script.close();
	}
%>
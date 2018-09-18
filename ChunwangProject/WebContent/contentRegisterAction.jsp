<%@page import="contents.ContentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="contents.ContentDAO" %>
<%@ page import="contents.ContentDTO" %>
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
	
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.')");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
	String topicName = null;
	String contentName = null;
	String boardDivide = (String)session.getAttribute("boardDivide");
	
	if(request.getParameter("topicName") != null) {
		topicName = request.getParameter("topicName");
	}
	if(request.getParameter("contentName") != null) {
		contentName = request.getParameter("contentName");
	}
	
	if(topicName == null || contentName == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("'history.back()';");
		script.println("</script>");
		script.close();
		return;
	}
	if(boardDivide == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('세션 오류가 발생하였습니다.')");
		script.println("location.href = 'index.jsp';");
		script.println("</script>");
		script.close();
		return; 
	}
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd  HH:mm:ss");  
	Date dTime = new Date();
	TimeZone tz = TimeZone.getTimeZone("Asia/Seoul");
	sdf.setTimeZone(tz);
	String time = sdf.format(dTime);
	
	contents.ContentDAO cntDAO = new contents.ContentDAO();
	int result = cntDAO.write(new contents.ContentDTO(0, userID, topicName, contentName, time, boardDivide, 0, 0));

	if(result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('글 작성에 실패했습니다.')");
		script.println("history.back();");
		script.println("<script>");
		script.close();
		return;
	} else {
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = \'" + boardDivide + ".jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>
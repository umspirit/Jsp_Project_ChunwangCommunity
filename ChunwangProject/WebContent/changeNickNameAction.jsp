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
	
	String nickName = null;
	
	if(request.getParameter("nickName") != null) {
		nickName = request.getParameter("nickName");
	}
	
	if(nickName == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("'history.back()';");
		script.println("</script>");
		script.close();
		return;
	}
	
	UserDAO userdao = new UserDAO();
	String result1 = userdao.isExistNickname(nickName);
	
	System.out.println(result1);
	if(result1 != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 사용중인 닉네임입니다.')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	int result2 = userdao.changeNickName(userID, nickName);

	if(result2 == 1) {
		session.setAttribute("nickName", nickName);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('닉네임이 정상적으로 변경되었습니다.')");
		script.println("location.href = 'myPage.jsp'");
		script.println("</script>");
		script.close();
		return;
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('닉네임 변경에 실패하였습니다.')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
%>
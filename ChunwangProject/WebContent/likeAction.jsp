<%@ page import="like.LikeDAO"%>
<%@ page import="like.LikeDTO" %>
<%@ page import="contents.ContentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	
	int writeID = 0;
	String boardType = "";
	
	if(request.getParameter("boardType") != null) {
		boardType = request.getParameter("boardType");
	}
	if(request.getParameter("writeID") != null) {
		writeID = Integer.parseInt(request.getParameter("writeID"));
	}
	
	if(boardType == null || writeID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('페이지 오류입니다.')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}

	LikeDAO likedao = new LikeDAO();
	int result = likedao.LikeUp(boardType, writeID, userID);
	 
	if(result == -2) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 추천을 누르셨습니다.')");
		script.println("history.back();");
		script.println("</script>");
		return;
	} else {
		likedao.setLikeCount(boardType, writeID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('추천 하였습니다.')");
		script.println("location.href = './contentView.jsp?boardType="+ boardType +"&idx=" + writeID + "';");
		script.println("</script>");
		return;
	}
%>
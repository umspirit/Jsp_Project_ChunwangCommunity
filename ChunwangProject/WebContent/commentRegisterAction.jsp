<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="comment.CommentDAO" %>
<%@ page import="comment.CommentDTO" %>
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
	
	String commentContent = null;
	String boardType = null;
	int idx = 0;
	int preComment = 0;
	
	if(request.getParameter("commentContent") != null) {
		commentContent = request.getParameter("commentContent");
	}
	if(request.getParameter("boardType") != null) {
		boardType = request.getParameter("boardType");
	}
	if(request.getParameter("idx") != null) {
		idx = Integer.parseInt(request.getParameter("idx"));
	}
	if(request.getParameter("preComment") != null) {
		preComment = Integer.parseInt(request.getParameter("preComment"));
	}
	System.out.println(preComment);
	
	if(commentContent == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	if(boardType == null || idx == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('페이지 오류가 발생하였습니다.');");
		script.println("location.href = 'index.jsp';");
		script.println("</script>");
		script.close();
		return; 
	}
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd  hh:mm:ss");  
	Date dTime = new Date();
	TimeZone tz = TimeZone.getTimeZone("Asia/Seoul");
	sdf.setTimeZone(tz);
	String time = sdf.format(dTime);
	
	CommentDAO cmtDAO = new CommentDAO();
	int result = cmtDAO.commentWrite(new CommentDTO(0, idx, preComment, userID, commentContent, time, boardType));

	if(result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('글 작성에 실패했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} 
 	else {
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = \'contentView.jsp?boardType=" + boardType + "&idx=" + idx + "\';");
		script.println("</script>");
		script.close();
		return;
	}
%>
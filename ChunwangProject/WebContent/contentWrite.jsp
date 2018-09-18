<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.io.*" %>
<%@ page import="java.lang.String" %>
<%@ page import="contents.*" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.UserDTO" %>
<%@ page import="comment.CommentDTO"%>
<%@ page import="comment.CommentDAO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>천왕 광장</title>
	<meta http-equiv="Content-Type" content="text.html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fot=no">
	<!-- 부트스트랩 css 추가 -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<!-- 커스텀 css 추가하기 -->
	<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String)session.getAttribute("userID");
	}
	String nick = null;
	if(session.getAttribute("nickName") != null) {
		nick = (String)session.getAttribute("nickName");
	}
	
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요 !');");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
	
	if(emailChecked == false) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'eamilSendConfirm.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
	String boardType = null;
	
	if(request.getParameter("boardType") != null) {
		boardType = (String)request.getParameter("boardType");
	}
	if(boardType == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand mr-5" href="index.jsp">천왕 광장</a>
		<button class="navbar-toggler " type="button" data-toggle="collapse" data-target="#navbar">
		</button>
			<ul class="navbar-nav mr-auto">
				<li class="nav-item">
<%
	if(boardType.equals("freeboard")) {
%>
					<a class="nav-link active" style="font-weight: bold; border-bottom: solid 2px #343A40;" href="freeboard.jsp">자유광장</a>
<%
	} else {
%>
					<a class="nav-link" href="freeboard.jsp">자유광장</a>
<%
	}
%>
				</li>
				<li class="nav-item">
<%
	if(boardType.equals("anonboard")) {
%>
					<a class="nav-link active" style="font-weight: bold; border-bottom: solid 2px #343A40;" href="anonboard.jsp">익명광장</a>
<%
	} else {
%>
					<a class="nav-link" href="anonboard.jsp">익명광장</a>
<%
	}
%>
				</li>
				<li class="nav-item">
<%
	if(boardType.equals("nanumboard")) {
%>
					<a class="nav-link active" style="font-weight: bold; border-bottom: solid 2px #343A40;" href="nanumboard.jsp">나눔광장</a>
<%
	} else {
%>
					<a class="nav-link" href="nanumboard.jsp">나눔광장</a>
<%
	}
%>
				</li>
				<li class="nav-item">
<%
	if(boardType.equals("promoteboard")) {
%>
					<a class="nav-link active" style="font-weight: bold; border-bottom: solid 2px #343A40;" href="promoteboard.jsp">홍보광장</a>
<%
	} else {
%>				
					<a class="nav-link" href="promoteboard.jsp">홍보광장</a>
<% 
	}
%>
				</li>
			</ul>
		<div id="navbar" class="collapse navbar-collapse justify-content-end" style="display:inline; right:0px;">
			<ul class="navbar-nav">
<%
	if(userID == null) {
%>	
				<li class="nav-item">
					<a class="nav-link" href="userLogin.jsp">로그인</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="userJoin.jsp">회원가입</a>
				</li>
<%
	} else {
%>
				<li class="nav-item">
					<a class="nav-link" style="color: black"><small>&lt; <%= nick %> &gt;님 반갑습니다.</small></a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="./myPage.jsp">마이페이지</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="userLogout.jsp">로그아웃</a>
				</li>
<%
	}
%>
			</ul>
		</div>
	</nav>
	<section class="container">
		<h2 class="bg-dark p-3 mb-0" style="color: #FFFFFF;">
			게시글 작성
		</h2>
		<form class="bg-light mt-0 p-3" method="post" action="./contentRegisterAction.jsp" autocomplete="off">
			<h4 class="form-group">
				제목
			</h4>
			<div class="form-group">
				<input type="text" class="form-control" name="topicName" maxlength="30" placeholder="제목을 입력하세요.">
			</div>
			<h4 class="form-group">
				내용
			</h4>
			<div class="form-group">
				<textarea class="form-control" maxlength="2048" name="contentName" style="height: 600px" placeholder="내용을 입력하세요."></textarea>
			</div>
			<div class="form-group text-center">
				<button class="btn btn-success mr-3" type="submit">글 등록</button>
				<a><button class="btn btn-danger">취소</button></a>
			</div>
		</form>
	</section>
	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; 2018 엄정기 All Rights Reserved.
		<br><br>
		<a style="color: #bbbbbb;"> &lt; Contact &gt; email:
			<a style="color: #ffffff">umjugnki@Naver.com</a>&nbsp;&nbsp;
			<a style="color: #bbbbbb">instagram:</a> 
			<a style="color: #ffffff" href="http://www.instagram.com/spirit_umm" target="_blank">spirit_umm</a>
		</a>
	</footer>
	
	<!-- 스크립트 추가 -->
	
	<script src="./js/jquery.min.js"></script>
	<script src="./js/popper.min.js"></script>
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="contents.*" %>
<%@page import="java.util.ArrayList"%>
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
	String nick = null;
	
	if(session.getAttribute("userID") != null) {
		userID = (String)session.getAttribute("userID");
	}
	if(session.getAttribute("nickName") != null) {
		nick = (String)session.getAttribute("nickName");
	}

	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
	
	if(userID != null && emailChecked == false) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'emailSendConfirm.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand mr-5" href="index.jsp">천왕 광장</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item">
					<a class="nav-link" href="freeboard.jsp">자유광장</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="anonboard.jsp">익명광장</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="nanumboard.jsp">나눔광장</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="promoteboard.jsp">홍보광장</a>
				</li>
			</ul>
		</div>
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
	<h2 class="bg-dark p-5 text-center" style="color: #ffffff">
		천왕이펜하우스 소통 사이트입니다.
	</h2>
	<section>
		<div style="text-align: center;">
			<img src="image/mainimg.jpg" width="100%" height="580">
		</div>
	</section>
	<section class="mt-2">
		<div class="bg-secondary text-center">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item">
					<a class="nav-link" href="noticeBoard.jsp" style="color: #FFFFFF; font-weight: bold; display:inline-block;">공지사항</a>
				</li>
			</ul>
		</div>
	</section>
	<footer class="bg-dark p-5 text-center" style="color: #FFFFFF;">
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
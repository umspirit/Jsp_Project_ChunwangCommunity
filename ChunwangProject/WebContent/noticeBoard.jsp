<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.lang.String" %>
<%@ page import="contents.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.UserDTO" %>
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
	String searchType = "제목";
	String search = "";
	int pageNumber = 1;
	int contentcount = 0;
	
	if(request.getParameter("search") != null) {
		search = request.getParameter("search");
	}
	if(request.getParameter("pageNumber") != null) {
		try {
	pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		} catch (Exception e) {
	System.out.println("검색 페이지 번호 오류");
		}
	}

	boolean admincheck = false;	
	String userID = null;
	String nick = null;
	
	if(session.getAttribute("userID") != null) {
		userID = (String)session.getAttribute("userID");
		admincheck = new UserDAO().getAdminCheck(userID);
	}
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
	
	String cururl = request.getRequestURI().toString();
	String tmp = ".";
	String pageName = cururl.substring(cururl.lastIndexOf("/") + 1, cururl.length());
	String filename = pageName.replace(".jsp", "");
	session.setAttribute("boardDivide", filename);
%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand mr-5" href="index.jsp" style="color:#aaaaaa;">천왕 광장</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
		</button> 
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
		<table class="table table-striped table-bordered table-hover mt-5">
			<thead>
				<tr>
					<th width="10%">글번호</th>
					<th width="47%">제목</th>
					<th width="12%">작성자</th>
					<th width="17%">작성시간</th>
					<th width="14%">추천수</th>
				</tr>
			</thead>
			<tbody>
<%
	ArrayList<ContentDTO> contentList = new ArrayList<ContentDTO>();	
	contentList = new ContentDAO().getList(filename, searchType, search, pageNumber);
	
	if(contentList.size() > 0 && contentList != null) {
		int i = 0;
		for(; i < contentList.size(); i++) {
			ContentDTO content = contentList.get(i);
			String time = content.getTime();
			String[] timearr = time.split(":");
%>
				<tr>
					<td><%= content.getwriteID() %></td>
					<td><a href="contentView.jsp?boardType=<%= filename %>&idx=<%= content.getwriteID() %>"><%= content.getTopicName() %></a></td>
<%
	String nickName = new UserDAO().getNickname(content.getUserID());

	if(nickName == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류입니다.')");
		script.println("location.href = 'index.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
%>
					<td><%= nickName %></td>
					<td><%= content.getTime() %></td>
					<td><%= content.getSearchCount() %></td>
				</tr>
<%
		}
		contentcount = contentList.get(--i).getwriteID();
	}
%>			</tbody>
		</table>
		<nav aria-label="Page navigation example">
		  	<ul class="pagination" style="margin: 0 auto;">
				<%
					int startPage = (pageNumber / 10) * 10 + 1;
					if(pageNumber % 10 == 0) 
						startPage -= 10;
					int targetPage = new ContentDAO().targetPage(contentcount, "freeboard");
					if(targetPage > 0)
						targetPage = (targetPage / 10) + 1;
					if(startPage != 1) {
				%>
				<li class="page-item"><a class="page-link" href="freeboard.jsp?pageNumber=<%= startPage - 1 %>">&lt;</a></li>
		    	<% 
					} else {
				%>
				<li class="page-item"><a class="page-link" href="">&lt;</a></li>
				<%
					}
					for(int i = startPage; i < pageNumber; i++) {
				%>
			    <li class="page-item"><a class="page-link" href="freeboard.jsp?pageNumber=<%= i %>"><%= i %></a></li>
			    <%
					}
			    %>
			    <li class="page-item active"><a class="page-link" href="freeboard.jsp?pageNumber=<%= pageNumber %>"><%= pageNumber %></a></li>
			    <%
			    	for(int i = pageNumber + 1; i <= pageNumber + targetPage; i++) {
			    		if(i < startPage + 10) {	
				%>
				<li class="page-item"><a class="page-link" href="freeboard.jsp?pageNumber=<%= i %>"><%= i %></a></li>
				<% 
			    		}
			    	}
			    if(targetPage + pageNumber > startPage + 9) {
			    %>
			    <li class="page-item"><a class="page-link" href="freeboard.jsp?pageNumber=<%= startPage + 10 %>">&gt;</a></li>
			    <%
			    }
			    %>
			</ul>
		</nav>
		<form method="get" action="./index.jsp" class="form-inline-block text-center mt-3">
			<select name="lectureDivide" class="form-control mx-1 mt-5" style="width: 100px; display: inline;">
				<option value="전체" >전체</option>
				<option value="제목" >제목</option>
				<option value="내용" >내용</option>
				<option value="작성자" >작성자</option>
			</select>
			<input type="text" name="search" class="form-control mx-1 mt-5" placeholder="내용을 입력하세요" style="width: 250px; display: inline;">
			<button type="submit" class="btn btn-primary mx-1 mt-2 mb-2" style:"width:100px;">검색</button>
<%
	if(admincheck == true) {
%>			
			<a class="btn btn-success mx-1 mt-2 mb-2" href="./contentWrite.jsp?boardType=<%= filename %>">글 작성</a>
<%
	}
%>
		</form>
	</section>
	<section class="mt-4">
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
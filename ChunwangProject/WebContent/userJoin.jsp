<%@page import="java.awt.TrayIcon.MessageType"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width-device-width, initial-scale=1">
	<link rel="stylesheet" href="./css/bootstrap.css">
	<link rel="stylesheet" href="./css/custom.css">
	<title>천왕광장</title>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="https://www.google.com/recaptcha/api.js" async defer></script>
	<script type="text/javascript">
		function idCheck() {
			var userID = $('#userID').val();
			
			$.ajax({
				type: 'POST',
				url: './JoinCheckServlet',
				data: {userID: userID},
				success: function(result) {
					if(userID.length == 0) {
						$('#userID').attr('style', 'background-color: #FFFFFF;');
						$('#idtxt').html('');
					}
					else if(userID.length < 6) {
						$('#userID').attr('style', 'background-color: #FFCECE;');
						$('#idtxt').attr('style', 'color: red;');
						$('#idtxt').html('6자리 이상으로 아이디를 만들어주세요.');
					}
					else if(result == 1) {
						$('#userID').attr('style', 'background-color: #B0F6AC;');
						$('#idtxt').attr('style', 'color: limeGreen;');
						$('#idtxt').html('사용가능한 아이디입니다.');
						
					}
					else {
						$('#userID').attr('style', 'background-color: #FFCECE;');
						$('#idtxt').attr('style', 'color: red;');
						$('#idtxt').html('이미 사용중인 아이디입니다.');
					}
				}
			})
		}
		function emailCheck() {
			var userEmail = $('#userEmail').val();
			
			$.ajax({
				type: 'POST',
				url: './JoinCheckServlet',
				data: {userEmail: userEmail},
				success: function(result) {
					if(userEmail.length == 0) {
						$('#userEmail').attr('style', 'background-color: #FFFFFF;');
						$('#emailtxt').html('');
					}
					else if(result == 1) {
						$('#userEmail').attr('style', 'background-color: #B0F6AC;');
						$('#emailtxt').attr('style', 'color: limeGreen;');
						$('#emailtxt').html('사용가능한 이메일 입니다.');
					}
					else {
						$('#userEmail').attr('style', 'background-color: #FFCECE;');
						$('#emailtxt').attr('style', 'color: red;');
						$('#emailtxt').html('이미 인증에 사용된 이메일 입니다.');
					}
				}
			})
		}
		function nameCheck() {
			var userName = $('#userName').val();
			
			if(userName.length > 0) {
				$('#userName').attr('style', 'background-color: #B0F6AC;');
			}
			else {
				$('#userName').attr('style', 'background-color: #FFCECE;');
			}
		}
		function passwordCheckFuntion() {
			var userPassword = $('#userPassword').val();
			var userPasswordCheck = $('#userPasswordCheck').val();
			
			if(userPassword.length < 6) {
				$('#userPassword').attr('style', 'background-color: #FFCECE;');
				$('#userPasswordCheck').attr('style', 'background-color: #FFCECE;');
				$('#pwtxt').attr('style', 'color: red;');
				$('#pwtxt').html('6자리 이상으로 만들어주세요.');
			}
			else if(userPassword != userPasswordCheck) {
				$('#userPassword').attr('style', 'background-color: #FFCECE;');
				$('#userPasswordCheck').attr('style', 'background-color: #FFCECE;');
				$('#pwtxt').attr('style', 'color: red;');
				$('#pwtxt').html('비밀번호가 서로 다릅니다.');
			}
			else {
				$('#userPassword').attr('style', 'background-color: #B0F6AC;');
				$('#userPasswordCheck').attr('style', 'background-color: #B0F6AC;');
				$('#pwtxt').attr('style', 'color: limegreen;');
				$('#pwtxt').html('사용가능한 비밀번호 입니다.');
			}
		}
	</script>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");

	String userID = null;
	int check = 0;
	
	if(session.getAttribute("userID") != null) {
		userID = (String)session.getAttribute("userID");
	}
 	if(userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인 상태입니다 !')");
		script.println("location.href = 'index.jsp';");
		script.println("</script>");
		script.close();
		return;
	} 
%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand mr-5" href="index.jsp" style="color: #aaaaaa;">천왕
			광장</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar"></button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item"><a class="nav-link" href="freeboard.jsp">자유광장</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="anonboard.jsp">익명광장</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="nanumboard.jsp">나눔광장</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="promoteboard.jsp">홍보광장</a>
				</li>
			</ul>
		</div>
		<div id="navbar" class="collapse navbar-collapse justify-content-end" style="display: inline; right: 0px;">
			<ul class="navbar-nav">
				<%
	if(userID == null) {
%>
				<li class="nav-item">
					<a class="nav-link" href="userLogin.jsp">로그인</a>
				</li>
				<li class="nav-item">
					<a class="nav-link active bold" style="font-weight: bold; border-bottom: solid 2px #343A40;" href="userJoin.jsp">회원가입</a>
				</li>
				<%
	} else {
%>
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
	<section class="container" style="max-width: 560px;">
		<h2 class="bg-dark p-3 mb-3" style="color: #FFFFFF;">회원가입</h2>
		<form method="post" action="./userJoin" autocomplete="off">
			<div class="form-group">
				<label>아이디<small class="ml-3" id="idtxt"></small></label> 
				<input type="text" id="userID" name="userID" class="form-control" onkeyup="idCheck();" maxlength="20" placeholder="아이디 입력">
			</div>
			<div class="form-group">
				<label>비밀번호<small class="ml-3" id="pwtxt"></small></label> 
				<input type="password" id="userPassword" name="userPassword" onkeyup="passwordCheckFuntion();" class="form-control" maxlength="64" placeholder="비밀번호 입력">
			</div>
			<div class="form-group">
				<label>비밀번호 확인</label> 
				<input type="password" id="userPasswordCheck" name="userPasswordCheck" onkeyup="passwordCheckFuntion();" class="form-control" maxlength="64" placeholder="비밀번호 다시 입력">
			</div>
			<div class="form-group">
				<label>이름</label> 
				<input type="text" id="userName" name="userName" class="form-control" onkeyup="nameCheck()" maxlength="10" placeholder="이름 입력">
			</div>
			<div class="form-group">
				<label>이메일<small class="ml-3" id="emailtxt"></small></label> 
				<input type="email" id="userEmail" name="userEmail" class="form-control" maxlength="50" onkeyup="emailCheck();" placeholder="이메일 입력">
			</div>
			<div class="g-recaptcha" data-sitekey="6LeaNGoUAAAAAArj04whbM2qyl-1GaQsvz-d8BUy"></div>
			<button id="joinbtn" class="btn btn-primary mt-4" type="submit">회원가입</button>
		</form>
	</section>
	<%
		String msgContent = null;
		if(session.getAttribute("msgContent") != null) {
			msgContent = (String)session.getAttribute("msgContent");
		}
		String msgType = null;
		if(session.getAttribute("msgType") != null) {
			msgType = (String)session.getAttribute("msgType");
		}
		if(msgContent != null) {
	%>
	<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<div class="modal-content" <% if (msgType.equals("2")) out.println("panel-warning"); else out.println("panel-success"); %>>
					<div class="modal-header panel-heading">
						<h4 class="modal-title">
							<%
								if(msgType.equals("1"))
									out.println("성공");
								else
									out.println("실패");
							%>
						</h4>
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
					</div>
					<div class="modal-body">
						<%= msgContent %>
					</div>
					<div class="modal-footer">
						<button class="btn btn-primary" data-dismiss="modal" <% if(msgType.equals("1")) out.print("onclick='goindex()'"); %>>확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		$('#messageModal').modal('show');
	</script>
	<%
		session.removeAttribute(msgType);
		session.removeAttribute(msgContent);
		}
	%>
	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; 2018 엄정기 All Rights Reserved. <br>
		<br> 
		<a style="color: #bbbbbb;"> &lt; Contact &gt; email: 
			<a style="color: #ffffff">umjugnki@Naver.com</a>&nbsp;&nbsp; 
			<a style="color: #bbbbbb">instagram:</a> 
			<a style="color: #ffffff;" href="http://www.instagram.com/spirit_umm" target="_blank">spirit_umm</a>
		</a>
	</footer>
</body>
</html>

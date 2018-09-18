<%@page import="java.util.Random"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.TimeZone"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@ page import="javax.mail.*" %>
<%@ page import="java.util.Properties" %>
<%@ page import="util.Gmail" %>

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
	
	String uid = null;
	String userEmail = null;

	if(request.getParameter("uid") != null) {
		uid = request.getParameter("uid").toLowerCase();
	}
	if(request.getParameter("userEmail") != null) {
		userEmail = request.getParameter("userEmail").toLowerCase();
	}
	if(uid == null || userEmail == null || uid.equals("") || userEmail.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	String tmp_email = new UserDAO().getUserEmail(uid).toLowerCase();
	
	if(tmp_email == null || !tmp_email.equals(userEmail)) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디거나 이메일이 틀립니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	char[] charaters = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9'};
	StringBuffer sb = new StringBuffer();
	Random rn = new Random();
	for( int i = 0 ; i < 15 ; i++ ){
    	sb.append( charaters[ rn.nextInt( charaters.length ) ] );
	}
	String ran_char = sb.toString();
	String host = "http://localhost:8080/ChunwangProject/";
	String from = "umjugnki@gmail.com";
	String to = userEmail;
	String subject = "천왕 광장 임시 비밀번호입니다.";
	String content = "임시 비밀번호 : " + ran_char;
		
	Properties p = new Properties();
	p.put("mail.smtp.user", from);
	p.put("mail.smtp.host", "smtp.googlemail.com");
	p.put("mail.smtp.port", "465");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "465");
	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");
	
	try {
		Authenticator auth = new Gmail();
		Session ses = Session.getInstance(p, auth);
		ses.setDebug(true);
		MimeMessage msg = new MimeMessage(ses);
		msg.setSubject(subject);
		//보내는 사람 정보
		Address fromAddr = new InternetAddress(from);
		msg.setFrom(fromAddr);	
		// 받는 사람 정보
		Address toAddr = new InternetAddress(to);
		msg.addRecipient(Message.RecipientType.TO, toAddr);
		//메일에 들어갈 내용
		msg.setContent(content, "text/html;charset=UTF8");
		// 실제로 메세지 전송
		Transport.send(msg);
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이메일로 임시 비밀번호를 보냈습니다.');");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	} catch(Exception e) {
		e.printStackTrace();
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('오류가 발생했습니다.');");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	}
	
	
	
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.userDTO"%>
<%@ page import="user.userDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userID=null;
	String userPassword=null;
	String userEmail=null;
	if(request.getParameter("userID")!=null){
		userID=request.getParameter("userID");
		
	}
	if(request.getParameter("userPassword")!=null){
		userPassword=request.getParameter("userPassword");
		
	}
	if(request.getParameter("userEmail")!=null){
		userEmail=request.getParameter("userEmail");
		
	}
	
	if(request.getParameter("userID")==null||request.getParameter("userPassword")==null||request.getParameter("userEmail")==null){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('입력이안된 사항이 있습니다.')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	userDAO userDao=new userDAO();
	int result=userDao.join(new userDTO(userID,userPassword,userEmail,SHA256.getSHA256(userEmail),false));
	if(result==-1){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('이미 존재하는 아이디입니다.')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}else{
		PrintWriter script=response.getWriter();
		session.setAttribute("userID", userID);
		script.println("<script>");
		script.println("locaton.href='emailSendAction.jsp'");
		
		script.println("</script>");
		script.close();
		return;
	}
%>
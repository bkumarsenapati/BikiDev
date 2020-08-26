<%@ page language="java"%>

<%
	String examId=request.getParameter("examid");
	String createdDate=request.getParameter("createddate").replace('-','_');
	String version=request.getParameter("version");
	String stuPassword=request.getParameter("stupassword");
	
	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>

<BODY>
	<a href='#' onclick="document.location.href='/LBCOM/exam/CheckExamStatus.jsp?examid=<%=examId%>&createddate=<%=createdDate%>&version=<%=version%>&stupassword=<%=stuPassword%>'">Do you want to submit again</a>
</BODY>
</HTML>

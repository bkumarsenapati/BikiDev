<%@page language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
String userName=null,schoolId=null;
%>
<%
String sessid=(String)session.getAttribute("sessid");
if(sessid==null){
	out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
	return;
}

userName=(String)session.getAttribute("emailid");
schoolId=(String)session.getAttribute("schoolid");
%>
<html>
<head>
<title></title>
</head>
<frameset cols="27%,*" frameborder="0">
	<frame name="one" src="/LBCOM/nboards/ListNoticeBoards.jsp?emailid=<%=userName%>&schoolid=<%=schoolId%>&viewer=teacher" frameborder="0"/>
	<frame name="two" src=""/>
</frameset>
</html>

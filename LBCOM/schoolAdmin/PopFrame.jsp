<%@page language="java"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
String msg="",file="",dir="",school="";
session=request.getSession();
String sessid=(String)session.getAttribute("sessid");
String emailid=(String)session.getAttribute("emailid");
file=request.getParameter("file");
dir=request.getParameter("dir");
msg=request.getParameter("msg");
school=(String)session.getAttribute("schoolid");
String spath=(String)session.getAttribute("schoolpath");
%>
<html>
<head>
<script language="JavaScript">
 var message='<%=msg%>'; 
</script>
<title><%=application.getInitParameter("title")%></title>
</head>
<frameset rows="20%,*" frameborder="0">
<frame name="one" src="Top.jsp?msg=<%=msg%>" scrolling="auto"/>
<!--<frame name="two" src="/LBCOM/schools/<%=school%>/<%=dir%>/<%=file%>" scrolling="auto"/>-->
<frame name="two" src="<%=spath%>/<%=school%>/<%=dir%>/<%=file%>" scrolling="auto"/>
</frameset>

</html>

<%@page language="java"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
String msg="",file="",dir="",school="",nbId="";
%>
<%
session=request.getSession();
String sessid=(String)session.getAttribute("sessid");
String emailid=(String)session.getAttribute("emailid");
file=request.getParameter("file");
dir=request.getParameter("dir");
msg=request.getParameter("msg");
nbId=request.getParameter("nbid");
school=(String)session.getAttribute("schoolid");
%>
<html>
<head>
<script language="JavaScript">
 var message='<%=msg%>'; 
</script>

<title><%=application.getInitParameter("title")%></title>
</head>
<frameset rows="20%,*" frameborder="0">
<frame name="one" src="Top.jsp?nbid=<%=nbId%>&msg=<%=msg%>" scrolling="auto"/>
<!--<frame name="two" src="/LBCOM/schools/<%=school%>/<%=dir%>/<%=file%>" scrolling="auto"/>-->
<!-- <frame name="two" src="/LBCOM/sessids/<%=sessid%>_<%=emailid.toLowerCase()%>/<%=school%>/<%=dir%>/<%=file%>" scrolling="auto"/> -->
<frame name="two" src="<%=(String)session.getAttribute("schoolpath")%><%=school%>/nboards/<%=dir%>/<%=file%>" scrolling="auto"/>
</frameset>

</html>

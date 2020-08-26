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
nbId=request.getParameter("nbid");
dir=request.getParameter("dir");
msg=request.getParameter("msg");
school=(String)session.getAttribute("schoolid");
%>
<html>
<head>
<script language="JavaScript">
 var message=<%=msg%>; 
</script>

<title><%=application.getInitParameter("title")%></title>
</head>
<!-- <frameset rows="90,*,0" frameborder="0">
<frame name="three" src="top.jsp"/>
<frame name="one" src="NBTop.jsp?nbid=<%=nbId%>&msg=<%=msg%>" scrolling="auto"/>
<frame name="two" src="<%=(String)session.getAttribute("schoolpath")%><%=school%>/nboards/<%=dir%>/<%=file%>" scrolling="auto"/>
</frameset> -->
<frameset rows="9,*,0" border="0" frameborder="0" framespacing="0">
	<frame name="refreshframe" target="main" scrolling="no" noresize border="0">
	<frameset rows="168,0,*"name="userloginfr">
		<frame src="/LBCOM/studentAdmin/NBTop.jsp?nbid=<%=nbId%>" name="left" scrolling="no" marginwidth="0" marginheight="0">
		<frame name="refreshframe" target="main" scrolling="no" noresize border="0">
		<frame src='' name="main" scrolling="auto" >
	</frameset>
	<frame src="/LBCOM/bottom.jsp" id="bottom" name="bottom" marginwidth="0" marginheight="0" scrolling="no" target="_self">
	<noframes>
    <body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
    <p>To view this page correctly, you need a Web browser that supports frames.</p>
	<A HREF="/LBCOM/common/Logout.jsp">Logout</A> 
    </body>
    </noframes>
</frameset>
</html>

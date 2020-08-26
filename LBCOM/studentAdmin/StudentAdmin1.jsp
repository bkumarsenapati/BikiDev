<%@ page language="java" %>

<html>
<head>

<title><%=application.getInitParameter("title")%></title>

<script>
//var logopath = "<%= session.getAttribute("logopath")%>";
</script>
<%
String userId,userType,schoolId;
userId=(String) session.getAttribute("Login_user");
schoolId =(String)session.getAttribute("Login_school");
%>
</head>
<!-- <frameset rows="90,*,0" border="0" frameborder="0" framespacing="0">
	<frame src="/LBCOM/studentAdmin/top.html?schoolid=<%=schoolId%>&userid=<%=userId%>" name="studenttopframe" marginwidth="0" marginheight="0" scrolling="no" target="_self">
	<frameset cols="168,0,*"name="userloginfr">
		<frame src='/LBCOM/studentAdmin/left.jsp' name="left" scrolling="no" marginwidth="0" marginheight="0">
		<frame name="refreshframe" target="main" scrolling="no" noresize border="0">
		
		<frame src='' name="main" scrolling="auto" >
	</frameset> -->
	<frameset rows="90,*,0" border="0" frameborder="0" framespacing="0">
	<frame src="/LBCOM/studentAdmin/top.html?schoolid=<%=schoolId%>&userid=<%=userId%>" name="studenttopframe" marginwidth="0" marginheight="0" scrolling="no" target="_self">
	<frameset cols="168,0,*"name="userloginfr">
		<frame src='/LBCOM/studentAdmin/left.jsp' name="left" scrolling="no" marginwidth="0" marginheight="0">
		<frame name="refreshframe" target="main" scrolling="no" noresize border="0">
		<frame src='/LBCOM/studentAdmin/StudentHomeNB.jsp' name="main" scrolling="auto" > 
		<frame src='' name="main" scrolling="auto" >
	</frameset>
	<frame src="/LBCOM/bottom.jsp" id="bottom" name="bottom" marginwidth="0" marginheight="0" scrolling="no" target="_self">
	<noframes>
    <body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
    <p>To view this page correctly, you need a Web browser that supports frames.</p>
	<A HREF="/LBCOM/common/Logout.jsp">Logout</A> 
    </body>
    </noframes>
</frameset></html>

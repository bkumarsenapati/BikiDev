<%@ page import = "java.sql.*,java.util.Hashtable,coursemgmt.ExceptionsFile" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<%@ include file="/common/checksession.jsp" %> 	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><%=application.getInitParameter("title")%></title>
<style>
 div.botright{    display:block;    /*set the div in the bottom right corner*/    position:absolute;    bottom:0;    right:0;    width:350px;        /*give it some background and border*/    background:yellow;    border:1px solid #ddd;  }
 </style>
</head>
<%
	String userId,userType,schoolId;
	userId=(String) session.getAttribute("Login_user");
	schoolId =(String)session.getAttribute("Login_school");
	response.sendRedirect("/LBCOM/com/teacher/index.jsp");
	
%>
<!--
<frameset framespacing="0" rows="90,*,0" border="0" frameborder="0">
		<frame name="topframe" scrolling="no" noresize target="contents" src="/LBCOM/asm/toppage.jsp?schoolid=<%=schoolId%>&userid=<%=userId%>"  marginwidth="0" marginheight="0" namo_target_frame="contents">
			<frameset cols="168,0,*">
				<frame name="left" target="main" src="/LBCOM/asm/LeftFrame.html" scrolling="no" noresize  marginwidth="0" marginheight="0" namo_target_frame="main">
				<frame name="refreshframe" target="main" scrolling="no" noresize  marginwidth="0" marginheight="0" namo_target_frame="main">
				<frame src="about:blank" name="main"  noresize>
			</frameset>
		<frame name="bottom" id="bottom" src="/LBCOM/bottom.jsp">

</frameset>
<noframes>
    <body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
    <p>To view this page correctly, you need a Web browser that supports frames.</p>
	<A HREF="/LBCOM/common/Logout.jsp">Logout</A> 
	
    </body>
	
</noframes>
-->
<div class="botright">  <p>Here is my div content!!</p></div>
<div id='dude' class='' style="position:absolute;float:left;top=5;left=25;display='none';z-index=200;">***this is my content...***</div>

</html>

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
<link type="text/css" rel="stylesheet" media="all" href="css/chat.css" />
<link type="text/css" rel="stylesheet" media="all" href="css/screen.css" />
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" leftmargin="0" marginwidth="0" topmargin="0" marginheight="0">

<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
    <tr>
        <td width="100%" colspan="2" height="72" align="center" valign="top">
			<iframe  name="studenttopframe" src="/LBCOM/studentAdmin/top.html?schoolid=<%=schoolId%>&userid=<%=userId%>" width="100%" height="100%" frameborder="0" scrolling="no" target="_self">
			<p>Your browser does not support iframes.</p>
			</iframe>
		</td>
    </tr>
    <tr>
        <td width="170" height="100%" align="left" valign="top">
			<iframe name="left" src='/LBCOM/studentAdmin/left.jsp' width="200" height="100%">
			<p>Your browser does not support iframes.</p>
			</iframe>
		</td>
        <td width="100%" height="100%" align="left" valign="top">
			<iframe name="main" src="/LBCOM/bottom.jsp" id="main" width="100%" height="100%">
			<p>Your browser does not support iframes.</p>
			</iframe>
		</td>
    </tr>
</table>

<div id="main_container">
<a href="javascript:void(0)" onclick="javascript:chatWith('johndoe')">Chat With John Doe</a>
<a href="javascript:void(0)" onclick="javascript:chatWith('babydoe')">Chat With Baby Doe</a>
</div>

<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/chat.js"></script>
</body>

</html>
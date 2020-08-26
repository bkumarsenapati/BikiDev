<!-- creates two frames. one for providing the links for create/list options of  a particular Assignment(HW/PW/AS) and another for  displaying the list or for providing a templete for creating/modifing -->

<%@ page language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<%
	session=request.getSession();
	String s=(String)session.getAttribute("sessid");
	if(s==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
%>

<html>
<head>
<title></title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>

<frameset rows="6%,*" noborders framespacing="0" border="0" frameborder="0" topmargin="0" >
	<frame name="toppanel" target="main" src="DBItemTopPanel.jsp" scrolling="no" marginwidth="0" marginheight="0">
	<frame name="bottompanel" target="main" src="FilesList.jsp?totrecords=&start=0&cat=all&status=" marginheight="0" scrolling="auto">
	<noframes>
		<body topmargin="0" leftmargin="0">
			<p>This page uses frames, but your browser doesn't support them.</p>
		</body>
	</noframes>
</frameset>

</html>

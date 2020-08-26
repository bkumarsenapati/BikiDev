<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String docName="",studentId="";
%>
<%
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	docName=request.getParameter("docname");
	studentId=request.getParameter("studentid");
%>

<head>
<title></title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0"><meta name="author" content="Think-And-Learn.com">
</head>
<body bgcolor="#EBF3FB">
<table width="100%" border="0" cellpadding="0" cellspacing="2" bgcolor="white">
<tr>
	<td colspan="4"><br></td>
</tr>
<tr>
	<td width="22%" valign="top">
		<a href="AssignmentEditor.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_editor1.gif" WIDTH="188" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="24%" valign="top">
		<a href="AssignmentDistributor.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_distributor1.gif" WIDTH="214" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="24%" valign="top">
		<a href="AssignmentEvaluator.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_evaluator2.gif" WIDTH="214" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="28%">&nbsp;</td>
</tr>
</table>
<hr>
<table border="0" width="100%" cellspacing="1">
<tr>
	<td width="24%" valign="middle" align="left" bgcolor="#E8ECF4">
		<font color="#003399" face="verdana" size="2"><b><%=studentId%></b></font>
		<font size=2>&nbsp;<b>:</b>&nbsp;</font>
		<font color="black" face="verdana" size="2"><%=docName%></font>
	</td>
</tr>
</table>
</body>
</html>

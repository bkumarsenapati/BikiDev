<html>
<%@  page language="java"  import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<%
	session=request.getSession(true);
	String s=(String)session.getAttribute("sessid");
	if(s==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
%>

<head>
<title>.:: Welcome to www.hotschools.net ::. [ for quality eLearning experience ]</title>
<meta name="generator" content="Microsoft FrontPage 5.0">
<SCRIPT language=JavaScript>
<!--
function handler(anc)
{
	if(anc=="schoolmgmt")
		parent.main.location.href="SelectSchoolName.jsp";
	else if(anc=='usermgmt')
		parent.main.location.href="UserListingFrame.jsp";
	else if(anc=='reports')
		parent.main.location.href="ReportFrame.jsp";
	else if(anc=='crossregister')
		parent.main.location.href="CrossRegisterFrame.jsp";
	return false;
}

function logout()
{
	parent.location.href="Logout.jsp";
	return false;
}
//-->
</SCRIPT>
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" leftmargin="0" marginwidth="0" topmargin="0" marginheight="0" >
<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td width="208" colspan="2">
            <p>
            <img src="../images/hsn/logo.gif"  border="0" width="204" height="42" ></p>
        </td>
        <td width="387" colspan="2">&nbsp;</td>
        <TD vAlign=center align=top width="120" height="48" colspan="2"> 
				<!-- BEGIN Help Center Live Code, ? Michael Bird 2004 -->
				<!-- <div id="HCLInitiate" style="position:absolute; z-index:1; visibility: hidden;">
				&nbsp;</div>
				<script type="text/javascript" language="javascript" src="file://www.hotschools.net/~hsn/hcl/lh/live.php?department=Hotschools"></script> -->
				<!-- END Help Center Live Code, ? Michael Bird 2004 -->
		</TD>
        <td width="104" align="center" valign="top" colspan="2">&nbsp;</td>
        <td width="93" align="center" valign="top" colspan="2"><a href="javascript://" onclick="return logout();">
	        <img src="../images/hsn/logout.gif" width="59" height="48" border="0" align="right"></a>
        </td>
    </tr>
    <tr>
        <td width="1004" colspan="10" bgcolor="#ECD8CA" height="22">&nbsp;</td>
    </tr>
    <tr>
       	<td width="200" bgcolor="#D7AB8E" align="center">
			<a onclick="return handler('schoolmgmt');" href="javascript://">
			<img border="0" src="images/schoolmanagement.gif" width="197"></a>
		</td>
		<td width="200" bgcolor="#D7AB8E" align="center">
			<a onclick="return handler('usermgmt');" href="javascript://">
			<img border="0" src="images/users.gif" width="76"></a>
		</td>
        <td width="125" bgcolor="#D7AB8E" align="center">
			<a onclick="return handler('reports');" href="javascript://">
			<img border="0" src="images/reports.gif" width="76"></a></td>

		<td width="125" bgcolor="#D7AB8E" align="left">
			<a onclick="return handler('crossregister');" href="javascript://">
			<img border="0" src="images/crossregistration.gif"></a></td>
        <td width="167" colspan="2" bgcolor="#D7AB8E">&nbsp;</td>
        <td width="167" colspan="2" bgcolor="#D7AB8E">&nbsp;</td>
        <td width="167" bgcolor="#D7AB8E">&nbsp;</td>
    </tr>
	<tr>
		<td width="100%" colspan="7">&nbsp;</td>
	</tr>

</table>
</body>

</html>
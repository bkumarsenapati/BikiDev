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
<title>.:: Welcome to www.learnbeyond.net ::. [ for quality eLearning experience ]</title>
<meta name="generator" content="Microsoft FrontPage 5.0">
<SCRIPT language=JavaScript>
<!--
function handler(anc)
{
	//if(anc=="schoolmgmt")
	//	parent.main.location.href="SelectSchoolName.jsp";
	if(anc=="facilityhome")
		parent.main.location.href="FacilityHome.jsp";
	else if(anc=='usermgmt')
		parent.main.location.href="UserListingFrame.jsp";
	else if(anc=='reports')
		parent.main.location.href="ReportFrame.jsp";
	else if(anc=='crossregister')
		parent.main.location.href="CrossRegisterFrame.jsp";
	else if(anc=='buildermgmt')
		parent.main.location.href="BuilderListingFrame.jsp";
	return false;
}

function logout()
{
	parent.location.href="Logout.jsp";
	return false;
}
//-->
</SCRIPT>
<style type="text/css">
A:link {text-decoration: none; color:#FFF; font-family:Arial, Helvetica, sans-serif;font-size:12px; font-weight:bold}
A:visited {text-decoration: none}
A:active {text-decoration: none}
A:hover {text-decoration: underline; color: blue;}
body {margin-top:0px;margin-left:0px;margin-right:0px;}
table.padded-table td { padding:20px; }

</style>
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" leftmargin="0" marginwidth="0" topmargin="0" marginheight="0" >
<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td colspan="2">
            <p>
            <img src="../images/hsn/logo.gif"  border="0" width="204" height="42" ></p>      </td>
        <td colspan="2">&nbsp;</td>
        <TD vAlign=center align=top height="48" colspan="2"> 
				<!-- BEGIN Help Center Live Code, ? Michael Bird 2004 -->
				<!-- <div id="HCLInitiate" style="position:absolute; z-index:1; visibility: hidden;">
				&nbsp;</div>
				<script type="text/javascript" language="javascript" src="file://www.hotschools.net/~hsn/hcl/lh/live.php?department=Hotschools"></script> -->
				<!-- END Help Center Live Code, ? Michael Bird 2004 -->		</TD>
        <td align="center" valign="top" colspan="2">&nbsp;</td>
        <td width="68" align="center" valign="top" colspan="2"><a href="javascript://" onClick="return logout();">
	        <img src="../images/hsn/logout.gif" width="59" height="48" border="0" align="right"></a>        </td>
    </tr>
    <tr>
        <td colspan="10" bgcolor="#ECD8CA" height="23">&nbsp;</td>
    </tr>
   <!--  <tr>
       	<td width="221" align="center" valign="middle" bgcolor="#bf8058"><a onClick="return handler('facilityhome');" href="javascript://">
        <img src="images/facilitymgmt.gif" width="158" height="24" border="0"></a></td>
		<td width="124" align="center" valign="middle" bgcolor="#bf8058">
			<a onClick="return handler('usermgmt');" href="javascript://"><img src="images/users.gif" width="161" height="23" border="0"></a>		</td>
        <td width="121" align="center" valign="middle" bgcolor="#bf8058">
			<a onClick="return handler('reports');" href="javascript://"><img src="images/reports.gif" width="161" height="23" border="0"></a></td>

		<td width="197" align="center" valign="middle" bgcolor="#bf8058"><a onClick="return handler('crossregister');" href="javascript://"><img src="images/crossregistration.gif" width="161" height="23" border="0"></a></td>

        <td width="197" align="center" valign="middle" bgcolor="#bf8058"><a onClick="return handler('buildermgmt');" href="javascript://"><!-- <img src="images/users.gif" width="161" height="23" border="0">Course Builder</a></td>

       
    </tr> 
	 -->
	<tr>
    <td width="221" align="center" valign="middle" bgcolor="#bf8058"><a onClick="return handler('facilityhome');" href="javascript://">
        Facility Management</a></td>
		<td width="124" align="center" valign="middle" bgcolor="#bf8058"><a onClick="return handler('usermgmt');" href="javascript://">Users</a>		</td>
        <td width="121" align="center" valign="middle" bgcolor="#bf8058"><a onClick="return handler('reports');" href="javascript://">Reports</a></td>
		<td width="197" align="center" valign="middle" bgcolor="#bf8058"><a onClick="return handler('crossregister');" href="javascript://">Cross Registration</a></td>

        <td bgcolor="#bf8058"><a onClick="return handler('buildermgmt');" href="javascript://">Course Builder</a></td>

        <td bgcolor="#bf8058">&nbsp;</td>

        
  </tr>
</table>
</body>

</html>
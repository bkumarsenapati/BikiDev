<%@ page language="java" import="coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String loginType="",schoolId="",userId="";

	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
  
	try
	{	
  		schoolId=(String)session.getAttribute("schoolid");
		userId=(String)session.getAttribute("emailid");
  		loginType=(String)session.getAttribute("logintype");
	  	session.setAttribute("attach",null);
		
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("LeftFrameMail.jsp","operations on database","Exception",e.getMessage());
	}  
%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="images/style.css" rel="stylesheet" type="text/css" />
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table border="0" link="#FFFFFF" bordercolor="#FFFFFF" cellspacing="1" width="100%">
<tr>
	<td bgcolor="#FFFFFF" align="left" colspan="6" valign="bottom"></td>
</tr>
<!-- <tr>
	<td height="30" bgcolor="#FFFFFF" width="844" align="left" colspan="6">
		<font face="Verdana" size="4" color="#E25F38"><b>Welcome to Mail Home!</b></font></td>
</tr> -->
<tr>
	<td height="23" bgcolor="#546878" align="center" width="20%">
		<a href="#" onClick='mailhandler("inbox");return(false);'><font color="#FFFFFF" face="Verdana" size="2">Inbox</font></a>
	</td>
	<td height="23" bgcolor="#546878" align="center" width="20%"><b>
		<font face="Verdana" size="2">
		<a href="#" onClick='mailhandler("compose");return(false);'>
        <font color="#FFFFFF">Compose</font></a></font></b></td>
	<td height="23" bgcolor="#546878" align="center" width="20%"><b>
        <font face="Verdana" size="2">
		<a href="#" onClick='mailhandler("sent");return(false);'>
        <font color="#FFFFFF">Sent Mails</font></a></font></b></td>	

<% 
	if(!(loginType.equals("admin")))
	{
%>
	<!-- <td height="23" bgcolor="#546878" align="center" width="20%"><b>
		<font face="Verdana" size="2">
		<a href="#" onClick='mailhandler("bulkmail");return(false);'>
        <font color="#FFFFFF">Bulk</font></a></font></b></td> -->

<% 
	}
%>	
	<td height="23" bgcolor="#546878" align="center" width="20%"><b>
		<font face="Verdana" size="2">
		<a href="#" onClick='mailhandler("folder");return(false);'>
        <font color="#FFFFFF">Folders</font></a></font></b></td>
	   <!--     <td height="23" bgcolor="#546878" align="center"><b>
            <font face="Verdana" size="2">
			<a href="#" onClick='mailhandler("old");return(false);'>
            <font color="#FFFFFF">Old Mails</font></a></font></b></td>  -->
</tr>
</table>
</body>
<SCRIPT LANGUAGE="JavaScript">
<!--
function mailhandler(anc){
	if(anc=="inbox")
		parent.mainmail.location.href="/LBCOM/Commonmail/Inbox.jsp?folder=Inbox";
	else if(anc=="compose")
		parent.mainmail.location.href="/LBCOM/Commonmail/Compose.jsp";
	else if(anc=="sent")
		parent.mainmail.location.href="/LBCOM/Commonmail/Inbox.jsp?folder=Sent";
	else if(anc=="folder")
		parent.mainmail.location.href="/LBCOM/Commonmail/Folder.jsp";
	else if(anc=="bulkmail")
		parent.mainmail.location.href="/LBCOM/Commonmail/BulkInbox.jsp";
	else if(anc=="old")
		parent.mainmail.location.href="/LBCOM/Commonmail/oldmail/index.jsp";	
	return false;
}
//-->
    </SCRIPT>
</html>

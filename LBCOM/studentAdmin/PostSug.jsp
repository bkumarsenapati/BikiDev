<%@page language="java"  import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile"%>
<%@page errorPage="/ErrorPage.jsp"%>

<html>
<head><title></title>
<script language="javascript" src="/LBCOM/validationscripts.js"></script> 
<script>
function Validate()
{
	if((document.PostNewTopic.message.value=="")|| (document.PostNewTopic.dir.value=="noval"))
	{
		alert("Please dont' leave any field blank");
		return false;
	}
	replacequotes(); 
	return true;
}
</script>
</head>

<body bgColor="#FFFFFF" topmargin="0" leftmargin="0" marginwidth=0 marginheight=0>
<%
	String emailid=null,schoolid=null,sId=null,dir=null,forumid=null;
%>
<% 
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	try
	{
		schoolid=(String)session.getAttribute("schoolid");
		emailid=(String)session.getAttribute("emailid");
		dir = request.getParameter("fname");
		sId = request.getParameter("sid");
		forumid = request.getParameter("fid");
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("PostSug.jsp","reading parameters","Exception",e.getMessage());
		out.println("Exception is "+e);
	}
%>

	<table border="0" cellpadding="0" cellspacing="0" width="100%" align="center">
	<tr>
		<td width="50%" bgColor="#d0c0a0">
			<font color="#000000" size="2" face="Arial">
			<a href="/LBCOM/studentAdmin/ShowDirTopics.jsp?emailid=<%= emailid %>&schoolid=<%= schoolid %>" style="color: #000000;text-decoration:none"><b>Forums</b></a></font></td>
		<td bgColor="#d0c0a0" width="50%" align=right>&nbsp;</td>
	</tr>
	<tr>
		<td colspan=2>
			<font color="#800000" size="2" face="Arial">&nbsp;Please post your suggestions/comments and help us to improve this Board .
			</font></td>
	</tr>
	</table>

<FORM action="/LBCOM/forums.SaveForum?sid=<%=sId%>&fid=<%=forumid%>&fname=<%=dir%>&type=3" METHOD="POST" name="PostNewTopic" onsubmit="return Validate();">

	<table align=center border="0" cellPadding="0" cellSpacing="0" width="100%">
    <tr> 
		<td bgColor="#e08040" vAlign="top">
			<font face="Arial" size="2" color="#000000">&nbsp;Post Your Suggestion</font></td>
		<td bgColor="#e08040" vAlign="top">
			<font face="Arial" size="2" color="#000000">&nbsp;We welcome your valuable suggestions to improve this Board.</font></td>
	</tr>
    <tr> 
		<td bgColor="#d0c0a0"><b>
			<font color="#000000" face="Arial" size="2">&nbsp;User Name:</font></b></td>
		<td bgColor="#d0c0a0">
			<font size="2" face="Arial"><b><%= emailid %></b></font></td>
    </tr>
    <tr> 
		<td bgColor="#d0c0a0" noWrap><b>
			<font color="#000000" size="2" face="Arial">&nbsp;Forum:</font></b></td>
		<td bgColor="#d0c0a0">
			<font size="2" face="Arial"><b><%=dir%></b></font></td>
    </tr>
    <tr> 
		<td bgColor="#d0c0a0" noWrap vAlign="top"><b>
			<font face="Arial" size="2" color="#000000">&nbsp;Suggestion:</font></b></td>
		<td bgColor="#d0c0a0">
			<font size="2" face="Arial">
			<textarea cols="45" name="message" rows="10" wrap="VIRTUAL"></textarea></font></td>
    </tr>
    <tr> 
		<td bgColor="#d0c0a0" noWrap vAlign="top">&nbsp;</td>
		<td bgColor="#d0c0a0">&nbsp;</td>
    </tr>
    <tr> 
		<td bgColor="#d0c0a0" align=right>&nbsp;</td>
		<td bgColor="#d0c0a0" align=left>
			<input type="submit" value="Submit"><input type="reset" value="Clear"></td>
    </tr>
 	<tr> 
      <td bgColor="#e08040" colspan=2 vAlign="top">&nbsp;</td>
    </tr>
	</table>
</form>
</body>
</html>

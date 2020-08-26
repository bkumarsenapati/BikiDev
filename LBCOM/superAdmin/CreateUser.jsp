<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,java.util.StringTokenizer,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
System.out.println("request.getMethod()..."+request.getMethod());
if(request.getMethod()!=null)
{
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;

	int i=0; 
    String sessid="",builderId="";
	session=request.getSession();
	sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	
	String uname=request.getParameter("clname");
	String pass=request.getParameter("password");
	
try
{
	con=con1.getConnection();
	st=con.createStatement();
	
	rs=st.executeQuery("select userid from dev_users");
	while(rs.next())
	{
		builderId=rs.getString("userid");
		if((builderId).equals(uname))
			{
			out.println("<b><font face=\"Verdana\" size=\"2\" color=\"red\"><center>Username is already exists!<br>Create with a new username!</center></font></b>");
			}
	}
if(uname!=null || pass!=null)
	{
	int s=st.executeUpdate("insert into dev_users(userid,password) values('"+uname+"','"+pass+"')");
	if(s>0)
	{
		out.println("<b><font face=\"Verdana\" size=\"2\" color=\"#008080\"><center>A new developer account has been created successfully!</center></font></b>");
	}else
	{
		out.println("<b><font face=\"Verdana\" size=\"2\" color=\"red\"><center>Sorry! transaction failed!</center></font></b>");
	}
	}
}
catch(Exception e)
{
	ExceptionsFile.postException("CreateBuilder.jsp","operations on database","Exception",e.getMessage());
	System.out.println("Exception in AddCluster.jsp is..."+e);
}
}
%>
<HTML>
<HEAD>
<TITLE>create a developer account</TITLE>
<link href="../../style.css" rel="stylesheet" type="text/css" />
<META NAME="Generator" CONTENT="Microsoft FrontPage 5.0">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<script language="javascript" src="../validationscripts.js"></script>
<script>
function validate()
{
	var win=window.document.grcreate;
	win.clname.value=trim(win.clname.value);	
	if(win.clname.value=="")
	{
		alert("Please enter the user name!");
		window.document.grcreate.clname.focus();
		return false;
	}else{
		return true;
	}
}
</script>
</HEAD>
<body> 
<form name="grcreate" method="POST" action="#" method="POST" onsubmit="return validate();">
<BR><BR><BR>
<table border="1" cellspacing="0" width="50%"  align="center" bordercolor="#808080" cellpadding="0">
<tr>
	<td width="64%" colspan="2"  bgcolor="#EBF3FB"><b>
		<font face="Verdana" size="3" color="#008080">Create User</font></b>
	</td>
</tr>
<tr>
	<td width="28%">&nbsp;</td>
    <td width="36%">&nbsp;</td>
</tr>
<tr>
	<td width="28%">
		<p align="center"><font face="Verdana" size="2" color="#000080">User Name</font>
	</td>
    <td width="36%">
		<input type="text" name="clname" size="20">
	</td>
</tr>
<tr>
	<td width="28%">
		<p align="center"><font face="Verdana" size="2" color="#000080">Password</font>
	</td>
    <td width="36%">
		<input type="password" name="password" size="20" value="">
	</td>
</tr>
<tr>
	<td width="28%">&nbsp;</td>
    <td width="36%">&nbsp;</td>
</tr>
<tr>
	<td width="64%" colspan="2" align="center">
		<input type="submit" value="CREATE" name="crt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="reset" value="RESET" name="reset">
	</td>
</tr>
</table>
</center>
</form>
</body>
</html>
</BODY>
</HTML>
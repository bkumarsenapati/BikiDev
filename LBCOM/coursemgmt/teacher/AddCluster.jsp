<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,java.util.StringTokenizer,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%!
	int pageSize=15;
%>
<%
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null;

	int i=0; 
    String schoolId="",teacherId="",courseName="",classId="",workId="",cat="",status="",workFlag="",bgColor="",ids="";
	String courseId="",sessid="";
	session=request.getSession();
	sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	
	con=con1.getConnection();
	st=con.createStatement();
try
{
	teacherId = (String)session.getAttribute("emailid");
	schoolId = (String)session.getAttribute("schoolid");
	courseName=(String)session.getAttribute("coursename");
	classId=(String)session.getAttribute("classid");
	courseId=(String)session.getAttribute("courseid");		
	cat=request.getParameter("cat");
	status=request.getParameter("status");
	ids=request.getParameter("selids");
	
	StringTokenizer idsTkn=new StringTokenizer(ids,",");

	while(idsTkn.hasMoreTokens())
	{
		workId=idsTkn.nextToken();
		i++;		
	}
}
catch(Exception e)
{
	ExceptionsFile.postException("AddEditCluster.jsp","operations on database","Exception",e.getMessage());
	System.out.println("Exception in AddCluster.jsp is..."+e);
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>Add/Edit Cluster</TITLE>
<link href="../../style.css" rel="stylesheet" type="text/css" />
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<script language="javascript" src="../../validationscripts.js"></script>
<script>
function validate()
{
	var win=window.document.grcreate;
	win.clname.value=trim(win.clname.value);	
	if(win.clname.value=="")
	{
		alert("Please enter the cluster name!");
		window.document.grcreate.clname.focus();
		return false;
	}
}
</script>

</HEAD>

<body bgcolor="#EBF3FB"> 

<form name="grcreate" method="POST" action="/LBCOM/coursemgmt.AddGroup?mode=add&categoryid=<%=cat%>&selids=<%=ids%>" method="POST" onsubmit="return validate();">

<table width="100%" border="0" cellpadding="0" cellspacing="2" bgcolor="white"> 
<tr>
	<td colspan="4"><br></td>
</tr>
<tr>
	<td width="22%" valign="top">
		<a href="AssignmentEditor.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_editor2.gif" WIDTH="188" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="24%" valign="top">
		<a href="AssignmentDistributor.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_distributor1.gif" WIDTH="214" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="24%" valign="top">
		<a href="AssignmentEvaluator.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_evaluator1.gif" WIDTH="214" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="28%">&nbsp;</td>
</tr>
</table>

<hr>
<BR><BR><BR>
<table border="1" cellspacing="0" width="50%"  align="center" bordercolor="#808080" cellpadding="2">
<tr>
	<td width="64%" colspan="2"><b>
		<font face="Verdana" size="4" color="#008000">Add/Edit Cluster</font></b>
	</td>
</tr>
<tr>
	<td width="28%">&nbsp;</td>
    <td width="36%">&nbsp;</td>
</tr>
<tr>
	<td width="28%">
		<font face="Verdana" size="2" color="#000080">Cluster Name</font>
	</td>
    <td width="36%">
		<input type="text" name="clname" size="20" oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return AlphaNumbersOnly(this, event)">
	</td>
</tr>
<tr>
	<td width="28%">
		<font face="Verdana" size="2" color="#000080">No. of Assignments</font>
	</td>
    <td width="36%">
		<input type="text" name="noassgn" size="20" value="<%=i%>" disabled>
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

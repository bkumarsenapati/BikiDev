<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,java.util.StringTokenizer,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
Connection con=null;
	Statement st=null,st9=null,st1=null;
	ResultSet rs=null,rs9=null,rs1=null;
	String fName="",lName="";

System.out.println("request.getMethod()..."+request.getMethod());
if(request.getMethod()!=null)
{
	
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
	st9=con.createStatement();
	
	rs=st.executeQuery("select userid from lbcms_dev_users");
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
	int s=st.executeUpdate("insert into lbcms_dev_users(userid,password) values('"+uname+"','"+pass+"')");
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
function getUsers()
{
	alert("Entered");
}
</script>
</HEAD>
<body> 
<form name="grcreate" method="POST" action="#" method="POST" onsubmit="return validate();">
<BR><BR><BR>
<table border="1" cellspacing="0" width="50%"  align="center" bordercolor="#808080" cellpadding="0">

<!-- <tr>
	<td width="64%" colspan="2"  bgcolor="#EBF3FB"><b>
		<font face="Verdana" size="3" color="#008080">Manage User</font></b>
	</td>
</tr> -->
<tr>
	<td width="28%">&nbsp;</td>
    <td width="36%">&nbsp;</td>
</tr>
<tr>
<td width="28%">
		<p align="center"><font face="Verdana" size="2" color="#000080">Available Course</font>
	</td>
<td>
<select id='ctype' name='ctype' readonly>
		<option id='ctype' name='ctype' value="" selected>Select Course</option>
<%
		
		rs9=st9.executeQuery("select course_id,course_name from lbcms_dev_course_master order by course_name");
		while (rs9.next())
		{
%>
		<option value='<%=rs9.getString("course_id")%>'><%=rs9.getString("course_name")%></option>
<%
		}
		rs9.close();
		st9.close();
%>
		</select>
		</td></tr>
<tr>
	<td width="28%">
		<p align="center"><font face="Verdana" size="2" color="#000080">User Name</font>
	</td>
    <td width="36%">
		<select id="school" name="school" onchange='getstudents(this.value)'>
			<option value="all" selected>All Schools</option>
<%		
		rs=st.executeQuery("select schoolid from school_profile");
		while (rs.next())
		{
%>
			<option value='<%=rs.getString("schoolid")%>'><%=rs.getString("schoolid")%></option>
<%
		}
		rs.close();
		st.close();
%>
		</select>
	</td>
</tr>
<tr>
	<td width="28%">
		<select id='teacher_id' name='teacherid'>
	          <option value='none' selected>Select</option></select>
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
<%
out.println("<script>\n");  
	
	out.println("var students=new Array();\n");

	rs1=st1.executeQuery("select * from teachprofile");

	int i=0,j=1;

	while (rs1.next())
	{
	
		fName=rs1.getString("fname");
		lName=rs1.getString("lname");
		fName=fName.replaceAll("'","");
		lName=lName.replaceAll("'","");

		out.println("students["+i+"]=new Array('"+rs1.getString("grade")+"','"+rs1.getString("username")+"','"+fName+" "+lName+"');\n"); 
		i++;
		j++;
	}%>
</form>
</body>
</html>

<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null,rs1=null;
    String teacherId="",classId="",schoolId="",workIds="";
	String courseId="";
	Hashtable hsSelIds=null;	
	
	
	try
	{	 
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		con=con1.getConnection();
			
		classId=(String)session.getAttribute("classid");
		courseId=(String)session.getAttribute("courseid");
		teacherId = (String)session.getAttribute("emailid");
		schoolId = (String)session.getAttribute("schoolid");

		workIds=request.getParameter("workids");
								
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in SetMarking.jsp is....."+e);
	}	
%>

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Assignment Editor</title>

<SCRIPT LANGUAGE="JavaScript">
var studentids=new Array();
	
function validate()
{	
	var obj=document.setmarking;
	var flag=false;
	var stdCount=0;
	var cat=window.document.setmarking.asgncategory.value
	
	if(cat=="all")
	{
		alert("Please select category");
		window.document.setmarking.asgncategory.focus();
		return false;
		//window.location.href="SetMPAssignments.jsp?workids=<%=workIds%>";
	}
	else
	{
		
		window.location.href="SetMPAssignments.jsp?workids=<%=workIds%>&mpid="+cat;
		return true;
	}
	
}

</SCRIPT>

</head>

<body bgcolor="#EBF3FB"> 
<form name="setmarking" method="post">
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

<table border="1" cellpadding="0" cellspacing="0" bordercolor="white" width="100%">
 <td width="68%" height="23">
		<select id="asgncategory" name="asgncategory">
			<option value="all" selected>Select</option>

<%
		try
		{
			st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);	
			
			rs=st.executeQuery("select * from marking_admin where schoolid='"+schoolId+"' order by m_id");
			

			while (rs.next())
			{
				out.println("<option value='"+rs.getString("m_id")+"'>"+rs.getString("m_name")+"</option>");
			}
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("SetMarking.jsp","operations on database","Exception",e.getMessage());
			System.out.println("Exception in the try block is...."+e);
		}
		finally
		{
			try
			{
				if(st!=null)
					st.close();
				if(rs!=null)
					rs.close();
				if(con!=null && !con.isClosed())
					con.close();
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("SetMarking.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				System.out.println("Exception in SetMarking.jsppp iss..."+se.getMessage());
			}
		}
%>  
	</select>
	</td>
</tr>
<tr>
	<td colspan=8 align="left">&nbsp;</td>
</tr>
<tr>
	<td colspan=8 align="left"><input type="button" value="Submit" onclick="return validate();"></td>
</tr>
</table>
</form>
</body>
</html>

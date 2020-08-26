<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;  
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rs2=null;
	String schoolId="",classId="",courseId="",studentId="",workId="",masterTable="",startDate="",endDate="",assignmentName="";		
	int sCount=0;
	
	try
	{	 
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}

		schoolId = (String)session.getAttribute("schoolid");
		classId=(String)session.getAttribute("classid");
		courseId=(String)session.getAttribute("courseid");

		workId=request.getParameter("wid");
		//assignmentName=request.getParameter("asgnname");

		masterTable=schoolId+"_"+classId+"_"+courseId+"_dropbox";
		
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		rs2=st2.executeQuery("select doc_name from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where work_id='"+workId+"'");
		if(rs2.next())
		{
			assignmentName=rs2.getString("doc_name");
		}
%>
<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Students List</title>

<SCRIPT LANGUAGE="JavaScript">

function unassignStudents(sid)
{
	if(confirm("Are you sure that you want to delete this assignment for this student?"))
	{
		location.href="UnassignToStudent.jsp?studentid="+sid+"&workid=<%=workId%>";
		return true;
	}
}
//-->
</SCRIPT>
</head>
<body>
<center>
<table border="1" cellspacing="1" width="500">
<tr>
	<td colspan="4" width="100%" height="21" bgcolor="#C0C0C0">
		<font face="Verdana" size="2" color="brown"><b>&nbsp;Assignment Name :</b>&nbsp;<%=assignmentName%></font>
	</td>
</tr>
<tr>
	<td width="2%" height="19">&nbsp;</td>
	<td width="58%" height="19">
		<font face="Verdana" size="2" color="#008000"><b>Student Name</b></font></td>
	<td width="20%" align="center" height="19">
		<font face="Verdana" size="2" color="#008000"><B>Start Date</B></font></td>
	<td width="20%" align="center" height="19">
		<font face="Verdana" size="2" color="#008000"><B>Due Date</B></font></td>
</tr>

<%
		rs=st.executeQuery("select distinct(student_id),start_date,end_date,submit_count from "+masterTable+" where work_id='"+workId+"' and submit_count <=1 and status!=5 order by student_id");
		
		while(rs.next())
		{
			studentId=rs.getString("student_id");
			startDate=rs.getString("start_date");
			endDate=rs.getString("end_date");
			sCount=sCount+1;

			rs1=st1.executeQuery("select username,fname,lname from studentprofile where schoolid='"+schoolId+"' and username='"+studentId+"' order by fname,lname");
			while(rs1.next())
			{
				
%>
				<tr>
					<td width="2%" bgcolor="#C0C0C0">
						<a href="#" onclick="unassignStudents('<%=studentId%>');return false;">
							<IMG SRC="images/iddelete.gif" BORDER="0" align="middle" width="19" height="21" alt="Click here to delete this assignment for this student."></a></td>
					<td width="58%"><font face="Verdana" size="2"><%=rs1.getString("fname")%> <%=rs1.getString("lname")%></font>&nbsp;</td>
					<td width="20%" align="center" height="25"><font face="Verdana" size="2"><%=startDate%></font></td>
					<td width="20%" align="center" height="25"><font face="Verdana" size="2"><%=endDate%></font></td>
				</tr>
<%
			}
		}
		if(sCount==0)
		{
%>
			<tr>
				<td width="100%" colspan="4" height="19">
					<font face="Verdana" size="2">There are no students.</font>
				</td>
			</tr>
<%
		}
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in ListAssignments.jsp is....."+e);
	}
	finally
		{
			try
			{
				if(st!=null)
					st.close();
				if(st1!=null)
					st1.close();
				if(st2!=null)
					st2.close();
				if(con!=null && !con.isClosed())
					con.close();
			}
			catch(SQLException se)
			{
				System.out.println("The exception in ListAssignments.jsp is....."+se.getMessage());
			}
		}
%>
   
    <input type="hidden" name="asgnname" value="<%=assignmentName%>">
	<tr>
      <td colspan="4" width="100%" align="center" height="19" bgcolor="#C0C0C0">
		<font face="Verdana" size="2"><a href="#" onclick="javascript:window.close(-1);">CLOSE</a></font>
      </td>
    </tr>
</table>
</center>
</body>
</html>
<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;  
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rs2=null;
	String schoolId="",classId="",courseId="",studentId="",workId="",masterTable="",startDate="",endDate="",assessmentName="";		
	int sCount=0;
	String tableName="",examId="";
	
	try
	{	 
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			//out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}

		schoolId = (String)session.getAttribute("schoolid");
		classId=(String)session.getAttribute("classid");
		courseId=(String)session.getAttribute("courseid");
		
		workId=request.getParameter("examid");
					
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		rs2=st2.executeQuery("select exam_name from exam_tbl where exam_id='"+workId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");
		if(rs2.next())
		{
			assessmentName=rs2.getString("exam_name");
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
	if(confirm("Are you sure that you want to delete this Assessment for this student?"))
	{
		location.href="UnassignToStudent.jsp?studentid="+sid+"&workid=<%=workId%>&asgnname=<%=assessmentName%>";
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
		<font face="Verdana" size="2" color="brown"><b>&nbsp;Assessment Name :</b>&nbsp;<%=assessmentName%></font>
	</td>
</tr>
<tr>
	<!-- <td width="2%" height="19">&nbsp;</td> -->
	<td width="58%" height="19">
		<font face="Verdana" size="2" color="#008000"><b>Student Name</b></font></td>
	<td width="20%" align="center" height="19">
		<font face="Verdana" size="2" color="#008000"><B>Start Date</B></font></td>
	<td width="20%" align="center" height="19">
		<font face="Verdana" size="2" color="#008000"><B>Due Date</B></font></td>
</tr>

<%
		System.out.println("select e.exam_name,c.user_id,e.from_date,e.to_date,curdate() t ,curtime() ct from exam_tbl as e inner join "+schoolId+"_cescores as c on e.exam_id=c.work_id and e.school_id='"+schoolId+"' and c.work_id='"+workId+"' and e.course_id='"+courseId+"' and c.school_id='"+schoolId+"' and c.report_status>=0 order by c.user_id");

		rs=st.executeQuery("select e.exam_name,c.user_id,e.from_date,e.to_date,curdate() t ,curtime() ct from exam_tbl as e inner join "+schoolId+"_cescores as c on e.exam_id=c.work_id and e.school_id='"+schoolId+"' and c.work_id='"+workId+"' and e.course_id='"+courseId+"' and c.school_id='"+schoolId+"' and c.report_status>=0 order by c.user_id");
		
		while(rs.next())
		{
			assessmentName=rs.getString("exam_name");
			studentId=rs.getString("user_id");
			//startDate=rs.getString("from_date");
			//endDate=rs.getString("to_date");
			
			sCount=sCount+1;
			
			System.out.println("select sp.username,sp.fname,sp.lname, ss.end_date from studentprofile as sp inner join "+schoolId+"_"+studentId+" as ss where schoolid='"+schoolId+"' and username='"+studentId+"' and exam_id='"+workId+"' order by fname,lname");
			rs1=st1.executeQuery("select sp.username,sp.fname,sp.lname, ss.start_date,ss.end_date from studentprofile as sp inner join "+schoolId+"_"+studentId+" as ss where schoolid='"+schoolId+"' and username='"+studentId+"' and exam_id='"+workId+"' order by fname,lname");
				
			//rs1=st1.executeQuery("select username,fname,lname from studentprofile where schoolid='"+schoolId+"' and username='"+studentId+"' order by fname,lname");
			
			while(rs1.next())
			{
				startDate=rs1.getString("start_date");
				endDate=rs1.getString("end_date");
				if(endDate==null || endDate.equals("null"))
				{
					endDate="0000-00-00";
				}
				if(endDate.equals("0000-00-00"))
				{
					startDate="0000-00-00";
				}
				
%>
				<tr>
					<!-- <td width="2%" bgcolor="#C0C0C0">
						<a href="#" onclick="unassignStudents('<%=studentId%>');return false;">
							<IMG SRC="images/iddelete.gif" BORDER="0" align="middle" width="19" height="21" alt="Click here to delete this Assessment for this student."></a></td> -->
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
		System.out.println("The exception2 in ListAssessments.jsp is....."+e);
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
				System.out.println("The exception in ShowAssStudentsList.jsp is....."+se.getMessage());
			}
		}
%>
   
    <tr>
      <td colspan="4" width="100%" align="center" height="19" bgcolor="#C0C0C0">
		<font face="Verdana" size="2"><a href="#" onclick="javascript:window.close(-1);">CLOSE</a></font>
      </td>
    </tr>
</table>
</center>
</body>
</html>
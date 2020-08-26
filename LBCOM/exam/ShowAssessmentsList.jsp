<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null,rs1=null;
	String schoolId="",classId="",courseId="",studentId="",workId="",startDate="",endDate="";
	String tableName="";
	
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
		
		studentId=request.getParameter("studentid");

		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		
%>
<html>
<head>
</head>
<body>
<center>
		<table border="1" cellspacing="1" width="500">
		<tr>
			<td colspan="3" width="100%">
				<font face="Verdana" size="2" color="brown"><b>Student Name :</b>&nbsp;<%=studentId%></font>
			</td>
		</tr>
		<tr>
			<td width="60%"><font face="Verdana" size="2" color="#008000"><b>Asessments Name</b></font></td>
			<td width="20%" align="center"><font face="Verdana" size="2" color="#008000"><B>Start Date</B></font></td>
			<td width="20%" align="center"><font face="Verdana" size="2" color="#008000"><B>Due Date</B></font></td>
		</tr>
<%		
		tableName=schoolId+"_"+studentId;
		rs=st.executeQuery("select s.*,e.*,curdate() t ,curtime() ct from "+tableName+" as s inner join exam_tbl as e inner join "+schoolId+"_cescores as c on s.exam_id=e.exam_id and e.school_id='"+schoolId+"' and e.course_id='"+courseId+"' and e.status='1' and c.school_id='"+schoolId+"' and c.work_id=e.exam_id and user_id='"+studentId+"' and c.report_status=1 order by e.exam_name");

		while(rs.next())
		{
			startDate=rs.getString("start_date");
			endDate=rs.getString("end_date");
			
%>
				<tr>
					<td width="60%"><font face="Verdana" size="2"><%=rs.getString("exam_name")%></font></td>
					<td width="20%" align="center"><font face="Verdana" size="2"><%=startDate%></font></td>
					<td width="20%" align="center"><font face="Verdana" size="2"><%=endDate%></font></td>
				</tr>
<%
			
		}
		rs.close();
	}
	catch(SQLException se)
	{
		System.out.println("The exception in ListAssignments.jsp is....."+se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in ListAssignments.jsp is....."+e);
	}	
%>

    <tr>
      <td colspan="3" width="100%">&nbsp;</td>
    </tr>
    <tr>
      <td width="100%" colspan="3" align="center">
		<font face="Verdana" size="2"><a href="#" onclick="javascript:window.close(-1);">CLOSE</a></font>
      </td>
    </tr>
</table>
</center>
</body>
</html>
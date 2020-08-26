<meta http-equiv="Content-Language" content="en-us">
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>CESCORES</title>

<body>
<p align="center">
	<font face="Verdana" size="3" color="#F16C0A"><b>CESCORES EDITOR</b></font><br>
	<font face="Verdana" size="2" color="#000080">Enter the values that you want to edit and click the 'Go!' button. The points and the dates will be saved.</font></p>
<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	 
	String cat="",schoolId="",teacherId="",courseName="",classId="",sessid="",courseId="";
	String studentId="",secPoints="",maxPoints="",status="",repStatus="",workId="",submitDate="";

	session=request.getSession();
	sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	
	try
	{
		con=con1.getConnection();
		teacherId = (String)session.getAttribute("emailid");
		schoolId = (String)session.getAttribute("schoolid");
		courseName=(String)session.getAttribute("coursename");
		classId=(String)session.getAttribute("classid");
		courseId=(String)session.getAttribute("courseid");		
		cat=request.getParameter("cat");
		out.println("<font color='red' size='1' face='verdana'>");
		out.println("select * from "+schoolId+"_cescores where school_id='"+schoolId+"' and course_id= '"+courseId+"'");
		out.println("</font>");

		st=con.createStatement();

		rs=st.executeQuery("select * from "+schoolId+"_cescores where school_id='"+schoolId+"' and course_id= '"+courseId+"' and category_id='HW' and user_id='08smetts'");
%> <br>
&nbsp;<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber2">
  <tr>
    <td width="25%">
		<font face="Verdana" size="2" color="#F16C0A"><b>School ID :</b></font>
		<font face="Verdana" size="2"><%=schoolId%></font>
	</td>
    <td width="25%">
		<font face="Verdana" size="2" color="#F16C0A"><b>Teacher ID :</b></font>
		<font face="Verdana" size="2"><%=teacherId%></font>
	</td>
    <td width="25%">
		<font face="Verdana" size="2" color="#F16C0A"><b>Course Name :</b></font>
		<font face="Verdana" size="2"><%=courseName%></font>
	</td>
    <td width="25%">
		<font face="Verdana">
		 </font>
        </font>
	</td>
  </tr>
</table>
<br>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="101%" id="AutoNumber1" bordercolorlight="#EFEFEF">
  <tr>
    <td width="10%" align="center" bgcolor="#EFEFEF"><b>
    <font face="Verdana" size="2" color="#F16C0A">School ID</font></b></td>
    <td width="8%" align="center" bgcolor="#EFEFEF"><b>
    <font face="Verdana" size="2" color="#F16C0A">Course ID</font></b></td>
    <td width="13%" align="center" bgcolor="#EFEFEF"><b>
    <font face="Verdana" size="2" color="#F16C0A">Student ID</font></b></td>
    <td width="10%" align="center" bgcolor="#EFEFEF"><b>
    <font face="Verdana" size="2" color="#F16C0A">Work ID</font></b></td>
    <td width="12%" align="center" bgcolor="#EFEFEF"><b>
    <font face="Verdana" size="2" color="#F16C0A">Submit Date</font></b></td>
    <td width="14%" align="center" bgcolor="#EFEFEF"><b>
    <font face="Verdana" size="2" color="#F16C0A">Secured Points</font></b></td>
    <td width="11%" align="center" bgcolor="#EFEFEF"><b>
    <font face="Verdana" size="2" color="#F16C0A">Max Points</font></b></td>
    <td width="8%" align="center" bgcolor="#EFEFEF"><b>
    <font face="Verdana" size="2" color="#F16C0A">Status</font></b></td>
    <td width="11%" align="center" bgcolor="#EFEFEF"><b>
    <font face="Verdana" size="2" color="#F16C0A">Rep Status</font></b></td>
	<td width="11%" align="center" bgcolor="#EFEFEF"><b>&nbsp;</td>
  </tr>

<%
		int i=0;
		String bgColor="";

		while(rs.next())
		{
			i++;
			if(i%2==0)
				bgColor="#EFEFEF";
			else
				bgColor="#BCBCBC";
			studentId=rs.getString("user_id");
			workId=rs.getString("work_id");
			submitDate=rs.getString("submit_date");
			secPoints=rs.getString("marks_secured");
			maxPoints=rs.getString("total_marks");
			status=rs.getString("status");
			repStatus=rs.getString("report_status");
%>
<form name="cescores<%=i%>" method="POST" action="SetCEScores.jsp?studentid=<%=studentId%>&workid=<%=workId%>">
  <tr bgcolor="<%=bgColor%>">
    <td width="10%"><font face="Verdana" size="2"><%=schoolId%></font>&nbsp;</td>
    <td width="8%"><font face="Verdana" size="2"><%=courseId%></font>&nbsp;</td>
    <td width="13%"><font face="Verdana" size="2"><%=studentId%></font>&nbsp;</td>
    <td width="10%" align="center">
		<font face="Verdana" size="2"><%=workId%></font> &nbsp;</td>
    <td width="12%" align="center">
		<input type="text" name="submitdate" size="13" value="<%=submitDate%>">
	</td>
    <td width="14%" align="center">
		<input type="text" name="secpoints" size="5" value="<%=secPoints%>">
	</td>
    <td width="11%" align="center">
		<input type="text" name="maxpoints" size="5" value="<%=maxPoints%>">
	</td>
    <td width="8%" align="center">
		<input type="text" name="status" size="3" value="<%=status%>">
	</td>
    <td width="11%" align="center">
		<input type="text" name="repstatus" size="2" value="<%=repStatus%>">
	</td>
	<td width="11%" align="center" bgcolor="#EFEFEF"><b>
		<input type="submit" value="GO!">
	</td>
  </tr>
  </form>
<%
		}
	}
	catch(Exception e)
	{
		out.println("ShowCEScores.jsp Exception is..."+e.getMessage());
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}
		catch(SQLException se)
		{
			out.println("ShowCEScores.jsp SQL Exception in finally is..."+se.getMessage());
		}
    }
%>  	

</table>
</body>
</html>
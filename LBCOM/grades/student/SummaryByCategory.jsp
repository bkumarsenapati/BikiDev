<%@ page import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page" />
<%@ include file="/common/checksession.jsp" %> 	

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>SummaryByCategory</title>
</head>

<body>
<form name="grstudselectfrm" id='gr_stud_id'><BR>
<div align="center">
  <center>
<%
	
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet  rs=null,rs1=null,rs2=null;
	boolean flag=false;

	String studentId=request.getParameter("userid");
	String schoolId=(String)session.getValue("schoolid");
	if(schoolId==null){
			out.println("<font face='Arial' size='2'><b>Your session has expired. Please Login again... <a href='#' onclick=\"top.location.href='/LBCOM/'\">Login.</a></b></font>");
			return;
	}
  try
	 {
		con=con1.getConnection();	
		st=con.createStatement();
		st1=con.createStatement();
		rs=st.executeQuery("select c.course_name,c.course_id,c.teacher_id from coursewareinfo c inner join coursewareinfo_det d  on c.course_id=d.course_id and c.school_id=d.school_id where d.student_id='"+studentId+"' and c.status=1 and c.school_id='"+schoolId+"' and d.school_id='"+schoolId+"' order by c.course_id");
%>
<table border="0" cellspacing="0" width="90%" id="AutoNumber3" bgcolor="#429EDF" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" height="28">
  <tr>
    <td width="50%" height="28"><font face="Verdana" size="2"><b>&nbsp;<font color="#FFFFFF">Summary By Category</font></b></font></td>
	<td width="50%" height="24" align="right">
	<a href="index.jsp?userid=<%=studentId%>"><IMG SRC="images/back.jpg" WIDTH="20" HEIGHT="15" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a>&nbsp;
	</td>
  </tr>
</table>
  </center>
</div>
<br>
<div align="center">
  <center>
<table border="0" cellspacing="0" width="90%" id="AutoNumber1" bgcolor="#429EDF" height="26" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0">
  <tr>
    <td width="30%" height="23" colspan="2" bgcolor="#96C8ED">
	<select size="1" id="grade_id" name="gradeid"  onchange="goResults(this.value)">
    <option value="no" selected>Select A Course</option>
	<option value='allcourses'>List All Courses</option>
<%		
		while (rs.next())
		{
%>
			<option value='<%=rs.getString("course_id")%>'><%=rs.getString("course_name")%></option>
<%
		flag=true;
		}
%>
    </select></td>
<%
	if(flag==false){
		out.println("<td align='center'>Courses are not available yet. </td></tr></table>");
		return;
	}
%>
<td width="30%" height="23" colspan="2" bgcolor="#96C8ED">
    </td>
  </tr>
  
</table>
  </center>
</div>
					<font face="Verdana" size="2"><center>-*****-Please select a course.-*****-</center></font>
			<hr color="#F16C0A" width="90%" size="1">
<br>

</form>
</body>
<%
	
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("DisplayGrade.jsp","operations on database","Exception",e.getMessage());
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
		catch(SQLException se){
			ExceptionsFile.postException("DisplayGrade.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
	
%>
<script language="javascript">

function goResults(grade1)
{
	if(grade1!='no')
	{
		grades=grade1
			document.location.href="SummaryByCategory3.jsp?userid=<%=studentId%>&courseid="+grade1;
	}
	else
	{
		alert("Select Grade")
		grades='no';
		location.href="SummaryByCategory.jsp?userid=<%=studentId%>";						
	}
}


</script>
</html>
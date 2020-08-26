<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String schoolId="",teacherId="",courseId="",courseName="";
	String studentId="",category="",preference="";
	String catId="",catName="",catType="";

	ResultSet rs=null,rs1=null,rs2=null;
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	int asgnCount=0;

	try
	{
		session=request.getSession();
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		
		schoolId = (String)session.getAttribute("schoolid");
		studentId = (String)session.getAttribute("emailid");
		courseId=request.getParameter("courseid");
		if(courseId == null)
			courseId="selectcourse";
		
		category=request.getParameter("category");
		if(category == null)
			category="selectany";

		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();

		rs=st.executeQuery("select c.course_name,c.course_id,c.teacher_id from coursewareinfo c inner join coursewareinfo_det d  on c.course_id=d.course_id and c.school_id=d.school_id where d.student_id='"+studentId+"' and c.status=1 and c.school_id='"+schoolId+"' order by c.course_id");	
%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Assignments List Page</title>
<SCRIPT LANGUAGE="JavaScript">
<!--
function goCourse()
{
	var crsid=document.assignmentslist.courselist.value;
	var cat=document.assignmentslist.category.value;
	window.location.href="AssignmentsList.jsp?courseid="+crsid+"&category="+cat;

}

function goCategory()
{
	var cat=document.assignmentslist.category.value;
	var crsid=document.assignmentslist.courselist.value;
	window.location.href="AssignmentsList.jsp?courseid="+crsid+"&category="+cat;
}
//-->
</SCRIPT>
</head>

<body>
<form name="assignmentslist" method="POST" action="--WEBBOT-SELF--"><BR>

<div align="center">
<center>
<table border="0" cellpadding="0" cellspacing="0" width="90%" bgcolor="#429EDF" height="24">
  <tr>
    <td width="50%" height="24">&nbsp; <b>
    <font face="Verdana" size="2" color="#FFFFFF">Assignments List</font></b></td>
     <td width="50%" height="24" align="right">
	<%
	if(!category.equals("selectany")){
	%><a href="javascript:window.print()"><img border="0" src="images/print.jpg" width="20" height="15" BORDER="0" ALT="Print"></a><%}%>&nbsp;&nbsp;
		
		<a href="index.jsp?userid=<%=studentId%>"><IMG SRC="images/back.jpg" WIDTH="20" HEIGHT="15" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a>&nbsp;
	</td>
  </tr>
</table>
  </center>
</div>
<br>
<div align="center">
  <center>
<table border="0" width="90%" bgcolor="#429EDF" height="26" bordercolor="#111111">
  <tr>
    <td width="30%" height="23" bgcolor="#96C8ED">
		<select id="courselist" name="courselist" onchange="goCourse(); return false;">
			<option value="selectcourse" selected>Select A Course</option>
<%
				while(rs.next())
				{
					courseName=rs.getString("course_name");
					out.println("<option value='"+rs.getString("course_id")+"'>"+courseName+"</option>");
				}
				rs.close();
%>
		</select>
		<script>
			document.assignmentslist.courselist.value="<%=courseId%>";	
		</script>
	</td>
	<td width="30%" height="23" colspan="2" bgcolor="#96C8ED" align="right">
		<select id="category" name="category" onchange="goCategory(); return false;">
			<option value="selectany" selected>Select Category</option>
<%
			rs=st.executeQuery("select item_id,item_des from category_item_master where school_id='"+schoolId+"' and course_id='"+courseId+"' and (category_type='AS' || category_type='EX') order by item_des");
			
			while(rs.next())
			{
				catId=rs.getString(1);
				catName=rs.getString(2);
				out.println("<option value='"+catId+"'>"+catName+"</option>");
			}
			rs.close();
%>
		</select>
		<script>
			document.assignmentslist.category.value="<%=category%>";
		</script>
	</td>
</tr>
<tr>
    <td width="60%" height="23" colspan="3" bgcolor="#FFFFFF">
    <hr color="#F16C0A"></td>
</tr>
</table>

<table border="1" cellspacing="1" width="90%" bordercolorlight="#E6F2FF">
<tr>
	<td width="38%" align="left" bgcolor="#96C8ED" height="25">
		<b><font face="Verdana" size="2">Assignment Name</font></b>
	</td>
    <td width="25%" align="center" bgcolor="#96C8ED" height="25">
		<b><font face="Verdana" size="2">Start Date</font></b>
	</td>
    <td width="22%" align="center" bgcolor="#96C8ED" height="25">
		<b><font face="Verdana" size="2">End Date</font></b>
	</td>
    <td width="15%" align="center" bgcolor="#96C8ED" height="25">
		<b><font face="Verdana" size="2">Max Points</font></b>
	</td>
</tr>

<%
		rs1=st1.executeQuery("select category_type from category_item_master where school_id='"+schoolId+"' and course_id='"+courseId+"' and item_id='"+category+"'");
	
		if(rs1.next())
		{
			catType=rs1.getString(1);
		}
		rs1.close();	

		if(catType.equals(""))
			catType="EX";
%>

<%
	//System.out.println("cattype is..."+catType);

		if(catType.equals("AS"))
		{
			rs2=st2.executeQuery("select doc_name,from_date,to_date,marks_total from "+schoolId+"_C000_"+courseId+"_workdocs where category_id='"+category+"' order by doc_name");
		}
		else if(catType.equals("EX"))
		{
			rs2=st2.executeQuery("select distinct  e.exam_name,e.from_date,e.to_date,c.total_marks from exam_tbl e,`"+schoolId+"_cescores` c where e.school_id='"+schoolId+"' and e.course_id='"+courseId+"' and e.exam_id=c.work_id and e.exam_type='"+category+"' order by e.exam_name");
		}

		while(rs2.next())
		{
			asgnCount=asgnCount+1;
%>
			<tr>
				<td width="38%">
					<font face="Verdana" size="2"><%=rs2.getString(1)%></font> &nbsp;</td>
				<td width="25%" align="center">
					<font size="2" face="Verdana"><%=rs2.getString(2)%></font> &nbsp;</td>
				<td width="22%" align="center">
					<font face="Verdana" size="2"><%=rs2.getString(3)%></font> &nbsp;</td>
				<td width="15%" align="center">
					<font face="Verdana" size="2"><%=rs2.getString(4)%></font> &nbsp;</td>
			</tr>
<%
		}
		rs2.close();
		
		if(asgnCount == 0)
		{
			if(courseId.equals("selectcourse"))
			{
%>
			<tr>
				<td width="100%" colspan="5">
					<font face="Verdana" size="2">Please select any course.</font>
				</td>
			</tr>
<%
			}
			else if(category.equals("selectany"))
			{
%>
			<tr>
				<td width="100%" colspan="5">
					<font face="Verdana" size="2">Please select any Category.</font>
				</td>
			</tr>
<%
			}
			else
			{
%>
			<tr>
				<td width="100%" colspan="5">
					<font face="Verdana" size="2">There are no assignments in this course.</font>
				</td>
			</tr>
<%
			}
		}
	}	
	catch(SQLException se)
	{
		out.println("SQLError: General-" +se);
		System.out.println("Error: SQL -" + se.getMessage());
	}
	catch(Exception e)
	{
		out.println("Error: General-" + e);
		System.out.println("Error:  -" + e.getMessage());
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
			ExceptionsFile.postException("AssignmentList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }

%>

</table>
</center>
</div>
</form>
</body>
</html>
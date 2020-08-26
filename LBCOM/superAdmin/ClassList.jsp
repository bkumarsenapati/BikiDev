<%@  page language="java"  import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	Connection con=null;
	ResultSet rs1=null,rs2=null,rs3=null;
	Statement st1=null,st2=null,st3=null;
	String schoolId="",classId="",className="",courseId="",courseName="";
	int studentsCount=0;
	boolean courseFlag=false;
%>

<%
	schoolId=request.getParameter("schoolid");
%>

<%
	try
	{
		con=con1.getConnection();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
		rs1=st1.executeQuery("select class_id,class_des from class_master where school_id='"+schoolId+"'");
%>



<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Class Name</title>
</head>

<body>

<table border="1" cellpadding="0" cellspacing="0" width="100%" id="AutoNumber1" bordercolorlight="#C0C0C0" bordercolordark="#FFFFFF">
  <tr>
    <td width="14%" align="center" height="31" bgcolor="#D9B095">
    <font face="Verdana" size="2" color="#FFFFFF"><b>
    Class Name</b></font></td>
    <td width="14%" align="center" height="31" bgcolor="#D9B095"><b>
    <font face="Verdana" size="2" color="#FFFFFF">
    Course Name</font></b></td>
    <td width="14%" align="center" height="31" bgcolor="#D9B095"><b>
    <font face="Verdana" size="2" color="#FFFFFF">
    Teacher Name</font></b></td>
    <td width="14%" height="31" align="center" bgcolor="#D9B095"><b>
    <font face="Verdana" size="2" color="#FFFFFF">
    No of Students</font></b></td>
    <td width="14%" align="center" height="31" bgcolor="#D9B095"><b>
    <font face="Verdana" size="2" color="#FFFFFF">Course Created On</font></b></td>
    <td width="14%" align="center" height="31" bgcolor="#D9B095">
    <font face="Verdana" size="2" color="#FFFFFF"><b>
    Course Dead Line</b></font></td>
  </tr>
<%
		while(rs1.next())
		{
			classId=rs1.getString("class_id");
			className=rs1.getString("class_des");
			courseFlag=false;
			rs2=st2.executeQuery("select * from coursewareinfo where school_id='"+schoolId+"' and class_id='"+classId+"'");
			while(rs2.next())
			{
				courseId=rs2.getString("course_id");
				courseName=rs2.getString("course_name");
				courseFlag=true;
				rs3=st3.executeQuery("select count(*) from coursewareinfo_det where school_id='"+schoolId+"' and course_id='"+courseId+"'");
				if(rs3.next())
				{
					studentsCount=Integer.parseInt(rs3.getString(1));
				}


%>
   <tr>
    <td width="14%" height="19" align="left"><font face="Verdana" size="2"><%=className%></font></td>
    <td width="14%" height="19" align="left"><font face="Verdana" size="2"><%=rs2.getString("course_name")%></font></td>
    <td width="14%" height="19" align="left"><font face="Verdana" size="2"><%=rs2.getString("teacher_id")%></font></td>
    <td width="14%" height="19" align="center"><b><font face="Verdana" size="2">
    <a target="_self" href="StudentList.jsp?schoolid=<%=schoolId%>&classid=<%=classId%>&classname=<%=className%>&courseid=<%=courseId%>&coursename=<%=courseName%>&teacherid=<%=rs2.getString("teacher_id")%>&enddate=<%=rs2.getString("last_date")%>"><%=studentsCount%></a></font></b></td>
    <td width="14%" height="19" align="center">
    <font face="Verdana" size="2" color="#008080"><%=rs2.getString("create_date")%></font></td>
    <td width="14%" height="19" align="center">
    <font color="#008000" face="Verdana" size="2"><%=rs2.getString("last_date")%></font></td>
  </tr>
 <!--  <tr>
    <td width="84%" height="19" colspan="6">
    <hr>
    </td>
  </tr> -->
<%
			}
			if(courseFlag==false)
			{
%>
				<tr>
				    <td width="14%" height="19" align="left"><font face="Verdana" size="2"><%=className%></font></td>
				    <td width="14%" height="19" align="left"<b>&nbsp;-</b></td>
				    <td width="14%" height="19" align="left"<b>&nbsp;-</b></td>
				    <td width="14%" height="19" align="center"<b>-</b></td>
				    <td width="14%" height="19" align="center"<b>-</b></td>
				    <td width="14%" height="19" align="center"<b>-</b></td>
				</tr>
				<!-- <tr>
				    <td width="84%" height="19" colspan="6"><hr></td>
				</tr> -->
<%
			}

		}


%>
</table>
<%
}
catch(Exception e)
{
	System.out.println(e);
	ExceptionsFile.postException("Contactst.jsp","Operations on database ","Exception",e.getMessage());
    out.println("<b>There is an error raised in the search. Please try once again.</b>");
}

finally
{
	try
	{
		if(con!=null)
			con.close();
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("Contactst.jsp","Closing connection objects","Exception",e.getMessage());
		System.out.println("Connection close failed");
	}
}
%>
</body>

</html>
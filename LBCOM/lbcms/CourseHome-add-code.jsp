<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;   
	Statement st=null,st1=null; 
	ResultSet rs=null,rs1=null;
	String developerId="",courseId="",courseName="",courseDevPath="";
	boolean courseFlag=false;
	int totUnits=0;
try{
	courseDevPath=application.getInitParameter("lbcms_dev_path");
	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
		return;
	}
	developerId=request.getParameter("userid");
	con=con1.getConnection();
	st=con.createStatement();

	rs=st.executeQuery("select * from lbcms_dev_course_master where developer='"+developerId+"' and status=1");
%>

<html>
<head>
<title>Hotschools Course Builder</title>
<meta name="generator" content="Microsoft FrontPage 5.0">
<link href="css/style.css" rel="stylesheet" type="text/css" />
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
<table border="0" cellpadding="0" cellspacing="0" width="100%" background="images/CourseHome_01.gif">
<tr>
	<td width="15" height="70">&nbsp;</td>
	<td width="475" height="70">
		<img src="images/hscoursebuilder.gif" width="194" height="70" border="0">
	</td>
    <td width="493" height="70" align="right">
		<img src="images/mahoning-Logo.gif" width="296" height="70" border="0">
    </td>
</tr>
<tr>
	<!-- <td width="100%" height="28" colspan="3" background="images/TopStrip-bg.gif"> -->
	<td width="100%" height="28" colspan="3" bgcolor="#A53C00">
    <div align="right">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
	    <tr>
			<td width="90%"><p>&nbsp;</p></td>
			<td width="97" align="left"><a href="Logout.jsp"><img src="images/logout.gif" width="64" height="28" border="0"></a></td>
		</tr>
		<tr>
			<td width="100%" height="5" bgcolor="#ECECEC" colspan="2"></td>
		</tr>
		</table>
    </div>
	</td>
</tr>
<tr>
	<td width="100%" height="495" colspan="3" background="images/bg2.gif" align="center" valign="top">
		<p align="center">&nbsp;</p>
		<div align="center"> 
		<table width="60%" border="0" cellspacing="0" cellpadding="0" height="32" style="border-collapse: collapse" bordercolor="#111111">
        <tr class="tNavigation">
			<td align="left" width="412" height="30" valign="middle">&nbsp;<b>Course Home &gt;&gt; </b></td>
			<td align="right" width="28" height="30" valign="middle">
				<img src="images/createnew.gif" width="20" height="20" border="0">
			</td>
            <td width="105" align="left" height="30">
				<a href="CreateCourse.jsp?developer=<%=developerId%>"><font color="white">Add New Course</font></a></td>
		</tr>
		</table>
		<table width="60%" border="0" cellpadding="0" cellspacing="0" class="boarder">
		<tr>
		<th height="86" align="center" valign="top" scope="col">
			<table width="100%" cellspacing="1" cellpadding="3"  border="0">
	        <tbody>
		    <tr>
				<td width="101" align="middle" class="Grid_tHeader" height="20" valign="middle" colspan="5"><b>Manage Course</b></td>
				<td width="265" class="Grid_tHeader" align="left" height="20"><strong>Course Name</strong></td>
				<td width="100" class="Grid_tHeader" align="center" height="20"><strong>No. of Units</strong></td>
				<td width="120" class="Grid_tHeader" align="center" height="20"><strong>Save to disk</strong></td>
				<td width="100" class="Grid_tHeader" align="center" height="20"><strong>Manage Assignments</strong></td>
				<td width="100" class="Grid_tHeader" align="center" height="20"><strong>Manage Assessments</strong></td>
			</tr>
<%
	while(rs.next())
	{
		courseFlag=true;
		courseName=rs.getString("course_name");
		courseId=rs.getString("course_id");
		
%>
		<tr>
			<td align="middle" class="tr-subrow" width="20" valign="middle" height="20">
				<a href="EditCourse.jsp?courseid=<%=courseId%>&userid=<%=developerId%>">
					<img src="images/edit.gif" width="20" height="20" border="0" alt="Edit">
				</a>
			</td>
			<td align="middle" class="tr-subrow" width="20" valign="middle" height="20">
				<a href="CurriculumMap.jsp?courseid=<%=courseId%>&userid=<%=developerId%>">
					<img src="images/cmap.png" width="20" height="20" border="0" alt="Curriculum Map">
				</a>
			</td>
		    <td align="middle" class="tr-subrow" width="20" valign="middle" height="20">
				<a href="#" onclick="deleteCourse('<%=courseId%>','<%=developerId%>')">
					<img src="images/delet.gif" width="20" height="20" border="0" alt="Delete">
				</a>
			</td>
		    <td align="center" class="tr-subrow" width="20" height="20" valign="middle">
				<a href="#" onclick="viewLessonFile('<%=courseName%>');return false;"><img src="images/view.gif" width="20" height="20" border="0" alt="View"></a>
			</td>
		    <td align="center" class="tr-subrow" width="20" height="20" valign="middle">
				<a href="SaveCourse.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>">
				<img src="images/save.gif" width="20" height="20" border="0" alt="Save"></a>
			</td>
		    <td align="left" class="tr-subrow" width="265" height="20">
				<a href="CourseUnits.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&userid=<%=developerId%>"><%=courseName%></a>
			</td>
<%
			st1=con.createStatement();
			rs1=st1.executeQuery("select count(unit_id) from lbcms_dev_units_master where course_id='"+courseId+"'");
			if(rs1.next())
				totUnits=rs1.getInt(1);
			st1.executeUpdate("update lbcms_dev_course_master set no_of_units='"+totUnits+"'where course_id='"+courseId+"'");
%>
		  <td align="center" class="tr-subrow" width="80" height="20"><%=totUnits%></td>
		  <td align="center" class="tr-subrow" width="126" height="20"><a href="#" onclick="saveToDesk('<%=courseName%>');return false;"><img src="images/zipicon.gif" width="20" height="20" border="0" alt="Save to Desk"></td>
		  <td align="center" class="tr-subrow" width="80" height="20"><a href="ViewAssignInfo.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&userid=<%=developerId%>">
				<img src="images/view.gif" width="20" height="20" border="0" alt="Manage Assignments"></a></td>
		<td align="center" class="tr-subrow" width="80" height="20"><a href="ViewAssessInfo.jsp?mode=none&courseid=<%=courseId%>&coursename=<%=courseName%>&userid=<%=developerId%>">
				<img src="images/view.gif" width="20" height="20" border="0" alt="Manage Assessments"></a></td>
			
		</tr>
<%
	rs1.close();
	}
	if(courseFlag==false)
	{
%>
		<tr>
			<td colspan="7" bgcolor="#D7D7D7">
				<font face="Verdana" size="2">&nbsp;There are no courses.</font>
			</td>
		</tr>
<%
	}	
}
catch(SQLException se)
	{
		System.out.println("The exception1 in CourseHome.jsp is....."+se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in CourseHome.jsp is....."+e);
	}
	finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(rs!=null)
				rs.close();
			if(con!=null && !con.isClosed())
				con.close();
			}
			catch(SQLException se){
			ExceptionsFile.postException("CourseHome.jsp","closing the statement objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}
%>
		</tbody>
        </table>
	</th>
    </tr>
    </table>
	<br /></div>
	</td>
</tr>

</table>
</body>
<SCRIPT LANGUAGE="JavaScript">
<!--
	function deleteCourse(courseid,developerid)
	{
		if(confirm("Are you sure that you want to delete the course?")==true)
		{
			window.location.href="AddEditCourse.jsp?mode=del&courseid="+courseid+"&userid="+developerid;
		}
		else
			return;
	}
function viewLessonFile(coursename)
{
	
window.open("/LBCOM/lbcms/course_bundles/"+coursename+"/Lessons.html","Document","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
}
function saveToDesk(coursename)
{
	
alert("This feature will be added soon");	
return false;
}
//-->
</SCRIPT>

</html>

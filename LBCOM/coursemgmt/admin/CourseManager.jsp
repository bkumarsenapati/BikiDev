<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar"%>
<%@ page errorPage="/ErrorPage.jsp"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:include page="AlertMessages.jsp" />
<%
String courseName="",classId="",teacherName="",teacherId="",schoolId="",courseId="",grade="",gradeTag="";
Hashtable classNames=null;
Hashtable gradeTags=null;
ResultSet  rs=null,rs1=null;
Connection con=null;
Statement st=null,st1=null;
boolean courseFlag=false;
String noOfStudents="";
%>
<%
String stateStandard="";
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
	stateStandard=((String)session.getAttribute("statestandard")).trim();
	grade=request.getParameter("classid");
	if(grade==null)
		grade=(String)session.getAttribute("grade");
	classNames=new Hashtable();
	gradeTags=new Hashtable();
	con=con1.getConnection();
	courseFlag=false;	
	st=con.createStatement();
	st1=con.createStatement();
	rs=st.executeQuery("select *,DATE_FORMAT(create_date, '%m/%d/%Y') as c_date from coursewareinfo where school_id='"+schoolId+"' and status>0 order by course_name");
%>

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title></title>
<SCRIPT LANGUAGE="JavaScript">
<!--
	function viewStatus(courseName,classId,courseId,teacherid){
	  window.location.href="status/AssignmentsDetail.jsp?classid="+classId+"&courseid="+courseId+"&coursename="+courseName+"&classname=&teacherid="+teacherid+"&start=0";	
	}
	function editCourse(courseName,teacherId,classId,courseId)
	{
		window.location.href="AdminEditCourse.jsp?coursename="+courseName+"&teacherid="+teacherId+"&classid="+classId+"&courseid="+courseId;
	}

	function assignTeacher(courseName,courseId)
	{
		window.location.href="AssignTeacher.jsp?coursename="+courseName+"&courseid="+courseId;
	}

	function deleteCourse(courseName,classId,courseId)
	{
		if(confirm("Are you sure that you want to delete the course?")==true)
		{
			window.location.href="/LBCOM/coursemgmt.AdminAddCourse?mode=del&coursename="+courseName+"&classid="+classId+"&courseid="+courseId;
		}
		else
			return;
	}

	function distributeCourse(courseName,classId,courseId,nostd)
	{
		if(nostd="Distribute")
			{
			nostd="0";
			}
		
		window.location.href="CourseStudentsList.jsp?mode=mod&coursename="+courseName+"&noofstd="+nostd+"&classid="+classId+"&courseid="+courseId;
	}

	function selectAll()
	{
		if(document.courselist.selectall.checked==true)
		{
			with(document.courselist)
			{
				for(var i=0; i < elements.length; i++) 
				{
					if(elements[i].type == 'checkbox' && elements[i].name == 'courseids')
						elements[i].checked = true;
				}
			}
		}
		else
		{
			with(document.courselist)
			{
				for(var i=0; i < elements.length; i++) 
				{
					if(elements[i].type == 'checkbox' && elements[i].name == 'courseids')
						elements[i].checked = false;
				}
			}
		}
	}
	
	function deleteSelectedCourses()
	{
		var selid=new Array();
        with(document.courselist) 
		{
			for(var i=0,j=0; i < elements.length; i++) 
			{
				if(elements[i].type == 'checkbox' && elements[i].name == 'courseids' && elements[i].checked==true)
					selid[j++]=elements[i].value;
            }
		}
        if(j>0)
		{
			if(confirm("Are you sure you want to delete the selected courses?")==true)
			{
				alert("Will be added soon.");
                return false;
			}
			else
				return false;
        }
		else
		{
			alert("Please select the courses to be deleted");
            return false;
        }
    }

//-->
</SCRIPT>

</head>
<body>
<form name="courselist" method="POST" action="--WEBBOT-SELF--">
 
<table border="0" cellspacing="0" bordercolor="#111111" width="100%" >
  <tr>
    <td width="14%" align="left" bgcolor="#FFFFFF">
		<a href="AddNewCourse.jsp"><img border="0" src="images/create.gif" title="Create a new Course"></a></td>
    <td width="26%" align="center" bgcolor="#FFFFFF">&nbsp;</td>
    <td width="20%" colspan="2" align="right" bgcolor="#FFFFFF">
		<a href="CourseController.jsp">
		<font face="arial" size="2">Course Controller</font></a></td>
    <!--  <td width="13%" align="center" bgcolor="#FFFFFF"><select size="1" name="D1">
    <option selected>All Courses</option>
    <option>Active Courses</option>
    <option>Inactive Courses</option>
    <option>New Courses</option>
    </select></td> -->
  </tr>
</table>
<table border="1" cellspacing="0" width="100%">
  <tr>
	<!-- <td width="10" height="20" align="center" bgcolor="#E7D57C">
		<input type="checkbox" name="selectall" onclick="selectAll()" value="ON" title="Select or deselect all students">
	</td>  -->
    <td width="17" align="center" height="20" bgcolor="#E7D57C" colspan="2">&nbsp;</td>
<!-- <td width="20" align="center" height="20" bgcolor="#E7D57C">
		<a href="#" onclick="return deleteSelectedCourses()">
		<img border="0" src="../images/del.gif" width="19" height="21" title="Delete selected courses"></a>
	</td>
-->
    <td width="278" align="center" height="20" bgcolor="#E7D57C">
		<font face="Arial" size="2"><b>Course Name</b></font></td>
    <td width="210" align="center" height="20" bgcolor="#E7D57C">
		<font face="Arial" size="2"><b>Teacher Assigned</b></font></td>
    <td width="122" align="center" height="20" bgcolor="#E7D57C">
		<font face="Arial" size="2"><b>Students</b></font></td>
    <td width="231" align="center" height="20" bgcolor="#E7D57C">
		<font face="Arial" size="2"><b>Start Date</b></font></td>
    <td width="239" align="center" height="20" bgcolor="#E7D57C">
		<font face="Arial" size="2"><b>Close Date</b></font></td>
	<td  align="center" height="20" bgcolor="#E7D57C">
		<font face="Arial" size="2"><b>Status</b></font></td>
   <!--  <td width="188" align="center" height="20" bgcolor="#E7D57C">
		<font face="Arial" size="2"><b>Status</b></font></td> -->
  </tr>
<%
	while(rs.next())
	{
		courseFlag=true;
		courseId=rs.getString("course_id"); 
		courseName=rs.getString("course_name"); 
		classId=rs.getString("class_id"); 
		teacherId=rs.getString("teacher_id");
		rs1=st1.executeQuery("select count(*) from coursewareinfo_det where school_id='"+schoolId+"' and course_id='"+courseId+"'");
		if(rs1.next())
		{
			noOfStudents=rs1.getString(1);
		}
		if(noOfStudents.equals("0"))
			noOfStudents="Distribute";
		rs1.close();
%>
  <tr>
<!--     <td width="26" height="13">
			<input type="checkbox" name="courseids" value="ON">
		</td>
 -->    
		<td width="17" height="13">
			<a href="#" onclick="editCourse('<%=courseName%>','<%=teacherId%>','<%=classId%>','<%=courseId%>')">
			<img border="0" src="../images/iedit.gif" width="16" height="19"></a></td>
		<td width="20" height="13">
			<a href="#" onclick="deleteCourse('<%=courseName%>','<%=classId%>','<%=courseId%>')">
			<img border="0" src="../images/del.gif" title="Delete Course" width="19" height="21"></a></td>
		<td width="278" height="13">
			<font face="Arial" size="2"><%=courseName%></font></td>
<%
		if(!teacherId.equals(""))
		{	
%>
	<td width="210" height="13">
		<font face="Arial" size="2"><%=teacherId%></font></td>
<%
		}
		else
		{
%>
	<td width="210" height="13">
		<font face="Arial" size="2">
		<a href="#" onclick="assignTeacher('<%=courseName%>','<%=courseId%>')">Assign Teacher</a></font></td>
<%
		}	
%>
    <td width="122" height="13" align="center">
		<a href="#" onclick="distributeCourse('<%=courseName%>','<%=classId%>','<%=courseId%>','<%=noOfStudents%>')" title="View Students List"><font size="2" face="Arial"><%=noOfStudents%></font></a>
		</font>
	</td>
    <td width="231" height="13" align="center">
		<font size="2" face="Arial"><%=rs.getString("create_date")%></font></td>
    <td width="239" height="13" align="center">
		<font size="2" face="Arial"><%=rs.getString("last_date")%></font>
	</td>
	<%
		if(!teacherId.equals(""))
		{	
	%>
	<td height="13" align="center">
		<a href="#" onclick="viewStatus('<%=courseName%>','<%=classId%>','<%=courseId%>','<%=teacherId%>')" ><font size="2" face="Arial">View</font></a>
	</td>
	 
	<%
		}
		else
		{
	%>
	<td height="13" align="center">
		&nbsp;
	</td>
	<%
		}	
	%>
	
    <!--  <td width="188" height="13" align="center" align="center">
		<font size="2" face="Arial">Active</font></td> -->
  </tr>
<%
	}	
%>
  </table>
<%
		if(courseFlag==false)
		{
%>
	<tr>
		<td width="26" height="13" colspan="9">
			<font size="2" face="Arial">There are no courses available.</font></td>
	</tr>
<%
		}
	}	
	catch(SQLException se)
	{
		ExceptionsFile.postException("CoursesList.jsp","operations on database","SQLException",se.getMessage());	 
			System.out.println("Error in CourseManager.jsp: SQL -" + se.getMessage());
	}
	catch(Exception e){
		ExceptionsFile.postException("CoursesList.jsp","operations on database","Exception",e.getMessage());	 
		System.out.println("Error in CourseManager.jsp:  -" + e.getMessage());

	}

	finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
		}catch(SQLException se){
			ExceptionsFile.postException("CoursesList.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println("Error in CourseManager.jsp :"+se.getMessage());
		}
	}
%>

</form>
</body>

</html>
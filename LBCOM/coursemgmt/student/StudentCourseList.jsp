<!--
	/**
	 *Lists the available courses to a particular student and also lists the no. of new items  
	 *(i.e)new AS/PW/HW/Materials/Exam(Quiz)/Final exam/Midterm Exam/Results.
	 */
 -->

<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" autoFlush="true"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%

Connection con=null;
Statement st=null;
ResultSet  rs=null;

boolean flag=false;					//false if there are no courses for the student

String courseName="",classId="",studentName="",teacherId="",studentId="",schoolId="",courseId="",workId="",examId="",createDate="",examType="";
String tableName="";
%>

<%
try
{
	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	schoolId = (String)session.getAttribute("schoolid");
	studentId = (String)session.getAttribute("emailid");
	studentName = (String)session.getAttribute("studentname");
	
	con=con1.getConnection();
	st=con.createStatement();
		
	rs=st.executeQuery(" select c.course_name,c.course_id,c.class_id,c.teacher_id from coursewareinfo c inner join coursewareinfo_det d  on c.course_id=d.course_id  and c.school_id=d.school_id where d.student_id='"+studentId+"' and status=1 and c.school_id='"+schoolId+"'");
	
	flag=false;	
	
	
%>

<html>
<head>
<title></title>
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" topmargin="0" leftmargin="5">

<table border="0" width="100%" cellspacing="0" align="center" cellpadding="0">
  <tr>
    <td ><b><font face="Arial" size="4">Welcome,<%= studentName %> !</font></b>&nbsp;</td>
  </tr>
  </table><P>

<div align="center">
  <center>
  <table width="100%">

<tr>
<td width="100%" valign=top >
<table border="0" align="center" width="500" cellspacing="1" bordercolor="#e08040">
    <tr>
        <td width="100%" height="20" align="center" colspan="2">
					<p align="left">
                    <img border="0" src="../images/slistofcourses.gif" width="151" height="28"></td>
    </tr>

    <tr>
        <td vAlign="center" width="5%" height="20" bgcolor="#e08040" align="center">
					<!--<img src="/LBCOM/studentAdmin/images/studentfolder.jpg" width=25 height=25>-->&nbsp;
        </td>
        <td width="95%" height="20" bgcolor="#e08040">
                 <span style="font-size:10pt;"><font face="Arial" color="#FFFFFF"><b>&nbsp;Course Name</b></font></span> 
        </td>
    </tr>

<%	while (rs.next()) {		
		courseName=rs.getString("course_name");
		courseId=rs.getString("course_id");
		classId=rs.getString("class_id");
		teacherId=rs.getString("teacher_id");
		%>
<!--To display the course name, new items in a tabular format   -->
	<tr>
        <td width="5%" height="20" bgcolor="#FFFFFF" align="center" style="border-left-style: solid; border-left-width: 1; border-right-width: 1; border-top-width: 1; border-bottom-style: solid; border-bottom-width: 1" bordercolor="#E7E7E7">
					<!--<a href="../teacher/ViewPerformance.jsp?emailid=<%=teacherId%>&mode=stu&grade=<%=classId%>&courseid=<%=courseId%>&coursename=<%=courseName%>"><img src="/LBCOM/studentAdmin/images/studentfolder.jpg" width=25 height=25 border=0></a>-->
					<a href="../reports/GradesByClass.jsp"><img src="/LBCOM/studentAdmin/images/studentfolder.jpg" width=25 height=25 border=0></a>
        </td>
        <td width="95%" height="20" bgcolor="#E7E7E7"><p align="left">
           <b><font face="Arial" size="2" color="blue">&nbsp;
		   <!--<a  href="../teacher/ViewPerformance.jsp?emailid=<%=teacherId%>&mode=stu&grade=<%=classId%>&courseid=<%=courseId%>&coursename=<%=courseName%>"><%=courseName%></a>-->
		   <a href="../reports/GradesByCategory.jsp"><%=courseName%></a></font></b>          
        </td>
    </tr>

	<% 
		flag=true;
	} 
		if (!flag){					//if there are no courses alloted to the user		
				out.println("<tr><td width='100%' colspan='9' height='21' align='center' bgcolor='#E7E7E7'><font face='Arial' color='#000000' size='2'>Courses are not available </font> </td></tr>");			
		}	

	
	}	
	catch(SQLException se){
		ExceptionsFile.postException("StudentCourseList.jsp","Operations on database","SQLException",se.getMessage());
//		System.out.println("Error: SQL -" + se.getMessage());
	}
	catch(Exception e){
		ExceptionsFile.postException("StudentCourseList.jsp","Operations on database","Exception",e.getMessage());
		System.out.println("Error:  -" + e.getMessage());

	}

	finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
			con1.close(con);
						
		}catch(SQLException se){
			ExceptionsFile.postException("StudentCourseList.jsp","Closing statement object","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}

	%>


</table>
    </td>
  </tr>
  </table>
  </center>
</div>
</body>
<SCRIPT LANGUAGE="JavaScript">
<!--
/*	function editCourse(courseName,classId,courseId){
		window.location.href="EditCourse.jsp?coursename="+courseName+"&classid="+classId+"&courseid="+courseId;
	}
	function deleteCourse(courseName,classId,courseId){
		if(confirm("Are you sure? You want to delete the course.")==true){				window.location.href="/servlet/coursemgmt.AddCourse?mode=del&coursename="+courseName+"&classid="+classId+"&courseid="+courseId;
		}else
			return;
	}

	function distCourse(courseName,classId,courseId){
		window.location.href="StudentsList.jsp?mode=mod&coursename="+courseName+"&classid="+classId+"&courseid="+courseId;
	}

	function courseLinks(courseName,classId,courseId){
		window.location.href="WeblinksList.jsp?coursename="+courseName+"&classid="+classId+"&courseid="+courseId;
	}

	function editDropBox(courseName,classId,courseId){
		window.location.href="DropBox.jsp?coursename="+courseName+"&classid="+classId+"&courseid="+courseId;
	}

	function editGrades(courseName,classId,courseId){		window.location.href="CourseGrades.jsp?coursename="+courseName+"&classid="+classId+"&courseid="+courseId;
	}*/



//-->
</SCRIPT>
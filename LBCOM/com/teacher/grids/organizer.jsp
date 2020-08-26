<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>::  Learn Beyond ::</title>

<script type="text/javascript">
	$(document).ready(function() {
		
		 // Topics
		$("#addedittopic").click(function(){			
		  
				$("#nav_main li").removeClass('selected');showLoading('grid');$("#notice_main").addClass('selected');grid_content.load("/LBCOM/coursemgmt/teacher/DisplayTopics.jsp?mode=add", hideLoading);
				
			}); 
				
	});
	
	function DoAction(courseName,classId,courseId,classname){
		courseName=courseName.replace(/ /g,"+");
		
		$("#nav_main li").removeClass('selected');grid_content.load("grids/DisplayTopics.jsp?classid="+classId+"&courseid="+courseId+"&coursename="+courseName+"&classname="+classname,hideLoading);
				
	} 
	
	</script>
</head>

<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
String courseName="",classId="",teacherName="",teacherId="",schoolId="",courseId="",grade="",className="",gradeTag="";
Hashtable classNames=null;
Hashtable gradeTags=null;
ResultSet  rs=null,rs1=null;
Connection con=null;
Statement st=null,st1=null;
boolean flag=false;
String courseFlag="0",courseEditFlag="0",courseDistributeFlag="0",classFlag="0";
%>
<%
try
{
	/*
	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	*/
	
	
	con=con1.getConnection();
	schoolId = (String)session.getAttribute("schoolid");
	//schoolId = "myschool";
	teacherId = (String)session.getAttribute("emailid");
	//teacherId ="teacher1";
	teacherName = (String)session.getAttribute("firstname");
	//teacherName = "Teacher One";
	//grade=request.getParameter("classid");
	grade="C000";
	//className=request.getParameter("classname");
	className="Common";
	if (grade==null)
		grade=(String)session.getAttribute("grade");
	
	classNames=new Hashtable();
	gradeTags=new Hashtable();
	
	flag=false;	
	st=con.createStatement();
	
	rs=st.executeQuery("select course_createflag,course_editflag,course_distributeflag from school_profile where schoolid='"+schoolId+"'");
	if(rs.next())
	{
		courseFlag=rs.getString("course_createflag");
		courseEditFlag=rs.getString("course_editflag");
		courseDistributeFlag=rs.getString("course_distributeflag");
	}
	rs.close();
	st.close();

	st=con.createStatement();
	%>

	<div class="hdetails">Hello <span class="dtext" onclick="right_content_load('profile_but');"><%=teacherId%></span>, You have <span class="dtext" onclick="right_content_load('event_but');">0</span> Appointments for the Day</div>
	
	<%
	//rs=st.executeQuery("select class_id,class_des,grades_tag from class_master where school_id='"+schoolId+"'");
	rs=st.executeQuery("select *,DATE_FORMAT(create_date, '%m-%d-%Y') as c_date from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"' and class_id='"+grade+"' and status>0 order by course_name");

	while(rs.next())
	{
		courseName=rs.getString("course_name"); 
		classId=rs.getString("class_id");
		courseId=rs.getString("course_id");
		className=(String)classNames.get(classId);
		gradeTag=(String)gradeTags.get(classId);
	
%>
	

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="objectborder">
  <tr>
    <td class="gridhdr">Course Name</td>
    <td class="gridhdr">Topics</td>
    <td class="gridhdr">Subtopics</td>
    <td class="gridhdr">Distribution</td>
    <td class="gridhdr">Grading System</td>
    <td class="gridhdr">WebLinks</td>
    <td class="gridhdr">Class Performance</td>
    <td class="gridhdr">Created On</td>
    <td class="gridhdr">Credit</td>
    <td class="gridhdr">Academic Year</td>
  </tr>
  <tr>
    <td class="griditem"><%=courseName%></td>
    <td class="griditem"><a href="#"  onClick="DoAction('<%=courseName%>','<%= classId%>','<%= courseId %>','<%= classId %>');" >Add/Edit</td>
    <td class="griditem">Add/Edit</td>
    <td class="griditem"><img class="hand" src="../images/editIcon.jpg" alt="edit" width="28" height="28" /></td>
    <td class="griditem"><img class="hand" src="../images/editIcon.jpg" alt="edit" width="28" height="28" /></td>
    <td class="griditem">Add/Edit</td>
    <td class="griditem">View</td>
    <td class="griditem"><%= rs.getString("c_date") %></td>
    <td class="griditem"><%= rs.getString("sess") %></td>
    <td class="griditem"><%= rs.getString("last_date") %></td>
  </tr>
 
   <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
<br />
<br />
<%
	}  
}
	  catch(Exception e){
		
		System.out.println("Error:  -" + e.getMessage());

	}

	finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			
			if(con!=null)
				con.close();
		}catch(SQLException se){
			
			System.out.println(se.getMessage());
		}
	}
	%>

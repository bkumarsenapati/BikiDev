<script type="text/javascript">
	$(document).ready(function() {
		
		 // Topics
		$("#addedittopic").click(function(){			
		  
				$("#nav_main li").removeClass('selected');showLoading('grid');$("#notice_main").addClass('selected');grid_content.load("/LBCOM/coursemgmt/teacher/DisplayTopics.jsp?mode=add", hideLoading);
				
			}); 
				
	});

	function DoActionCoursesList(courseName,classId,courseId,classname)
	{

		courseName=courseName.replace(/ /g,"+");
		$("#nav_main li").removeClass('selected');grid_content.load("/LBCOM/coursemgmt/teacher/CoursesMain.jsp?classid="+classId+"&courseid="+courseId+"&coursename="+courseName+"&classname="+classname,hideLoading);
	}
	
	function DoActionMarking(courseName,classId,courseId,classname)
	{
		
		courseName=courseName.replace(/ /g,"+");
		$("#nav_main li").removeClass('selected');grid_content.load("/LBCOM/markingpoints/teacher/MPMain.jsp?classid="+classId+"&courseid="+courseId+"&coursename="+courseName+"&classname="+classname,hideLoading);
	}

	function DoActionTopic(courseName,classId,courseId,classname){
		courseName=courseName.replace(/ /g,"+");
				
		$("#nav_main li").removeClass('selected');grid_content.load("/LBCOM/coursemgmt/teacher/DisplayTopics.jsp?classid="+classId+"&courseid="+courseId+"&coursename="+courseName+"&classname="+classname,hideLoading);
				
	}
	function DoActionSubTopic(courseName,classId,courseId,classname)
	{

		courseName=courseName.replace(/ /g,"+");
		$("#nav_main li").removeClass('selected');grid_content.load("/LBCOM/coursemgmt/teacher/TopicFrameMain.jsp?classid="+classId+"&courseid="+courseId+"&coursename="+courseName+"&classname="+classname,hideLoading);
	}
	function DoActionDistribute(courseName,classId,courseId,classname)
	{

		courseName=courseName.replace(/ /g,"+");
		$("#nav_main li").removeClass('selected');grid_content.load("/LBCOM/coursemgmt/teacher/StudentsList.jsp?mode=edit&classid="+classId+"&courseid="+courseId+"&coursename="+courseName+"&classname="+classname,hideLoading);
	}
	function DoActionGrading(courseName,classId,courseId,classname,mode)
	{
		
		courseName=courseName.replace(/ /g,"+");
		$("#nav_main li").removeClass('selected');grid_content.load("/LBCOM/coursemgmt/teacher/ViewEditCourseGrades.jsp?mode=edit&classid="+classId+"&courseid="+courseId+"&coursename="+courseName+"&classname="+classname+"&mode="+mode+"&schema=Main",hideLoading);
	}
	function DoActionCategories(courseName,classId,courseId,classname,mode)
	{
		
		courseName=courseName.replace(/ /g,"+");
		$("#nav_main li").removeClass('selected');grid_content.load("/LBCOM/coursemgmt/teacher/CourseCategories.jsp?mode=edit&classid="+classId+"&courseid="+courseId+"&coursename="+courseName+"&classname="+classname+"&mode="+mode+"&schema=Main",hideLoading);
	}
	function DoActionPerformance(courseName,classId,courseId,classname,mode)
	{
		
		courseName=courseName.replace(/ /g,"+");
		$("#nav_main li").removeClass('selected');grid_content.load("/LBCOM/coursemgmt/teacher/StudentPerformance.jsp?mode=edit&classid="+classId+"&courseid="+courseId+"&coursename="+courseName+"&classname="+classname+"&mode="+mode+"&schema=Main",hideLoading);
	}
	function go(clid)
	{
		$("#nav_main li").removeClass('selected');grid_content.load("/LBCOM/coursemgmt/teacher/CoursesList.jsp?classid="+clid+"&classname=Common",hideLoading);

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
int noOfEvents=0;
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
	
	
	con=con1.getConnection();
	schoolId = (String)session.getAttribute("schoolid");
	teacherId = (String)session.getAttribute("emailid");
	teacherName = (String)session.getAttribute("firstname");
	//teacherName = "Teacher One";
	grade=request.getParameter("classid");
	//grade="C000";
	className=request.getParameter("classname");
	if(className==null)
	{
		className="Common";
	}
	//className="Common";
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
	st1=con.createStatement();
	rs1= st1.executeQuery("select count(*) from event where owner='"+teacherId+"' and sdate=curdate()");
	if(rs1.next())
	{
		noOfEvents=rs1.getInt(1);
	}
	rs1.close();
	st1.close();
	st=con.createStatement();
	rs=st.executeQuery("select class_id,class_des,grades_tag from class_master where school_id='"+schoolId+"'");

	%>
	


	<div class="hdetails"><!-- Welcome <span class="dtext" onclick="right_content_load('profile_but');"><%=teacherName%></span>, --> You have <span class="dtext" onclick="right_content_load('event_but');"><font color="blue"><%=noOfEvents%></font></span> Appointments for the Day</div>
	<table border="0" width="100%" cellspacing="1">
	
    <tr>
		<td height="21" bgcolor="#FFFFFF" colspan="3" align="right">
			<select size="1" name="classid" onchange="return go(this.value,this.value);">
				<option value="">............Select Grade...........</option>
<%
							while(rs.next())
							{
								String cId=rs.getString("class_id");
								classNames.put(cId,rs.getString("class_des"));
								gradeTags.put(cId,rs.getString("grades_tag"));
								out.println("<option value='"+cId+"'>"+rs.getString("class_des")+"</option>");
							}
							rs.close();
							//st.close();
%>
            </select>
		</td>
	</tr>
	</table>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="objectborder">
  <tr>
    <td class="gridhdr">Course Name</td>
	<td class="gridhdr">Marking Period</td>
	<td class="gridhdr">Categories</td>
    <td class="gridhdr">Topics</td>
    <td class="gridhdr">Subtopics</td>
    <td class="gridhdr">Distribution</td>
    <td class="gridhdr">Grading Schema</td>
    <!-- <td class="gridhdr">Web Links</td> -->
<!--     <td class="gridhdr">Class Performance</td> -->
    <!-- <td class="gridhdr">Created On</td> -->
    <td class="gridhdr">Credit</td>
	<td class="gridhdr">Status</td>
    <td class="gridhdr">End Date</td>
  </tr>
	<%
	//rs=st.executeQuery("select class_id,class_des,grades_tag from class_master where school_id='"+schoolId+"'");
	rs=st.executeQuery("select *,DATE_FORMAT(create_date, '%m-%d-%Y') as c_date from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"' and class_id='"+grade+"' and status>0 order by course_name");

	while(rs.next())
	{
		courseName=rs.getString("course_name"); 
		classId=rs.getString("class_id");
		courseId=rs.getString("course_id");
		className=(String)classNames.get(classId);
		//className="Common";
		gradeTag=(String)gradeTags.get(classId);
	
%>
	


  <tr>

    <td class="griditemcourse"><a href="#"  onClick="DoActionCoursesList('<%=courseName%>','<%= classId%>','<%= courseId %>','<%= className%>');" ><%=courseName%></td>

	<td class="griditem"><a href="#"  onClick="DoActionMarking('<%=courseName%>','<%= classId%>','<%= courseId %>','<%= className %>');" ><img class="hand" src="/LBCOM/coursemgmt/teacher/images/markingperiod.png" title="Marking Period Manager" width="28" height="28" border="0" /></td>
	
	<td class="griditem"><a href="#"  onClick="DoActionCategories('<%=courseName%>','<%= classId%>','<%= courseId %>','<%= className %>','edit');" ><img class="hand" src="/LBCOM/coursemgmt/teacher/images/item_cate.png" title="Add/Edit Categories" width="28" height="28" border="0" /></td>
    
	<td class="griditem"><a href="#"  onClick="DoActionTopic('<%=courseName%>','<%= classId%>','<%= courseId %>','<%= className %>');" >Add/Edit</td>
    <td class="griditem"><a href="#"  onClick="DoActionSubTopic('<%=courseName%>','<%= classId%>','<%= courseId %>','<%= className%>');" >Add/Edit</td>
    <td class="griditem"><a href="#"  onClick="DoActionDistribute('<%=courseName%>','<%= classId%>','<%= courseId %>','<%= className %>');" ><img class="hand" src="/LBCOM/coursemgmt/teacher/images/iassign.gif" title="Distribution" width="28" height="28" border="0"/></td>
    <td class="griditem"><a href="#"  onClick="DoActionGrading('<%=courseName%>','<%= classId%>','<%= courseId %>','<%= className %>','edit');" ><img class="hand" src="../images/grade_system.png" title="Grading System" width="28" height="28" border="0" /></td>
    <!-- <td class="griditem"><a href="#" ><img class="hand" src="../images/link_blue.png" title="Manage Web Links" width="28" height="28" border="0" /></td> -->
   <!--  <td class="griditem">View</td> -->
    <!-- <td class="griditem"><%= rs.getString("c_date") %></td> -->
    <td class="griditem"><%= rs.getString("sess") %></td>
	<td class="griditem"><a href="#"  onClick="DoActionPerformance('<%=courseName%>','<%= classId%>','<%= courseId %>','<%= className %>','edit');" ><img class="hand" src="/LBCOM/coursemgmt/teacher/images/status_results.png" title="Student Performance" width="28" height="28" border="0" /></td>
    <td class="griditem"><%= rs.getString("last_date") %></td>
  </tr>
 
   

<%
	}  
%>
</table>
<br />
<br />
<%
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
	<script>
	document.courselist.classid.value="<%=grade%>";
	document.courselist.classid.focus();

</SCRIPT>


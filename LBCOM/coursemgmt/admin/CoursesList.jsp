<!--Lists the courses that are created by a particular teacher   -->

<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:include page="AlertMessages.jsp" />
<%
String courseName="",classId="",teacherName="",teacherId="",schoolId="",courseId="",grade="",className="",gradeTag="";
Hashtable classNames=null;
Hashtable gradeTags=null;
ResultSet  rs=null;
Connection con=null;
Statement st=null;
boolean flag=false;
%>

<%
//System.out.println("Message is..."+delCourseMsg);

%>
<%
String stateStandard="";
try
{
	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	schoolId = (String)session.getAttribute("schoolid");
	teacherId = (String)session.getAttribute("emailid");
	teacherName = (String)session.getAttribute("firstname");
	stateStandard=((String)session.getAttribute("statestandard")).trim();
	grade=request.getParameter("classid");
	className=request.getParameter("classname");
   
	if (grade==null)
		grade=(String)session.getAttribute("grade");

	classNames=new Hashtable();
	gradeTags=new Hashtable();
	con=con1.getConnection();

	flag=false;	
	st=con.createStatement();
	
	//rs=st.executeQuery("select distinct grade from studentprofile where schoolid='"+schoolId+"' order by grade" );
	//rs=st.executeQuery("select class_id,class_des from class_master where school_id='"+schoolId+"'  and class_id= any(select distinct(grade) from studentprofile where schoolid='"+schoolId+"')");
	rs=st.executeQuery("select class_id,class_des,grades_tag from class_master where school_id='"+schoolId+"'");

%>

<html>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" topmargin="0" leftmargin="3">
<form name="courselist">

<br>
<table border="0" width="100%" cellspacing="1">
	
    <tr>
		<td width="198" height="15" bgcolor="#FFFFFF" colspan="4">
			<img src="../images/listofcourses.gif" width="151" height="28" border="0"></td>
        <td width="67" height="21" bgcolor="#FFFFFF">&nbsp;</td>
        <td width="79" height="21" bgcolor="#FFFFFF">&nbsp;</td>
        <td width="91" height="21" bgcolor="#FFFFFF">&nbsp;</td>
        <td width="70" height="15" bgcolor="#FFFFFF" align="center">
			<font size="1" face="Arial">
			<a href="javascript://" onclick="return help();"><b>HELP</b></a></font>
		</td>
        <td width="86" height="15" bgcolor="#FFFFFF">&nbsp;</td>
       <!--  <td width="96" height="15" bgcolor="#FFFFFF">&nbsp;</td>
        <td width="94" height="15" bgcolor="#FFFFFF">&nbsp;</td> -->
        <td height="21" bgcolor="#FFFFFF" colspan="3" align="right">
			<select size="1" name="classid" onchange="return go();">
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
								//selects the courses that are created by the teacher
							rs=st.executeQuery("select *,DATE_FORMAT(create_date, '%m/%d/%Y') as c_date from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"' and class_id='"+grade+"' and status>0");

%>
                        </select></td>
    </tr>

    <tr>
        <td width="24" height="15" bgcolor="#42A2E7"></td>
     <!--   <td width="25" height="15" bgcolor="#42A2E7">           &nbsp;        </td>-->

		<td width="12" height="22" bgcolor="#42A2E7">&nbsp;</td>
        <td width="12" height="22" bgcolor="#42A2E7">&nbsp;</td>
        <td width="150" height="22" bgcolor="#42A2E7" align="center">
			<font face="Arial" color="#FFFFFF" style="font-size: 9pt"><b>Course Name</b></font> 
        </td>
        <td width="67" height="21" bgcolor="#42A2E7" align="center">
			<font face="Arial" color="#FFFFFF" style="font-size: 9pt;"><b>Topics</b></font>
		</td>
        <td width="79" height="21" bgcolor="#42A2E7" align="center">
			<b><font face="Arial" color="#FFFFFF" style="font-size: 9pt">Subtopics</font></b>
        </td>
        <td width="91" height="21" bgcolor="#42A2E7" align="center">
			<b>
			<font face="Arial" color="#FFFFFF" style="font-size: 9pt">Distribution</font></b>
        </td>
        <td width="70" height="15" bgcolor="#42A2E7" align="center">
			<b><font face="Arial" color="#FFFFFF" style="font-size:9pt">Grading</font></b>
        </td>
        <td width="86" height="15" bgcolor="#42A2E7" align="center">
			<b><font face="Arial" color="#FFFFFF" style="font-size: 9pt">Web Links</font></b>
        </td>
        <td width="96" height="15" bgcolor="#42A2E7" align="center">
			<b><font face="Arial" color="#FFFFFF" style="font-size: 9pt">Performance</font></b>
		</td>
        <td width="94" height="15" bgcolor="#42A2E7" align="center">
			<b><font face="Arial" color="#FFFFFF" style="font-size: 9pt">Created On</font></b>
		</td>
        
		<!-- <td width="61" height="21" bgcolor="#42A2E7" align="center">
			<span style="font-size:9pt;">
			<b><font face="Arial" color="#FFFFFF">Session</font></b></span>
        </td> -->

		<td height="21" bgcolor="#42A2E7" align="center">
			<b><font face="Arial" color="#FFFFFF" style="font-size: 9pt">Status</font></b>
        </td>

        <!-- <td width="99" height="15" bgcolor="#42A2E7" align="center">
			<span style="font-size:9pt;">
			<font face="Arial" color="#FFFFFF"><b>Academic</b></font></span>
        </td> -->

    </tr>

<%
	while(rs.next())
	{
%>
		<tr>
			<td width="24" height="25" bgcolor="#E7E7E7" align="center">
<% 
		courseName=rs.getString("course_name"); 
		classId=rs.getString("class_id");
		courseId=rs.getString("course_id");
		className=(String)classNames.get(classId);
		gradeTag=(String)gradeTags.get(classId);
%>

			    <a href="#" onclick="editCourse('<%=courseName%>','<%=classId%>','<%= courseId %>','<%=className%>')">
				<img border="0" src="../images/iedit.gif" width="16" height="19" TITLE="Edit Course"></a></td>
			<td width="13" height="25" bgcolor="#E7E7E7" align="center">
				<a href="#" onclick="deleteCourse('<%=courseName %>','<%= classId %>','<%= courseId %>','<%=className%>')">
				<img border="0" src="../images/idelete.gif"  TITLE="Delete Course" width="19" height="21"></a></td>
			<td width="12" height="25" bgcolor="#E7E7E7" align="center">
				<a href="#" onclick="marking('<%=courseName %>','<%= classId %>','<%= courseId %>','<%=className%>')">
				<img border="0" src="../images/marking.gif"  TITLE="Marking Period Manager" width="25" height="20"></a></td>
			<td width="150" height="25" bgcolor="#E7E7E7">
				<span style="font-size:10pt;">
				<font face="Arial">
				<a href="#" onclick="editDropBox('<%=courseName %>','<%= classId %>','<%= courseId %>','<%=className%>')"><%= courseName %></a></font></span>
			</td>
			<td width="67" height="25" bgcolor="#E7E7E7" align="center">           
				<span style="font-size:10pt;">
				<font face="Arial"><a href="#" onclick="editTopics('<%=courseName%>','<%= classId%>','<%= courseId %>','<%=className%>')">Add/Edit</a></font></span>
			</td>
			<td width="79" height="25" bgcolor="#E7E7E7" align="center">           
				<span style="font-size:10pt;">
				<font face="Arial">
				<a href="#" onclick="editSubTopics('<%=courseName%>','<%= classId%>','<%= courseId %>','<%=className%>')">Add/Edit</a></font></span>
			</td>
			<td width="91" height="25" bgcolor="#E7E7E7" align="center">
				<span style="font-size:10pt;">
				<font face="Arial"><a href="#" onclick="distCourse('<%=courseName%>','<%= classId%>','<%= courseId %>','<%=className%>')">Edit</a></font></span></td>

<%
	if(gradeTag.equals("1"))
	{
%>		
		 <td width="70" height="25" bgcolor="#E7E7E7" align="center">
			<font face="Arial">
			<span style="font-size: 10pt"><a href="#" onclick="editGrades('<%= courseName %>','<%= classId %>','<%= courseId %>','<%=className%>','edit')">Edit</a></span></font>
        </td>
<%
	}
	else
	{
%>
		<td width="70" height="25" bgcolor="#E7E7E7" align="center">
			<font face="Arial">
			<span style="font-size: 10pt"><a href="#" onclick="editGrades('<%= courseName %>','<%= classId %>','<%= courseId %>','<%=className%>','view')">View</a></span></font>
        </td>
<%
	}	
%>

		<td width="86" height="25" bgcolor="#E7E7E7" align="center">
			<span style="font-size:10pt;">
			<font face="Arial"><a href="#" onclick="courseLinks('<%=courseName%>','<%= classId%>','<%= courseId %>','<%=className%>')">Add/Edit</a></font></span>
        </td>
		 <td width="96" height="25" bgcolor="#E7E7E7" align="center">
			<span style="font-size:10pt;">
			<font face="Arial"><a href="#" onclick="viewPerformance('<%= courseName %>','<%= classId %>','<%= courseId %>','<%=className%>')"> View</a></font></span>
        </td>
       <!-- <td width="85" height="25" bgcolor="#E7E7E7">-->
        <td width="94" height="25" bgcolor="#E7E7E7" align="center">
			<span style="font-size:10pt;">
			<font face="Arial"><%= rs.getString("c_date") %></font></span>
        </td>

       <!--  <td width="61" height="25" bgcolor="#E7E7E7" align="center">
			<span style="font-size:10pt;">
			<font face="Arial"><%= rs.getString("sess") %></font></span>
        </td> -->

		<td width="61" height="25" bgcolor="#E7E7E7" align="center">
			<span style="font-size:10pt;">
			<font face="Arial"><a href="#" onclick="viewStatus('<%= courseName %>','<%= classId %>','<%= courseId %>','<%=className%>')" >View</a></font></span>
        </td>

       <!--  <td width="99" height="25" bgcolor="#E7E7E7" align="center">
			<span style="font-size:10pt;">
			<font face="Arial"><%= rs.getString("ac_year")%></font></span>
        </td> -->

    </tr>

<%
		flag=true;
	} 
		if (!flag)
		{
%>
	<tr>
		<td width='100%' colspan='14' height='21' align='left' bgcolor='#E7E7E7'>
			<font face='Arial' color='#000000' size='2'>Courses are not available yet.</font> </td>
	</tr>			
<%
		}	
	}	
	catch(SQLException se)
	{
		ExceptionsFile.postException("CoursesList.jsp","operations on database","SQLException",se.getMessage());	 
			System.out.println("Error: SQL -" + se.getMessage());
	}
	catch(Exception e){
		ExceptionsFile.postException("CoursesList.jsp","operations on database","Exception",e.getMessage());	 
		System.out.println("Error:  -" + e.getMessage());

	}

	finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
		}catch(SQLException se){
			ExceptionsFile.postException("CoursesList.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println(se.getMessage());
		}
	}

	%>


</table>

<table width="100%" border="0">
	<tr>
		<td width="23" height="19"> 

<%
	if(stateStandard.equals(""))
	{
%>
		<a href="CreateCourse.jsp">
<%
	}
	else
	{
%>
		<a href="StateStandardsFrame.jsp">
<%
	}
%>

		<img border="0" src="../images/create.gif"  align="left" TITLE="Create Course" width="89" height="33"></a>&nbsp;</td>
			<td width="490" height="19">
				<font face="Arial" size="2">Click here to create a new Course. </font></td>
			<td width="473" height="19">&nbsp;</td>
  </tr>
</table>

</form>
</body>
<SCRIPT LANGUAGE="JavaScript">
<!--
	function editCourse(courseName,classId,courseId,classname){
		window.location.href="EditCourse.jsp?coursename="+courseName+"&classid="+classId+"&courseid="+courseId+"&classname="+classname;
	}
	function deleteCourse(courseName,classId,courseId,classname){
		if(confirm("Are you sure that you want to delete the course?")==true){				window.location.href="/LBCOM/coursemgmt.AddCourse?mode=del&coursename="+courseName+"&classid="+classId+"&courseid="+courseId+"&classname="+classname;
		}else
			return;
	}
	function marking(courseName,classId,courseId,classname){
		window.location.href="/LBCOM/markingpoints/teacher?coursename="+courseName+"&classid="+classId+"&courseid="+courseId+"&classname="+classname;
	}

	function distCourse(courseName,classId,courseId,classname){
		window.location.href="StudentsList.jsp?mode=mod&coursename="+courseName+"&classid="+classId+"&courseid="+courseId+"&classname="+classname;
	}

	function courseLinks(courseName,classId,courseId,classname){
		window.location.href="WeblinksList.jsp?coursename="+courseName+"&classid="+classId+"&courseid="+courseId+"&classname="+classname;
	}

	function editDropBox(courseName,classId,courseId,classname){
		window.location.href="DropBox.jsp?coursename="+courseName+"&classid="+classId+"&courseid="+courseId+"&classname="+classname;
	}

	function editGrades(courseName,classId,courseId,classname,mode){	
		window.location.href="ViewEditCourseGrades.jsp?coursename="+courseName+"&classid="+classId+"&courseid="+courseId+"&classname="+classname+"&mode="+mode+"&schema=Main";
	}

	function editTopics(courseName,classId,courseId,classname){		window.location.href="DisplayTopics.jsp?coursename="+courseName+"&classid="+classId+"&courseid="+courseId+"&classname="+classname;
	}

	function editSubTopics(courseName,classId,courseId,classname){		window.location.href="TopicFrame.jsp?coursename="+courseName+"&classid="+classId+"&courseid="+courseId+"&classname="+classname;
	}


	function viewPerformance(courseName,classId,courseId,classname){		//window.location.href="ViewStudentsPerformance.jsp?coursename="+courseName+"&classid="+classId+"&courseid="+courseId;
	  window.location.href="../reports/GradesByCourse.jsp?classid="+classId+"&courseid="+courseId+"&coursename="+courseName+"&classname="+classname;	
	}

	function go(){
		var classname;
		var x=document.getElementsByName("classid");
		classname=x[0].options[x[0].selectedIndex].text;
		window.location.href="CoursesList.jsp?classid="+document.courselist.classid.value+"&classname="+classname;

	}
	function viewStatus(courseName,classId,courseId,classname){
	  window.location.href="AssignmentsDetail.jsp?classid="+classId+"&courseid="+courseId+"&coursename="+courseName+"&classname="+classname+"&start=0";	
	}
	
	function help()
	{
		var x=window.open('/LBCOM/helpfiles/CourseMgmtHelp.html' ,'nmwindow','status=0,resizable=no,toolbar=no,menubar=no,titlebar=no,scrollbars=no,width=700,height=400');
		x.window.focus();
	}

	document.courselist.classid.value="<%=grade%>";
	document.courselist.classid.focus();

//-->
</SCRIPT>
</html>
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
ResultSet  rs=null,rs2=null,rs3=null;
Connection con=null;
Statement st=null,st2=null,st3=null;
boolean flag=false;
String courseFlag="0",courseEditFlag="0",courseDistributeFlag="0",classFlag="0",mode="",builderId="",aMaterialId="";
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
	//grade=request.getParameter("classid");
	//className=request.getParameter("classname");
	mode=request.getParameter("mode");
	if(mode==null)
	{
		mode="";
	}
   
	//if (grade==null)
		//grade=(String)session.getAttribute("grade");

	//classNames=new Hashtable();
	//gradeTags=new Hashtable();
	con=con1.getConnection();

	flag=false;	
	st=con.createStatement();
	st2=con.createStatement();
	st3=con.createStatement();
	
%>

<html>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" topmargin="0" leftmargin="3">
<BR><BR><BR><BR>
<form name="courselist">

<table border="0" width="511" cellspacing="1" height="108" align="center">
	
    <tr>
		<td width="507" height="32" bgcolor="#FFFFFF" colspan="4">
			<img src="../images/listofcourses.gif" width="151" height="28" border="0"> </td>
	</tr>

    <tr>
         <td width="476" height="20" bgcolor="#42A2E7" align="left" colspan="4">
		<font face="Arial" color="#FFFFFF" style="font-size: 11pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Course Name</b></font> 
        </td>
	 </tr>

<%
	//selects the courses that are created by the teacher
	rs=st.executeQuery("select *,DATE_FORMAT(create_date, '%m/%d/%Y') as c_date from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"' and status>0");

	while(rs.next())
	{
%>
		<tr>
<% 
		courseName=rs.getString("course_name"); 
		classId=rs.getString("class_id");
		courseId=rs.getString("course_id");
		//className=(String)classNames.get(classId);
		//gradeTag=(String)gradeTags.get(classId);
%>
<%

	rs3=st3.executeQuery("SELECT * FROM course_docs where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and  course_id='"+courseId+"' order by status");
	while (rs3.next())
			{
				aMaterialId=rs3.getString("work_id");
			}


	rs2=st2.executeQuery("select count(*) as accesscount  from accessbuilder where course_id=(select course_id from dev_course_master where course_name='"+courseName+"') and builder_id='"+teacherId+"'");
	while (rs2.next())
			{
		builderId=rs2.getString("accesscount");
			}

		if((builderId).equals("0"))
			{
%>
		
			<td width="14" height="20" bgcolor="#E7E7E7" align="center">
			<a href="#" onclick="alert('You have not permission to Add the Content for the Course..!');return false;">
				<img border="0" src="images/add.gif" width="22" height="22" TITLE="Add the Content to Course"></a></td>

			<td width="14" height="20" bgcolor="#E7E7E7" align="center">
			<a href="#" onclick="alert('You have not permission to Import the Course..!');return false;">
				<img border="0" src="images/import_icon.jpg" width="22" height="20" TITLE="Import the Course"></a></td>

			<td width="14" height="20" bgcolor="#E7E7E7">&nbsp;</td>
			

<%
		}else{
%>
		<td width="14" height="20" bgcolor="#E7E7E7" align="center">
			<a href="/LBCOM/coursedeveloper/CourseHome.jsp?userid=<%=rs.getString("course_name")%>&&docname=<%=rs.getString("course_name")%>" target="_self">
				<img border="0" src="images/add.gif" width="22" height="20" TITLE="Add the Content to Course"></a></td>

			<td width="14" height="20" bgcolor="#E7E7E7" align="center">
			<a href="/LBCOM/coursedeveloper/CourseCopy.jsp?coursename=<%=courseName%>&materialid=<%=aMaterialId%>&courseid=<%=courseId%>&teacherid=<%=teacherId%>&schoolid=<%=schoolId%>" target="_self">
				<img border="0" src="images/import_icon.jpg" width="22" height="20" TITLE="Import the Course"></a></td>
			
			<td width="14" height="20" bgcolor="#E7E7E7" valign="bottom">
			<img border="0" src="images/access_icon.jpg" width="20" height="20" TITLE="You have the Permissions to this Course" valign="top">
			</td>

<%
		}
%>
		<td width="476" height="20" bgcolor="#E7E7E7" align="left">
			<span style="font-size:9pt;">
			<b><font face="verdana" color="#996600">&nbsp;<%= rs.getString("course_name")%></font></b></span>
        </td>

		</tr>
<%
	flag=true;
	} 
		if (!flag)
		{
%>
	<tr>
		<td width='507' colspan='3' height='20' align='left' bgcolor='#E7E7E7'>
			<font face='Arial' color='#000000' size='2'>Presently there are no Courses available.</font> </td>
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
			if(st2!=null)
				st2.close();
			if(con!=null)
				con.close();
		}catch(SQLException se){
			ExceptionsFile.postException("CoursesList.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println(se.getMessage());
		}
	}

	%>


</table>
</form>
</body>

</html>
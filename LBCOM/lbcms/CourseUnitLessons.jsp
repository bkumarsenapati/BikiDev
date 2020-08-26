<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@ include file="/common/checksession.jsp" %>

<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String courseId="",courseName="",unitId="",unitName="",previousLessonId="",nextLessonId="";
	String lessonId="",lessonName="",developerId="",lessonStatus="",fileName="";
	boolean lessonFlag=false;
%>
<%
	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
		return;
	}
	con=con1.getConnection();
	st=con.createStatement();

	//courseId=request.getParameter("courseid");
	courseId=(String)session.getAttribute("cb_courseid");
	//courseName=request.getParameter("coursename");
	courseName=(String)session.getAttribute("cb_coursename");
	unitId=request.getParameter("unitid");
	unitName=request.getParameter("unitname");
	session.setAttribute("cb_unitid",unitId);
	session.setAttribute("cb_unitname",unitName);
	developerId=request.getParameter("userid");

	rs=st.executeQuery("select * from lbcms_dev_lessons_master where course_id='"+courseId+"' and unit_id='"+unitId+"' order by lesson_id");
%>
<html>
<head>
<SCRIPT LANGUAGE="JavaScript">
<!--
	function deleteLesson(courseid,coursename,unitid,unitname,lessonid,developerid)
	{
		if(confirm("Are you sure you want to delete the lesson?")==true)
		{
			window.location.href="AddNewLesson.jsp?userid="+developerid+"&courseid="+courseid+"&coursename="+coursename+"&unitid="+unitid+"&unitname="+unitname+"&lessonid="+lessonid+"&mode=delete"
			return false;
		}
		else
			return false;
}

function moveUp(currentlid,prevlid)
{
	parent.location.href="ChangeOrder.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&userid=<%=developerId%>&lessonid1="+currentlid+"&lessonid2="+prevlid;
}

function moveDown(currentlid,nextlid)
{
	parent.location.href="ChangeOrder.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&userid=<%=developerId%>&lessonid1="+currentlid+"&lessonid2="+nextlid;
}
function viewUserManual()
{
	
window.open("/LBCOM/manuals/coursebuilder_webhelp/Learnbeyond_Course_Builder.htm","DocumentUM","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
}


//-->
</SCRIPT>
<title>Add Edit Lesson</title>
<meta name="generator" content="Microsoft FrontPage 5.0">
<link href="styles/teachcss.css" rel="stylesheet" type="text/css" />
</head>

<body >
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="whiteBgClass" >

<tr>
	<td width="15" height="70">&nbsp;</td>
	<td width="368" height="70">
		<img src="images/logo.png" width="368" height="101" border="0">
	</td>
    <td> <a href="#" onClick="viewUserManual();return false;"><img src="images/helpmanaual.png" border="0" style="margin-left:320px;"></a></td>
    <td width="423" height="70" align="right">
		<img src="images/mahoning-Logo.gif" width="208" height="70" border="0">
    </td>
</tr>
  </table>
    <tr>
        <td width="100%" height="495" colspan="3" bgcolor="#FFFFFF" align="center" valign="top">
          
        <td width="100%" height="495" colspan="3" background="images/bg2.gif" align="center" valign="top">
          
<div align="center"> 


			  <table width="90%" border="0" cellspacing="0" cellpadding="0" height="32" style="border-collapse: collapse" bordercolor="#111111">
        <tr  class="gridhdrNew">
               <td align="left" width="419" height="30" valign="middle">
					<b><a href="CourseHome.jsp?userid=<%=developerId%>">&nbsp;Course Home</a>
					&gt;&gt; <a href="CourseUnits.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>">
						<%=courseName%></a>
					&gt;&gt; <%=unitName%></b></td>
                <td align="center" width="10" height="30">
               
                                        <p align="right"><img src="images/createnew.gif" width="20" height="20" border="0"></p>
</td>
                <td width="107" align="left" height="30">

				<a href="LessonArchives.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>">Lesson Archived</a></td>
				<td align="center" width="10" height="30">
               
                                        <p align="right"><img src="images/createnew.gif" width="20" height="20" border="0"></p>
</td>
				<td width="107" align="left" height="30">
					<a href="AddLesson.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>">Add New Lesson</a></td>
        </tr>
            </table>

              <table width="90%" border="0" cellpadding="0" cellspacing="0" class="boarder">
                <tr>
                  <th height="86" align="center" valign="top" scope="col">
                  <table width="100%" cellspacing="1" cellpadding="3"  border="0">
                    <tbody>
                      <tr>
                        <td width="151" align="middle" class="gridhdrNew1" height="20" valign="middle" colspan="5"><b>Manage Lesson </b></td>
                        <td width="408" class="gridhdrNew1" align="center" height="20">
                        
                            <p align="left"><strong>Lesson  Name</strong></td>
                      </tr>
<%
	try
	{
		while(rs.next())
		{
			lessonId=rs.getString("lesson_id");
				
			if(rs.previous())
			{
				previousLessonId=rs.getString("lesson_id");
				rs.next();
				if(rs.next())
				{
					nextLessonId=rs.getString("lesson_id");
					rs.previous();
				}
				else
				{
					rs.previous();
				}
			}
			else
			{
				previousLessonId=lessonId;
				rs.next();
				if(rs.next())
				{
					nextLessonId=rs.getString("lesson_id");
				}
				rs.previous();
			}
	
			lessonFlag=true;
			lessonName=rs.getString("lesson_name");
			lessonStatus=rs.getString("status");
			if(lessonStatus.equals("1"))
				fileName="01_01_01.jsp";
			else
				fileName="Checklist.jsp";
%>

		<tr>
			<td align="middle" class="gridhdrNew1" width="20" valign="middle" height="20">
				<a href="EditLesson.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>"><img src="images/edit.gif" width="20" height="20" border="0" alt="Edit"></a>
			</td>
            <td align="middle" class="gridhdrNew1" width="20" valign="middle" height="20">
				<a href="#" onClick="javascript:return deleteLesson('<%=courseId%>','<%=courseName%>','<%=unitId%>','<%=unitName%>','<%=lessonId%>','<%=developerId%>')"><img src="images/delet.gif" width="20" height="20" border="0" alt="Delete"></a>
			</td>
            <td align="center" class="gridhdrNew1" width="20" height="20" valign="middle">
				<a href="<%=fileName%>?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>">
				<img src="images/add.gif" width="20" height="20" border="0" alt="Add Content to this Lesson"></a>
			</td>
           <td align="center" class="gridhdrNew1" width="7" height="20" valign="middle">
				<a href="#" onClick="return moveUp('<%=lessonId%>','<%=previousLessonId%>');"><img src="images/up_arrow.gif" width="16" height="19" border="0" alt="Move Up"></a>
			</td>
            <td align="center" class="gridhdrNew1" width="20" height="20" valign="middle">
				<a href="#" onClick="return moveDown('<%=lessonId%>','<%=nextLessonId%>');"><img src="images/down_arrow.gif" width="16" height="19" border="0" alt="Move Down"></a>
			</td>
			<td align="left" class="gridhdrNew1" width="458" height="20">
				<a href="<%=fileName%>?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>"><%=lessonName%></a>
			</td>
		</tr>
<%
		}
	}
	catch(Exception e)
	{
		System.out.println("Exception1 in CourseUnitLessons.jsp is..."+e);
	}
	finally
	{
			try
			{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("The exception2 in CourseUnitLessons.jsp is....."+se.getMessage());
			}
		}
		if(lessonFlag==false)
		{
%>
		<tr>
			<td colspan="6" bgcolor="#D7D7D7">
				<font face="Verdana" size="2">There are no lessons in this unit.</font>
			</td>
		</tr>
<%
		}	
%>
		</tbody>
        </table>
	</th>
    </tr>
    </table>
    &nbsp;</div>
	</td>
</tr>
</table>
</body>
</html>

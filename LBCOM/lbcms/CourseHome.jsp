<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;   
	Statement st=null,st1=null; 
	ResultSet rs=null,rs1=null;
	String developerId="",courseId="",courseName="",courseDevPath="",schoolId="",sessid="";
	boolean courseFlag=false;
	int totUnits=0,status=1;

	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
		return;
	}

try{
	courseDevPath=application.getInitParameter("lbcms_dev_path");
	sessid=(String)session.getAttribute("sessid");
		if(sessid==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
		}
	schoolId=(String)session.getAttribute("schoolid");
	developerId=request.getParameter("userid");
	con=con1.getConnection();
	st=con.createStatement();

	rs=st.executeQuery("select * from lbcms_dev_course_master where developer='"+developerId+"' order by course_name");
%>

<html>
<head>
<title>Course Builder</title>
<meta name="generator" content="Microsoft FrontPage 5.0">


<link href="styles/teachcss.css" rel="stylesheet" type="text/css" />
</head>

<body>
<table width="90%" border="0" cellpadding="0" cellspacing="0" class="whiteBgClass" >

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
	<!-- <td width="100%" height="28" colspan="3" background="images/TopStrip-bg.gif"> -->
	
    <div align="right">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
	  
		</table>
    </div>
	</td>
</tr>
<tr>
	<td width="100%" height="495" colspan="3" background="images/bg2.gif" align="center" valign="top">
		
		<tr>
		 <td width="100%" height="495" colspan="3" align="center" valign="top"><table width="75%" border="0" cellspacing="0" cellpadding="0">
      <tr>
         <td align="left" >
		 
		 <a href="CreateCourse.jsp?developer=<%=developerId%>"><img src="images/createcourse.png" title="Create" width="228" height="54" border="0" style="margin-left:20px;"></a>

		 <a href="UploadCourse.jsp?developer=<%=developerId%>"><img src="images/uploadcourse.png" title="Upload a Course" width="228" height="54" border="0" style="margin-left:20px;"></a>

         <a href="AddCourse.jsp?developer=<%=developerId%>"><img src="images/addcourse.png" title="Add" width="228" height="54" border="0" style="margin-left:20px;"></a>

		 <a href="#" onclick="return handler('importcb');"><font color="white">Import Assessments</font></a>
         
       
         </td>
        </tr>
    </table>
			
			
          
		</tr>
		</table>
	
	
			   <table width="90%" border="0" cellpadding="0" cellspacing="0" class="objectborder" align="center">
	
		    <tr>
        <td class="gridhdrNew">Course Name </td>
        <td class="gridhdrNew">No of Units </td>
        <td class="gridhdrNew">View in LMS </td>
        <td class="gridhdrNew">Assignments</td>
        <td class="gridhdrNew">Assessments</td>
        <td width="200" class="gridhdrNew" align="center">Actions</td>
         <td class="gridhdrNew">Staus</td>
      </tr>
<%
	while(rs.next())
	{
		courseFlag=true;
		courseName=rs.getString("course_name");
		courseId=rs.getString("course_id");
		status=rs.getInt("status");
		
%>
		<tr>
        
        <td class="gridFirstitem">
        <a href="CourseUnits.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&userid=<%=developerId%>"><%=courseName%></a></td>
        
			
		
<%
			st1=con.createStatement();
			rs1=st1.executeQuery("select count(unit_id) from lbcms_dev_units_master where course_id='"+courseId+"'");
			if(rs1.next())
				totUnits=rs1.getInt(1);
			st1.close();
			st1=con.createStatement();
			st1.executeUpdate("update lbcms_dev_course_master set no_of_units='"+totUnits+"'where course_id='"+courseId+"'");
			st1.close();
			
%>

	 <td class="gridFirstitem"><%=totUnits%></td>
		  <!-- <td align="center" class="tr-subrow" width="126" height="20"><a href="#" onclick="saveToDesk('<%=courseName%>');return false;"><img src="images/zipicon.gif" width="20" height="20" border="0" title="Save to Desk"></td> -->
		  
		
          <td class="gridFirstitem">
				<a href="#" onClick="if(confirm('Are you sure you want to give permissions to this course')){popup1('/LBCOM/lbcms/LMSTeachersList.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&schoolid=<%=schoolId%>&coursename=<%=courseName%>');}else{ return false;}"><font color="Green" face="Arial" size="2"><font color="green"><img src="images/viewlms.png" title="View in lms" width="28" height="28" border="0" style="margin-right:15px;"></a></font></td>
                <td class="gridFirstitem"><a href="ViewAssignInfo.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&userid=<%=developerId%>">
				<img src="images/massgnments.png" title="Manage Assignments" width="28" height="28" border="0" style="margin-right:30px;"></a></td>
		 <td class="gridFirstitem"><a href="ViewAssessInfo.jsp?mode=none&courseid=<%=courseId%>&coursename=<%=courseName%>&userid=<%=developerId%>">
				<img src="images/massessments.png" title="Manage Assesments" width="28" height="28" border="0" style="margin-right:30px;"></a></td>
<td class="gridFirstitem">
				<a href="EditCourse.jsp?courseid=<%=courseId%>&userid=<%=developerId%>">
					<img src="images/editcourse.png" title="Edit" width="28" height="28" border="0" style="margin-right:15px;">
				</a>
		
				<!-- <a href="CurriculumMap.jsp?courseid=<%=courseId%>&userid=<%=developerId%>">
                <img src="images/adddocument.png" title="Add" width="28" height="28" border="0" style="margin-right:15px;">
					
				</a> -->
			
		  
				<a href="#" onClick="deleteCourse('<%=courseId%>','<%=developerId%>')">
					<img src="images/deletecourse.png" title="Delete" width="28" height="28" border="0" style="margin-right:15px;">
				</a>
		
				<%
				if(status==2)
				{
					String path="";
					st1=con.createStatement();
				rs1=st1.executeQuery("select * from lbcms_dev_course_welcome where course_id='"+courseId+"'");
				if(rs1.next())
					path=rs1.getString("mat_path");
				st1.close();
				String disPath=courseDevPath+"/course_bundles/ext_files/"+courseId+"/"+path;
	%>
				<a href="#" onClick="viewLessonFile1('<%=courseId%>','<%=path%>');return false;"><img src="images/viewcourse.png" title="Course Viewer" width="28" height="28" border="0" style="margin-right:15px;"></a>
				<%
				}
				else
				{
				%>
				<a href="#" onClick="viewLessonFile('<%=courseName%>');return false;"><img src="images/viewcourse.png" title="Course Viewer" width="28" height="28" border="0" style="margin-right:15px;"></a>
				<%
				}
				%>
		
		 
				<a href="#" onClick="saveCourse('<%=courseId%>','<%=courseName%>');return false;">
				<img src="images/savecourse.png" title="Save" width="28" height="28" border="0"></a>
			</td>

<%
		if(status==1)
		{
%>
		<td class="gridFirstitem"><a href="#" onClick="lmsCourse('<%=courseId%>','<%=developerId%>','no')"><font color="green"><!-- <input type="checkbox"> --><img src="images/eye_open.png" width="20" height="20" border="0" title="View"></a></font></td>
<%
		}
		else
		{
			%>
		<td class="gridFirstitem"><a href="#" onClick="lmsCourse('<%=courseId%>','<%=developerId%>','yes')"><font color="red"><!-- <input type="checkbox" checked="true"> --><img src="images/eye_close.png" width="20" height="20" border="0" title="Hide"></a></font></td>
<%
		}
%>
			
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

	function handler(impdb)
	{
		window.document.location.href="/LBCOM/importutility/ImportUtilFramesCB.jsp";
	}

	function lmsCourse(courseid,developerid,status)
	{
		window.location.href="LMSCourse.jsp?mode="+status+"&courseid="+courseid+"&userid="+developerid;
		
	}
function viewLessonFile(coursename)
{
	
window.open("/LBCOM/lbcms/course_bundles/"+coursename+"/Lessons.html","Document","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
}
function viewLessonFile1(cid,path)
{
	alert(cid);
	alert(path);
	
window.open("/LBCOM/lbcms/course_bundles/ext_files/"+cid+"/"+path,"Document","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
}

function saveCourse(cid,cname)
{
	
		window.location.href="SaveCourse.jsp?courseid="+cid+"&coursename="+cname;
}

function viewUserManual()
{
	http://oh.learnbeyond.net:8080/LBCOM/manuals/coursebuilder_webhelp/Learnbeyond_Course_Builder.htm
window.open("/LBCOM/manuals/coursebuilder_webhelp/Learnbeyond_Course_Builder.htm","DocumentUM","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
}

function saveToDesk(coursename)
{
	
alert("This feature will be added soon");	
return false;
}
function popup1(url){
	
	window.location.href=url;
	//window.open(url,"AVW","width=800,height=400,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no,copyhistory=no");
	//window.refresh();
}
//-->
</SCRIPT>

</html>

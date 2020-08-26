<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null,rs1=null;
	String developerId="",courseId="",courseName="",courseDevPath="",lessonName="",unitId="",unitName="";
	String categoryId="",assgnName="",workFile="",lessonId="",tableName="";
	int assgNo=0;
	boolean assignFlag=false;
	int totUnits=0,i=0;;
%>
<%
	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
		return;
	}
	try
	{
		courseDevPath=application.getInitParameter("lbcms_dev_path");
		
		developerId=request.getParameter("userid");
		courseId=request.getParameter("courseid");
		courseName=request.getParameter("coursename");
		con=con1.getConnection();
		st=con.createStatement();

	//rs=st.executeQuery("select * from lbcms_dev_coursebuilder_"+courseId+"_workdocs where courseid='"+courseId+"' and status=1");
		if(courseId.equals("DC008")||courseId.equals("DC015")||courseId.equals("DC032")||courseId.equals("DC016")||courseId.equals("DC026")||courseId.equals("DC049")||courseId.equals("DC030")||courseId.equals("DC018")||courseId.equals("DC031")||courseId.equals("DC047")||courseId.equals("DC055")||courseId.equals("DC056")||courseId.equals("DC023")||courseId.equals("DC036")|courseId.equals("DC060")||courseId.equals("DC036")||courseId.equals("DC057")||courseId.equals("DC046")||courseId.equals("DC042")||courseId.equals("DC058")||courseId.equals("DC024")||courseId.equals("DC019"))
		{
			tableName="lbcms_dev_assgn_social_larts_content_master";
		
		}
		else if(courseId.equals("DC048")||courseId.equals("DC005")||courseId.equals("DC043")||courseId.equals("DC044")||courseId.equals("DC051")||courseId.equals("DC037")||courseId.equals("DC080")||courseId.equals("DC050")||courseId.equals("DC020")||courseId.equals("DC017")||courseId.equals("DC059"))
		{
			tableName="lbcms_dev_assgn_science_content_master";
		
		}
		else
		{
			tableName="lbcms_dev_assgn_math_content_master";
		}

		System.out.println("tableName..."+tableName);
		

	rs=st.executeQuery("select * from "+tableName+" where course_id='"+courseId+"' order by slno");
%>

<html>
<head>
<title>Hotschools Assignment Builder</title>
<meta name="generator" content="Microsoft FrontPage 5.0">
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="styles/teachcss.css" rel="stylesheet" type="text/css" />
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
<form name="assesslist" method="POST" action="--WEBBOT-SELF--">
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
	<!-- <td width="100%" height="28" colspan="3" background="images/TopStrip-bg.gif"> -->
	
</table>
<tr>
	
	<td width="100%" height="495" colspan="3"  align="center" valign="top">
		
		<div align="center"> 
		<table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
		<tr>
		<th height="86" valign="top" scope="col">
		<table border="0">
		<!-- <tr>
		<td width="100%" height="30" valign="middle" align="left">
				<b>Course Name:&nbsp;<font color="#FF0000"><%=courseName%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </font><a href="CourseHome.jsp?userid=<%=developerId%>&courseid=<%=courseId%>"><font color="red">&lt;&lt; Back To Course Home&nbsp;</font></a></b>&nbsp;
			</td>
			</tr> -->
			<tr>
			<td width="3%" class="gridhdrNew" align="center" valign="middle"><font size="1" face="Verdana" color="#000080"><b>
			<a href="#" onClick="return setMapping()">
            <img border="0" src="images/marking.gif" TITLE="Assignment Mapping" width="40" height="40"></b>
			</a>
		</font></td>
				<td width="460" class="gridhdrNew" align="left" height="20" valign="middle" colspan="4" bgcolor="#D7D7D7"><b>Course Name:&nbsp;<font color="#FF0000"><%=courseName%></b></td>
				<td width="217" class="gridhdrNew" align="left" height="20" valign="middle" colspan="4" bgcolor="#D7D7D7"><a href="OrderAssignments.jsp?totrecords=&start=0&courseid=<%=courseId%>&tname=<%=tableName%>&cname=<%=courseName%>&uid=<%=developerId%>">Order List</a></td>
				<td width="263" class="gridhdrNew" align="right" height="20"><strong><a href="CourseHome.jsp?userid=<%=developerId%>&courseid=<%=courseId%>">&lt;&lt; Back To Course Home&nbsp;</a></strong></td>
								
			</tr>
			</table>
			<table width="100%" cellspacing="1" cellpadding="3"  border="0">
	        <tbody>
		    <tr bgcolor="#08495f">
				<td width="150" align="middle" height="20" valign="middle" colspan="4"><b> <font color="#FFFFFF">Manage Assignment</font></b></td>
				<td  align="left" height="20"><strong><font color="#FFFFFF">Assignment Name</font></strong></td>
				<td  align="left" height="20"><strong><font color="#FFFFFF">Unit/Lesson Name</font></strong></td>	
			</tr>
<%
	while(rs.next())
	{
		
		assignFlag=true;
		categoryId=rs.getString("category_id");
		assgnName=rs.getString("assgn_name");
		lessonId=rs.getString("lesson_id");
		lessonName=rs.getString("lesson_name");
		unitId=rs.getString("unit_id");
		assgNo=Integer.parseInt(rs.getString("assgn_no"));
		st1=con.createStatement();

		rs1=st1.executeQuery("select unit_name from lbcms_dev_units_master where course_id='"+courseId+"' and  unit_id='"+unitId+"'");
		if(rs1.next())
			unitName=rs1.getString("unit_name");
		st1.close();
		rs1.close();

		
		
%>
		<tr>
		<td align="center" class="gridhdrNew1" width="10" height="20" valign="middle">
				<font size="2" face="verdana" color="">
					<input type="checkbox" name="selids" value="<%=rs.getInt("slno")%>">
				</font>
			</td>
			<td align="middle" class="gridhdrNew1" width="20" valign="middle" height="20">
				<a href="EditAssignmentBuilder.jsp?course_id=<%=courseId%>&unit_id=<%=unitId%>&lesson_id=<%=lessonId%>&assgn_no=<%=assgNo%>" target="_blank"><img src="images/edit.gif" width="20" height="20" border="0" alt="Edit">
				</a>
			</td>
		    <td align="middle" class="gridhdrNew1" width="20" valign="middle" height="20">
				<a href="#" onClick="javascript:return deleteAssgn('<%=courseId%>','<%=courseName%>','<%=unitId%>','<%=lessonId%>','<%=assgNo%>','<%=developerId%>')"><img src="images/delet.gif" width="20" height="20" border="0" alt="Delete"></a>
			</td>
		    <td align="center" class="gridhdrNew1" width="20" height="20" valign="middle">
				<a href="#" onClick="showFile('<%=courseId%>','<%=courseName%>','<%=unitId%>','<%=lessonId%>','<%=assgNo%>');return false;"><img src="images/view.gif" width="20" height="20" border="0" alt="View"></a>
			</td>
		    
		    <td align="left" class="gridhdrNew1" width="265" height="20">&nbsp;<%=assgnName%></td>
		
		  <td align="left" class="gridhdrNew1" height="20"><%=unitName%>/<%=lessonName%></td>
		 
			
		</tr>
<%
			i++;
	
	}
	if(assignFlag==true)
	{
%>
	<tr>
			<td colspan="7" class="gridhdrNew1">
				<font face="Verdana" size="2">&nbsp;No. of assignments:&nbsp;<%=i%></font>
			</td>
		</tr>
<%
	}
	if(assignFlag==false)
	{
%>
		<tr>
			<td colspan="7"class="gridhdrNew1">
				<font face="Verdana" size="2">&nbsp;There are no assignments available.</font>
			</td>
		</tr>
<%
	}	
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in ViewAssignInfo.jsp is....."+e);
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
				System.out.println("The exception2 in ViewAssignInfo.jsp is....."+se.getMessage());
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
	

function showFile(courseid,coursename,unitid,lessonid,assgnno)
{
	window.open("/LBCOM/lbcms/AssignmentView.jsp?courseid="+courseid+"&coursename="+coursename+"&unitid="+unitid+"&lessonid="+lessonid+"&assgnno="+assgnno,"Document","resizable=no,scrollbars=yes,width=800,height=500,toolbars=no");
}
function deleteAssgn(courseid,coursename,unitid,lessonid,assgnno,developerid)
	{
		if(confirm("Are you sure you want to delete the unit?")==true)
		{
			window.location.href="CourseDeveloperWorkDone.jsp?courseid="+courseid+"&coursename="+coursename+"&unitid="+unitid+"&lessonid="+lessonid+"&assgnno="+assgnno+"&userid="+developerid+"&mode=delete";
			return false;
		}
		else
			return false;
	}

	function viewUserManual()
{
	
window.open("/LBCOM/manuals/coursebuilder_webhelp/Learnbeyond_Course_Builder.htm","DocumentUM","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
}
function setMapping()
	{
        var selid=new Array();
        with(document.assesslist)
		{
				for(var i=0,j=0; i < elements.length; i++)
				{
                   
				   if (elements[i].type == 'checkbox' && elements[i].name == 'selids' && elements[i].checked==true)
                            selid[j++]=elements[i].value;
				}
         }
		if (j>0)
		{
			if(confirm("Are you sure you want to set the Map the Assignments?")==true)
			{
				parent.location.href="/LBCOM/lbcms/MapAssgnLessons.jsp?courseid=<%=courseId%>&assmtids="+selid+"&userid=<%=developerId%>";
					 return false;
             }
             else
                return false;
         }
		 else
		 {
             alert("Please select the assignment(s) to Map Lesson");
              return false;
        }
	}
//-->
</SCRIPT>

</html>
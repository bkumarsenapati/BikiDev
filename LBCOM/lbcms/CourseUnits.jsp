<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@ include file="/common/checksession.jsp" %>

<%
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null,rs1=null;
	String courseId="",courseName="",unitId="",unitName="",noOfLessons="",developerId="",previousUnitId="",nextUnitId="";
	boolean unitFlag=false;
	int totLessons=0;
%>
<%
	/*developerId = (String)session.getAttribute("emailid");
	if(developerId==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
		return;
	}
*/
	con=con1.getConnection();
	st=con.createStatement();
	courseId=request.getParameter("courseid");
	 session.setAttribute("cb_courseid",courseId);
	courseName=request.getParameter("coursename");
	developerId=request.getParameter("userid");
	session.setAttribute("cb_coursename",courseName);
	System.out.println("session courseName..."+session.getAttribute("cb_coursename"));

	rs=st.executeQuery("select * from lbcms_dev_units_master where course_id='"+courseId+"' order by unit_id");
%>

<html>
<head>
<title>.::Course Builder::.</title>
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
          
<div align="center"> 


		<table width="95%" border="0" cellspacing="0" cellpadding="0" height="32" style="border-collapse: collapse" bordercolor="#FFFFFF">
		<tr class="gridhdrNew">
			<td align="center" width="413" height="30" valign="middle">
            <p align="left">&nbsp;<b><a href="CourseHome.jsp?userid=<%=developerId%>"><font>Course Home</font></a>&nbsp;&nbsp;&gt;&gt;&nbsp;&nbsp;<%=courseName%></b>
		  </td>
			<td align="left" width="24" height="30" valign="middle">
				<img src="images/createnew.gif" width="20" height="20" border="0">			</td>
			<td width="180" align="left" height="30">
				<a href="AddUnits.jsp?developer=<%=developerId%>&courseid=<%=courseId%>"><font>Add Unit from Archived</font></a></td>
			<td align="left" width="22" height="30" valign="middle">
				
				<img src="images/createnew.gif" width="20" height="20" border="0"></td>
			<td width="220" align="right" height="30" valign="middle">
			  <p align="left">
				<a href="AddUnit.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&userid=<%=developerId%>"><font >
          Add New Unit</font></a></td>
		</tr>
        </table>
		<table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">
        <tr>
        <th height="86" align="center" valign="top" scope="col">
			<table width="100%" cellspacing="0" cellpadding="3"  border="0" style="border-collapse: collapse" bordercolor="#000">
            <tbody>
            <tr>
            <td width="99" align="middle" class="Grid_tHeader" height="20" valign="middle" colspan="4"><b>&nbsp;Manage</b></td>
            <td width="325" class="Grid_tHeader" align="left" height="20" colspan="3"><strong>Unit Name</strong></td>
			<td width="104" class="Grid_tHeader" align="center" height="20"><strong>No. of Lessons</strong></td>
		</tr>
<%
	while(rs.next())
	{
		unitFlag=true;
		unitId=rs.getString("unit_id");
		unitName=rs.getString("unit_name");
		noOfLessons=rs.getString("no_of_lessons");
		if(rs.previous())
		{
			previousUnitId=rs.getString("unit_id");
			rs.next();
				if(rs.next())
				{
					nextUnitId=rs.getString("unit_id");
					rs.previous();
				}
				else
				{
					rs.previous();
				}
		}
		else
			{
				previousUnitId=unitId;
				rs.next();
				if(rs.next())
				{
					nextUnitId=rs.getString("unit_id");
				}
				rs.previous();
			}
			unitFlag=true;
			unitName=rs.getString("unit_name");
			//System.out.print(previousUnitId+"\t"+nextUnitId);
%>

        <tr>
			<td align="middle" class="gridhdrNew1" width="10" valign="middle" height="20">
				<a href="EditUnit.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&no_of_lessons=<%=noOfLessons%>&userid=<%=developerId%>"><img src="images/edit.gif" width="20" height="20" border="0" alt="Edit"></a>
			</td>
            <td align="middle" class="gridhdrNew1" width="10" valign="middle" height="20">
				<a href="#" onClick="javascript:return deleteUnit('<%=courseId%>','<%=courseName%>','<%=unitId%>','<%=unitName%>','<%=developerId%>')"><img src="images/delet.gif" width="20" height="20" border="0" alt="Delete"></a>
			</td>
              <td align="center" class="gridhdrNew1" width="10" height="20" valign="middle">
				<a href="#" onClick="return moveUp('<%=unitId%>','<%=previousUnitId%>');"><img src="images/up_arrow.gif" width="16" height="19" border="0" alt="Move Up"></a>
			</td>
            <td align="center" class="gridhdrNew1" width="10" height="20" valign="middle">
				<a href="#" onClick="return moveDown('<%=unitId%>','<%=nextUnitId%>');"><img src="images/down_arrow.gif" width="16" height="19" border="0" alt="Move Down"></a>
			</td>
            <td align="left" class="gridhdrNew1" width="375" height="20" colspan="3">
				<a href="CourseUnitLessons.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&userid=<%=developerId%>"><%=unitName%></a>
			</td>
<%
			st1=con.createStatement();
			rs1=st1.executeQuery("select count(lesson_id) from lbcms_dev_lessons_master where course_id='"+courseId+"' and unit_id='"+unitId+"'");
			if(rs1.next())
				totLessons=rs1.getInt(1);
			st1.executeUpdate("update lbcms_dev_units_master set no_of_lessons='"+totLessons+"'where course_id='"+courseId+"' and unit_id='"+unitId+"'");
%>
            <td align="center" class="gridhdrNew1" width="104" height="20"><%=totLessons%></td>
		</tr>
<%
	}
	if(unitFlag==false)
	{
%>
		<tr>
			<td colspan="6" class="gridhdrNew1" width="542">
				<font face="Verdana" size="2">&nbsp;There are no units in this course.</font>
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
<SCRIPT LANGUAGE="JavaScript">
<!--
	function deleteUnit(courseid,coursename,unitid,unitname,developerid)
	{
		if(confirm("Are you sure you want to delete the unit?")==true)
		{
			window.location.href="AddNewUnit.jsp?courseid="+courseid+"&coursename="+coursename+"&unitid="+unitid+"&unitname="+unitname+"&userid="+developerid+"&mode=delete"
			return false;
		}
		else
			return false;
	}

function moveUp(currentuid,prevuid)
{
parent.location.href="ChangeUnitOrder.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&userid=<%=developerId%>&unitid1="+currentuid+"&unitid2="+prevuid;

}

function moveDown(currentuid,nextuid)
{
parent.location.href="ChangeUnitOrder.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&userid=<%=developerId%>&unitid1="+currentuid+"&unitid2="+nextuid;
}

function viewUserManual()
{
	
window.open("/LBCOM/manuals/coursebuilder_webhelp/Learnbeyond_Course_Builder.htm","DocumentUM","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
}



//-->
</SCRIPT>
</html>

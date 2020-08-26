<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null,rs1=null;
	String developerId="",courseId="",courseName="",courseDevPath="",lessonName="",unitId="",unitName="",assmtId="";
	String categoryId="",assmtName="",workFile="",lessonId="",tableName="",mode="";
	int assmtNo=0;
	boolean assmtFlag=false;
	int totUnits=0,i=0;
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
		mode=request.getParameter("mode");
		con=con1.getConnection();
		st=con.createStatement();

	//rs=st.executeQuery("select * from lbcms_dev_coursebuilder_"+courseId+"_workdocs where courseid='"+courseId+"' and status=1");

	
		tableName="lbcms_dev_assessment_master";
		System.out.println("mode is ...."+mode);

		if(mode.equals("delete"))
		{
			String unitid="",lessonid="",assmtno="",assmtid="";
			unitid=request.getParameter("unitid");
			lessonid=request.getParameter("lessonid");
			assmtno=request.getParameter("assmt");
			assmtid=request.getParameter("assmtId");
			
			//System.out.println("delete from lbcms_dev_assessment_master  where course_id='"+courseId+"' and unit_id='"+unitid+"' and lesson_id='"+lessonid+"' and slno='"+assmtno+"' and assmt_id='"+assmtid+"'");
						
			i=st.executeUpdate("delete from lbcms_dev_assessment_master  where course_id='"+courseId+"' and unit_id='"+unitid+"' and lesson_id='"+lessonid+"' and slno='"+assmtno+"' and assmt_id='"+assmtid+"'");
	
		}
		rs=st.executeQuery("select * from "+tableName+" where course_id='"+courseId+"' order by slno");
%>

<html>
<head>
<title>Learnbeyond Assessment Builder</title>
<meta name="generator" content="Microsoft FrontPage 5.0">
<link href="styles/teachcss.css" rel="stylesheet" type="text/css" />
 <SCRIPT LANGUAGE="JavaScript">


		function showFile(courseid,assmtId)
		{
			window.open("/LBCOM/lbcms/AssmtBuilder/exams/"+courseid+"/"+assmtId+"/1.html","Document","resizable=no,scrollbars=yes,width=800,height=500,toolbars=no");
		}
	function deleteAssmt(courseid,coursename,unitid,lessonid,assmtno,developerid,assmtid)
	{
		alert("Hi");
		alert(assmtno);
		if(confirm("Are you sure you want to delete the assessment?")==true)
		{

			i=st.executeUpdate("delete from lbcms_dev_assessment_master  where course_id='"+courseid+"' and unit_id='"+unitid+"' and lesson_id='"+lessonid+"' and slno='"+assmtno+"' and assmt_id='"+assmtid+"' and course_name='"+coursename+"' ");
		}
		if(i>0)
			{
				response.sendRedirect("ViewAssessInfo.jsp?courseid='"+courseid+"'&coursename='"+coursename+"'&userid='"+developerid+"' ");
				
			}
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
			if(confirm("Are you sure you want to set the Map the Assessments?")==true)
			{
				parent.location.href="/LBCOM/lbcms/MapLessons.jsp?courseid=<%=courseId%>&assmtids="+selid+"&userid=<%=developerId%>";
					 return false;
             }
             else
                return false;
         }
		 else
		 {
             alert("Please select the assessment(s) to Map Lesson");
              return false;
        }
	}
function viewUserManual()
{
	
	window.open("/LBCOM/manuals/coursebuilder_webhelp/Learnbeyond_Course_Builder.htm","DocumentUM","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
}

	
</SCRIPT>
</head>

<body >
<form name="assesslist" method="POST" action="--WEBBOT-SELF--">
<table width="100%" border="0" cellpadding="0" cellspacing="0"  >

<tr>
	<td width="15" height="70">&nbsp;</td>
	<td width="368" height="70">
		<img src="images/logo.png" width="368" height="101" border="0">
	</td>
    <td> <a href="#" onClick="viewUserManual();return false;"><img src="images/helpmanaual.png" border="0" style="margin-left:320px;"></a></td>
    <td width="423" height="70" align="right">
		<img src="images/mahoning-Logo.gif" width="208" height="70" border="0">
    </td>
</tr></table>

<tr>
	
	<td width="100%" height="495" colspan="3" bgcolor="#FFFFFF" align="center" valign="top">
		
		<div align="center"> 
		<table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
		<tr>
		<th height="86" align="center" valign="top" scope="col">
		<table border="0">
		<!-- <tr>
		<td width="100%" height="30" valign="middle" align="left">
				<b>Course Name:&nbsp;<font color="#FF0000"><%=courseName%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </font><a href="CourseHome.jsp?userid=<%=developerId%>&courseid=<%=courseId%>"><font color="red">&lt;&lt; Back To Course Home&nbsp;</font></a></b>&nbsp;
			</td>
			</tr> -->
			<tr>
			<td width="3%"  align="center" class="gridhdrNew" valign="middle"><font size="1" face="Verdana" color="#000080"><b>
			<a href="#" onClick="return setMapping()">
            <img border="0" src="images/marking.gif" TITLE="Assessment Mapping" width="40" height="40"></b>
			</a>
		</font></td>
				<td width="407" class="gridhdrNew" align="left" height="20" valign="middle" colspan="4" ><b>Course Name:&nbsp;<%=courseName%></b></td>

			<td width="337" class="gridhdrNew" align="left" height="20" valign="middle" colspan="4" >
				<a href="OrderAssessments.jsp?totrecords=&start=0&courseid=<%=courseId%>&cname=<%=courseName%>&uid=<%=developerId%>">Order List</a>&nbsp;|&nbsp;<a href="/LBCOM/lbcms/AssmtBuilder/AssessmentDeveloperWork.jsp?userid=<%=developerId%>&courseid=<%=courseId%>" target="_blank">Create Assessment</a>
			</td>
			<td width="337" class="gridhdrNew" align="left" height="20" valign="middle" colspan="4" >
				<!-- <a href="/LBCOM/lbcms/AssmtBuilder/UnitPretest.jsp?courseid=<%=courseId%>">Pretest</a> -->
				<a href="/LBCOM/lbcms/AssmtBuilder/CreatePretest.jsp?mode=add&courseid=<%=courseId%>">Pretest</a>
			</td>
			<td width="75" class="gridhdrNew" align="right" height="20" ><strong><a href="CourseHome.jsp?userid=<%=developerId%>&courseid=<%=courseId%>">&lt;&lt; Back&nbsp;</a></strong></td>
								
			</tr>
			</table>
			<table width="100%" cellspacing="1" cellpadding="3"  border="0">
	        <tbody>
		    <tr>
				<td width="150" align="middle" class="Grid_tHeader" height="20" valign="middle" colspan="4"><b>Manage Assessment</b></td>
				<td class="Grid_tHeader" align="center" height="20"><strong>Assessment Name</strong></td>
				<td class="Grid_tHeader" align="center" height="20"><strong>Unit/Lesson Name</strong></td>
				<td class="Grid_tHeader" align="center" height="20"><strong>Map</strong></td>

				<td class="Grid_tHeader" align="center" height="20"><strong><font color="#ffffff">XML</font></strong></td>
								
			</tr>
<%
	while(rs.next())
	{
		
		assmtFlag=true;
		categoryId=rs.getString("category_id");
		assmtName=rs.getString("assmt_name");
		lessonId=rs.getString("lesson_id");
		lessonName=rs.getString("lesson_name");
		unitId=rs.getString("unit_id");
		assmtId=rs.getString("assmt_id");
		assmtNo=Integer.parseInt(rs.getString("slno"));
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
					<input type="checkbox" name="selids" value="<%=assmtId%>">
				</font>
			</td>
			
			<td align="middle" class="gridhdrNew1" width="20" valign="middle" height="20">
				
		<%
			if(!categoryId.equals("PC"))
			{
				%>
				<a href="AssmtBuilder/index.jsp?mode=edit&coursename=<%=courseName%>&userid=<%=developerId%>&courseid=<%=courseId%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>&assmt=<%=assmtNo%>&cattype=<%=categoryId%>&assmtId=<%=assmtId%>" target="_blank"><img src="images/edit.gif" width="20" height="20" border="0" alt="Edit">
				</a>
		<%
			}
			else
				{
				%>
				<!-- <a href="AssmtBuilder/MultiPartQue.jsp?mode=add&qt=no&coursename=<%=courseName%>&userid=<%=developerId%>&courseid=<%=courseId%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&cattype=<%=categoryId%>&assmt=<%=assmtId%>&slideno=1" target="_blank"><img src="images/edit.gif" width="20" height="20" border="0" alt="Edit">
				</a> -->
				<a href="AssmtBuilder/index.jsp?mode=edit&coursename=<%=courseName%>&userid=<%=developerId%>&courseid=<%=courseId%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>&assmt=<%=assmtNo%>&cattype=<%=categoryId%>&assmtId=<%=assmtId%>" target="_blank"><img src="images/edit.gif" width="20" height="20" border="0" alt="Edit">
				</a>
		<%
				}
		%>

			</td>
		    <td align="middle" class="gridhdrNew1" width="20" valign="middle" height="20">
				<a href="ViewAssessInfo.jsp?mode=delete&courseid=<%=courseId%>&coursename=<%=courseName%>&userid=<%=developerId%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>&assmt=<%=assmtNo%>&cattype=<%=categoryId%>&assmtId=<%=assmtId%>" onClick="javascript:return confirm('Are you sure you want to delete the assessment?'); "><img src="images/delet.gif" width="20" height="20" border="0" alt="Delete"></a>
			</td>
		    <td align="center" class="gridhdrNew1" width="20" height="20" valign="middle">
				<a href="#" onClick="showFile('<%=courseId%>','<%=assmtId%>');return false;"><img src="images/view.gif" width="20" height="20" border="0" alt="View"></a>
			</td>
			<td align="left" class="gridhdrNew1" width="265" height="20">
		    
			<%

				String[] result=assmtName.split("<br>");
				 for( int k =0; k<result.length; k++){
				%>
						<%=result[k]%><br><!-- <%=assmtName%> -->
				   <%}
				%>
				</td>
		  <td align="left" class="gridhdrNew1" height="20"><%=unitName%>/<%=lessonName%></td>
		  <td align="center" class="gridhdrNew1" height="20"><a href="pretest/QuestionMapping.jsp?classid=C000&cb_courseid=<%=courseId%>&totrecords=&start=0&cname=<%=courseName%>&developer=<%=developerId%>&assmtid=<%=assmtId%>&slno=<%=assmtNo%>">&nbsp;&nbsp;Map</a></td>

		  <td align="center" class="gridhdrNew1" height="20"><a href="downloadxml.jsp?courseid=<%=courseId%>&assmtid=<%=assmtId%>&slno=<%=assmtNo%>">&nbsp;&nbsp;-----</a></td> 
		 
			
		</tr>
<%
			i++;
	
	}
	if(assmtFlag==true)
	{
%>
	<tr>
			<td colspan="7" bgcolor="#D7D7D7">
				<font face="Verdana" size="2">&nbsp;No. of assessments:&nbsp;<%=i%></font>
			</td>
		</tr>
<%
	}
	if(assmtFlag==false)
	{
%>
		<tr>
			<td colspan="7" bgcolor="#D7D7D7">
				<font face="Verdana" size="2">&nbsp;There are no assessments available.</font>
			</td>
		</tr>
<%
	}	
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in ViewAssessInfo.jsp is....."+e);
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
				System.out.println("The exception2 in ViewAssessInfo.jsp is....."+se.getMessage());
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
</form>
</body>


</html>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null,rs1=null;
	String developerId="",courseId="",courseName="",courseDevPath="",lessonName="",unitId="",unitName="";
	String categoryId="",assgnName="",workFile="",lessonId="",aTeacherId="",aSchoolId="",aCourseId="",tableName="",aClassId="";
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
	courseDevPath=application.getInitParameter("lbcms_dev_path");
	
	courseId=request.getParameter("courseid");

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


	aCourseId=request.getParameter("acourseid");
	aTeacherId=request.getParameter("ateacherid");
	aClassId=request.getParameter("aclassid");
	aSchoolId=request.getParameter("aschoolid");
	courseName=request.getParameter("coursename");
	con=con1.getConnection();
	st=con.createStatement();
	

	
	rs=st.executeQuery("select * from "+tableName+" where course_id='"+courseId+"' order by slno");
%>



<html>
<head>
<title>Hotschools Assignment Builder</title>
<meta name="generator" content="Microsoft FrontPage 5.0">
<link href="css/style.css" rel="stylesheet" type="text/css" />
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" background="images/bg2.gif">
<form method="POST" name="dir">
<table border="0" cellpadding="0" cellspacing="0" width="100%" background="images/CourseHome_01.gif">
<tr>
	<td width="15" height="70">&nbsp;</td>
	<td width="475" height="70">
		<img src="images/hscoursebuilder.gif" width="194" height="70" border="0">
	</td>
    <td width="493" height="70" align="right">
		<img src="images/mahoning-Logo.gif" width="296" height="70" border="0">
    </td>
</tr>
<tr>

	<td width="100%" height="28" colspan="3" bgcolor="#A53C00">
    <div align="right">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
	 
		<tr>
			<td width="100%" height="5" bgcolor="#ECECEC" colspan="3"></td>
		</tr>
		</table>
    </div>
	</td>
</tr>
<tr>
	
	<td width="100%" height="100%" colspan="3" background="images/bg2.gif" align="center" valign="top">
		<p align="center">&nbsp;</p>
		<div align="center"> 
		<table width="80%" border="0" cellpadding="0" cellspacing="0" class="boarder">
		<tr>
		<th height="86" align="center" valign="top" scope="col">
		<table border="0" width="100%">
		<tr>
		<td width="70%" height="30" valign="middle" align="left">
				<b>Course Name:&nbsp;<font color="#FF0000"><%=courseName%></font></b>&nbsp;
			</td>
			<td width="30%" height="30" valign="middle" align="right">
				<b><a href="ImportAssignments.jsp?classid=<%=aClassId%>&courseid=<%=aCourseId%>&teacherid=<%=aTeacherId%>&schoolid=<%=aSchoolId%>"><font color="red">&lt;&lt; Back To Course Home&nbsp;</font></a></b>&nbsp;
			</td>
			</tr>
			</table>
			<table width="100%" cellspacing="1" cellpadding="3"  border="0">
	        <tbody>
		    <tr>
			<td width="3%" class="Grid_tHeader" height="21" align="center" valign="middle">
				<input type="checkbox" name="selectall" onclick="javascript:selectAll1()" title="Select or deselect all files" value="ON">
			</td>
				<td width="67%" align="middle" class="Grid_tHeader" height="20" valign="middle"><b>Manage Assignments</b></td>
				<td width="30%" class="Grid_tHeader" align="center" height="20"><strong>Lesson Name</strong></td>
								
			</tr>
<%
	while(rs.next())
	{
		
		assignFlag=true;
		int slno=rs.getInt("slno");
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
			<!-- <td align="middle" class="tr-subrow" width="20" valign="middle" height="20">
				<a href="EditAssignmentBuilder.jsp?course_id=<%=courseId%>&unit_id=<%=unitId%>&lesson_id=<%=lessonId%>&assgn_no=<%=assgNo%>" target="_blank"><img src="images/edit.gif" width="20" height="20" border="0" alt="Edit">
				</a>
			</td>
		    <td align="middle" class="tr-subrow" width="20" valign="middle" height="20">
				<a href="#" onclick="javascript:return deleteAssgn('<%=courseId%>','<%=courseName%>','<%=unitId%>','<%=lessonId%>','<%=assgNo%>','<%=developerId%>')"><img src="images/delet.gif" width="20" height="20" border="0" alt="Delete"></a>
			</td>
		    <td align="center" class="tr-subrow" width="20" height="20" valign="middle">
				<a href="#" onclick="showFile('<%=rs.getString("assgn_no")%>','<%= rs.getString("assgn_name") %>','<%=categoryId%>');return false;"><img src="images/view.gif" width="20" height="20" border="0" alt="View"></a>
			</td>
		     -->
			<td align="left" class="tr-subrow" width="22" height="20"><input type="checkbox" name="selnames" value="<%=slno%>"></td>

		    <td align="left" class="tr-subrow" width="358" height="20">&nbsp;<%=assgnName%></td>
		
		  <td align="center" class="tr-subrow" width="164" height="20"><%=unitName%>/<%=lessonName%></td>
		 
			
		</tr>
<%
			i++;
	
	}
%>
	

<%	
	if(assignFlag==true)
	{
%>
	<tr>
		<td align="center" colspan="3"><input type="submit" value="Submit" name="sb" onclick="return selectAll();"></td>
	</tr>
	<tr>
			<td colspan="7" bgcolor="#D7D7D7">
				<font face="Verdana" size="2">&nbsp;No. of assignments:&nbsp;<%=i%></font>
			</td>
		</tr>
<%
	}
	else if(assignFlag==false)
	{
%>
		<tr>
			<td colspan="7" bgcolor="#D7D7D7">
				<font face="Verdana" size="2">&nbsp;There are no assignments available.</font>
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
	<br /></div>
	</td>
</tr>

</table>
</form>
</body>
<SCRIPT LANGUAGE="JavaScript">
<!--
	
function selectAll()
{
        var selid=new Array();
        with(document.dir)
		{
				for(var i=0,j=0; i < elements.length; i++)
				{
                   if (elements[i].type == 'checkbox' && elements[i].name == 'selnames' && elements[i].checked==true)
                            selid[j++]=elements[i].value;
				   
				}
         }
		if (j>0)
		{
			if(confirm("Are you sure you want to import the selected file(s)?")==true)
			{
				 
			window.location.href="/LBCOM/lbcms/ImpCreateAssignments.jsp?mode=import&aclassid=<%=aClassId%>&courseid=<%=courseId%>&selnames="+selid+"&acourseid=<%=aCourseId%>&ateacherid=<%=aTeacherId%>&aschoolid=<%=aSchoolId%>";
					 return false;
             }
             else
                return false;
         }
		 else
		 {
             alert("Please select the file(s) to import");
              return false;
        }
}

function selectAll1()
{
	if(document.dir.selectall.checked==true)
	{
		with(document.dir) 
		{
			
			for(var i=0; i < elements.length; i++)
				{
                   if (elements[i].type == 'checkbox' && elements[i].name == 'selnames')
                            elements[i].checked = true;
				   
				}
         }
		
			if(confirm("Are you sure you want to import the all assignment(s)?")==true)
			{
				 
			window.location.href="/LBCOM/lbcms/ImpCreateAssignments.jsp?mode=import&aclassid=<%=aClassId%>&courseid=<%=courseId%>&selnames="+selnames+"&acourseid=<%=aCourseId%>&ateacherid=<%=aTeacherId%>&aschoolid=<%=aSchoolId%>";
					 return false;
             }
             else
                return false;
		
	}
	else
	{
		with(document.dir) 
		{
			for(var i=0; i < elements.length; i++)
				{
                   if (elements[i].type == 'checkbox' && elements[i].name == 'selnames')
					   elements[i].checked = false;
				}
		}
	}
}

//-->
</SCRIPT>

</html>
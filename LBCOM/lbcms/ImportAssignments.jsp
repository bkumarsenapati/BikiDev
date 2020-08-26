<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null,rs1=null;
	String developerId="",courseId="",courseName="",courseDevPath="",aCourseId="",aTeacherId="",aSchoolId="",aClassId="";
	boolean courseFlag=false;
	int totUnits=0;
%>
<%
    try{
	courseDevPath=application.getInitParameter("lbcms_dev_path");
	
	con=con1.getConnection();
	st=con.createStatement();
	aClassId=request.getParameter("classid");
	System.out.println("aClassId..."+aClassId);
	aCourseId=request.getParameter("courseid");
	aTeacherId=request.getParameter("teacherid");
	aSchoolId=request.getParameter("schoolid");
	if(aSchoolId.equals("netleisure"))
	{
		rs=st.executeQuery("select course_id,course_name from lbcms_dev_course_master where course_id='DC054' or course_id='DC046' order by course_name");
	}
	else
	{
			
		rs=st.executeQuery("select * from lbcms_dev_course_master where developer='"+aTeacherId+"' order by course_name");
	}
	
	//rs=st.executeQuery("select * from lbcms_dev_course_master where status=1");
	
%>

<html>
<head>
<script language="javascript" src="../validationscripts.js"></script>
<script language="javascript">
function validate()
{
	var cid;
	var bool=0;
	var size=window.document.dir.elements.length;
	

	if(size==0)
	{
		alert("No item is available.");
		return;
	}

for(var i=0;i<size;i++)
	{
		
//		if(window.document.dir.elements[i].checked)
		if((window.document.dir.elements[i].type=="radio")&&(window.document.dir.elements[i].checked))
		{   
			if(confirm("Are you ready to import the assignments?")==true){
		
				cid=window.document.dir.elements[i].value;
				alert(cid);
				bool==1;
				return window.location.href="/LBCOM/lbcms/ImpCreateAssignments.jsp?courseid="+cid+"&aclassid=<%=aClassId%>&acourseid=<%=aCourseId%>&ateacherid=<%=aTeacherId%>&aschoolid=<%=aSchoolId%>";
				}
			else
				return false;
		}
	}
	if(bool==0)
	{
		alert("Select an item to delete.");
		return;
	}
	
}
</script>
<title>Hotschools Course Builder</title>
<meta name="generator" content="Microsoft FrontPage 5.0">
<link href="css/style.css" rel="stylesheet" type="text/css" />
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" background="images/bg2.gif" >
<form method="POST" name="dir" action="ImpCreateAssignments.jsp" onsubmit="return validate();">
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
			<td width="90%"><p>&nbsp;</p></td>
			<td width="97" align="left"></td>
		</tr>
		<tr>
			<td width="100%" height="5" bgcolor="#ECECEC" colspan="2"></td>
		</tr>
		</table>
    </div>
	</td>
</tr>
<tr>
	<td width="100%" height="100%" colspan="3" background="images/bg2.gif" align="center" valign="top">
		<p align="center">&nbsp;</p>
		<div align="center"> 
		
		<table width="60%" border="0" cellpadding="0" cellspacing="0" class="boarder">
		<tr>
		<th height="86" align="center" valign="top" scope="col">
			<table width="398" cellspacing="1" cellpadding="3"  border="0">
	        <tbody>
		    <tr>
				<td width="390" align="middle" class="Grid_tHeader" height="20" valign="middle" colspan="2"><b>My Courses</b></td>
				
			</tr>
<%
				

	while(rs.next())
	{
		courseFlag=true;
		courseName=rs.getString("course_name");
		courseId=rs.getString("course_id");
		
%>
		<tr>
			
		  <td width="21"  bgcolor="#FFFFFF"><input type="radio" name="dir" TITLE="This feature will be added soon"></td>
		  <td align="left" class="tr-subrow" width="362" height="20"><font color="#34526c"><a href="SelectAssignments.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&acourseid=<%=aCourseId%>&aclassid=<%=aClassId%>&ateacherid=<%=aTeacherId%>&aschoolid=<%=aSchoolId%>"><%=courseName%></font></a>
		</td>
	
		</tr>
		
<%
			
	
	}
	rs.close();
	st.close();

	// Based on the Permissions Added from here
%>
			<tr>
				<td width="390" align="middle" class="Grid_tHeader" height="20" valign="middle" colspan="2"><b>Shared Courses</b></td>
				
			</tr>
<%
	st1=con.createStatement();
	rs1=st1.executeQuery("select * from lbcms_dev_course_master dcm inner join lbcms_dev_course_permissions dcp on dcm.course_id=dcp.dev_course_id and (dcp.school_id='"+aSchoolId+"' || dcp.school_id='all') and dcp.teacher_id='"+aTeacherId+"' where dcm.status=1 and dcp.teacher_id='"+aTeacherId+"' order by dcm.course_name");
	while(rs1.next())
	{
		courseFlag=true;
		courseName=rs1.getString("course_name");
		courseId=rs1.getString("course_id");
				
		
%>
		<tr>
			
		  <td width="21"  bgcolor="#FFFFFF"><input type="radio" name="dir" TITLE="This feature will be added soon"></td>
		  <td align="left" class="tr-subrow" width="362" height="20"><font color="#34526c"><a href="SelectAssignments.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&acourseid=<%=aCourseId%>&aclassid=<%=aClassId%>&ateacherid=<%=aTeacherId%>&aschoolid=<%=aSchoolId%>"><%=courseName%></font></a>
		</td>
	
		</tr>
		
<%
			
	
	}
	rs1.close();
	st1.close();
	// Upto here
	if(courseFlag==false)
	{
%>
		<tr>
			<td colspan="2" bgcolor="#D7D7D7" width="390">
				<font face="Verdana" size="2">&nbsp;There are no courses.</font>
			</td>
		</tr>
<%
	}	
%>
		</tbody>
        </table>
	</th>
    </tr>
	<tr>
		<td align="center">&nbsp;</td>
	</tr>
	<tr>
		<!-- <td align="center"><input type="submit" value="Submit" name="sb"></td> -->
	</tr>
    </table>
	<br /></div>
	</td>

</tr>


</table>
</form>
<%
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in ImportAssignments.jsp is....."+e);
	}
	finally
	{
			try
			{
				if(st!=null)
					st.close();
				if(st1!=null)
					st1.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("SQLException in ImportAssignments.java is..."+se);
			}
		}
%>
</body>


</html>
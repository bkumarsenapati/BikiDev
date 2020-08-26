<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String schoolId="",teacherId="",courseId="",courseName="",crsId="";
	String studentId="",preference="",addr="",phno="";
	String sortStr="",sortingBy="",sortingType="";
	ResultSet rs=null,rs1=null,rs2=null;
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	int studentCount=0;
  
	try
	{
		session=request.getSession();
		String sessid=(String)session.getAttribute("sessid");
		 sortingBy=request.getParameter("sortby");
	    sortingType=request.getParameter("sorttype");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		
		schoolId = (String)session.getAttribute("schoolid");
		//teacherId = (String)session.getAttribute("emailid");
		courseId=request.getParameter("courseid");
		crsId=request.getParameter("courseid");
		if(crsId == null)
			crsId="selectcourse";
		
		preference=request.getParameter("pref");   
		if(preference == null)
			preference="personal";

		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();

		rs=st.executeQuery("select * from coursewareinfo where school_id='"+schoolId+"' and status>0 order by course_id");	
%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Course Vs Students Page</title>
<SCRIPT LANGUAGE="JavaScript">
<!--
function goCourse()
{
	var crsid=document.coursestudents.courselist.value;
	parent.main.location.href="CourseStudents.jsp?courseid="+crsid;

}

function goPreference()
{
	var pref=document.coursestudents.preference.value;
	var crsid=document.coursestudents.courselist.value;
	parent.main.location.href="CourseStudents.jsp?courseid="+crsid+"&pref="+pref;
}
//-->
</SCRIPT>
</head>

<body>
<form name="coursestudents" method="POST" action="--WEBBOT-SELF--"><BR>

<div align="center">
<center>
<table border="0" cellpadding="0" cellspacing="0" width="90%" bgcolor="#429EDF" height="24">
  <tr>
    <td width="50%" height="24">&nbsp; <b>
    <font face="Arial" size="2" color="#FFFFFF">Course Vs Students</font></b></td>
    <td width="50%" height="24" align="right">
	<%
	if(!crsId.equals("selectcourse")){
	%><a href="javascript:window.print()"><img border="0" src="../images/printer22.png" width="22" height="22" BORDER="0" ALT="Print"></a><%}%>&nbsp;&nbsp;
		
		<a href="index.jsp?userid=<%=schoolId%>"><IMG src="../images/back.png" width="22" height="22" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a>&nbsp;
	</td>
  </tr>
</table>
  </center>
</div>
<br>
<div align="center">
  <center>
<table border="0" cellspacing="0" width="90%" id="AutoNumber1" bgcolor="#429EDF" height="26" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0">
  <tr>
    <td width="30%" height="23" bgcolor="#96C8ED">
		<select id="courselist" style="width:200px" name="courselist" onchange="goCourse(); return false;">
			<option value="selectcourse" selected>Select Course</option>
<%
				while(rs.next())
				{
					courseName=rs.getString("course_name");
					courseId=rs.getString("course_id");
					out.println("<option value='"+courseId+"'>"+courseName+"</option>");
				}
				rs.close();
%>
		</select>
		<script>
			document.coursestudents.courselist.value="<%=crsId%>";	
		</script>
	</td>
	<td width="30%" height="23" bgcolor="#96C8ED" align="right">
		<select id="preference" name="preference" onchange="goPreference(); return false;">
			<option value="personal" selected>Personal Information</option>
			<option value="contact">Contact Information</option>
			<option value="passwords">Passwords</option>
		</select>
		<script>
			document.coursestudents.preference.value="<%=preference%>";	
		</script>
	</td>
</tr>
<tr>
    <td width="60%" height="23" colspan="2" bgcolor="#FFFFFF">
    <hr color="#F16C0A"></td>
</tr>
</table>
<%

	if (sortingType==null)
			sortingType="A";
	String bgColorDoc="",bgColorDate="";
	
if (sortingBy==null || sortingBy.equals(""))
		{
	        
				sortStr="s.username";
				sortingBy="slno";
				sortingType="D";
				bgColorDoc="#C0C0C0";
				bgColorDate="#858585";
		}
		else
		{
			if(sortingBy.equals("slno"))
				{
			   if(sortingType.equals("A"))
			{
				sortStr="s.lname asc"+",s.fname asc";
			}
			else
			{
				sortStr="s.lname desc"+",s.fname desc";
			}				
		}
			else if (sortingBy.equals("sid"))
			{
				bgColorDoc="#C0C0C0";
				sortStr="s.username";
			if(sortingType.equals("A"))
			{
				sortStr=sortStr+" asc";
			}
			else
			{
				sortStr=sortStr+" desc";
			}
			}
		}
		 
			if(request.getParameter("sorttype")!=null&&sortingBy.equals("slno"))
			{
				bgColorDoc= "#9D9D9D";     
				bgColorDate="#C0C0C0";
			}
			if(sortingBy.equals("sid"))	 
			{
				bgColorDate= "#858585";   
			} 

				if(preference.equals("personal"))
				{		
					
%>
<table border="1" cellspacing="1" width="90%" bordercolorlight="#E6F2FF">
<tr>
	<td width="30%" align="left" bgcolor="<%=bgColorDoc%>" height="25">

	 <%  
			if((sortingType.equals("D"))||(sortingBy.equals("en")))
			{
%>
				<a href="CourseStudents.jsp?sortby=slno&sorttype=A&courseid=<%=crsId%>&pref=<%=preference%>&status=" target="_self">
					<img border="0" src="../images/sort_dn_1.gif" width="12" height="11"></a>
<%   
			}
			else
			{
%>
				<a href="CourseStudents.jsp?sortby=slno&sorttype=D&courseid=<%=crsId%>&pref=<%=preference%>&status=" target="_self">
					<img border="0" src="../images/sort_up_1.gif" width="12" height="11"></a>
<%   
			}
%>	
		<b><font face="Arial" size="2">Student Name</font></b>
	</td>
    <td width="20%" align="center" bgcolor="<%=bgColorDate%>" height="25">
	<%  
			if((sortingType.equals("D"))||(sortingBy.equals("en")))
			{
%>
				<a href="CourseStudents.jsp?sortby=sid&sorttype=A&courseid=<%=crsId%>&pref=<%=preference%>&status=" target="_self">
					<img border="0" src="../images/sort_dn_1.gif" width="12" height="11"></a>
<%   
			}
			else
			{
%>
				<a href="CourseStudents.jsp?sortby=sid&sorttype=D&courseid=<%=crsId%>&pref=<%=preference%>&status=" target="_self">
					<img border="0" src="../images/sort_up_1.gif" width="12" height="11"></a>
<%   
			}
%>
		<b><font face="Arial" size="2">Student ID</font></b>
	</td>
    <td width="35%" align="center" bgcolor="#C0C0C0" height="25">
		<b><font face="Arial" size="2">Mail ID</font></b>
	</td>
    <td width="15%" align="center" bgcolor="#C0C0C0" height="25">
		<b><font face="Arial" size="2">Contact No</font></b>
	</td>
</tr>
<%
				}	
				else if(preference.equals("contact"))
				{		
%>
<table border="1" cellspacing="1" width="90%" bordercolorlight="#E6F2FF">
<tr>
	<td width="15%" align="left" bgcolor="<%=bgColorDoc%>">
	<%  
			if((sortingType.equals("D"))||(sortingBy.equals("en")))
			{
%>
				<a href="CourseStudents.jsp?sortby=slno&sorttype=A&courseid=<%=crsId%>&pref=<%=preference%>&status=" target="_self">
					<img border="0" src="../images/sort_dn_1.gif" width="12" height="11"></a>
<%   
			}
			else
			{
%>
				<a href="CourseStudents.jsp?sortby=slno&sorttype=D&courseid=<%=crsId%>&pref=<%=preference%>&status=" target="_self">
					<img border="0" src="../images/sort_up_1.gif" width="12" height="11"></a>
<%   
			}
%>	
		<b><font face="Arial" size="2">&nbsp;Student Name</font></b>
	</td>
    <td width="16%" align="center" bgcolor="<%=bgColorDate%>">
	<%  
			if((sortingType.equals("D"))||(sortingBy.equals("en")))
			{
%>
				<a href="CourseStudents.jsp?sortby=sid&sorttype=A&courseid=<%=crsId%>&pref=<%=preference%>&status=" target="_self">
					<img border="0" src="../images/sort_dn_1.gif" width="12" height="11"></a>
<%   
			}
			else
			{
%>
				<a href="CourseStudents.jsp?sortby=sid&sorttype=D&courseid=<%=crsId%>&pref=<%=preference%>&status=" target="_self">
					<img border="0" src="../images/sort_up_1.gif" width="12" height="11"></a>
<%   
			}
%>
		<b><font face="Arial" size="2">Student ID</font></b>
	</td>
    <td width="13%" align="center" bgcolor="#C0C0C0">
		<b><font face="Arial" size="2">Mail ID</font></b>
	</td>
    <td width="14%" align="center" bgcolor="#C0C0C0">
		<b><font face="Arial" size="2">Contact No</font></b>
	</td>
    <td width="14%" align="center" bgcolor="#C0C0C0">
		<b><font face="Arial" size="2">Parent Mail Id</font></b>
	</td>
</tr>
<%
				}	
				else if(preference.equals("passwords"))
				{		
%>
<table border="1" cellspacing="1" width="90%"bordercolorlight="#E6F2FF">
<tr>
	<td width="15%" align="left" bgcolor="<%=bgColorDoc%>">
	<%  
			if((sortingType.equals("D"))||(sortingBy.equals("en")))
			{
%>
				<a href="CourseStudents.jsp?sortby=slno&sorttype=A&courseid=<%=crsId%>&pref=<%=preference%>&status=" target="_self">
					<img border="0" src="../images/sort_dn_1.gif" width="12" height="11"></a>
<%   
			}
			else
			{
%>
				<a href="CourseStudents.jsp?sortby=slno&sorttype=D&courseid=<%=crsId%>&pref=<%=preference%>&status=" target="_self">
					<img border="0" src="../images/sort_up_1.gif" width="12" height="11"></a>
<%   
			}
%>	
		<b><font face="Arial" size="2">&nbsp;Student Name</font></b>
	</td>
    <td width="16%" align="center" bgcolor="<%=bgColorDate%>">
	<%  
			if((sortingType.equals("D"))||(sortingBy.equals("en")))
			{
%>
				<a href="CourseStudents.jsp?sortby=sid&sorttype=A&courseid=<%=crsId%>&pref=<%=preference%>&status=" target="_self">
					<img border="0" src="../images/sort_dn_1.gif" width="12" height="11"></a>
<%   
			}
			else
			{
%>
				<a href="CourseStudents.jsp?sortby=sid&sorttype=D&courseid=<%=crsId%>&pref=<%=preference%>&status=" target="_self">
					<img border="0" src="../images/sort_up_1.gif" width="12" height="11"></a>
<%   
			}
%>
		<b><font face="Arial" size="2">Student ID</font></b>
	</td>
    <td width="13%" align="center" bgcolor="#C0C0C0">
		<b><font face="Arial" size="2">Password</font></b>
	</td>
</tr>
<%
				}	
%>
<%
		//rs1=st1.executeQuery("select student_id from coursewareinfo_det where school_id='"+schoolId+"' and course_id='"+crsId+"' and student_id!='C000_vstudent' order by "+sortStr+"");

		System.out.println("crsId...."+crsId);

		rs1=st1.executeQuery("select distinct s.username,s.fname,s.lname from coursewareinfo_det c,studentprofile s where c.school_id='"+schoolId+"' and c.course_id='"+crsId+"' and c.school_id=s.schoolid and s.username!='C000_vstudent' and s.username!='C001_vstudent' and s.username!='C002_vstudent' order by "+sortStr+"");

		while(rs1.next())
		{
			studentCount = studentCount + 1;
			studentId=rs1.getString(1);
              
			rs2=st2.executeQuery("select * from studentprofile where schoolid='"+schoolId+"' and username='"+studentId+"'");

			while(rs2.next())
			{
				phno=rs2.getString("phone");
				if(phno==null || phno.equals(""))
					phno="-";

				addr=rs2.getString("address");
				if(addr==null || addr.equals(""))
					addr="-";
%>
<%
				if(preference.equals("personal"))
				{
%>
					<tr>
						<td width="30%">
							<font face="Arial" size="2">
								<%=rs2.getString("lname")%>&nbsp;<%=rs2.getString("fname")%>
							</font>
						</td>
					    <td width="20%" align="center">
							<font size="2" face="Arial"><%=rs2.getString("username")%></font>
						</td>
					    <td width="35%" align="center">
							<font face="Arial" size="2"><%=rs2.getString("con_emailid")%></font>
						</td>
					    <td width="15%" align="center">
							<font face="Arial" size="2"><%=phno%></font>
						</td>
					</tr>
<%
				}
				else if(preference.equals("contact"))
				{
%>
					<tr>
						<td width="15%">
							<font face="Arial" size="2"><%=rs2.getString("lname")%>&nbsp;<%=rs2.getString("fname")%></font>
						</td>
					    <td width="16%" align="center">
							<font size="2" face="Arial"><%=rs2.getString("username")%></font>
						</td>
					    <td width="13%" align="center">
							<font face="Arial" size="2"><%=rs2.getString("con_emailid")%></font>
						</td>
					    <td width="14%" align="center">
							<font face="Arial" size="2"><%=phno%></font>
						</td>
					    <td width="14%" align="center">
							<font size="2" face="Arial"><%=addr%></font>
						</td>
					</tr>
<%
				}
				else if(preference.equals("passwords"))
				{
%>
					<tr>
						<td width="50%">
							<font face="Arial" size="2">
								<%=rs2.getString("lname")%>&nbsp;<%=rs2.getString("fname")%>
							</font>
						</td>
					    <td width="25%" align="center">
							<font size="2" face="Arial"><%=rs2.getString("username")%></font>
						</td>
					    <td width="25%" align="center">
							<font face="Arial" size="2"><%=rs2.getString("password")%></font>
						</td>
					</tr>
<%
				}
			}
			rs2.close();
		}
		rs1.close();	
		if(studentCount == 0)
		{
			if(crsId.equals("selectcourse"))
			{
%>
			<tr>
				<td width="100%" colspan="5">
					<font face="Arial" size="2">Please select any course.</font>
				</td>
			</tr>
<%
			}
			else
			{
%>
			<tr>
				<td width="100%" colspan="5">
					<font face="Arial" size="2">There are no students in this course.</font>
				</td>
			</tr>
<%
			}
		}
	}	
	
	catch(Exception e)
	{
		out.println("Error: General-" + e);
		System.out.println("Error:  -" + e.getMessage());
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(st2!=null)
				st2.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}
		catch(SQLException se){
			ExceptionsFile.postException("CourseStudents.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }


%>

</table>
</center>
</div>
</form>
</body>
</html>

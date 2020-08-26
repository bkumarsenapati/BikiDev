<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	ResultSet  rs=null,rs1=null,rs2=null,rs3=null;
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null;
	String schoolId="",teacherId="",courseId="",courseName="";

	try
	{
		session=request.getSession();
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		
		schoolId = (String)session.getAttribute("schoolid");
		//teacherId = (String)session.getAttribute("emailid");
		courseId=request.getParameter("courseid");
		if(courseId == null)
			courseId="selectcourse"; 
		courseName=request.getParameter("coursename");
			
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();   
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Categories List</title>
<SCRIPT LANGUAGE="JavaScript">
<!--

function goCourse()
{
	var courseId=document.categorylist.courselist.value;
	//alert(courseId);
	//var courseName=document.categorylist.courselist.value;
	window.location="CategoriesList.jsp?courseid="+courseId + "&classid=C000";
}

</SCRIPT>
</head>

<body>
<form name="categorylist" method="POST" action="--WEBBOT-SELF--"><BR>

<div align="center">
<center>
<table border="0" width="90%" bgcolor="#429EDF" height="24">
  <tr>
    <td width="50%" height="24">
		<b><font face="Arial" size="2" color="#FFFFFF">Course Categories</font></b></td>
   <td width="50%" height="24" align="right">
   <%
	if(!courseId.equals("selectcourse")){
	%><a href="javascript:window.print()"><img border="0" src="../images/printer22.png" width="22" height="22" BORDER="0" ALT="Print"></a><%}%>&nbsp;&nbsp;
	<a href="index.jsp?userid=<%=schoolId%>"><IMG src="../images/back.png" width="22" height="22" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a>&nbsp;
	</td>
  </tr>
</table>
  </center>
</div><br>
<div align="center">
  <center>
<table border="0" cellpadding="5" cellspacing="0" width="90%" id="AutoNumber1" height="26" style="border-collapse: collapse" bordercolor="#111111" >
  <tr bgcolor="#429EDF">
   <td width="30%" height="23" bgcolor="#96C8ED" align="right">
		<select id="courselist" style="width:200px" name="courselist" onchange="goCourse(); return false;">
		<option value="selectcourse" selected>Select Course</option>
<%		
			rs3=st3.executeQuery("select * from coursewareinfo where school_id='"+schoolId+"' and status>0 order by course_id");
			out.println("<option value='allcourses'>List All Courses</option>");

		while(rs3.next())
			{
				
				out.println("<option value='"+rs3.getString("course_id")+"'>"+rs3.getString("course_name")+"</option>");
				
				}
			rs3.close();
%>
		</select>

		 <script>
			document.categorylist.courselist.value="<%=courseId%>";	
		</script> 
		</td>
	
</tr>
  <tr>
    <td width="60%" height="23" bgcolor="#FFFFFF">
    </td>
</tr>

<%
	
	if(courseId.equals("selectcourse")){
	%>
	<tr>
				<td width="100%">
					<font face="Arial" size="2"><center><strong>Please Select a Course</strong></center></font>
				</td>
              
			</tr>
			<tr><td>
    
    </td></tr>
						
			<%
}
%>
</table>

<%
	if(courseId.equals("allcourses"))
		{
			
		rs=st.executeQuery("select course_id,course_name from coursewareinfo where school_id='"+schoolId+"' and status>0 order by course_id");
		
		while(rs.next())
		{
			courseId=rs.getString(1);
			courseName=rs.getString(2);
			
			rs1=st1.executeQuery("select item_des,weightage from category_item_master where (category_type='EX' OR 									category_type='AS') and school_id='"+schoolId+"' and course_id ='"+courseId+"' order by item_des");
			
%>
		<table border="1" cellpadding="2" width="90%" bordercolorlight="#96C8ED" bordercolordark="#96C8ED" bgcolor="#7CBBE9">
			<tr>
				<td width="100%" colspan="2">
					<font face="Arial" size="2"><b><%=courseName%></b></font> &nbsp;</td>
			</tr>
		</table>
		<table border="1" cellpadding="2" width="90%" bordercolorlight="#96C8ED" bordercolordark="#96C8ED">
		<tr>
				<td width="70%" bgcolor="#C2E0F5">
					<font face="Arial" size="2"><b>Category Name</b></font>
				</td>
				<td width="30%" align="center" bgcolor="#C2E0F5">
					<font face="Arial" size="2"><b>Weightage</b></font>
				</td>
			</tr>
<%
			while(rs1.next())
			{
%>
			<tr>
				<td width="70%">
					<font face="Arial" size="2"><%=rs1.getString(1)%></font> &nbsp;</td>
				<td width="30%" align="center">
					<font face="Arial" size="2"><%=rs1.getString(2)%></font> &nbsp;</td>
			</tr>

<%
			}
%> 
        
		</table>
		<table border="0" cellpadding="2" width="90%">
		<tr><td>
    
    </td></tr></table>
	
<%
		}
%>

</center>
</div>
<%
		}else{
%>
<%
rs=st.executeQuery("select course_name from coursewareinfo where school_id='"+schoolId+"' and course_id='"+courseId+"'");
		
		while(rs.next())
		{
			courseName=rs.getString("course_name");
			
			rs1=st1.executeQuery("select item_des,weightage from category_item_master where (category_type='EX' OR 									category_type='AS') and school_id='"+schoolId+"' and course_id ='"+courseId+"' order by item_des");
%>

<table border="1" cellpadding="2" width="90%" bordercolorlight="#96C8ED" bordercolordark="#96C8ED" bgcolor="#7CBBE9">
			<tr>
				<td width="100%" colspan="2">
					<font face="Arial" size="2"><b><%=rs.getString("course_name")%></b></font> &nbsp;</td>
			</tr>
		</table>
		<table border="1" cellpadding="2" width="90%" bordercolorlight="#96C8ED" bordercolordark="#96C8ED">
		<tr>
				<td width="70%" bgcolor="#C2E0F5">
					<font face="Arial" size="2"><b>Category Name</b></font>
				</td>
				<td width="30%" align="center" bgcolor="#C2E0F5">
					<font face="Arial" size="2"><b>Weightage</b></font>
				</td>
			</tr>
<%
			while(rs1.next())
			{
%>
			<tr>
				<td width="70%">
					<font face="Arial" size="2"><%=rs1.getString(1)%></font> &nbsp;</td>
				<td width="30%" align="center">
					<font face="Arial" size="2"><%=rs1.getString(2)%></font> &nbsp;</td>
			</tr>
<%
			}
%> 
      
		</table>


<table border="0" cellpadding="2" width="90%">
		<tr><td>
    
    </td></tr></table>


<%
			}}
	}
 
	catch(SQLException se)
	{
		ExceptionsFile.postException("CoursesList.jsp","operations on database","SQLException",se.getMessage());
		System.out.println("Error: SQL -" + se.getMessage());
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("CoursesList.jsp","operations on database","Exception",e.getMessage());	 
		System.out.println("Error:  -" + e.getMessage());
	}
	finally
	{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(st2!=null)
				st2.close();
			if(st3!=null)
				st3.close();
			if(con!=null)
				con.close();
		}catch(SQLException se){
			ExceptionsFile.postException("CoursesList.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println(se.getMessage());
		}
	}
%>
</body>
</html>
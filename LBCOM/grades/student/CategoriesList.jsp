<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	ResultSet  rs=null,rs1=null,rs3=null;
	Connection con=null;
	Statement st=null,st1=null,st3=null;
	String schoolId="",studentId="",courseId="",courseName="";

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
		studentId = (String)session.getAttribute("emailid");
		courseId=request.getParameter("courseid");
		if(courseId == null)
			courseId="selectcourse"; 
		
			
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
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
	if(courseId.value!="")
	window.location.href="CategoriesList.jsp?courseid="+courseId+"&studentid="+'<%=studentId%>'+"&classid=C000&dcourse=dcourse";
}

</SCRIPT>
</head>

<body>
<form name="categorylist" method="POST" action="--WEBBOT-SELF--"><BR>

<div align="center">
<center>
<table border="0" width="80%" bgcolor="#429EDF" height="24">
  <tr>
    <td width="50%" height="24">
		<b><font face="Verdana" size="2" color="#FFFFFF">Course Categories</font></b></td>
   <td width="50%" height="24" align="right">
   <%
	if(!courseId.equals("selectcourse")){
	%><a href="javascript:window.print()"><img border="0" src="images/print.jpg" width="20" height="15" BORDER="0" ALT="Print"></a><%}%>&nbsp;&nbsp;
	<a href="index.jsp?userid=<%=studentId%>"><IMG SRC="images/back.jpg" WIDTH="20" HEIGHT="15" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a>&nbsp;
	</td>
  </tr>
</table>
  </center>
</div><br>
<div align="center">
  <center>
<table border="0" cellspacing="0" width="80%" id="AutoNumber1"  height="26" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0">
  <tr bgcolor="#429EDF">
   <td width="30%" height="23" bgcolor="#96C8ED" align="right">
		<select id="courselist" name="courselist" onchange="goCourse(); return false;">
		<option value="selectcourse" selected>Select A Course</option>
        <option value='allcourses'>List All Courses</option>
<%		
			rs3=st3.executeQuery("select c.course_name,c.course_id,c.teacher_id from coursewareinfo c inner join coursewareinfo_det d  on c.course_id=d.course_id and c.school_id=d.school_id where d.student_id='"+studentId+"' and c.status=1 and c.school_id='"+schoolId+"' order by c.course_id");
			

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
    <hr color="#F16C0A"></td>
</tr>

</table>

<%

	
		
		if(request.getParameter("dcourse")==null || courseId.equals("selectcourse"))
					{
%>
<tr>
				<td width="100%" colspan="5">
					<font face="Verdana" size="2"><center>-*****-Please select a course.-*****-</center></font>
				</td>
			</tr>
			<table border="0" cellpadding="2" width="80%">
		<tr><td>
    <hr color="#F16C0A" size="1">
    </td></tr></table>
<%
	}

	if(courseId.equals("allcourses"))
		{
			
		rs=st.executeQuery("select c.course_name,c.course_id,c.teacher_id from coursewareinfo c inner join coursewareinfo_det d  on c.course_id=d.course_id and c.school_id=d.school_id where d.student_id='"+studentId+"' and c.status=1 and c.school_id='"+schoolId+"' order by c.course_id");
		
		while(rs.next())
		{
			courseId=rs.getString("course_id");
			courseName=rs.getString("course_name");
			
			rs1=st1.executeQuery("select item_des,weightage from category_item_master where (category_type='EX' OR 									category_type='AS') and school_id='"+schoolId+"' and course_id ='"+courseId+"' order by item_des");
			
%>
		<table border="1" cellpadding="2" width="80%" bordercolorlight="#96C8ED" bordercolordark="#96C8ED" bgcolor="#7CBBE9">
			<tr>
				<td width="100%" colspan="2">
					<font face="Verdana" size="2"><b><%=rs.getString("course_name")%></b></font> &nbsp;</td>
			</tr>
		</table>
		<table border="1" cellpadding="2" width="80%" bordercolorlight="#96C8ED" bordercolordark="#96C8ED">
		<tr>
				<td width="70%" bgcolor="#C2E0F5">
					<font face="Verdana" size="2"><b>Category Name</b></font>
				</td>
				<td width="30%" align="center" bgcolor="#C2E0F5">
					<font face="Verdana" size="2"><b>Weightage</b></font>
				</td>
			</tr>
<%
			while(rs1.next())
			{
%>
			<tr>
				<td width="70%">
					<font face="Verdana" size="2"><%=rs1.getString(1)%></font> &nbsp;</td>
				<td width="30%" align="center">
					<font face="Verdana" size="2"><%=rs1.getString(2)%></font> &nbsp;</td>
			</tr>

<%
			}
%> 
        
		</table>
		<table border="0" cellpadding="2" width="80%">
		<tr><td>
    <hr color="#F16C0A" size="1">
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
rs=st.executeQuery("select course_name,teacher_id from coursewareinfo  where  status=1 and school_id='"+schoolId+"' and course_id='"+courseId+"'");
		
		while(rs.next())
		{
			courseName=rs.getString("course_name");
			
			
			rs1=st1.executeQuery("select item_des,weightage from category_item_master where (category_type='EX' OR 									category_type='AS') and school_id='"+schoolId+"' and course_id ='"+courseId+"' order by item_des");
%>

<table border="1" cellpadding="2" width="80%" bordercolorlight="#96C8ED" bordercolordark="#96C8ED" bgcolor="#7CBBE9">
			<tr>
				<td width="100%" colspan="2">
					<font face="Verdana" size="2"><b><%=courseName%></b></font> &nbsp;</td>
			</tr>
		</table>
		<table border="1" cellpadding="2" width="80%" bordercolorlight="#96C8ED" bordercolordark="#96C8ED">
		<tr>
				<td width="70%" bgcolor="#C2E0F5">
					<font face="Verdana" size="2"><b>Category Name</b></font>
				</td>
				<td width="30%" align="center" bgcolor="#C2E0F5">
					<font face="Verdana" size="2"><b>Weightage</b></font>
				</td>
			</tr>
<%
			while(rs1.next())
			{
%>
			<tr>
				<td width="70%">
					<font face="Verdana" size="2"><%=rs1.getString(1)%></font> &nbsp;</td>
				<td width="30%" align="center">
					<font face="Verdana" size="2"><%=rs1.getString(2)%></font> &nbsp;</td>
			</tr>
<%
			}
%> 
      
		</table>


<table border="0" cellpadding="2" width="80%">
		<tr><td>
    <hr color="#F16C0A" size="1">
    </td></tr></table>


<%
			}}
	}
 
	catch(SQLException se)
	{
		ExceptionsFile.postException("CategoriesList.jsp","operations on database","SQLException",se.getMessage());
		System.out.println("Error: SQL -" + se.getMessage());
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("CategoriesList.jsp","operations on database","Exception",e.getMessage());	 
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
			
			if(st3!=null)
				st3.close();
			
			if(con!=null && !con.isClosed())
				con.close();
			
		
		}catch(SQLException se){
			ExceptionsFile.postException("CategoriesList.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println(se.getMessage());
		}
	}
%>
</body>
</html>
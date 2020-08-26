<%@ page language="java" import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.StringTokenizer" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
String schoolId="",courseName="",courseId="";
ResultSet rs=null;
Connection con=null;
Statement st=null;
%>
<%
	try
	{
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}	
		con=con1.getConnection();
		st=con.createStatement();
		session=request.getSession(true);
		schoolId = (String)session.getAttribute("schoolid");
		courseName=request.getParameter("coursename");
		courseId=request.getParameter("courseid");
%>

<html>
<head>
<title></title>
</head>

<body topmargin='0'>
<form action="/LBCOM/coursemgmt.AdminAddCourse?mode=assignteacher" name="editcourse" method="post">

<div align="center">
<center>

<table cellspacing="0" width="525" bordercolor="#111111" cellpadding="0">
    <tr bgcolor="#E7D57C"> 
      <td height="18" width="523"><b><font face="arial">Assign Teacher</font></b></td>
	  <td height="19" width="313" align="right">&nbsp;</td>
    </tr>
    <tr> 
      <td width="208" height="33"> <b> <font face="Arial" size="2">Course Name</font></b></td>
      <td width="313" height="33"> 
		<font face="Arial" size="2">
		<input type="text" name="coursename" size="28" value="<%=courseName%>" readonly></font></td>
    </tr>
	<tr> 
		<td width="232" height="22"><b><font face="Arial" size="2">Teacher ID</font></b></td>
		<td width="263" height="22"><font face="Arial" size="2">
			<select name="teacherid" id="teacherid" size="1">
			<option value="">Select Teacher ID</option>
<%
				rs=st.executeQuery("select username from teachprofile where schoolid='"+schoolId+"' and status=1");
				while(rs.next())	
				{
					out.println("<option value="+rs.getString("username")+">"+rs.getString("username")+"</option>");      
				}
%>	
			</select>
		</font></td>
    </tr>
    <tr> 
      <td width="208" bgcolor="#E7D57C" height="18"></td>
      <td bgcolor="#E7D57C" width="313" height="18">
		<font face="Arial" size="2">&nbsp;</font></td>
    </tr>
    <tr> 
      <td width="208" bgcolor="#DCC03F" height="19"></td>
      <td bgcolor="#DCC03F" width="313" height="19">&nbsp;</td>
    </tr>
    
    <tr align="center" valign="middle"> 
      <td colspan=2 width="523" height="36"> 
        <font face="Arial" size="2"> 
        <input type=image src="images/submit.gif" width="88" height="33">
        </font>
      </td>
    </tr>
  </table>
</center>
</div>
<input type="hidden" name="courseid" value="<%=courseId%>">
</form>
</body>

<%
	}
	catch(SQLException se)
	{
		ExceptionsFile.postException("EditCourse.jsp","operations on database","SQLException",se.getMessage());	 
		System.out.println("Error in AdminEditCourse.jsp : SQL -" + se.getMessage());
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("EditCourse.jsp","operations on database","Exception",e.getMessage());	 
		System.out.println("Error in AdminEditCourse.jsp :  -" + e.getMessage());
	}

	finally     //closes all the database connections at the end
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
			ExceptionsFile.postException("AdminEditCourse.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println("Error in AdminEditCourse.jsp :"+se.getMessage());
		}
	}
%>
</html>
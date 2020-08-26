<%@ page language="java" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@ page import = "java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ include file="/common/checksession.jsp" %> 	
<%
    Connection dbCon=null; 
	Statement st=null;
    ResultSet rs=null;
	String schoolid="";
%>
<%
	String myschoolid = (String)request.getParameter("myschoolid");
	String mycourseid = (String)request.getParameter("mycourseid");
		
	try
	{
		dbCon=con1.getConnection();
	    st=dbCon.createStatement(); 
		rs = st.executeQuery("select s.fname , s.lname , s.username , s.password from studentprofile s 	where s.schoolid='"+myschoolid+"' and s.username  in (select student_id from  coursewareinfo_det    where school_id='"+myschoolid+"' and course_id='"+mycourseid+"') ");
	}
	catch(Exception se)
	{
		out.println("Exception here");
		System.out.println("SQL Error in studentlist.jsp");		
	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Student List</title>
</head>

<body topmargin='10'>
<table border="1" width="100%" cellspacing="1" bordercolordark="#FFFFFF" id="table1">
	<tr>             
        <td width="975" height="30" align="center" valign="bottom" colspan="3" >
<table border="0" width="86%" id="table2" height="104">
	<tr>
		 <td width="233" height="23" align="right" valign="bottom" >
              <span style="font-size:10pt;"><b><font face="Arial" >School Name :</font></b></span></td>
		 <td width="442" height="23" align="left" valign="bottom" ><font size="2" face="Verdana">&nbsp;<%=request.getParameter("myschoolid")%></font>  </td>
	</tr>
	<tr>
		 <td width="233" height="23" align="right" valign="bottom" >
              <span style="font-size:10pt;"><font face="Arial" ><b>Grade :</b></font></span> 
        </td>
	    <td width="442" height="23" align="left" valign="bottom" ><font size="2" face="Verdana">&nbsp;<%=request.getParameter("mygrade")%>
              &nbsp;</font></td>
	</tr>
	<tr>
		<td width="233" height="23" align="right" valign="bottom" >
              <span style="font-size:10pt;"><font face="Arial" ><b>Teacher Name :</b></font></span> 
        </td>
		<td width="442" height="23" align="left" valign="bottom" ><font size="2" face="Verdana">&nbsp;<%=request.getParameter("mytname")%>&nbsp;</font></td>
	</tr>
	<tr>
		<td width="233" height="23" align="right" valign="bottom" >
              <span style="font-size:10pt;"><font face="Arial" ><b>Course Name :</b></font></span> 
        </td>
	    <td width="442" height="23" align="left" valign="bottom" ><font size="2" face="Verdana">&nbsp;<%=request.getParameter("mycname")%>&nbsp;</font></td>
	</tr>
</table>
 
        </td>
   </tr>

	<tr>             
        <td width="250" align="center" valign="bottom" bgcolor="#FF9900" >
              <span style="font-size:10pt;"><font face="Arial" ><b>Student Name</b></font></span> 
        </td>
        <td width="250" valign="bottom" bgcolor="#FF9900" >
              <p align="center"><font face="Arial" ><b><span style="font-size: 10pt">Student ID</span></b></font> </p>
        </td>
        <td width="250" valign="bottom" bgcolor="#FF9900" >
              <p align="center"><font face="Arial" ><b><span style="font-size: 10pt">Student Password</span></b></font>
        </td>
   </tr>

<%
	while(rs.next())
	{
%>    
    <tr>
        <td width="250" height="25" bgcolor="" align="left">
			
				<font size="2" face="Verdana"><%=rs.getString("s.fname")%>&nbsp;<%=rs.getString("s.lname")%></font> 
        </td>
       <td width="250" height="25" bgcolor="" align="left"><font size="2" face="Verdana"><%=rs.getString("s.username")%></font></td>
       <td width="250" height="25" bgcolor="" align="left"><font size="2" face="Verdana"><%= rs.getString("s.password")%></font></td>
  </tr>
<%
	}
%>
</table>
<%
   rs.close();
   dbCon.close();
%>
</body>
</html>

<%@ page language="java" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@ page import = "java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ include file="/common/checksession.jsp" %> 	
<%
    Connection dbCon=null; 
    Statement st=null,st1=null;
    ResultSet rs=null,rs1=null;
    String schoolid="",sId="",teacherCount="",studentCount="";
	int count=0;
%>

<%
	try
	{
		//System.out.println("con1 object."+con1);
		dbCon=con1.getConnection();		
		//System.out.println("st object."+dbCon);
		
		st = dbCon.createStatement();		
		//System.out.println("st object."+st);
		
		st1 = dbCon.createStatement(); 
		//System.out.println("st1 object."+st1);
		//System.out.println("SELECT  schoolid,schoolname,PASSWORD,reg_date FROM school_profile order by schoolid");
		
		rs = st.executeQuery("SELECT  schoolid,schoolname,PASSWORD,reg_date FROM school_profile order by schoolid");
	}
	catch(Exception se)
	{
		System.out.println("SQL Error");
		System.out.println("SQL Error.."+se.getMessage());
	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>School List</title>
</head>

<body>

<table border="0" cellpadding="0" cellspacing="0" width="100%" height="0">
    <tr>
        <td width="208" height="24">
            <p>
            <img src="images/hsn/logo.gif"  border="0" width="204" height="42" ></p>
        </td>
        <td width="387" height="24">
            <p>&nbsp;</p>
        </td>
        <td width="212" height="24">
            <p>&nbsp;</p>
        </td>
        <td width="104" height="24" align="center" valign="top">
            <p align="left">&nbsp;</p>
        </td>
        
    </tr>
</table>
<table>

<table border="1" width="95%" cellspacing="1" bordercolordark="#FFFFFF" align="center">
	<tr>             
		<td align="center" valign="bottom" bgcolor="#FFCC33" colspan="7">
			<font face="Verdana" size="2" ><b>Schools Details</b></font> 
        </td>
    </tr>
	<tr>             
		<td align="center" valign="bottom" bgcolor="#FFCC33" >
              <span style="font-size:10pt;"><font face="Verdana" ><b>School Name</b></font></span> 
        </td>

		<td align="center" valign="bottom" bgcolor="#FFCC33" >
              <span style="font-size:10pt;"><font face="Verdana" ><b>School ID</b></font></span> 
        </td>

        <td valign="bottom" align="left" bgcolor="#FFCC33" >
              <p align="center"><font face="Verdana" ><b><span style="font-size: 10pt">Admin ID</span></b></font> </p>
        </td>
        <td valign="bottom" align="left" bgcolor="#FFCC33" >
              <p align="center"><font face="Verdana" ><b><span style="font-size: 10pt">Password</span></b></font>
        </td>
		<td valign="bottom" align="left" bgcolor="#FFCC33" >
              <p align="center"><font face="Verdana" ><b><span style="font-size: 10pt">No. of Teachers</span></b></font>
        </td>
		<td valign="bottom" align="left" bgcolor="#FFCC33" >
              <p align="center"><font face="Verdana" ><b><span style="font-size: 10pt">No. of Students</span></b></font>
        </td>
		<td valign="bottom" align="left" bgcolor="#FFCC33" >
              <p align="center"><font face="Verdana" ><b><span style="font-size: 10pt">Registered On</span></b></font>
        </td>
    </tr>
<%
	while(rs.next())
	{
		sId=rs.getString("schoolid");

		rs1 = st1.executeQuery("SELECT  count(*) FROM teachprofile where schoolid='"+sId+"'");
		while(rs1.next())
		{
			teacherCount=rs1.getString(1);
		}
		rs1.close();

		rs1 = st1.executeQuery("SELECT  count(*) FROM studentprofile where schoolid='"+sId+"' and crossregister_flag<'2'");
		while(rs1.next())
		{
			studentCount=rs1.getString(1);
		}
		rs1.close();

		count++;
%>
    <tr>
        <td align="left">
			<font face="Verdana" size="2">
			<a href="tlist.jsp?myschoolid=<%=rs.getString("schoolid")%>"><%=rs.getString("schoolname")%></a></font>
		</td>
		<td align="left">
			<font face="Verdana" size="2"><%=rs.getString("schoolid")%></font>
		</td>
		<td align="left">
			<font face="Verdana" size="2">admin</font></td>
		<td align="left">
			<font face="Verdana" size="2"><%=rs.getString("password")%></font>
		</td>
		<td align="center">
			<font face="Verdana" size="2"><b><a href="TeachProfile.jsp?schoolid=<%=sId%>&sname=<%=rs.getString("schoolname")%>"><%=teacherCount%></a></b></font>
		</td>
		<td align="center">
			<font face="Verdana" size="2"><b><a href="StudentProfile.jsp?schoolid=<%=sId%>&sname=<%=rs.getString("schoolname")%>"><%=studentCount%></a></b></font>
		</td>
		<td align="center">
			<font face="Verdana" size="2"><b><%=rs.getString("reg_date")%></a></b></font>
		</td>
	</tr>       	
<%
	}
%>  
	<tr>             
		<td align="left" valign="bottom" bgcolor="#FFCC33" colspan="7">
			<font face="Verdana" size="2" >There are <b><%=count%></b> schools in all.</font> 
        </td>
    </tr>
</table>
<%
   rs.close();
   dbCon.close();
%>

</body>

</html>
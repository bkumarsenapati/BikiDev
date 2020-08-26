<%@  page language="java"  import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@ include file="/common/checksession.jsp" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0"><meta name="author" content="Hotschools, Inc. ">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Students</title>
</head>
<body>
<%
    String school_id,uname,sid,password,schoolid,pwd,fname,lname,sname;
    Connection con=null;
	ResultSet rs=null,rs1=null,rs2=null;
	Statement st=null;
	Hashtable stud_profile=null;
	Hashtable class_ids=null; 
	boolean student_flag=false;
	int count=0;
%>

<%
   school_id=request.getParameter("schoolid");
   sname=request.getParameter("sname");
   
  try
    {
		stud_profile = new Hashtable();
		con = con1.getConnection();
		st=con.createStatement();
		rs=st.executeQuery("select * from studentprofile where schoolid='"+school_id+"' and crossregister_flag<'2'");
		student_flag= false;
		
				
%>
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
<table border="1" cellpadding="0" cellspacing="1" width="95%" align="center">
 <tr>             
	   <td width="358" height="20%" align="center" valign="middle" colspan="3">
			<p align="left"><font face="Verdana" size="2" ><b>School Name : </font>
			<font size="2" face="Verdana"><%=sname%></b></font> 
       </td>
	   <td width="358" height="20%" align="center" valign="middle" colspan="3" >
			<p align="right"><b><font face="Verdana" size="2">
            <a target="_self" href="slist.jsp"><< Back</a></font></b></td>
    </tr>
</table>

<table border="1" width="95%" cellspacing="1" bordercolordark="#FFFFFF" align="center">
	<tr>             
		<td align="center" valign="bottom" bgcolor="#FF9900" colspan="6">
			<font face="Verdana" size="2" ><b>Student Details</b></font> 
        </td>
    </tr>
	<tr>   
        <td valign="bottom" align="center" bgcolor="#FF9900" width="300" height="19">
			<font face="Verdana" size="2"><b>Student Name</b></font>
        </td>
		<td align="center" valign="bottom" bgcolor="#FF9900" width="197" height="19">
            <font face="Verdana" size="2"><b>Student Id</b></font>
        </td>
		<td align="center" valign="bottom" bgcolor="#FF9900" width="211" height="19">
			<font face="Verdana" size="2"><b>Password</b></font>
        </td>
     </tr>
<%
		while(rs.next())
		{
			count++;
			uname=rs.getString("username");
			pwd=rs.getString("password");
			fname=rs.getString("fname");
			lname=rs.getString("lname");
			student_flag= true;
		
%>
   <tr>
	  <td width="250" align="left">
		<font size="2" face="verdana"><%=fname%>&nbsp;&nbsp;<%=lname%></font></td>
	  <td width="250" align="left">
		<font size="2" face="verdana"><%=uname%></font></td>
      <td width="250" align="left">
		<font size="2" face="verdana"><%=pwd%></font></td>
   </tr>
<%
		  }
		rs.close();
	
%>
    </td>
    </tr>
	<tr><td>&nbsp;</td></tr>
    <tr bgcolor="#FF9900">
	 <td colspan="6" width="100%" align="left">
		<font face="Verdana" size="2">Total number of students is <b><%=count%></b></font></td>
   </tr>
</table>

<%
if(student_flag==false)
{
%>
<table width="100%">
    <tr>
        <td colspan="6" width="100%" height="18">
			<CENTER><b><font face="verdana" color="#800080" size="2">Presently there are no Students.</font></b></CENTER>
        </td>
    </tr>
<%
}
%>
    <tr>
        <td width="100%">
            <p align="center"><span style="font-size:10pt;"><font face="Verdana">
<%
}
catch(Exception e)
{
	ExceptionsFile.postException("accounts/StudentProfile.jsp","Operations on database ","Exception",e.getMessage());
 out.println(e);
}
finally
{
	try{
         rs.close();
         st.close();
		 con.close();
	}catch(Exception e){
		ExceptionsFile.postException("accounts/StudentProfile","closing statement,resultset and connection objects","Exception",e.getMessage());
	}
}
%>
            
    </tr>
</table>
</body>
</html>
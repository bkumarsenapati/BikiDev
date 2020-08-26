<%@  page language="java"  import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@ include file="/common/checksession.jsp" %> 	

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0"><meta name="author" content="Hotschools, Inc. ">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Teachers</title>
</head>
<body>
<%
    String school_id,tname,tid,password,course_name,class_id,schoolid,sname;
    Connection con=null;
	ResultSet rs=null,rs1=null,rs2=null;
	Statement st=null;
	Hashtable teach_profile=null;
	Hashtable class_ids=null; 
	boolean teacher_flag=false;
	int count=0;
%>

<%
   school_id=request.getParameter("schoolid");
   sname=request.getParameter("sname");
  try
    {
		teach_profile = new Hashtable();
		con = con1.getConnection();
		st=con.createStatement();
		rs=st.executeQuery("select * from teachprofile where schoolid='"+school_id+"' order by username");
					
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
	   <td width="358" height="20%" align="center" valign="middle" colspan="3" >
              
			  
                <p align="left"><font face="Verdana" size="2" ><b>School Name : 
                </font><font size="2" face="Verdana"><%=sname%></b></font> 
       </td>
	   <td align="center" colspan="3" >
		<p align="right"><b><font face="Verdana" size="2">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a target="_self" href="slist.jsp"><< Back</a></font></b></td>
    </tr>
</table>

<table border="1" width="95%" cellspacing="1" bordercolordark="#FFFFFF" align="center" height="68">
	<tr>             
		<td align="center" valign="bottom" bgcolor="#0099FF" colspan="6" width="928" height="15">
			<font color="#FFFFFF">
			<font face="Verdana" size="2" ><b>Teacher Details</b></font></font></td>
	</tr>
	<tr>          
		<td align="center" bgcolor="#0099FF" width="300" height="19">
			<font color="#FFFFFF" face="Verdana" size="2"><b>Teacher Name</b></font>
		</td>
		<td align="center" bgcolor="#0099FF" width="197" height="19" >
			<font color="#FFFFFF" size="2" face="Verdana"><b>Teacher Id</b></font></td>
        <td valign="bottom" align="center" bgcolor="#0099FF" width="211" height="19" >
			<font face="Verdana" color="#FFFFFF" size="2"><b>Password</b></font>
        </td>
        
	</tr>
<%
		teacher_flag= false;
		
		while(rs.next())
		{
			count++;
			teacher_flag= true;
%>
   <tr>
      <td align="left" width="300"><font size="2" face="verdana"><%=rs.getString("firstname") %>&nbsp;<%=rs.getString("lastname")%></font></td>
	  <td align="left"><font size="2" face="verdana"><%=rs.getString("username")%></font></td>
      <td align="left"><font size="2" face="verdana"><%=rs.getString("password")%></font></td>
	  </tr>
<%
		}
%>
    </td>
    </tr>
	<tr>
		<td align="left" colspan="6">&nbsp;</td>
	</tr>
	<tr bgcolor="#0099FF">
		<td align="left" colspan="6">
			<font size="2" face="verdana" color="white">Total number of teachers is <b><%=count%></b></font></td>
		</td>
	</tr>

</table>
<%
		if(teacher_flag==false)
		{
%>
		<table width="100%">
			<tr>
				<td width="100%" height="18" align="center">
					<CENTER><b><font face="verdana" size="2" color="#800080">Presently there are no teachers.</font></b></CENTER>
		        </td>
			</tr>
<%
		}
%>
			<tr>
				<td width="100%" align="center">
					<font face="Verdana" size="10">
<%
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("accounts/TeacherProfile.jsp","Operations on database ","Exception",e.getMessage());
		out.println(e);
	}
	
	finally
	{
		try
		{
			rs.close();
			st.close();
			con.close();
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("accounts/TeacherProfile.jsp","closing statement,resultset and connection objects","Exception",e.getMessage());
			System.out.println("Connection close failed");
		}
	}
%>
			</tr>
</table>

</body>
</html>
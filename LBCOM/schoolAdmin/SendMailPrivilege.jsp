<%@  page language="java"  import="java.sql.*,java.lang.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ include file="/common/checksession.jsp" %> 	

<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<% 
	String schoolId="",userId="",userType="",toUser="",toSchool="",toGroup="",toAdmin="";
	Connection con=null;
	ResultSet rs=null;
	Statement st=null,st2=null;
%>
<%
try{
	userId=(String)session.getAttribute("emailid");
	schoolId=(String)session.getAttribute("schoolid");
	userType=request.getParameter("type");
	if(userType!=null)
	{
                toSchool=request.getParameter("toschool");
		toUser=request.getParameter("touser");
		toGroup=request.getParameter("togroup");
		toAdmin=request.getParameter("toadmin");
		if(toAdmin==null)
		    toAdmin="no";
		con = con1.getConnection();
		st=con.createStatement();		
                st2=con.createStatement();
		rs=st.executeQuery("select * from mail_priv where from_school='"+schoolId+"' and from_user='"+userType+"'");
		if(rs.next())
		{
		   st2.executeUpdate("update mail_priv set to_user='"+toUser+"', to_school='"+toSchool+"', to_group='"+toGroup+"', to_admin='"+toAdmin+"' where from_school='"+schoolId+"' and from_user='"+userType+"'");
		}else{
		   st2.executeUpdate("insert into mail_priv values('"+schoolId+"','"+toSchool+"','"+userType+"','"+toUser+"','"+toGroup+"','"+toAdmin+"')");
		}
        }
}
catch(Exception ex)
{
	ExceptionsFile.postException("SendMailPrivilege.jsp","creating statement and connection objects","Exception",ex.getMessage());
}
finally
{
	try
	{
		if(con!=null)
			con.close();
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("SendMailPrivilege.jsp","operations on database","Exception",e.getMessage());
	}
}
%>

<HTML>
<HEAD>
<TITLE>www.hotschools.net</TITLE>
</HEAD>
<body>
<br>
<table width="100%">
<tr><td width="100%" align="center">
<table width=250>
	<tr>
	<td bgcolor="#EEBA4D" align="center"><b>Define Mail Sending Privilege</b></td>
	</tr>
</table>
</td>
</tr>
</table>
<br><br><br>
<div align="center">
<table width="150" border="1" cellpadding="0" cellspacing="0" >
	<tr>
	<td width=30>&nbsp;<img src="images/AddEditUserpage_htm_smartbutton2.gif"></td>
	<td width=120 height="25"><P align="left"><b><font face="Verdana" size="2"><a style="color: blue; text-decoration: none">&nbsp;</a><A style="COLOR: blue; TEXT-DECORATION: none" 
href="DefineSendMailPrivilege.jsp?type=student" face="Verdana" size="10 pts" ><font>Students</A></font></b></P></td>
	</tr>
	<tr>
	<td>&nbsp;<img src="images/AddEditUserpage_htm_smartbutton2.gif"></td>
	<td height="25"><P align="left"><b><font face="Verdana" size="2"><a style="color: blue; text-decoration: none">&nbsp;</a><A style="COLOR: blue; TEXT-DECORATION: none" 
href="DefineSendMailPrivilege.jsp?type=teacher" face="Verdana" size="10 pts" ><font>Teachers</A></font></b></P></td>
	</tr>
</table>
</div>
<body>
</HTML>


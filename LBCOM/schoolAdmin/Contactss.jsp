<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Namo WebEditor v5.0"><meta name="author" content="Hotschools, Inc. ">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
</head>

<body>
 
<%@  page language="java"  import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String user="",cemail="",fname="",mname="",lname="",type="",schoolid="",username="";
    Connection con=null;ResultSet rs=null;Statement st=null;
%>

<% user=request.getParameter("userid");
   schoolid=request.getParameter("schoolid");
 %>
<script>
function details(ce)
{
  window.open("../schoolAdmin/ContactDetailss.jsp?schoolid=<%= schoolid %>&userid=<%= user %>&cemail="+ce,"win",320,320);
}
</script>
<table align="center" border="0" cellpadding="0" cellspacing="0" width="90%">
    <tr>
        <td width="968">
            <div align="right">
<table border="0" cellpadding="0" cellspacing="0" width="528">
<tr><td align="right" width="250"></td>
<td align="right" width="278"><font face="verdana" size="2"><b><a href="../schoolAdmin/ContactsMain.jsp?userid=<%= user %>&amp;schoolid=<%= schoolid %>" style="color: #000080;Text-decoration:none">&lt;&lt;BACK</a></b></font></td>
</tr></table>
 
            </div>
        </td>
    </tr>
    <tr>
        <td width="968">
            <p align="center"><% try
    {
		con = con1.getConnection();
		st=con.createStatement();
   
      rs=st.executeQuery("select * from studentprofile where schoolid='"+schoolid+"' and crossregister_flag<2");
   

    if(rs.next())
    {
    
     fname=rs.getString("fname");
     
     lname=rs.getString("lname");
      cemail=rs.getString("con_emailid");
	  username=rs.getString("username");
     
%>
  
<font color="#000000" size="4" face="verdana"><B>Students Contact Information</B> <br>&nbsp;</font></td>
    </tr>
    <tr>
        <td width="968"><table border="0" cellpadding="0" cellspacing="0" width=650 align="center">
    <tr>
      
      <th width="10" style="background-color: #F0B850" align="left"><font color="#F0B850">&nbsp;</font></th>
      <th width="150" style="background-color: #F0B850" align="left"><font color="#000000" size="2" face="Verdana">Email</font></th>
      <th width="150" style="background-color: #F0B850" align="left"><font color="#000000" size="2" face="Verdana">First
        Name</font></th>
      
      <th width="150" style="background-color: #F0B850" align="left"><font color="#000000" size="2" face="Verdana">Last
        Name</font></th>
     
    </tr>
    <tr>
      <td width="10" align="left"></td>
      <td width="150" align="left"><font size="2" face="verdana"><a href="mailto:<%= cemail %>" style="text-decoration:none;color:blue"><%= cemail %></a></font></td>
      <td width="150" align="left"><font size="2" face="verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:details('<%= username %>');" style="text-decoration:none;color:blue"><%= fname %></a></font></td>
      
      <td width="150" align="left"><font size="2" face="verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= lname %></font></td>

      
    </tr>
<%
  while(rs.next())
{
       fname=rs.getString("fname");
     
     lname=rs.getString("lname");
      cemail=rs.getString("con_emailid");
     	  username=rs.getString("username");

   
%>

        <tr>
      
      <td width="10" align="left"></td>
      <td width="200" align="left"><font size="2" face="verdana"><a href="mailto:<%= cemail %>" style="text-decoration:none;color:blue"><%= cemail %></a></font></td>
      <td width="150" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="2" face="verdana"><a href="javascript:details('<%= username %>');" style="text-decoration:none;color:blue"><%= fname %></a></font></td>
      
      <td width="150" align="left"><font size="2" face="verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= lname %></font></td>
     
    </tr>


<%
}
%>
</table></td>
    </tr>
    <tr>
        <td width="968"><hr>
        </td>
    </tr>
    <tr>
        <td width="968"><span style="font-size:10pt;"><font face="Verdana"><%
}
else
{
%>
            </font></span></td>
    </tr>
    <tr>
        <td width="968"><p align="center"><b><font face="Verdana" color="#800080"><span style="font-size:10pt;">You Don't have
Any Contacts of Type student</span></font></b><span style="font-size:10pt;"><font face="Verdana"><%
}
}
catch(Exception e)
{
	ExceptionsFile.postException("Contactss.jsp","Operations on database ","Exception",e.getMessage());
 out.println(e);
}
finally
{
	try{
		if(con!=null)
			con.close();
	}catch(Exception e){
		ExceptionsFile.postException("Contactss.jsp","closing connection object","Exception",e.getMessage());
		System.out.println("Connection close failed");
	}
}
%>
            </font></span></p>

        </td>
    </tr>
</table>
<p>&nbsp;</p>
&nbsp;<center> &nbsp;</center><br>

  
<p>&nbsp;</p>
<p>&nbsp;</p>
&nbsp;<p align="center">&nbsp;</p>

&nbsp;</body>

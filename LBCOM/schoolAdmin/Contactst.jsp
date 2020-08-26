<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Namo WebEditor v5.0"><meta name="author" content="Hotschools, Inc. ">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
</head>

<body>
 
<p>
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
  window.open("../schoolAdmin/ContactDetailst.jsp?schoolid=<%= schoolid %>&userid=<%= user %>&cemail="+ce,"win",250,250);
}
</script>
</p>
<table border="0" align="center" cellpadding="0" cellspacing="0" width="90%">
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
            <p align="center">

<font color="#000000" size="4" face="verdana"><B>Teachers Contact Information</B></font><% try
    {
		con = con1.getConnection();    

    st=con.createStatement();
   
      rs=st.executeQuery("select * from teachprofile where schoolid='"+schoolid+"'");
   

    if(rs.next())
    {
    
     fname=rs.getString("firstname");
     
     lname=rs.getString("lastname");
      cemail=rs.getString("con_emailid");
	  username=rs.getString("username");
     
%><br>&nbsp;
  
            </p>
        </td>
    </tr>
    <tr>
        <td width="968"><table border="0" cellpadding="0" cellspacing="0" width=650 align="center">
    <tr>
      
      <th width="10" style="background-color: #FOB850" align="left" bgcolor="#F0B850">&nbsp;</th>
      <th width="150" style="background-color: #FOB850" align="left" bgcolor="#F0B850"><font color="#282858" size="2" face="verdana">Email</font></th>
      <th width="150" style="background-color: #FOB850" align="left" bgcolor="#F0B850"><font color="#282858" size="2" face="verdana">First
        Name</font></th>
      
      <th width="150" style="background-color: #FOB850" align="left" bgcolor="#F0B850"><font color="#282858" size="2" face="verdana">Last
        Name</font></th>
     
    </tr>
    <tr>
      <td width="10" align="left"></td>
      <td width="150" align="left"><font size="2" face="verdana"><a href="mailto:<%= cemail %>" style="text-decoration:none;color:blue"><%= cemail %></a></font></td>
      <td width="150" align="left"><font size="2" face="verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:details('<%= username %>');" style="text-decoration:none;color:blue"><%= fname %></a></font></td>
      
      <td width="150" align="left"><font size="2" face="verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= lname %></font></td>

      
    </tr>
<%
  while(rs.next())
{
     fname=rs.getString("firstname");
     
     lname=rs.getString("lastname");
      cemail=rs.getString("con_emailid");
	  username=rs.getString("username");
   
%>

        <tr>
      
      <td width="10" align="left"></td>
      <td width="200" align="left"><font size="2" face="verdana"><a href="mailto:<%= cemail %>" style="text-decoration:none;color:blue"><%= cemail %></a></font></td>
      <td width="150" align="left"><font size="2" face="verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:details('<%= username %>');" style="text-decoration:none;color:blue"><%= fname %></a></font></td>
      
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
        <td width="968"><%
}
else
{
%>
        </td>
    </tr>
    <tr>
        <td width="968"><p align="center"><b><font face="verdana" color="#800080" size="2">You Don't have
Any Contacts of Type teacher</font></b><%
}
}
catch(Exception e)
{
	ExceptionsFile.postException("Contactst.jsp","Operations on database ","Exception",e.getMessage());
    out.println(e);
}
finally
{
	try{
		if(con!=null)
			con.close();
	}catch(Exception e){
		ExceptionsFile.postException("Contactst.jsp","Closing connection objects","Exception",e.getMessage());
		System.out.println("Connection close failed");
	}
}
%>
</p>

        </td>
    </tr>
</table>
</body>

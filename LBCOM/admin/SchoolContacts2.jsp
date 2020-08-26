<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0"><meta name="author" content="Hotschools, Inc. ">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
</head>

<body>
 
<%@  page language="java"  import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%!
    String schoolid,emailaddress,firstname,middlename,lastname,type,schoolname,ce;
    Connection con;ResultSet rs;Statement st;
%>


<script>
function delet(fn1,sn1){


if (confirm("Are you sure, you want to delete?")){
	window.location.href="/LBCOM/demo/DeleteSchoolContact.jsp?firstname="+fn1+"&schoolname="+sn1;
}else{
	return false;
}
 }
function details(sn,fn)
{
  window.open("/LBCOM/demo/SchoolContactDetails.jsp?firstname="+fn+"&schoolname="+sn,"win",320,320);
}
</script>
 
 <%
   try
    {
		con = con1.getConnection();
      st=con.createStatement();
      rs=st.executeQuery("select * from schoolregistration");
   

    if(rs.next())
    {
     firstname=rs.getString(2);
     lastname=rs.getString(4);
     emailaddress=rs.getString(6);
	 schoolname=rs.getString(7);
%>
<p align="center"> <font color="#000000" size="4" face="verdana"><B>Schools Contacts Information</B></font></p>
  
<table border="0" cellpadding="0" cellspacing="0" width="90%" align="center">
    <tr>
	<!--<td width="25" style="background-color: #F0B850" align="left" bgcolor="#F0B850"><p align="center"><b><font color="#282858" face="Verdana"><span style="font-size:10pt;">Actions</span></font><span style="font-size:10pt;"><font face="Verdana"></font></span></b></td>-->
	<td width="10" style="background-color: #F0B850" align="left" bgcolor="#F0B850"><p align="center"><b><font color="#282858" face="Verdana"><span style="font-size:10pt;">
    Actions</span></font><span style="font-size:10pt;"><font face="Verdana"></font></span></b></td>


    <td width="200" style="background-color: #F0B850" align="left" bgcolor="#F0B850"><p align="center"><font color="#282858" face="Verdana"><span style="font-size:10pt;">
    School Name</span></font></td>
	<td width="150" style="background-color: #F0B850" align="left" bgcolor="#F0B850"><p align="center"><font color="#282858" face="Verdana"><span style="font-size:10pt;">
    First Name</span></font></td>
    <td width="150" style="background-color: #F0B850" align="left" bgcolor="#F0B850"><p align="center"><font color="#282858" face="Verdana"><span style="font-size:10pt;">
    Last Name</span></font></td>
    <td width="150" style="background-color: #F0B850" align="left" bgcolor="#F0B850"><p align="center"><font color="#282858" face="Verdana"><span style="font-size:10pt;">
    emailaddress</span></font></td>
    </tr>
    <tr>
      <td width="10" align="left"><b><font color="blue"></font><a href="javascript://" onclick="delet('<%=firstname%>','<%=schoolname%>');return false;"><font size="2" face="verdana" style="text-decoration:none;color:blue"><b>
      Delete</b></font></a></td>
	  <td width="200" align="left"><font size="2" face="verdana"><a href="javascript:details('<%=schoolname%>','<%=firstname%>');" style="text-decoration:none;color:blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=schoolname%></font></td>
      <td width="150" align="left"><font size="2" face="verdana">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= firstname %></a></font></td>
      <td width="150" align="left"><font size="2" face="verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=lastname%></font></td>
	  <td width="150" align="left"><font size="2" face="verdana"><a href="mailto:<%=emailaddress%>" style="text-decoration:none;color:blue"><%= emailaddress %></a></font></td>
   </tr>
   <%
  while(rs.next())
{
     
     firstname=rs.getString(2);
     lastname=rs.getString(4);
     emailaddress=rs.getString(6);
	 schoolname=rs.getString(7);
%>

  <tr>
       <td width="10" align="left"><a href="javascript://" onclick="delet('<%=firstname%>','<%=schoolname%>');return false;"><font size="2" face="verdana" style="text-decoration:none;color:blue"><b>
       Delete</b></font></a></td>
       <td width="200" align="left"><font size="2" face="verdana"><a href="javascript:details('<%= schoolname %>','<%= firstname %>');" style="text-decoration:none;color:blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= schoolname %></font></td>
       <td width="150" align="left"><font size="2" face="verdana">
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= firstname %></a></font></td>
       <td width="150" align="left"><font size="2" face="verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= lastname %></font></td>
       <td width="100" align="left"><font size="2" face="verdana"><a href="mailto:<%= emailaddress %>" style="text-decoration:none;color:blue"><%= emailaddress %></a></font></td>
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
        <td width="968" height="18"><p align="center"><b><font face="verdana" color="#800080"><span style="font-size:10pt;">You don't have any contacts....</span></font></b></p>

        </td>
    </tr>
    <tr>
        <td width="968">
            <p align="center"><span style="font-size:10pt;"><font face="Verdana"><%
}
}
catch(Exception e)
{
	ExceptionsFile.postException("SchoolContacts2.jsp","Operations on database ","Exception",e.getMessage());
 out.println(e);
}
finally
{
	try{
 rs.close();
 st.close();
 con.close();
	}catch(Exception e){
		ExceptionsFile.postException("SchoolContacts2.jsp","closing statement,resultset and connection objects","Exception",e.getMessage());
		System.out.println("Connection close failed");
	}
}
%>
            </td>
    </tr>
</table>
</body>
</html>
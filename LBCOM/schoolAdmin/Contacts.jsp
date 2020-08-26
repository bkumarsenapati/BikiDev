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
    String schoolid="",user="",cemail="",fname="",mname="",lname="",type="",schoolId="";
    Connection con=null;ResultSet rs=null;Statement st=null;
%>

<% 
   session= request.getSession();
   String sessid=(String)session.getAttribute("sessid");
   if (sessid==null)
   {
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
   }
   schoolId=(String)session.getAttribute("schoolid");
   user=request.getParameter("userid");
   schoolid=request.getParameter("schoolid");
   
 %>
<script>
function delet(cemail){


if (confirm("Are you sure, you want to delete?")){
	window.location.href="/LBCOM/schoolAdmin/DeleteContact.jsp?schoolid=<%= schoolid %>&userid=<%= user%>&cemail="+cemail;
}else{
	return false;
}
 }
function details(ce)
{
  window.open("/LBCOM/schoolAdmin/ContactDetails.jsp?userid=<%= user %>&cemail="+ce,"win",320,320);
}
</script>
 
<% try
    {
		con = con1.getConnection();
      st=con.createStatement();
      rs=st.executeQuery("select * from contacts where userid='"+user+"' and school_id='"+schoolId+"'");
   

    if(rs.next())
    {
     cemail=rs.getString(2);
     fname=rs.getString(3);
     mname=rs.getString(4);
     if(mname==null)
        mname=" ";
     lname=rs.getString(5);
     
%>
  
<table border="0" cellpadding="0" cellspacing="0" width="90%" align="center">
    <tr>
        <td width="968">
            <div align="right">
<table border="0" cellpadding="0" cellspacing="0" width="528">
<tr><td align="right" width="250"></td>
<td align="right" width="278">
                            <p align="center"><font face="verdana" size="2"><b><a href="../schoolAdmin/ContactsMain.jsp?schoolid=<%= schoolid %>&amp;userid=<%= user %>" style="color: #000080;Text-decoration:none">&lt;&lt; 
                            BACK</a></b></font></td>
</tr></table>
            </div>
        </td>
    </tr>
    <tr>
        <td width="968" align="center" valign="middle"><center> <font color="#000000" size="4" face="verdana"><B>Your 
Personal Contact Information<br>&nbsp;</B></font></center></td>
    </tr>
    <tr>
        <td width="968"><table border="0" cellpadding="0" cellspacing="0" width=650 align="center">
    <tr>
      <th width="94" style="background-color: #F0B850" align="left" bgcolor="#F0B850">
                        <p align="center"><b><font color="#282858" face="Verdana"><span style="font-size:10pt;">Actions</span></font><span style="font-size:10pt;"><font face="Verdana">
        </font></span></b></th>
      <th width="6" style="background-color: #F0B850" align="left" bgcolor="#F0B850">
                        <p align="center"><span style="font-size:10pt;"><font face="Verdana">&nbsp;</font></span></th>
      <th width="150" style="background-color: #F0B850" align="left" bgcolor="#F0B850">
                        <p align="center"><font color="#282858" face="Verdana"><span style="font-size:10pt;">Email</span></font></th>
      <th width="150" style="background-color: #F0B850" align="left" bgcolor="#F0B850">
                        <p align="center"><font color="#282858" face="Verdana"><span style="font-size:10pt;">First
        Name</span></font></th>
      <th width="100" style="background-color: #F0B850" align="left" bgcolor="#F0B850">
                        <p align="center"><font color="#282858" face="Verdana"><span style="font-size:10pt;">Middle
        Name</span></font></th>
      <th width="150" style="background-color: #F0B850" align="left" bgcolor="#F0B850">
                        <p align="center"><font color="#282858" face="Verdana"><span style="font-size:10pt;">Last
        Name</span></font></th>
     
    </tr>
    <tr>
      <td width="94" align="left"><a href="/LBCOM/schoolAdmin/EditContact.jsp?schoolid=<%= schoolid %>&amp;userid=<%= user%>&cemail=<%= cemail%>" style="text-decoration:none;color:blue"><b><font face="verdana" size="2">Edit</font></b></a><b><font face="Verdana" color="blue"><span style="font-size:10pt;">/</span></font></b><font color="blue">
        </font><a href="javascript://" onclick="delet('<%=cemail%>');return false;"><font size="2" face="verdana" style="text-decoration:none;color:blue"><b>Delete</b></font></a></td>
	  <!--<td width="94" align="left"><a href="../schoolAdmin/EditContact.jsp?schoolid=<%= schoolid %>&amp;userid=<%= user%>&cemail=<%= cemail%>" style="text-decoration:none;color:blue"><b><font face="verdana" size="2">Edit</font></b></a>
<b><font face="Verdana" color="blue"><span style="font-size:10pt;">/</span></font></b><font color="blue">
        </font><a href="../schoolAdmin/DeleteContact.jsp?schoolid=<%= schoolid %>&amp;userid=<%= user%>&amp;cemail=<%=cemail%>"><font size="2" face="verdana" style="text-decoration:none;color:blue"><b>Delete</b></font></a></td>-->
      <td width="6" align="left"></td>
      <td width="150" align="left"><font size="2" face="verdana"><a href="mailto:<%= cemail %>" style="text-decoration:none;color:blue"><%= cemail %></a></font></td>
      <td width="150" align="left"><font size="2" face="verdana"><a href="javascript:details('<%= cemail %>');" style="text-decoration:none;color:blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= fname %></a></font></td>
      <td width="100" align="left"><font size="2" face="verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= mname %></font></td>
      <td width="150" align="left"><font size="2" face="verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= lname %></font></td>

      
    </tr>
<%
  while(rs.next())
{
     cemail=rs.getString(2);
     fname=rs.getString(3);
     mname=rs.getString(4);
     if(mname==null)
        mname=" ";
     lname=rs.getString(5);
   
%>

        <tr>
       <td width="94" align="left"><a href="/LBCOM/schoolAdmin/EditContact.jsp?schoolid=<%= schoolid %>&amp;userid=<%= user%>&cemail=<%= cemail%>" style="text-decoration:none;color:blue"><b><font face="verdana" size="2">Edit</font></b></a><a style="text-decoration:none;color:blue"><b><font face="verdana" size="2"> 
                        </font></b></a><b><font face="Verdana" color="blue"><span style="font-size:10pt;">/</span></font></b>
        <a href="javascript://" onclick="delet('<%=cemail%>');return false;"><font size="2" face="verdana" style="text-decoration:none;color:blue"><b>Delete</b></font></a></td>
      <td width="6" align="left"></td>
      <td width="150" align="left"><font size="2" face="verdana"><a href="mailto:<%= cemail %>" style="text-decoration:none;color:blue"><%= cemail %></a></font></td>
      <td width="150" align="left"><font size="2" face="verdana"><a href="javascript:details('<%= cemail %>');" style="text-decoration:none;color:blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= fname %></a></font></td>
      <td width="100" align="left"><font size="2" face="verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= mname %></font></td>
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
	ExceptionsFile.postException("Contacts.jsp","Operations on database ","Exception",e.getMessage());
 out.println(e);
}
finally
{
	try{
		if(st!=null)
		 st.close();
		if(con!=null)
		 con.close();
	}catch(Exception e){
		ExceptionsFile.postException("Contacts.jsp","closing statement,resultset and connection objects","Exception",e.getMessage());
		System.out.println("Connection close failed");
	}
}
%>
            </font></span><b><font face="Verdana"><a href="../schoolAdmin/AddContact.jsp?schoolid=<%= schoolid %>&amp;userid=<%= user%>" style="color:blue;text-decoration:none"><span style="font-size:10pt;">Add
New Personal Contact</span></a></font></b></td>
    </tr>
</table>
</body>
</html>

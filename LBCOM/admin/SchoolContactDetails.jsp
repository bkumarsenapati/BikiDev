<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Namo WebEditor v5.0"><meta name="author" content="Hotschools, Inc. ">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>School Contact Details</title>
</head>

<body>
 
<%@  page language="java"  import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%! String emailaddress,firstname,middlename,lastname,schooladdress,address2,state,country,schoolemailid,fax,salutation,phone,website;
    String schoolname,title,description,schooltype;

    Connection con;ResultSet rs;Statement st;
   
%>
<%
    
	session=request.getSession();
	String uname=(String)session.getAttribute("uname");
	if (uname==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
%>

<% 
   firstname=request.getParameter("firstname");
   schoolname=request.getParameter("schoolname");
   
   try
    {
		con = con1.getConnection();
		st=con.createStatement();
		
    rs=st.executeQuery("select * from schoolregistration where firstname='"+firstname+"' and schoolname='"+schoolname+"'");
    if(rs.next())
    {
	  salutation=rs.getString(1);	 
     firstname=rs.getString(2);
     middlename=rs.getString(3);
     if(middlename==null)
        middlename=" ";
     lastname=rs.getString(4);
	 title=rs.getString(5);
	 description=rs.getString(8);
	 schooltype=rs.getString(9);
	 schooladdress=rs.getString(10);
     address2=rs.getString(11);
     if(address2==null)
       address2=" ";
     phone=rs.getString(12);
     if(phone==null)
      {
       phone=" ";
      }
	  fax=rs.getString(13);
     if(fax==null)
       fax=" ";
     state=rs.getString(14);
     country=rs.getString(15);  
     
     schoolemailid=rs.getString(16);  
     website=rs.getString(17);
	 if(website==null)
       website="";
  }
  }
catch(Exception e)
{
	 ExceptionsFile.postException("SchoolContactDetails.jsp","operations on database","Exception",e.getMessage());
  out.println(e);
}
finally
{
	try{
  rs.close();
  st.close();
  con.close();
	}catch(Exception e){
		ExceptionsFile.postException("SchoolContactDetails.jsp","closing statement, connection and resultset objects","Exception",e.getMessage());
		System.out.println("Connection close failed");
	}
}
     
       %>

 
<table width="500">
<tr><td align="left" width="450">
<img border="0" height="43" src="../admin/images/hsn/logo.gif" width="208" height="56"></td>

<td align="left" width="50">
  <a href="javascript://" onclick="self.close();return false;" style="text-decoration:none;color=blue"><b><font face="Arial" size="3">Close</font></b></a></td>
</tr></table>

   <center> <font color="#800000"><b><font face="Arial" size="3"> Contact Information of <%= salutation %>. <%= firstname %> <%= lastname %> </font></b><br>
 </font> </center><br>

  <center><table border="1"  bordercolor="gray" cellpadding="0" cellspacing="0" width="290">
    <tr>
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">F
        Name</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= firstname %></font></td>
    </tr>
    <tr>
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">M
        Name</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= middlename %></font></td>
    </tr>
    <tr>
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">L
        Name</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= lastname %></font></td>
    </tr>
    
    <tr>
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">Title:</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= title %></font></td>
    </tr>
    <tr>
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">School Nmae:</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= schoolname %></font></td>
    </tr>
	<tr>
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">Description:</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= description %></font></td>
    </tr>
	 <tr>
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">School Type:</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= schooltype %></font></td>
    </tr>
	<tr>
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">Address1:</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= schooladdress %></font></td>
    </tr>
	<tr>
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">Address2:</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= address2 %></font></td>
    </tr>
	 <tr>
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">Phone:</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= phone %></font></td>
    </tr>
	<tr>
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">Fax:</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= fax %></font></td>
    </tr>
	<tr>
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">State:</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= state %></font></td>
    </tr>
    <tr>
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">Country:</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= country %></font></td>
    </tr>
    <tr>
	<td width="120" align="left"><b><font size="2" face="Arial" color="#800080">School MailId:</font></b></td>
	<td width="150" align="left"><font size="2" face="verdana"><a href="mailto:<%= schoolemailid %>" style="text-decoration:none;color:blue"><%= schoolemailid %></a></font></td>
	</tr>
    <tr>
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">Web Site:</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= website %></font></td>
    </tr>
    <tr>
      <td width="120" align="left"></td>
      <td width="170" align="left"></td>
    </tr>
  </table></center>
 
 
</body>
</html>

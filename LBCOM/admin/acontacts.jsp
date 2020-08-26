<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0"><meta name="author" content="Hotschools, Inc. ">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title><%=application.getInitParameter("title")%></title>
</head>

<body>
<%@  page language="java"  import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<table><tr><td  height="12"> 
            <img src="images/hsn/logo.gif"  border="0" width="204" height="42" ><td height="24" align="left">
            &nbsp;</td>
        <td width="387" height="24">
            &nbsp;</td>
        <td width="212" height="24">
            &nbsp;</td></tr>
		<tr>
	    <TD height="20" width="100%" bgcolor="#EEE0A1">&nbsp; </TD>

  </tr>

  <tr> 

    <TD height="20" width="100%" bgcolor="#EEBA4D">&nbsp;</TD>
  </tr></table>
<% 
	String username=null,password=null,pwd=null;
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
%>
<%
		
     username=request.getParameter("username");
     
	 pwd=request.getParameter("password");
     try
    {
		con = con1.getConnection();
		st=con.createStatement();
	rs=st.executeQuery("select password from contacts_admin where username='"+username+"'");
    if(rs.next())
    {
     password=rs.getString("password").trim();
	 if(pwd.equals(password))
		{
			session.putValue("uname",username);
        %><table border="0" cellpadding="0" cellspacing="0" width="20" align="center">
    <tr>
      
    <p align="left" width="212"><font face="Verdana"><a href="/LBCOM/admin/SchoolContacts.jsp?totrecords=&start=0" style="color:blue;text-decoration:none"><span style="font-size:10pt;"><b>Schools Contacts</b></span></a></font></p>
</table><%}
	else {
           %>
		   <table border="0" cellpadding="0" cellspacing="0" width="100%" height="0">
    <tr>
        <td width="100%" height="24">
            <p>
            <img src="images/hsn/logo.gif"  border="0" width="204" height="42" ></p>
        </td>
        <td width="100%" height="24">
            <p>&nbsp;</p>
        </td>
        <td width="100%" height="24">
            <p>&nbsp;</p>
        </td>
        <td width="100%" height="24" align="center" valign="top">
            <p align="left">&nbsp;</p>
        </td>
        
    </tr>
	<tr>
	    <TD height="20" width="100%" bgcolor="#EEE0A1">&nbsp; </TD>

  </tr>

  <tr> 

    <TD height="20" width="100%" bgcolor="#EEBA4D">&nbsp;</TD>
  </tr>

</table>
		                      
                        <td width="145"><font size="2" face="verdana" color="blue" align="center">Password wrong&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font> </td><p class="style7"><a href="index.html">login again</a></p>
              </div></td>
		 <% }
	}else
		{
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
	<tr>
	    <TD height="20" width="100%" bgcolor="#EEE0A1">&nbsp; </TD>

  </tr>

  <tr> 

    <TD height="20" width="100%" bgcolor="#EEBA4D">&nbsp;</TD>
  </tr>
</table><p class="style7">In valid login ,<a href="index.html"> login again</a></p>
		  <%}
		
         
	}    
catch(Exception e)
{
	 ExceptionsFile.postException("acontacts.jsp","operations on database","Exception",e.getMessage());
  out.println(e);
}
finally
{
	try{
		if(rs!=null)
		  rs.close();
		if(st!=null)
		  st.close();
		if(con!=null && !con.isClosed())
		  con.close();
	}catch(Exception e){
		ExceptionsFile.postException("acontacts.jsp","closing statement, connection and resultset objects","Exception",e.getMessage());
		System.out.println("Connection close failed");
	}
}
     
%>


</body>
</html>
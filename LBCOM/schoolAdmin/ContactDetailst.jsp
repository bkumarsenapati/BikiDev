<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Namo WebEditor v5.0"><meta name="author" content="Hotschools, Inc. ">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title><%=application.getInitParameter("title")%></title>
</head>

<body>
 
<%@  page language="java"  import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String schoolid="",user="",cemail="",fname="",mname="",lname="",address1="",address2="",phoner="",state="",zip="",phonew="",mobile="",fax="";
    Connection con=null;ResultSet rs=null;Statement st=null;
   
%>


<% user=request.getParameter("userid");
   cemail=request.getParameter("cemail");
   schoolid=request.getParameter("schoolid");
   try
    {
		con = con1.getConnection();
    st=con.createStatement();
    rs=st.executeQuery("select * from teachprofile where username='"+cemail+"' and schoolid='"+schoolid+"'");
    if(rs.next())
    {
    fname=rs.getString("firstname");
    
     lname=rs.getString("lastname");
     address1=rs.getString("address");
     address2="";
     zip=rs.getString("zip");
     phonew=rs.getString("phone");
     fax=rs.getString("fax");
     state=rs.getString("state"); 
    
    
    }
  }
catch(Exception e)
{
	ExceptionsFile.postException("ContactDetailst.jsp","operations on database","Exception",e.getMessage());
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
		ExceptionsFile.postException("ContactDetailst.jsp","closing resultset,statement and connection objects","Exception",e.getMessage());
		System.out.println("Connection close failed");
	}
}
     
       %>

 
<table width="500" align="center">
  <tr> 
    <td align="left" width="206"> <img border="0" src="../images/hsn/logo.gif"></td>
    <td align="left" width="282" valign="bottom"> 
      <div align="right"><a href="javascript:self.close();" style="text-decoration:none;color=blue"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#FF0000">Close</font></b></a></div>
    </td>
  </tr>
  <tr> 
    <td colspan=2 bgcolor="#FFCC33"> 
      <div align="center"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000">Contact 
        Information of <%= fname %> <%= lname %> </font></b></div>
    </td>
  </tr>
  <tr> 
    <td width="120" align="left" height="21"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000">First 
      Name</font></b></td>
    <td width="170" align="left" height="21"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000"><%= fname %></font></b></td>
  </tr>
  <tr> 
    <td width="120" align="left"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000">Last 
      Name</font></b></td>
    <td width="170" align="left"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000"><%= lname %></font></b></td>
  </tr>
  <tr> 
    <td width="120" align="left"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000">Address</font></b></td>
    <td width="170" align="left"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000"><%= address1 %> 
      </font></b></td>
  </tr>
  <tr> 
    <td width="120" align="left"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000">State</font></b></td>
    <td width="170" align="left"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000"><%= state %></font></b></td>
  </tr>
  <tr> 
    <td width="120" align="left"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000">Zip</font></b></td>
    <td width="170" align="left"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000"><%= zip %></font></b></td>
  </tr>
  <tr> 
    <td width="120" align="left"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000">Phone 
       </font></b></td>
    <td width="170" align="left"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000"><%= phonew %></font></b></td>
  </tr>
  <tr> 
    <td width="120" align="left"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000">Fax</font></b></td>
    <td width="170" align="left"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000"><%= fax %></font></b></td>
  </tr>
  <tr> 
    <td colspan=2 bgcolor="#FFCC33">&nbsp; </td>
  </tr>
</table> 
</body>
</html>

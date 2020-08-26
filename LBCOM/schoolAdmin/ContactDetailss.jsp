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
	String user="",schoolid="",cemail="",fname="",lname="",address1="",city="",state="",country="",zip="",phone="",fax="";
    Connection con=null;ResultSet rs=null;Statement st=null;
   
%>


<% user=request.getParameter("userid");
   cemail=request.getParameter("cemail");
   schoolid=request.getParameter("schoolid");
   try
    {
		con = con1.getConnection();
		st=con.createStatement();
    rs=st.executeQuery("select * from studentprofile where schoolid='"+schoolid+"' and username='"+cemail+"'");
    if(rs.next())
    {
		fname=rs.getString("fname");
		lname=rs.getString("lname");
		city=rs.getString("city");
		state=rs.getString("state");
		country=rs.getString("country");
		address1=rs.getString("address");
		zip=rs.getString("zip");
		phone=rs.getString("phone");
		fax=rs.getString("fax");
    }
  }
catch(Exception e)
{
  ExceptionsFile.postException("ContactDetailss.jsp","operations on database","Exception",e.getMessage());
  out.println(e);
}
finally
{
  try{
	  if (con!=null)
		  con.close();
  }catch(Exception e){System.out.println("Connection close failed");
  }

}
     
       %>

 
<table width="500" align="center">
  <tr> 
    <td align="left" width="208"> <img border="0" src="../images/hsn/logo.gif"></td>
    <td align="left" width="280" valign="bottom"> 
      <div align="right"><a href="javascript:self.close();" style="text-decoration:none;color=blue"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#FF0000">Close</font></b></a></div>
    </td>
  </tr>
  <tr bgcolor="#FFCC33"> 
    <td colspan=2> 
      <div align="center"><font color="#800000"><b><font face="Arial" size="3"> 
        <font size="2" color="#000000" face="Verdana, Arial, Helvetica, sans-serif">Contact 
        Information of  <%= fname %> <%= lname %></font></font></b> </font> 
      </div>
    </td>
  </tr>
  <tr> 
    <td width="208" align="left"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000">First 
      Name</font></b></td>
    <td width="280" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#000000"><%= fname %></font></b></td>
  </tr>
  <tr> 
    <td width="208" align="left"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000">Last 
      Name</font></b></td>
    <td width="280" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#000000"><%= lname %></font></b></td>
  </tr>
  <tr> 
    <td width="208" align="left"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000">Address</font></b></td>
    <td width="280" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#000000"><%= address1 %></font></b></td>
  </tr>
  <tr> 
    <td width="208" align="left"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000">City</font></b></td>
    <td width="280" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#000000"><%= city %></font></b></td>
  </tr>
  <tr> 
    <td width="208" align="left"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000">State</font></b></td>
    <td width="280" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#000000"><%= state %></font></b></td>
  </tr>
  <tr> 
    <td width="208" align="left"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000">Country</font></b></td>
    <td width="280" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#000000"><%= country %></font></b></td>
  </tr>
  <tr> 
    <td width="208" align="left"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000">Zip</font></b></td>
    <td width="280" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#000000"><%= zip %></font></b></td>
  </tr>
  <tr> 
    <td width="208" align="left"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000">Phone</font></b></td>
    <td width="280" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#000000"><%= phone %></font></b></td>
  </tr>
  <tr> 
    <td width="208" align="left"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000">Fax</font></b></td>
    <td width="280" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#000000"><%= fax %></font></b></td>
  </tr>
  <tr bgcolor="#FFCC33"> 
    <td colspan=2>&nbsp;</td>
  </tr>
</table>
 </body>
</html>

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
    String user="",cemail="",fname="",mname="",lname="",address1="",address2="",city="",state="",country="",zip="",phone="",extn="",mobile="",pager="",fax="";
	String schoolId="";
    Connection con=null;ResultSet rs=null;Statement st=null;
   
%>


<% user=request.getParameter("userid");
   cemail=request.getParameter("cemail");
   session=request.getSession();
   String sessid=(String)session.getAttribute("sessid");
   if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
   }
   schoolId=(String)session.getAttribute("schoolid");
	
   try
    {
		con = con1.getConnection();
		st=con.createStatement();
    rs=st.executeQuery("select * from contacts where userid='"+user+"' and contactemail='"+cemail+"' and school_id='"+schoolId+"'");
    if(rs.next())
    {
    fname=rs.getString(3);
     mname=rs.getString(4);
     if(mname==null)
        mname=" ";
     lname=rs.getString(5);
     address1=rs.getString(6);
     address2=rs.getString(7);
     if(address2==null)
       address2=" ";
     city=rs.getString(8);
     if(city==null)
      city=" ";
     state=rs.getString(9);
     country=rs.getString(10);
     zip=rs.getString(11);
     phone=rs.getString(12);
     if(phone==null)
      {
       phone=" ";
      }

     extn=rs.getString(13);
    if(extn==null)
      extn=" ";
    mobile=rs.getString(14);
    if(mobile==null)
      mobile=" ";
    pager=rs.getString(15);
    if(pager==null)
      pager=" ";
    fax=rs.getString(16);
     if(fax==null)
       fax=" ";
    }
  }
catch(Exception e)
{
	 ExceptionsFile.postException("ContactDetails.jsp","operations on database","Exception",e.getMessage());
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
		ExceptionsFile.postException("ContactDetails.jsp","closing statement, connection and resultset objects","Exception",e.getMessage());
		System.out.println("Connection close failed");
	}
}
     
       %>

 
<table width="500">
<tr><td align="left" width="450">
<img border="0" height="43" src="../images/hsn/logo.gif" width="208" height="56"></td>

<td align="left" width="50">
  <a href="javascript:self.close();" style="text-decoration:none;color=blue"><b><font face="Arial" size="3">Close</font></b></a></td>
</tr></table>

   <center> <font color="#800000"><b><font face="Arial" size="3"> Contact Information of Mr.<%= fname %> <%= lname %> </font></b><br>
 </font> </center><br>

  <center><table border="1"  bordercolor="gray" cellpadding="0" cellspacing="0" width="290">
    <tr>
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">F
        Name</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= fname %></font></td>
    </tr>
    <tr>
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">M
        Name</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= mname %></font></td>
    </tr>
    <tr>
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">L
        Name</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= lname %></font></td>
    </tr>
    <tr>
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">Address:</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= address1 %> ,<%= address2 %></font></td>
    </tr>
    <tr>
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">City:</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= city %></font></td>
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
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">Zip:</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= zip %></font></td>
    </tr>

    <tr>
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">Phone:</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= phone %></font></td>
    </tr>
	<tr>
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">Extn:</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= extn %></font></td>
    </tr>
    <tr>
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">Mobile:</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= mobile %></font></td>
    </tr>
    <tr>
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">Pager:</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= pager %></font></td>
    </tr>
    <tr>
      <td width="120" align="left"><b><font size="2" face="Arial" color="#800080">Fax:</font></b></td>
      <td width="170" align="left"><font face="Arial" size="2" color="#000080"><%= fax %></font></td>
    </tr>
    <tr>
      <td width="120" align="left"></td>
      <td width="170" align="left"></td>
    </tr>
  </table></center>
 
 
</body>
</html>

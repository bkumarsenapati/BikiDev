<%@  page language="java"  import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<html>
<head>
<title><%=application.getInitParameter("title")%></title>
</head>
<body> 
<%
	String user="",schoolid="",mode="",query="",fname="",lname="",emailid="",class1="",state="",country="",zip="",phone="",fax="";
    Connection con=null;ResultSet rs=null;Statement st=null;
	user=request.getParameter("userid");
	mode=request.getParameter("mode");
	schoolid=request.getParameter("schoolid");
	if(mode.equals("student"))
		query="select studentprofile.fname fname,studentprofile.lname lname ,studentprofile.con_emailid emailid,class_master.class_des class from studentprofile,class_master where studentprofile.schoolid='"+schoolid+"' and studentprofile.username='"+user+"' and studentprofile.grade=class_master.class_id";
	else
		query="select teachprofile.firstname fname,teachprofile.lastname lname ,teachprofile.con_emailid emailid,class_master.class_des class from teachprofile,class_master where teachprofile.schoolid='"+schoolid+"' and teachprofile.username='"+user+"'and teachprofile.class_id=class_master.class_id";
	try{
		con = con1.getConnection();
		st=con.createStatement();
		rs=st.executeQuery(query);
    if(rs.next())
    {
		fname=rs.getString("fname");
		lname=rs.getString("lname");
		emailid=rs.getString("emailid");
		class1=rs.getString("class");
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
        Information of  <%= fname%></font></font></b> </font> 
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
    <td width="208" align="left"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000">Email</font></b></td>
    <td width="280" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#000000"><%=emailid%></font></b></td>
  </tr>
  <tr> 
    <td width="208" align="left"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#000000">Class ID</font></b></td>
    <td width="280" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#000000"><%= class1 %></font></b></td>
  </tr>
 <tr bgcolor="#FFCC33"> 
    <td colspan=2>&nbsp;</td>
  </tr>
</table>
 </body>
</html>

<%@ page language="java" %>
<%@ page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.Date,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/TALRT/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="session" />

<% 
	String newsId="",title="",content="";
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	int count=0;

	try
	{
		con= db.getConnection();
		st=con.createStatement();

		rs=st.executeQuery("select * from lb_news where status=1 order by news_id desc");
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title></title>
</head>

<body>
<p>&nbsp;</p>

<table border="0" cellpadding="0" cellspacing="0" bordercolor="#111111" align="center" width="67%" height="180">
  <tr>
    <td width="2%" height="10"></td>
    <td width="99%" height="10" align="right">
    <a href='javascript:history.go(-1);'><font face="verdana" size="2"><b>Back</b></font></a></td>
    <td width="1%" height="10"></td>
  </tr>
  <tr>
    <td width="2%" height="149">&nbsp;</td>
    <td width="99%" height="149">

<%
		while(rs.next())
		{
			count++;
			newsId=rs.getString("news_id");
			title=rs.getString("title");
			content=rs.getString("content");
%>

	<a name="news<%=newsId%>">
	<table border="0" cellpadding="0" cellspacing="0" bordercolor="#111111" width="100%" height="62" align="center">
      <tr>
        <td width="100%" height="17"><b>
        <font face="Verdana" size="2" color="#800000"><%=title%></font></b></td>
      </tr>
      <tr>
        <td width="100%" height="44"><font face="Verdana" size="2"><%=content%></font></td>
      </tr>
    </table>
	<br>
  
<%
		}	
%>
  </td>
    <td width="1%" height="149">&nbsp;</td>
  </tr>
  <tr>
    <td width="2%" height="19">&nbsp;</td>
    <td width="99%" height="19">&nbsp;</td>
    <td width="1%" height="19">&nbsp;</td>
  </tr>
</table>

<%
	if(count==0)
	{
%>
 <p align="center"><font face="verdana" size="2">There are no News.</font></p>
<%
	}	
%>

</center>
</body>

<%
	}
	catch(Exception e)
	{
		System.out.println("The exception in News.jsp is..."+e);
	}
%>



</html>
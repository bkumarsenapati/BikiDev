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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Learnbeyond</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<link href="style/sheet1.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style26 {
	font-family: Verdana;
	font-size: 12px;
}
.style27 {
	color: #9a730a;
	font-weight: bold;
}

a:link {
	text-decoration: none;
	color: #000000;
}
a:visited {
	text-decoration: none;
	color: #000000;
}
a:hover {
	text-decoration: none;
	color: #CC0000;;
}
a:active {
	text-decoration: none;
	color: #CC0000;
}
-->
</style>
</head>

<body>
<p align="right"><a href='javascript:history.go(-1);'><font face="verdana" size="2"><<<b> BACK </b></font> </a></p>
<br>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
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
	}
	catch(Exception e)
	{
		System.out.println("The exception in News.jsp is..."+e);
	}
%>

</table></td>
  </tr>
</table>
</body>
</html>
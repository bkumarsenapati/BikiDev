<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Namo WebEditor v5.0"><meta name="author" content="Hotschools, Inc. ">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
</head>

<body>
<%@ page language="java"  import="java.sql.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<% String userid="",schoolid="",schoolId=""; %>
<%
    
	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if (sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
   schoolId=(String)session.getAttribute("schoolid");

   userid=request.getParameter("userid"); 
   schoolid=request.getParameter("schoolid");
%>
<br>
<br>
<table align="center" border="1" cellpadding="3" cellspacing="2" width="200" bordercolor="#FFCC33">
  <tr bgcolor="#FFCC33"> 
    <td width="200" colspan="2"> 
      <p align="center"> <font face="Verdana" color="#800080"><b><span style="font-size:11pt;"><font color="#000000">Contact 
        Types By</font></span></b></font></p>
    </td>
  </tr>
  <tr> 
    <td width="26" height="12" align="left" valign="middle"> 
      <p align="center"><font color="#000000"><span style="font-size:10pt;"><font face="Verdana"><i><font size="2"><b><font size="1">&gt;&gt;</font></b></font></i></font></span></font></p>
    </td>
    <td width="174" height="12"> 
      <p align="left"> <a href="../schoolAdmin/Contactst.jsp?schoolid=<%= schoolid %>&amp;userid=<%= userid %>" style="color:blue;text-decoration:none"><font face="Verdana"><span style="font-size:10pt;"><b>Teachers</b></span></font></a></p>
    </td>
  </tr>
  <tr> 
    <td width="26" height="12"> 
      <p align="center"><font color="#000000"><span style="font-size:10pt;"><b><font face="Verdana"><i><font size="1">&gt;&gt;</font></i></font></b></span></font></p>
    </td>
    <td width="174" height="12"> 
      <p align="left"> <font face="Verdana"><a href="../schoolAdmin/Contactss.jsp?schoolid=<%= schoolid %>&amp;userid=<%= userid %>" style="color:blue;text-decoration:none"><span style="font-size:10pt;"><b>Students</b></span></a></font></p>
    </td>
  </tr>
  <tr> 
    <td width="26" height="12"> 
      <p align="center"><font color="#000000"><span style="font-size:10pt;"><b><font face="Verdana"><i><font size="1">&gt;&gt;</font></i></font></b></span></font></p>
    </td>
    <td width="174" height="12"> 
      <p align="left"> <font face="Verdana"><a href="../schoolAdmin/Contacts.jsp?schoolid=<%= schoolid %>&amp;userid=<%= userid %>" style="color:blue;text-decoration:none"><span style="font-size:10pt;"><b>Personal</b></span></a></font></p>
    </td>
  </tr>
</table>
<p align="center">&nbsp;
</p>
<p align="center">&nbsp;
</p>
<p align="center">&nbsp;
</p>
<p align="center">&nbsp;

</p>

</body>

</html>


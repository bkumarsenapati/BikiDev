<%@ page language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%! String schoolid,schoolpass,tag,custom; %>
<%
schoolid=request.getParameter("schoolid");
schoolpass=request.getParameter("schoolpass");
//tag=request.getParameter("tag");
//custom = "admin$"+schoolid.trim()+"$school";
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Namo WebEditor v5.0"><meta name="author" content="Hotschoos, Inc.">
<title></title>
<script language="JavaScript">
<!--
function MM_reloadPage(init)
 {  //reloads the window if Nav4 resized
	if (init==true) with (navigator) 
	{
		if ((appName=="Netscape")&&(parseInt(appVersion)==4))
 		{
    		document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; 
		}
	}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) 
		location.reload();
}
MM_reloadPage(true);

</script>
</head>
<body style="font-family: Verdana" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<p align="center"><br><br><br></p>

<table align=center width="370">
<tr align=center>
      <td width="85">
            <p align="left">&nbsp;</td>
      <td width="107">
            <p align="left"><span style="font-size:10pt;"><font face="Arial"><b>Your Department ID</b></font></span></td>
      <td width="4">
            <p><b><span style="font-size:10pt;"><font face="Arial">:</font></span></b></p>
</td>
      <td width="156">
            <p align="left"><font face="Verdana" size="2" color="red"><b><%=schoolid%></b></font></td>
</tr>

<tr align=center>
      <td width="85">
            <p align="left">&nbsp;</td>
      <td width="107">
            <p align="left"><span style="font-size:10pt;"><font face="Arial"><b>Admin 
             ID</b></font></span></td>
      <td width="4">
            <p><b><span style="font-size:10pt;"><font face="Arial">:</font></span></b></p>
</td>
      <td width="156">
            <p align="left"><font face="Verdana" size="2" color="red"><b>admin </b></font></td>
</tr>


<tr align=center><td width="85">
            <p align="left">&nbsp;</td><td width="107">
            <p align="left"><font face="Verdana" size="2" font color="black"><b>Password</b></font></td><td width="4">
            <p><b><span style="font-size:10pt;"><font face="Arial">:</font></span></b></p>
</td><td width="156">
            <p align="left"><font face=verdana size=2 font color="red"><b><%=schoolpass%></b></font></td></tr>

    <tr>
		<td width="364" colspan="4">
            <p>&nbsp;</p>
		</td>
    </tr>
  <tr>
		<td width="364" colspan="4">
            <p align="justify"><span style="font-size:10pt;"><font face="Arial">Your 
            Department Administration Account has been created. Click the button below to Login...</font></span></p>
		</td>
    </tr>
    <tr>
		<td width="364" colspan="4">
            <form name="form1" action="/LBCOM/" target="_parent" method="post">
			<p align="right"><input type="submit" name="login" value="Login >>"></p>
            </form>
		</td>
    </tr>
    <tr>
		<td width="364" colspan="4">
            <p>&nbsp;</p>
		</td>
    </tr>
</table>
</body>
</html>

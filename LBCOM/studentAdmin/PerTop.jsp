<%
	String grade=null,subjId=null,subjStr=null;
%>
<%
	grade=(String)session.getAttribute("grade");
	subjId=(String)session.getAttribute("subjid");
	subjStr=(String)session.getAttribute("subjstr");
%>

<html>
<head>
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">

</head>

<body topmargin="3" leftmargin="3">
<table border="0" width="100%" cellspacing="1">
    <tr>
      <td width="100%" valign="middle" align="left" bgcolor="#FBF4EC"><font color="#800000" face="Arial"><b><a href="lcindex.htm" target="_parent"><span style="font-size:10pt;">Learning Center</span></a><span style="font-size:10pt;"> &nbsp;&gt;&gt;&nbsp;</span><a href="LCInner.jsp?subid=<%=subjId%>" target="_parent"><span style="font-size:10pt;"><%=subjStr%></span></a></b></font><span style="font-size:10pt;"><font face="Arial">  &nbsp;&gt;&gt;&nbsp;<b><a href="/LBCOM/pc/PerformanceIndex.jsp"	  target="bottom">Check your performance </a></b></font></span></td>


	  

    </tr>
</table>

</body>

</html>

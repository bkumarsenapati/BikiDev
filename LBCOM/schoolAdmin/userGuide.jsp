<%@ page language="java" import="java.io.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
String schoolid,userid;
%>
<%
schoolid=request.getParameter("schoolid");
userid=request.getParameter("userid");
session.putValue("schoolid",schoolid);
session.putValue("userid",userid);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Namo WebEditor v5.0"><meta name="author" content="Hotschools, Inc. ">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
</head>

<body>

<table border="0" width="100%">
  <tr>
    <td width="100%">
      <p class="MsoNormal" style="text-align:justify"><span style="font-size:10.0pt;
mso-bidi-font-size:12.0pt;font-family:Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      
      </span></p>
      <p class="MsoNormal" style="text-align:justify"><span style="font-size:10.0pt;
mso-bidi-font-size:12.0pt;font-family:Verdana">As an administrator you can learn
      and teach your teachers and students how to benefit from Hotschools, Inc. .
      To make you familiar with the flow of Hotschools, Inc.  services, are the
      three User Guides provided for your school
      administrators, teachers and students.<br>
      <br>
      School Administrators, Teachers
      and Students can access the User Guides to gain an in depth understanding of
      hotschools.net product features along with instructional guidance. You can
      either download the User Guides (Portable Document Format) or open them
      directly from the links provided.</span></p>
      <p class="MsoNormal" style="text-align:justify">&nbsp;</td>
  </tr>
  <tr>
    <td width="100%"><span style="font-size:10.0pt;
mso-bidi-font-size:12.0pt;font-family:Verdana"><b><a href="../manuals/admin_UG/">Administrator's User Guide<o:p>
      </a>
      </b></span>
      <p><span style="font-size:10.0pt;
mso-bidi-font-size:12.0pt;font-family:Verdana"><b>
      </o:p>
      </b></span></p>
    </td>
  </tr>
  <tr>
    <td width="100%"><span style="font-size:10.0pt;
mso-bidi-font-size:12.0pt;font-family:Verdana"><b><a href="../manuals/educator_UG/">Teacher's User Guide<o:p></a></b></span>
      <p><span style="font-size:10.0pt;
mso-bidi-font-size:12.0pt;font-family:Verdana"><b>
      </o:p>
      </b></span></p>
    </td>
  </tr>

	<tr>
    <td width="100%"><span style="font-size:10.0pt;
mso-bidi-font-size:12.0pt;font-family:Verdana"><b><a href="../manuals/learner_UG/">Student's User Guide <o:p></a><br>
      </b></span>
    <!--  <p><font size="2" face="Arial"><i><span style="mso-bidi-font-size: 12.0pt">To
      view the User Guides you need to have Adobe Acrobat Reader. </span>If not, download free
      Acrobat Reader <a href="http://www.adobe.com/products/acrobat/readstep.html"> <img src="images/getacro.gif" border=0 width="88" height="31"></a></i></font><i><span style="mso-bidi-font-size: 12.0pt"><font size="2" face="Arial"><b></o:p>
      </b></font></span></i>
    </td>
  </tr>-->
  <tr>
    <td width="100%"></td>
      
  </tr>
</table>

</body>

</html>

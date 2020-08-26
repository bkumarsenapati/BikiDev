<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="java.io.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
   String schoolId="",userId="",sessid="";
%>
<%
  schoolId=request.getParameter("schoolid");
  userId= request.getParameter("userid");
 
%>

<HTML>
<HEAD>
<TITLE><%=application.getInitParameter("title")%></TITLE>
<script type="text/javascript" src="/LBCOM/news/access.js"></script>
<SCRIPT LANGUAGE="JavaScript">

function cleardata()
{
	document.sub.reset();
	return false;
}
</script>

</HEAD>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
<form name="sub" enctype="multipart/form-data" action="UploadLogoFiles.jsp?mode=add" method="post" onsubmit="javascript: return view();">
 <BR><BR>

<BR>
<TABLE cellpadding="0" cellspacing="0" border="0" height="91" align="center">
<tr>
  <TD bgColor=#EEE0A1 height="34" width="73%" align="left"><font face="Arial"><span style="font-size:10pt;">&nbsp;<font face="arial" size="2">Attachment:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="file" id="logofile" name="logofile" size="20"></font></td>
    </tr>
	 
	<TR>
        <td width="73%" height="27" align="left" colspan="2" bgcolor="#EEE0A1"><font face="Arial"><span style="font-size:10pt;"><b>&nbsp;Note: </b>The size of the file should be <b> < 10MB</b></span></font></td>
    </TR> 
	
	<tr>
      <td bgColor=#EEBA4D height="30" width="73%">
      <p align="center">
		<input type="submit" value="Submit" name="B1">&nbsp;&nbsp; <input type="reset" value="Reset" name="B2" onClick="return cleardata();"></td>
    </tr>
	</table>

</form>
</BODY>
</HTML>

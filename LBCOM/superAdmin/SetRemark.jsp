<%@page language="java"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
  String remark="";
%>
<HTML>
<HEAD>
<title></title>

<SCRIPT LANGUAGE="JavaScript">
<!--
function setRemark()
{
	window.opener.document.sub.remarks.value=document.remarkfrm.remarks.value;
	window.close();
}
//-->
</SCRIPT>
</HEAD>

<%
	remark = request.getParameter("remark");
	if(remark.equals("null"))
	{
		remark="";
	}

%>

<BODY>
<form name="remarkfrm">
<font face="Arial" size="2">
	<b>Please enter your remarks here.</b>
<textarea rows="8" name="remarks" tabindex="1"><%=remark%></textarea><br><center>
<input type="image" src="../images/submit.gif" onclick="return setRemark();">
</font>
</form>
</BODY>
</HTML>

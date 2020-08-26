<%@page language="java" import="java.io.*,java.sql.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>

<%
String mode="",oldNbName="",nbDesc="";
%>
<HTML>
<HEAD>
<title></title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<SCRIPT LANGUAGE="JavaScript" SRC="../validationscripts.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
<!--
function isUserName(validateData){
	if(validateData==null || validateData.length==0){
			return false;
	}
	var charAta;
	for(var i=0;i<validateData.length;i++){
	charAta=validateData.charAt(i);
		if(!( (charAta>=0 && charAta<=9) || (charAta>='A' && charAta<='Z') || (charAta>='a' && charAta<='z') || (charAta=='_') || (charAta==' '))){
			alert("Enter valid Name");
			return false;
		}
	}
}

function validate(frm){
	frm.nbname.value=trim(frm.nbname.value);
	var title=frm.nbname.value;
	if(isUserName(title)==false){
			alert("Enter proper title.");
			frm.nbname.focus();
			return false;
		}
	frm.nbdesc.value=trim(frm.nbdesc.value);
	if(frm.nbdesc.value==""){
		alert("Enter description");
		frm.nbdesc.focus();
		return false;
	}
	var temp=frm.nbdesc.value;
	if(temp.indexOf('#')!=-1){
		alert("Remove # from description");
		frm.nbdesc.focus();
		return false;
	}
	//frm.nbname.disabled=false;
	replacequotes();
}
function goback(){
	document.location.href="NoticeBoards.jsp";
	return false;
}
//-->
</SCRIPT>
</HEAD>
<%
mode=request.getParameter("mode");
oldNbName=request.getParameter("oldname");
nbDesc=request.getParameter("desc");
String tag;
if(mode.equals("edit"))
	tag="Edit";
else
	tag="Create";
%>
<BODY bgcolor="white" text="black" link="blue" vlink="purple" alink="red"> 
<form name="frm1" action="/LBCOM/schoolAdmin.CreateEditNotice" method="post" onsubmit="return validate(this);">
<input type='hidden' name='mode' value='<%=mode%>'>
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="60%">
    <tr>
      <td width="100%" colspan="3" align='center'><font face="Arial Black" size="2"><%=tag%> Notice Board</font></td>
    </tr>
    <tr>
      <td width="100%" colspan="3"></td>
    </tr>
    <tr>
      <td width="40%" align="right"><font face="Arial" size="2">Enter Title&nbsp;</td>
      <td width="5%" align="center"><b><font face="Arial" size="3">:</font></b></td>
      <td width="55%">
	<%
		if(mode.equals("edit"))
			out.println("<input type='text' name='nbname' value=\""+oldNbName+"\" readonly>");
		else
			out.println("<input type='text' name='nbname' oncontextmenu=\"return false\" onkeydown=\"restrictctrl(this,event)\" onkeypress=\"return AlphaNumbersOnly(this, event)\">");
	%>
	  </td>
    </tr>
    <tr>
      <td width="40%" align="right" valign="top"><font face="Arial" size="2">Enter Description&nbsp;</td>
      <td width="5%" align="center" valign="top"><b><font face="Arial" size="3">:</font></b></td>
      
	  <%
	      
		//if(mode.equals("edit"))
		//	out.println("<textarea name='nbdesc' rows='5' cols='16'>"+nbDesc+"</textarea>");
		//else
		//	out.println("<textarea name='nbdesc' rows='5' cols='16'></textarea>");

		if(mode.equals("edit"))
		    out.println("<td width='55%'><input type='text' name='nbdesc' maxlength='50' value=\""+nbDesc.replaceAll("\"","&quot;")+"\" oncontextmenu=\"return false\" onkeydown=\"restrictctrl(this,event)\" onkeypress=\"return AlphaNumbersOnly(this, event)\"></td>");
		else
		    out.println("<td width='55%'><input type='text' name='nbdesc' maxlength='50' value=\"\" oncontextmenu=\"return false\" onkeydown=\"restrictctrl(this,event)\" onkeypress=\"return AlphaNumbersOnly(this, event)\"></td>");
	  %>
	 
    </tr>
    <tr><td>&nbsp;</td></tr>
    <tr><td width='100%' colspan='3' align='center'><input type='image' src='images/submit.gif'>&nbsp;<input type='image' src='images/cancel.gif' onclick="return goback();"></td></tr>
  </table>
  </center><P>
</form>
<p>&nbsp;</p>

</BODY>
</HTML>

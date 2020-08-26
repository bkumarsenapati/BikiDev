<html>

<head>
<title>.:: Welcome to www.hotschools.net ::. [ for quality eLearning experience ]</title>
<meta name="generator" content="Microsoft FrontPage 5.0">
<script language="JavaScript" src="validationscripts.js"></script>
<script language="JavaScript">


function validate(frm){

 		if(trim(frm.oldpwd.value)==""){
		alert("Please enter your current password");
		frm.oldpwd.focus();
		return false;
		}
	if(trim(frm.newpwd.value)==""){
		alert("Please enter your new password");
		frm.newpwd.focus();
		return false;
	}

	if(trim(frm.cnewpwd.value)==""){
		alert("Please confirm your new password");
		frm.cnewpwd.focus();
		return false;
	}
	//alert((frm.newpwd.value).length);
	if(frm.newpwd.value!=frm.cnewpwd.value)
	{
		alert("Your new password entries did not match");
		return false;
	}
	if((frm.newpwd.value).length<6)
	{
		alert("Password must be a minimum of 6 characters long");
		return false;
	 }
	return true;
}
</script>

<%
   String error = (String)request.getAttribute("error");
%>


</head>

<body onload="document.newhomepage.oldpwd.focus(); return false;">
<form name="newhomepage" method="post" target="_self" action="/LBCOM/ChangePassword" onsubmit="return validate(this);">

<TABLE cellSpacing=1 width=544 border="0" height="262" style="border-collapse: collapse" bordercolor="#111111">
	<TBODY>
		<TR bgColor="#a0b8c8">
			<TD colspan="4" align="left" bgcolor="#B0A890" width="532" height="24">
            <FONT face=arial color="#FFFFFF"><B>&nbsp;Change your Password</B></FONT></TD>
		</TR>
		<TR>
			<TD align="left" width="41" height="99">&nbsp;</TD>
			<TD align="left" bgcolor="#FFFFFF" colspan="3" width="485" height="99">
				<FONT face=arial size=-1><font color="#000080"><b>To better protect your account make sure that,</b></font><br><br>
				<font color="#008080">your password is memorable for you but difficult for others to guess. 
				<br>
				you do not share your password with anyone. 
				<br>
				your new password must be of minimum six characters long.
                </font>
				<br>
				</FONT>
			</TD>
		</TR>
<%        
	if("error".equals(error))
	{
		out.println("Sorry! You have entered a wrong password");
	}
	session.removeAttribute("error");
%>  	
		<tr>
			<td width="41" height="22">&nbsp;</TD>
			<td width="145" align="left" valign="bottom" bgcolor="#B0A890" height="22">
				<font face="Arial" color="#FFFFFF" size="2"><b>Current Password</b></font></td>
            <td width="334" align="left" valign="top" colspan="2" height="22"><input type="password" name="oldpwd" size="12"></td>
        </tr>
        <tr>
			<td width="41" height="22">&nbsp;</TD>
			<td width="145" align="left" valign="bottom" bgcolor="#B0A890" height="22">
				<font face="Arial" color="#FFFFFF" size="2"><b>New Password</b></font></td>
            <td width="334" align="left" valign="top" colspan="2" height="22"><input type="password" name="newpwd" size="12"></td>
        </tr>
        <tr>
			<td width="41" height="22">&nbsp;</TD>
			<td width="145" align="left" valign="bottom" bgcolor="#B0A890" height="22">
				<font face="Arial" color="#FFFFFF" size="2"><b>Confirm Password</b></font></td>
            <td width="334" align="left" valign="top" colspan="2" height="22"><input type="password" name="cnewpwd" size="12"></td>
		</tr>
        <tr>
			<td width="41" valign="bottom" height="37">&nbsp;&nbsp;&nbsp;</td>
            <td valign="bottom" colspan="3" width="485" height="37">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type='submit' name='button' value="Save" style="height: 21; width:60">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            	<input type="button" value="Cancel" name="Cancel" onclick="javascript:window.close()" style="height: 21;">
			</td>
        </tr>
</table>
</form>
</body>

</html>
<html>

<head>
<title>.:: Welcome to www.hotschools.net ::. [ for quality eLearning experience ]</title>
<meta name="generator" content="Namo WebEditor v5.0">
<script language="JavaScript" src="validationscripts.js"></script>
<script language="JavaScript">


function validate(frm){

 		if(trim(frm.oldpwd.value)==""){
		alert("Please enter current password");
		frm.oldpwd.focus();
		return false;
		}
	if(trim(frm.newpwd.value)=="")
	{
		alert("Please enter new password");
		frm.newpwd.focus();
		return false;
	}

	if(trim(frm.cnewpwd.value)=="")
	{
		alert("Please confirm your password");
		frm.cnewpwd.focus();
		return false;
	}
	//alert((frm.newpwd.value).length);
	if(frm.newpwd.value!=frm.cnewpwd.value)
	{
		alert("Password fields did not match. Please enter once again.");
		return false;
	}
	if((frm.newpwd.value).length<6)
	{
		alert("Password must be of atleast 6 characters long");
		return false;
	 }
	 window.opener.location="studentAdmin/modifyStudentReg.jsp?mode=modify";

	return true;
}
</script>

<%
   String error = (String)request.getAttribute("error");
%>


</head>

<body bgcolor="white" text="black" leftmargin="0" marginwidth="0" topmargin="0" marginheight="0" onload="document.newhomepage.oldpwd.focus(); return false;">
<form name="newhomepage" method="post" target="_self" action="/LBCOM/ChangePassword" onsubmit="return validate(this);">
<table border="0" width="400">
      
    <tr>
        <td width="125" height="36">
        </td>
        <td width="574" align="center" valign="middle" height="36">
	<font face="Arial" color="Red">
<TABLE cellSpacing=0 cellPadding=2 width=572 border=0 id="table1" >
  <TBODY>
  <TR bgColor=#eeeeee>
    <TD vAlign=center>&nbsp;</TD>
    <TD vAlign=center align=right>&nbsp;</TD></TR></TBODY></TABLE>
	<TABLE cellSpacing=0 cellPadding=4 width=573 bgColor=#eeeeee border=0 id="table2">
	  <TBODY>
	  <TR bgColor=#a0b8c8>
	    <TD align=left bgcolor="#FFCC66">
		<p align="center"><FONT face=arial size=4><B>Change your&nbsp; Password 
	      </B></FONT></TD></TR></TBODY>
	</TABLE>
	<TABLE cellPadding=2 width=574 bgColor=#eeeeee border=0 id="table3">
	 <TBODY>
	 <TR>
    <TD><FONT face=arial size=2>Enter your current password and then choose 
      your new password. Click <B>Save</B> to save Password</FONT></TD></TR></TBODY>
	</TABLE>
<TABLE cellSpacing=0 cellPadding=10 width=500 bgColor=#00FF99 border=0 id="table4">
  <TBODY>
  <TR>
    <TD align="left"><FONT face=arial size=-1><STRONG>Please Note:</STRONG> To better protect 
	your account, make sure that your password is memorable for you but 
	difficult for others to guess. Do not share your password with anyone, and 
	never use the same password that you've used in the past. For security 
	purposes, your new password must be a minimum of six characters long. 
  </FONT></TD></TR></TBODY>
</TABLE>
  <%        
	  if("error".equals(error))
	   {
  
  	   
	      out.println("  Wrong Password  ");
	     }
	     session.removeAttribute("error");
  %>  	
         </font>
        </td>
        
    </tr>
    <tr>
        <td width="50" height="124">
            
        </td>
        <td width="574" align="center" valign="middle">
            <table border="0">
                <tr>
                    <td width="150" align="left" valign="bottom" colspan="4">
                        <p><span style="font-size:9pt;"><font face="Arial"><b>
						Current Password</b></font></span></p>
                    </td>
                    <td width="150" align="left" valign="top"><input type="password" name="oldpwd" size="12"></td>
                </tr>
                <tr>
                    <td width="150" align="left" valign="bottom" colspan="4">
                        <p><span style="font-size:9pt;"><font face="Arial"><b>New Password</b></font></span></p>
                    </td>
               
                    <td width="150" align="left" valign="top"><input type="password" name="newpwd" size="12"></td>
                </tr>
                <tr>
                    <td width="150" align="left" valign="bottom" colspan="4">
                        <p><span style="font-size:9pt;"><font face="Arial"><b>Confirm Password</b></font></span></p>
                    </td>
                
                    <td width="150" align="left" valign="top"><input type="password" name="cnewpwd" size="12"></td>
                </tr>
                <tr>
                    <td width="75" valign="bottom">
                        <p align="left">&nbsp;&nbsp;&nbsp;</p>
                    </td>
                    <td width="38" valign="bottom">
                        <p align="right">&nbsp;</td>
                    <td width="37" valign="bottom">
                        <input type='submit' name='button' value="Save" style="height: 21; width:60"></td>
                    <td width="150" valign="bottom" colpan="2" colspan="2">
                        <input type="button" value="Cancel" name="Cancel" onclick="javascript:window.close()" style="height: 21;"></td>
                </tr>
            </table>
        </td>
        <td width="0" height="124">
         
        </td>
    </tr>
    <tr>
        <td width="400" height="112">
        </td>
    </tr>
   
</table>
</form>
</body>

</html>
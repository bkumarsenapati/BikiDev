<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Namo WebEditor v5.0"><meta name="author" content="Hotschoos, Inc.">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
<base target="bottom">
<script language="javascript" src="/LBCOM/validationscripts.js"></script>
<script language="JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
// -->


function validate(frm){

	if(trim(frm.schoolid.value)==""){
		alert("School ID should be entered");
		frm.schoolid.focus();
		return false;
		}
	if(trim(frm.password.value)==""){
		alert("Password should be entered");
		frm.password.focus();
		return false;
	}

	if(trim(frm.ConfPassword.value)==""){
		alert("Password should be confirmed");
		frm.ConfPassword.focus();
		return false;
	}

	if(frm.ConfPassword.value!=frm.password.value){
		alert("Passwords should match");
		frm.ConfPassword.focus();
		return false;
	}

}
</script>

<%@ page errorPage="/ErrorPage.jsp" %>
<%!
	String regTag,status,tag;

%>

</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="MyFrm" method="post" action="/LBCOM/registration.RegisterAdmin" onSubmit="return validate(this)" target="_self">
<input type="hidden" name="step" value="step1">
<%
	status = request.getParameter("status");

%>
    <p>&nbsp;</p>

<table cellpadding="0" cellspacing="0" width="768" height="211">
  <tr> 
    <td width="98" height="211" valign="top">
      <p>
	  &nbsp;
	  </p>
                <p>&nbsp;</p>
    </td>
    <td width="599" valign="top" height="211"> 
      <p>
<font color="red" face="Arial"><b><span style="font-size:14pt;">
<%

	if (status.equals("0"))
	{
			out.println("School ID already exists please try another ID.");
	}	
%>
	  </span></b></font><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#FF9900"><br>Create 
        your own Virtual School at Learnbeyond.com<br></font></b>
	  </p>
      <p><font face="Verdana,Arial" size="2" color="blue"><b>Step 
        1:<br></b></font><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#000000">
      Enter 
        your </font><font face="Verdana,Arial" size="2" color="black"><b>Virtual School 
                ID</b></font><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#000000"> that you would like to use for school management. <br>
        For example: </font><font face="Verdana,Arial" size="2" color="red"><i>&quot;myvirtualschool&quot;</i></font></p>
      
        <table width="65%" border="0" cellspacing="3" cellpadding="3" align="center" height="17">
          <tr> 
            <td width="416" height="16" colspan="2"> 
<P align="center"><span style="font-size:12pt;"><b><font color="red" face="Arial">&nbsp;</font></b></span></P></td>
          </tr>
          <tr> 
            <td width="39%" height="16"> 
              <b><font color="#000000" face="Verdana, Arial, Helvetica, sans-serif" size="2">Virtual School ID<br>
              </font></b></td>
            <td width="61%" height="16"> 
              <input type="text" name="schoolid" maxlength="50" size="20"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return UIDOnly(this, event)">
              <font color="#FF0000">*</font> </td>
          </tr>
          <tr> 
            <td width="39%"><b><font color="#000000" face="Verdana, Arial, Helvetica, sans-serif" size="2">Enter 
              password </font></b></td>
            <td width="61%"> 
              <input type="password" name="password" size="20"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return pwdOnly(this, event)">
               <font color="#FF0000">* </font></td>
          </tr>
          <tr> 
            <td width="39%"><b><font color="#000000" face="Verdana, Arial, Helvetica, sans-serif" size="2">Confirm 
              password </font></b></td>
            <td width="61%"> 
              <input type="password" name="ConfPassword" size="20"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return pwdOnly(this, event)">
               <font color="#FF0000">* </font></td>
          </tr>
          <tr> 
            <td width="39%" height="14"> 
              <div align="right"> 
                <input type="submit" name="Continue" value="Continue" style="font-family:Verdana; font-weight:bold; font-size:8pt;">
              </div>
            </td>
            <td width="61%" height="14"> 
              <input type="reset" name="reset" value="Reset" style="font-family:Verdana; font-weight:bold; font-size:8pt;">
            </td>
          </tr>
        </table>
      
    </td>
    <td width="1" height="211"></td>
        </tr>
</table>
</form>
</body>

</html>

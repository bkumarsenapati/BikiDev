<%@ page  import="java.util.*,java.sql.*,coursemgmt.ExceptionsFile,java.io.*" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
 <%
    String mode;
	mode=request.getParameter("mode");
	Vector buylist = (Vector) session.getAttribute("courselist");
	Vector weblist = (Vector) session.getAttribute("wblist");
	if(mode==null)
	{
		mode="";
	}
	if(buylist==null&&weblist==null)
	{
	   response.sendRedirect("/LBCOM/NoSession.html");
    }		 
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Learnbeyond_Registration</title>
<link href="style/style.css" rel="stylesheet" type="text/css" />
<LINK href="style/style1.css" type=text/css rel=stylesheet>
<style type="text/css">
<!--
.style28 {
	font-size: 14px;
	font-weight: bold;
	color: #9a730a;
}
a:link {
	text-decoration: none;
	color: #000000;
}
a:visited {
	text-decoration: none;
	color: #000000;
}
a:hover {
	text-decoration: none;
	color: #CC0000;;
}
a:active {
	text-decoration: none;
	color: #CC0000;
}
-->
</style>
<link href="sheet1.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
body {
	background-color: #575767;
}
-->
</style>
 <SCRIPT LANGUAGE="JavaScript" SRC="validationscripts.js"></SCRIPT>
  <script>
   function validate(sform)
      {  
      if(sform.uId.value=="")
	    {
        alert("Please enter UserId");
	    sform.uId.focus();
	    return false;
	    }	
	  if(trim( sform.pwd.value)=="")
	    {
	    alert("Please enter password");
	    sform.pwd.focus();
	    return false;
	    }
	  }
</SCRIPT>
</head>

<body topmargin="0">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="575767"><table width="770" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="8" background="images/bg_left panel.jpg">&nbsp;</td>
        <td><table width="756" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><table width="756" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td colspan="2"><img src="images/top_stip.jpg" width="761" height="4" /></td>
              </tr>
              <tr>
                <td width="334" height="100" bgcolor="#FFFFFF"><a href="#"><img src="images/logo.jpg" width="334" height="64" border="0"/></a></td>
                <td width="427" height="100" bgcolor="#FFFFFF"><table width="427" border="0" cellspacing="0" cellpadding="0">
                  
                  <tr>
                    <td width="152">&nbsp;</td>
                    <td width="219" align="center" valign="bottom"><form id="form1" name="form1" method="post" action="">
                        <label>
                        &nbsp;<span class="sheet">Search</span></label>
                        <label>
                        &nbsp;
                        <input name="textfield" type="text" size="20" />
                        </label>
                    </form>                      </td>
                    <td width="36" align="left" valign="baseline"><a href="#"><img src="images/search_btn.jpg" width="20" height="22" border="0" /></a></td>
                    <td width="20">&nbsp;</td>
                  </tr>
                  
                </table></td>
              </tr>
              <tr>
                <td height="3" colspan="2" bgcolor="#FFFFFF"><img src="images/spacer1.jpg" width="4" height="3" /></td>
              </tr>
              <tr>
                <td colspan="2"><table width="761" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="200" height="38" bgcolor="D9D9D1">&nbsp;</td>
    <td colspan="2" bgcolor="37728C">&nbsp;</td>
    <td width="203" rowspan="3" valign="top" bgcolor="37728C"><img src="images/img_pro1.jpg" width="202" height="112" /></td>
  </tr>
  <tr>
    <td bgcolor="D9D9D1"><div align="center"><img src="images/name_products.jpg" width="200" height="38" /></div></td>
    <td width="26" bgcolor="37728C">&nbsp;</td>
    <td width="332" bgcolor="37728C">&nbsp;</td>
  </tr>
  <tr>
    <td height="19" bgcolor="D9D9D1">&nbsp;</td>
    <td colspan="2" bgcolor="37728C">&nbsp;</td>
  </tr>
</table>
</td>
              </tr>
              <tr>
                <td colspan="2"><table width="761" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="561" align="left" valign="top" bgcolor="#FFFFFF"><p class="sheet"><br>
                    </p>

<FORM name=sform action="/LBCOM/register.ValidateUser" onsubmit="return validate(this);" action="" method=post>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="127%" height="466">
  <tr>
    <td width="100%" height="27" colspan="3">&nbsp;</td>
  </tr>
  <tr>
    <td width="19%" height="329">&nbsp;</td>
    <td width="63%" height="329">
     <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" >
        <TBODY>
         <TR>
	  <TD class=mainhead width=308 height=27><b>Student Login here</b> </TD>
	  <TD class=mainhead width=308 height=27 align="right"><font size=1px><a href="StudentRegistration.jsp?mode=shopping"> Register here</a> </font></TD>
	 </TR>
<%     
         if(mode.equals("invalid"))
          {
   			
%>
	 <TR class=td>
	  <TD class=tdleft width=308 colSpan=2 height=27><FONT color=#ff0000>Invalid UserId/password login again</FONT></TD>
	 </TR>
<%
	 }
					
%>
      <TR class=td>
	<TD class=tdleft align=right width=312 height=24> UserID:</TD>
	<TD width=308 height=24><INPUT type="text" name="uId" size="18"><FONT color=#ff0000>*</FONT></TD>
      </TR>
      <TR class=td>
	<TD class=tdleft align=right width=312 height=24>Password:</TD>
	<TD width=308 height=24><INPUT type="password" name="pwd" size="20"><FONT color=#ff0000>*</FONT></TD>
      </TR>
      <TR class=td>
	<TD width=588 colSpan=2 height=24><P align=center><INPUT type=submit value="Login" name=submit> </P></TD>
      </TR>
      <TR class=td>
	<TD width=588 colSpan=2 height=24><P align=center><a href="ForgotPassword.jsp">Forgot your password?</a></P></TD>
      </TR>
    </TBODY>
   </TABLE>
</td>
    <td width="18%" height="329">&nbsp;</td>
  </tr>
  <tr>
    <td width="100%" height="110" colspan="3">&nbsp;</td>
  </tr>
</table>
</form>
                    </td>
                  </tr>
                  
                  </table>
                  <table width="761" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td colspan="14"><img src="images/stip_line1.jpg" width="761" height="6" /></td>
                    </tr>
                    <tr>
                      <td width="86" height="35" bgcolor="#FFFFFF">&nbsp;</td>
                      <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                      <td width="67" bgcolor="#FFFFFF" class="sheet"><a href="#">Home</a></td>
                      <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                      <td width="106" bgcolor="#FFFFFF" class="sheet"><a href="#">Privacy Policy</a></td>
                      <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                      <td width="75" bgcolor="#FFFFFF" class="sheet"><a href="#">Site Map</a></td>
                      <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                      <td width="68" bgcolor="#FFFFFF" class="sheet"><a href="#">FAQs</a></td>
                      <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                      <td width="87" bgcolor="#FFFFFF" class="sheet"><a href="#">Contact Us</a></td>
                      <td width="13" bgcolor="#FFFFFF" class="sheet"><img src="images/bullet.jpg" width="13" height="12" /></td>
                      <td width="109" bgcolor="#FFFFFF" class="sheet"><a href="/LBCOM/feedback/GiveFeedback.html">Feedback</a></td>
                      <td width="85" bgcolor="#FFFFFF" class="sheet">&nbsp;</td>
                    </tr>
                    <tr>
                      <td colspan="14"><img src="images/stip_line2.jpg" width="761" height="6" /></td>
                    </tr>
                    <tr>
                      <td height="30" colspan="14" bgcolor="F3F2F0">&nbsp;</td>
                    </tr>
                    <tr>
                      <td colspan="14"><img src="images/bottom_stip.jpg" width="761" height="7" /></td>
                    </tr>
                  </table></td>
              </tr>
              
            </table></td>
          </tr>
        </table></td>
        <td width="6" background="images/bg_right panel.jpg">&nbsp;</td>
      </tr>
    </table>
    </td>
  </tr>
</table>
</body>
</html>
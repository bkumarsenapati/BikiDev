<%@ page import="java.util.*" %>
<jsp:useBean id="con1" scope="page" class="sqlbean.DbBean"/>
<%
     String smode;
	 Vector buylist = (Vector) session.getAttribute("courselist");
	 Vector weblist = (Vector) session.getAttribute("wblist");
	 smode=request.getParameter("mode");
	 if(smode==null)
	 {
		 smode="";
	 }
	 if(smode.equals("shopping")&& buylist==null&&weblist==null)
	 {
          response.sendRedirect("/LBCOM/NoSession.html");
	 }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Learnbeyond</title>
<link href="style/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style11 {
	font-size: 14px;
	color: #9a730a;
	font-weight: bold;
}
.style25 {
	color: #9a730a;
	font-weight: bold;
}
body {
	background-color: #575767;
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
<script language="javascript" src="../validationscripts.js"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="validationscripts.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
     function validate(sform)
        {
	 if(isUserId(trim( sform.username.value))==false)
	   {
	   sform.username.focus();
	   return false;
	   }	
    if(trim(sform.password.value)=="")
	   {
	   alert("Please enter password");
	   sform.password.focus();
	   return false;
	   }
	 if(trim(sform.password.value).length<6) 
	  {
	  alert("Password should be of atleast 6 characters long");
	  sform.password.focus();
	  return false;
	  }
	if(sform.password.value!=sform.cpassword.value)
	  {
	  alert("Password fields did not match. Please enter once again.");
	  sform.password.value="";
	  sform.cpassword.value="";
	  sform.password.focus();
	  return false;
	  }
        if(sform.secquestion.value=="nil")
	  {
	  alert("Please enter security question");
	  sform.secquestion.focus();
	  return false;
	  }
         if(sform.secanswer.value=="")
	  {
	  alert("Please enter security answer");
	  sform.secanswer.focus();
	  return false;
	  }
	if(sform.fname.value=="")
	  {
	  alert("Please enter firstname");
	  sform.fname.focus();
	  return false;
	  }
	if(sform.lname.value=="")
	  {
	  alert("Please enter lastname");
	  sform.lname.focus();
	  return false;
	  }
    if(sform.grade.value=="")
	  {
	  alert("Please enter Grade");
	  sform.grade.focus();
	  return false;
	  }
    if(sform.dob.value=="")
	  {
      alert("Please enter date of birth");
	  sform.dob.focus();
	  return false;
	  }
	 else if(isDate(sform.dob.value)==false)
	  {
	  sform.dob.focus();
	  return false;
	  }	
	if(sform.pname.value=="")
	  {
          alert("Please enter parent name");
	  sform.pname.focus();
	  return false;
	  }
	if(isValidEmail(sform.emailid.value)==false||sform.emailid.value=="")
	  {
	  sform.emailid.focus();
	  return false;
	  }
	if(isNaN(sform.phone.value)) 
	 {
	 alert("Please enter only numbers for phoneno");
	 sform.phone.focus();
	 return false;
         }
   }
</SCRIPT>

<script language="JavaScript">
<!--
function mmLoadMenus() {
  if (window.mm_menu_0515161022_0) return;
                  window.mm_menu_0515161022_0 = new Menu("root",170,18,"Verdana",12,"#333333","#000000","#D9D9D1","#666666","center","middle",3,3,1000,-5,7,true,false,true,0,false,true);
  mm_menu_0515161022_0.addMenuItem("Courses","location='/LBCOM/products/CourseIndex.jsp'");
  mm_menu_0515161022_0.addMenuItem("K-Caps","location='/LBCOM/products/WebinarIndex.jsp'");
  mm_menu_0515161022_0.addMenuItem("Preview","location='#'");
   mm_menu_0515161022_0.hideOnMouseOut=true;
   mm_menu_0515161022_0.bgColor='#555555';
   mm_menu_0515161022_0.menuBorder=1;
   mm_menu_0515161022_0.menuLiteBgColor='#FFFFFF';
   mm_menu_0515161022_0.menuBorderBgColor='#777777';

mm_menu_0515161022_0.writeMenus();
} // mmLoadMenus()

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
<script language="JavaScript" src="mm_menu.js"></script>
</head>

<body topmargin="0" onload="MM_preloadImages('images/btn_02_2.jpg')">
<FORM name=sform action="/LBCOM/register.AddStudentDetails?mode=add&type=<%= smode%>" onsubmit="return validate(this);" action="" method=post>
<script language="JavaScript1.2">mmLoadMenus();</script>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td   valign="top" bgcolor="575767"><table width="770"  border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="8" background="images/bg_left panel.jpg">&nbsp;</td>
        <td><table width="756" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td  valign="top"><table width="756" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td colspan="2"><img src="images/top_stip.jpg" width="761" height="4" /></td>
              </tr>
              <tr>
                <td width="334" height="100" bgcolor="#FFFFFF"><img src="images/logo.jpg" width="334" height="64" /></td>
                <td width="427" height="100" bgcolor="#FFFFFF"><table width="427" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="152">&nbsp;</td>
                    <td width="219" align="center" valign="bottom">
                     <!--  <label> &nbsp;<span class="sheet">Search</span></label>
                      <label> &nbsp;
                        <input name="textfield" type="text" size="20" />
                        </label> -->
                    </td>
                    <td width="36" align="center" valign="baseline"><!-- <img src="images/search_btn1.jpg" width="19" height="19" /> --></td>
                    <td width="20">&nbsp;</td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td colspan="2"><table width="761" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="80"><img src="images/btn_01.jpg" width="80" height="30" /></td>
                    
					<td width="74"><a href="/LBCOM/index.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image25','','images/btn_02_2.jpg',1)"><img src="images/btn_02.jpg" alt="Home" name="Image25" width="74" height="30" border="0" id="Image25" /></a><a href="/LBCOM/index.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image29','','images/btn_02_2.jpg',1)"></a></td>
                    
					<td width="95"><a href="/LBCOM/AboutUs.html" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image30','','images/btn_03_2.jpg',1)"><img src="images/btn_03.jpg" alt="About us" 
					name="Image30" width="95" height="30" border="0" id="Image30" /></a></td>

                    <td width="170"><a href="/LBCOM/products/CourseCatalog.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image31','','images/btn_04_2.jpg',1)"><img src="images/btn_04.jpg" alt="Products&amp;Services" name="Image31" width="170" height="30" border="0" id="Image31" onmouseover="MM_showMenu(window.mm_menu_0515161022_0,2,32,null,'Image31');MM_showMenu(window.mm_menu_0515161022_0,2,32,null,'Image31');MM_showMenu(window.mm_menu_0515161022_0,2,32,null,'Image31')" onmouseout="MM_startTimeout();" /></a></td>

                    <td width="83"><a href="/LBCOM/news/News.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image32','','images/btn_05_2.jpg',1)"><img src="images/btn_05.jpg" alt="News" name="Image32" width="83" height="30" border="0" id="Image32" /></a></td>

                    <td width="96"><a href="StudentRegistration.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image33','','images/btn_06_2.jpg',1)"><img src="images/btn_06_2.jpg" width="96" height="30" border="0" /></a></td>

                    <td width="99"><a href="/LBCOM/ContactUs.html" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image34','','images/btn_07_2.jpg',1)"><img src="images/btn_07.jpg" alt="Contact" name="Image34" width="113" height="30" border="0" id="Image34" /></a></td>
                    <td width="64"><img src="images/btn_08.jpg" width="50" height="30" /></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td height="3" colspan="2" bgcolor="#FFFFFF"><img src="images/spacer1.jpg" width="4" height="3" /></td>
              </tr>
              <tr>
                <td colspan="2"><table width="761" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="201" height="40" background="images/bg3.jpg" bgcolor="D9D9D1">&nbsp;</td>
                    <td width="397" colspan="2" align="center" valign="baseline" background="images/bg4.jpg" bgcolor="6C766E">&nbsp;</td>
                    <td width="163" rowspan="3" valign="bottom" bgcolor="6C766E"><img src="images/img_reg1.jpg" width="167" height="112" /></td>
                  </tr>
                  <tr>
                    <td background="images/bg3.jpg" bgcolor="D9D9D1"><img src="images/name_reg.jpg" width="200" height="31" /></td>
                    <td width="198" background="images/bg4.jpg" bgcolor="6C766E">&nbsp;</td>
                    <td width="199" background="images/bg4.jpg" bgcolor="6C766E">&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="41" background="images/bg3.jpg" bgcolor="D9D9D1">&nbsp;</td>
                    <td width="397" colspan="2" background="images/bg4.jpg" bgcolor="6C766E">&nbsp;</td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td  colspan="2" valign="top"><table width="761" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="200" height="46" valign="bottom" bgcolor="CBCCD0"><img src="images/pro_stip.jpg" width="200" height="47" /></td>
                    <td width="561" rowspan="3" align="left" valign="top" bgcolor="#FFFFFF">
                                <table width="561" border="0" cellspacing="0" cellpadding="0">
                                  <tr>
                                    <td width="12">&nbsp;</td>
                                    <td width="539"><p class="sheet">
                                    <font style="font-size: 9pt"><br>
                                    Don't have a 
                                    Learnbeyond Account? Get one now - It's easy 
                                    and free!<br>
                                    <br>
                                    An account with Learnbeyond will let students take Courses and 
                                    recorded classroom sessions (K-Caps). 
                                    Registered users will  also receive newsletters and 
                                    promotional materials every month. Getting the account is free. 
                                    Users will only be charged for the courses and the 
                                        K-Caps that they register later after 
                                    joining Learnbeyond.<br>
&nbsp;</font></p>
                                      </td>
                                    <td width="10"><p class="sheet">&nbsp;</p></td>
                                  </tr>
                                  <tr>
                                    <td colspan="3" width="561"><table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="36%" id="AutoNumber1" height="544">
                                        <tr>
                                          <td width="60%" height="246"><TABLE width="555">
                                              <TR>
                                                <TD width="554"><CENTER>
                                                    <TABLE id=errshow name="errshow">
                                                      <TBODY>
                                                        <TR>
                                                          <TD style="COLOR: blue"align=left></TD>
                                                        </TR>
                                                      </TBODY>
                                                    </TABLE>
                                                </CENTER>
                                                    <TABLE>
                                                      <CENTER>
                                                      </center>
                                                      <!-- code for errors -->
                                                      <TBODY>
                                                      </TBODY>
                                                    </TABLE>
                                                  <TABLE class=table borderColor=#111111 cellSpacing=1 
                                                                               cellPadding=0 width=552 border=0 style="border-collapse: collapse" bgcolor="#FFFFFF">
                                                      <TBODY>
                                                        <TR class=mainhead>
                                                          <TD class=mainhead width=891 height=27 colspan="2"><span class="sheet"><b>Create your Learnbeyond User ID Here</b></span><b>:</b><FONT color=#ff0000 size="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                                                          &nbsp;<SPAN style="FONT-WEIGHT: 400">* 
                                                          fields are required.</SPAN> </FONT></td>
                                                        </TR>
                                                        <TR class=td>
                                                          <TD  width=550 colSpan=2 height=27>The username and password allow you to access Learnbeyond. </TD>
                                                        </TR>
                                                        <TR class=td>
                                                          <TD width=226 height=41 align=right valign="middle" class=sheet>User ID</TD>
                                                          <TD class=td width=323 height=24><INPUT type="text" size=25 name="username" />
                                                              <FONT color=red>*<BR />
                                                            </FONT><FONT size=1>ID may consist of a-z, A-Z, 0-9, and underscores.</FONT></TD>
                                                        </TR>
                                                        <TR class=td>
                                                          <TD width=243 height=41 class=tdleft><div align="right" class="sheet">Password </div></TD>
                                                          <TD width=323 height=41><INPUT type="password" name="password" size="25" />
                                                              <FONT color=#ff0000>*<BR />
                                                              </FONT><FONT size=1>Six characters or 
                                                              more. 
                                                              Capitalization matters!</FONT> </TD>
                                                        </TR>
                                                        <TR class=td>
                                                          <TD class=sheet align=right width=226 height=24>Confirm Password </TD>
                                                          <TD width=323 height=24><INPUT type=password name="cpassword" size="25" />
                                                              <FONT color=#ff0000>*</FONT></TD>
                                                        </TR>
                                                        <TR class=td>
                                                          <TD align=right width=550 colSpan=2 height=14><P align=left><SPAN class=sheet><STRONG>If you forget your password...</STRONG></SPAN></P></TD>
                                                        </TR>
                                                        <TR class=td>
                                                          <TD class=sheet align=right width=226 height=24>Security Question</TD>
                                                          <TD width=323 height=24><SELECT size=1 name="secquestion">
                                                              <OPTION selected value="nil">Select a security question?</OPTION>
                                                              <OPTION value="What is your first school?">What is your first school?</OPTION>
                                                              <OPTION value="What is your favorite color?">What is your favorite color?</OPTION>
                                                              <OPTION value="What is your mother maiden name?">What is your mother's maiden name?</OPTION>
                                                              <OPTION value="What is your pet name?">What is your pet's name?</OPTION>
                                                              <OPTION value="Who is your favorite hero?">Who is your favorite hero?</OPTION>
                                                            </SELECT>
                                                              <FONT color=#ff0000>*</FONT> </TD>
                                                        </TR>
                                                        <TR class=td>
                                                          <TD class=sheet align=right width=226 height=24>Your Answer </TD>
                                                          <TD width=323 height=24><INPUT type="text" name="secanswer" size="25" oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NameOnly(this, event)"/>
                                                              <FONT color=#ff0000>* </FONT> </TD>
                                                        </TR>
                                                      </TBODY>
                                                  </TABLE></TD>
                                              </TR>
                                          </TABLE></td>
                                        </tr>
                                        <tr>
                                          <td width="60%" height="18"></td>
                                        </tr>
                                        <tr>
                                          <td width="60%" height="258"><TABLE class=hi height="400" width="559">
                                              <TR>
                                                <TD height="396" width="581" bgcolor="#C0C0C0">
                                                <TABLE class=table borderColor=#111111 cellSpacing=1 cellPadding=0 border=0 width="554" style="border-collapse: collapse" bgcolor="#FFFFFF" height="395">
                                                    <TBODY>
                                                      <TR class=mainhead>
                                                        <TD width="552" colSpan=2 class="sheet" height="19"><strong>Your Personal Details : </strong></TD>
                                                      </TR>
                                                      <TR class=td>
                                                        <TD class=td colSpan=2 width="552" height="15">&nbsp;</TD>
                                                      </TR>
                                                      <TR class=td>
                                                        <TD class=sheet align=right width="237" height="22">First Name</TD>
                                                        <TD width="314" height="22"><INPUT type="text" name="fname" size="24" oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NameOnly(this, event)"/>
                                                            <FONT color=#ff0000>*</FONT> </TD>
                                                      </TR>
                                                      <TR class=td>
                                                        <TD class=sheet align=right width="237" height="22">Last Name</TD>
                                                        <TD width="314" height="22"><INPUT type="text" name="lname" size="24" oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NameOnly(this, event)"/>
                                                            <FONT color=#ff0000>*</FONT> </TD>
                                                      </TR>
                                                      <TR class=td>
                                                        <TD class=sheet align=right width="237" height="22">Grade</TD>
                                                        <TD width="314" height="22"><INPUT type="text" name="grade" size="24" />
                                                            <FONT color=#ff0000>*</FONT> </TD>
                                                      </TR>
                                                      <TR class=td>
                                                        <TD class=sheet align=right width="237" height="21">School Name</TD>
                                                        <TD width="314" height="21"><INPUT type="text" name="school" size="24" />
                                                        </TD>
                                                      </TR>
                                                      <TR class=td>
                                                        <TD class=sheet align=right width="237" height="22">Gender</TD>
                                                        <TD width="314" height="22"><SELECT size=1 name="gender">
                                                            <OPTION selected>Select</OPTION>
                                                            <OPTION>Male</OPTION>
                                                            <OPTION>Female</OPTION>
                                                          </SELECT>
                                                        </TD>
                                                      </TR>
                                                      <TR class=td>
                                                        <TD class=sheet align=right width="237" height="22">Date of 
                                                        Birth</TD>
                                                        <TD width="314" height="22"><INPUT type="text" name="dob" size="24" />
                                                            <FONT color=#ff0000>* </FONT> 
                                                        (mm/dd/yyyy)</TD>
                                                      </TR>
                                                      <TR class=td>
                                                        <TD class=sheet align=right width="237" height="22">Parent's Name</TD>
                                                        <TD width="314" height="22"><INPUT type="text" name="pname" size="24" oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NameOnly(this, event)"/>
                                                            <FONT color=#ff0000>*</FONT> </TD>
                                                      </TR>
                                                      <TR class=td>
                                                        <TD class=sheet align=right width="237" height="22">Parent's Email Id</TD>
                                                        <TD width="314" height="22"><INPUT type="text" name="emailid" size="24" />
                                                            <FONT color=#ff0000>*</FONT>
                                                        <a target="_blank" href="/LBCOM/PrivacyPolicy.html"><U>Privacy Policy</U></a> </TD>
                                                      </TR>
                                                      <TR class=td>
                                                        <TD class=sheet align=right width="237" height="22">County</TD>
                                                        <TD width="314" height="22"><INPUT type="text" name="county" size="24" /></TD>
                                                      </TR>
                                                      <TR class=td>
                                                        <TD class=sheet align=right width="237" height="22">District</TD>
                                                        <TD width="314" height="22"><INPUT type="text" name="district" size="24" /></TD>
                                                      </TR>
                                                      <TR class=td>
                                                        <TD class=sheet align=right width="237" height="22">Zip Code</TD>
                                                        <TD width="314" height="22"><INPUT type="text" name="zipcode" size="24" /></TD>
                                                      </TR>
                                                      <TR class=td>
                                                        <TD class=sheet align=right width="237" height="22">State</TD>
                                                        <TD width="314" height="22"><INPUT type="text" name="state" size="24" /></TD>
                                                      </TR>
                                                      <TR class=td>
                                                        <TD class=sheet align=right width="237" height="22">Country</TD>
                                                        <TD width="314" height="22"><INPUT type="text" name="country" size="24" /></TD>
                                                      </TR>
                                                      <TR class=td>
                                                        <TD class=sheet align=right width="237" height="22">Phone</TD>
                                                        <TD width="314" height="22"><INPUT type="text" name="phone" size="24" /></TD>
                                                      </TR>
                                                      <TR class=td>
                                                        <TD width=552 colSpan=2 height=37><P align=center>
                                                          <INPUT type=submit value="Continue" name=submit />
                                                          &nbsp;&nbsp;&nbsp;
                                                            <INPUT type=reset value="Reset" name=reset />
                                                        </P></TD>
                                                      </TR>
                                                    </TBODY>
                                                  </TABLE>
                                                    <p>&nbsp;</p></TD>
                                              </TR>
                                          </TABLE></td>
                                        </tr>
                                    </table></td>
                                  </tr>
                              </table></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" bgcolor="#F6F6F4"><img src="images/img_reg2.jpg" width="200" height="278" /></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" background="images/bg_img down.jpg" bgcolor="F6F6F4"><p>&nbsp;</p></td>
                  </tr>
                </table>
                          <table width="761" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td colspan="14"><img src="images/stip_line1.jpg" width="761" height="6" /></td>
                            </tr>
                            <tr>
                              <td width="86" height="35" bgcolor="#FFFFFF">&nbsp;</td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="67" bgcolor="#FFFFFF"><span class="sheet"><a href="/LBCOM/">Home</a></span></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="106" bgcolor="#FFFFFF" class="sheet">
                              <a href="/LBCOM/PrivacyPolicy.html">Privacy Policy</a></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="75" bgcolor="#FFFFFF" class="sheet">
                              <a href="/LBCOM/SiteMap.html">Site Map</a></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="68" bgcolor="#FFFFFF" class="sheet">
                              <a href="/LBCOM/Faqs.html">FAQs</a></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="87" bgcolor="#FFFFFF" class="sheet">
                              <a href="/LBCOM/ContactUs.html">Contact Us</a></td>
                              <td width="13" bgcolor="#FFFFFF" class="sheet"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="109" bgcolor="#FFFFFF" class="sheet"><a href="/LBCOM/feedback/GiveFeedback.html"> Feedback</a></td>
                              <td width="85" bgcolor="#FFFFFF" class="sheet">&nbsp;</td>
                            </tr>
                            <tr>
                              <td colspan="14"><img src="images/stip_line2.jpg" width="761" height="6" /></td>
                            </tr>
                            <tr>
                              <td height="30" colspan="14" background="images/bg2.jpg" bgcolor="F3F2F0">
                              <p align="center"><span class="sheet style14">
                              <span style="font-size: 7pt">Copyright &copy; 2007-2008 Learnbeyond. All Rights Reserved.</span></span></td>
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
    </table></td>
  </tr>
</table>
</form>
</body>
</html>
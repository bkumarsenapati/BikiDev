<%@ page import = "java.sql.*,coursemgmt.ExceptionsFile,java.util.Vector,java.util.Iterator" %>
<%@ page language="java"  %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page" />
<%
String cookieSchoolId = "schoolid";
String cookieUserId = "userid";
String cookiePass = "password";
Cookie cookiesid [] = request.getCookies ();
Cookie cookieuid [] = request.getCookies ();
Cookie cookiepwd [] = request.getCookies ();
Cookie mySchoolCookie = null,myCookieUser=null,myCookiePass=null;
if (cookiesid != null)
{
for (int i = 0; i < cookiesid.length; i++) 
{
if (cookiesid [i].getName().equals (cookieSchoolId))
{
mySchoolCookie = cookiesid[i];
break;
}
}
}
if (cookieuid != null)
{
for (int i = 0; i < cookieuid.length; i++) 
{
if (cookieuid [i].getName().equals (cookieUserId))
{
myCookieUser = cookieuid[i];
break;
}
}
}
if (cookiepwd!= null)
{
for (int i = 0; i < cookiepwd.length; i++) 
{
if (cookiepwd [i].getName().equals (cookiePass))
{
myCookiePass = cookiepwd [i];
break;
}
}
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Learnbeyond</title>
<style type="text/css">
<!--
.style2 {
	color: #FF6600;
	font-weight: bold;
	font-size: 12px;
}
.style5 {font-size: 16px}
-->
</style>
<link href="style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style9 {
	color: #CC0000;
	font-weight: bold;
}
.style10 {font-size: 11px}
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
.style14 {font-size: 9px}
.style15 {
	color: #9a730a;
	font-weight: bold;
}
-->
</style>

<script language="javascript">
<!--
	function callhome(){
		var win=window.opener;
		if (win==null){
			window.open("new.html");
		}else{
			win.focus();
		}			
	}	
	//-->
</script>
<script language="javascript" src="images/index/validationscripts"></script>
<script language="JavaScript">
<!-- 
var usr;
var popUpsBlocked=false;
var popmessage="";
var cookiemess="";
var uid="";
var pwd="";
var x = navigator;
function validate(){
	   
    var homepage=document.homepage;
	if((popUpsBlocked)||(!x.cookieEnabled)){
		alert("please ensure that browser is configured as recommended in 'Browser Specific Requirements'");
//		window.location="/LBCOM/tech.html#browsers";
//		return false;
	}
	if(homepage.schoolid.value=="")
	{
		alert("School ID should be entered.");
		homepage.schoolid.focus();
		return false;
	}
	else
		sid=homepage.schoolid.value;

	if(homepage.userid.value=="")
	{
		alert("User ID should be entered.");
		homepage.userid.focus();
		return false;
	}
	else
     uid=homepage.userid.value;
	if(homepage.password.value=="")
	{
		alert("Password should be entered.");
		homepage.password.focus();
		return false;
	}
	else
     pwd=homepage.password.value;
	var obj=document.homepage.selbox;
	var chk="";
	if (obj.type=="checkbox" && obj.name=="selbox" && obj.checked==true)
	{
		var chk="checked";
			
	}
	else
		chk="unchecked";
	alert(chk);
		
	 document.location.href="/LBCOM/GetUserType?schoolid="+sid+"&userid="+uid+"&password="+pwd+"&checked="+chk;
	 return true;
} 
function reset()
 {
   var homepage=document.homepage;
   homepage.schoolid.value="";
   homepage.userid.value="";
   homepage.password.value="";
   return true;
 }
//-->
</script>

<script type="text/JavaScript">
<!--
function mmLoadMenus() 
{
	if (window.mm_menu_0515161022_0) 
		return;
    window.mm_menu_0515161022_0 = new Menu("root",170,18,"Verdana",12,"#FFFFFF","#000000","#666666","#999999","center","middle",3,3,100,-5,7,true,false,true,0,false,false);
	this.menu_background_color = "#cccccc"
	this.menu_border_color = "#999999"
	this.menu_border_width = "0"
	this.menu_padding = "0,0,0,0"
	this.menu_border_style = "solid"
	this.divider_caps = false
	this.divider_width = 0
	this.divider_height = 1
	this.divider_background_color = "#ffffff"
	this.divider_border_style = "none"
	this.divider_border_width = 0
	this.divider_border_color = "#000000"
	this.menu_is_horizontal = false
	this.menu_width = "101"
	this.menu_xy = "-77,-1"
	this.menu_scroll_direction = 1
	this.menu_scroll_reverse_on_hide = true
	this.menu_scroll_delay = 5
	this.menu_scroll_step = 8
	this.menu_animation = "progid:DXImageTransform.Microsoft.Wheel(duration=0.3,spokes=4)"
	mm_menu_0515161022_0.addMenuItem("Courses","location='products/CourseIndex.jsp'");
	mm_menu_0515161022_0.addMenuItem("K-Caps","location='products/WebinarIndex.jsp'");
	//mm_menu_0515161022_0.addMenuItem("Preview","location='#'");
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

<SCRIPT LANGUAGE="JavaScript">
<!--
	var mine = window.open('','','width=1,height=1,left=0,top=0,scrollbars=no');
	if(mine){
		popUpsBlocked = false;
	}else{
		popUpsBlocked = true;
popmessage="<hr width='50%'/>Popups from this site are blocked in your browser.<br/><font color='red'>Enable popups from this site, and reload this page to login.</font>";
	}
	if(mine)mine.close();
	if(!x.cookieEnabled){
cookiemess="<hr width='50%'/>Cookies from this site are not accepted by your browser.<br/><font color='red'>Allow cookies from this site, and reload this page to login.</font>";
	}
	var warn = "";
	if (popUpsBlocked || !x.cookieEnabled) {
warn = "<hr width='50%'/><font color='#990000'>If you login without following the recommendations, the application will NOT work properly.</font>";
	}

//-->
</SCRIPT>
</head>
<body onload="MM_preloadImages('lb_images/btn_02_2.jpg','lb_images/btn_03_2.jpg','lb_images/btn_04_2.jpg','lb_images/btn_05_2.jpg','lb_images/btn_06_2.jpg','lb_images/btn_07_2.jpg')" topmargin="0" leftmargin="0">
<form name="homepage" method="post" id="homepage" >
<script language="JavaScript1.2">mmLoadMenus();</script>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="575767"><table width="770" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="8" background="lb_images/bg_left panel.jpg">&nbsp;</td>
        <td><table width="756" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><table width="756" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td colspan="2"><img src="lb_images/top_stip.jpg" width="761" height="4" /></td>
              </tr>
              <tr>
                <td width="334" height="100" bgcolor="#FFFFFF"><img src="lb_images/logo.jpg" width="334" height="64" /></td>
                <td width="427" height="64" bgcolor="#FFFFFF">
                	<table width="427" border="0" cellspacing="0" cellpadding="0">
                  	<tr>
                    	<td width="227">&nbsp;</td>
	                    <td width="200" align="center" valign="bottom">
    	                	<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" height="77">
                        	<tr>
                          		<td width="100%" height="21" align="left">
		                        	<font face="Verdana" size="1">In 
                                    collaboration with: </font>
		                        </td>
                        	</tr>
                        	<tr>
                          		<td width="100%" height="56">
                          			<a target="_blank" href="http://pennsgrove.k12.nj.us/">
                          			<img border="0" src="PG_Logo.gif" width="208" height="56"></a>
                          		</td>
                        	</tr>
                      		</table>
                    	</td>
                  	</tr>
                	</table>
                </td>
              </tr>
              <tr>
                <td colspan="2"><table width="761" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="80"><img src="lb_images/btn_01.jpg" width="80" height="30" /></td>
                    <td width="74"><a href="index.jsp" onmouseout="MM_swapImgRestore()"  onmouseover="MM_swapImage('Image29','','lb_images/btn_02_2.jpg',1)"><img src="lb_images/btn_02_2.jpg" width="74" height="30" border="0" /></a></td>

                    <td width="95"><a href="AboutUs.html" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image30','','lb_images/btn_03_2.jpg',1)"><img src="lb_images/btn_03.jpg" alt="About us" name="Image30" width="95" height="30" border="0" id="Image30" /></a></td>

                    <td width="170"><a href="products/CourseCatalog.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image31','','lb_images/btn_04_2.jpg',1)"><img src="lb_images/btn_04.jpg" alt="Products&amp;Services" name="Image31" width="170" height="30" border="0" id="Image31" onmouseover="MM_showMenu(window.mm_menu_0515161022_0,2,32,null,'Image31');MM_showMenu(window.mm_menu_0515161022_0,2,32,null,'Image31');MM_showMenu(window.mm_menu_0515161022_0,2,32,null,'Image31')" onmouseout="MM_startTimeout();" /></a></td>

                    <td width="83"><a href="news/News.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image32','','lb_images/btn_05_2.jpg',1)"><img src="lb_images/btn_05.jpg" alt="News" name="Image32" width="83" height="30" border="0" id="Image32" /></a></td>

                    <td width="96"><a href="register/StudentRegistration.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image33','','lb_images/btn_06_2.jpg',1)"><img src="lb_images/btn_06.jpg" alt="Register" name="Image33" width="96" height="30" border="0" id="Image33" /></a></td>

                    <td width="99"><a href="ContactUs.html" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image34','','lb_images/btn_07_2.jpg',1)"><img src="lb_images/btn_07.jpg" alt="Contact" name="Image34" width="113" height="30" border="0" id="Image34" /></a></td>
                    <td width="64"><img src="lb_images/btn_08.jpg" width="50" height="30" /></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td height="3" colspan="2" bgcolor="#FFFFFF"><img src="lb_images/spacer1.jpg" width="4" height="3" /></td>
              </tr>
              <tr>
                <td colspan="2" width="761" height="112" bgcolor="#C0C0C0" valign="top" bordercolor="#C0C0C0">
					<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="761" height="112">
						<param name="movie" value="lb_images/banner.swf">
      					<param name="quality" value="High">
						<param name="_cx" value="20135">
						<param name="_cy" value="2963">
						<param name="FlashVars" value>
						<param name="Src" value="lb_images/banner.swf">
						<param name="WMode" value="Transparent">
						<param name="Play" value="0">
						<param name="Loop" value="-1">
						<param name="SAlign" value>
						<param name="Menu" value="-1">
						<param name="Base" value>
						<param name="AllowScriptAccess" value>
						<param name="Scale" value="ShowAll">
						<param name="DeviceFont" value="0">
						<param name="EmbedMovie" value="0">
						<param name="BGColor" value>
						<param name="SWRemote" value>
						<param name="MovieData" value>
						<param name="SeamlessTabbing" value="1">
						<param name="Profile" value="0">
						<param name="ProfileAddress" value>
						<param name="ProfilePort" value="0">
						<param name="AllowNetworking" value="all">
						<param name="AllowFullScreen" value="false">
						<embed src="lb_images/banner.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="761" height="112" swliveconnect=true></embed></object>
				</td>
              </tr>
              <tr>
                <td colspan="2">

                

                  <input type="hidden" name="mode">
                 <!--  <input type="hidden" name="schoolid" value='lbeyond' id="lbeyond"> -->

				 <table width="761" border="0" cellspacing="0" cellpadding="0">
                   <tr>
                    <td width="200"><table width="200" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td height="66" colspan="5" background="lb_images/bg1.jpg" bgcolor="F6F6F4"><div align="center" class="sheet">Registered users login here!</div></td>
                      </tr>

<%
		String validFlag=request.getParameter("validFlag");
		
		if(validFlag==null)
			validFlag="";
		//if(validFlag.equals("invalid"))
		//{
%>
   <!-- <tr>
        <td colspan="2" align="center">The username or password is wrong!</td>
    </tr> -->
<%
		//}	
%>

                      <tr>
                        <td width="13" bgcolor="#F6F6F4">&nbsp;</td>
                        <td colspan="3" valign="top"><table width="173" height="2" border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td><img src="lb_images/stip_top_log.jpg" width="173" height="2" /></td>
                          </tr>
                        </table>
                                									  
									  <table width="173" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                          <td width="1" background="lb_images/left line_bg.jpg"><img width="1" height="185" /></td>
                                          <td width="165" valign="top" bgcolor="#FFFFFF"><table width="171" border="0" cellspacing="0" cellpadding="0">
										  
											<tr>
											<td colspan="4">
											<%
if (mySchoolCookie == null) {
%>
<label><span class="sheet">&nbsp;&nbsp;<b><font color="#FF6600">SchoolID</font></b></span> &nbsp;&nbsp;
                                                      <input type="text" name="schoolid" size="20"/>
                                                    </label>
<%
} else {
	System.out.println("I am here at not null");
%> 
<label><span class="sheet">&nbsp;&nbsp;<b><font color="#FF6600">SchoolID</font></b></span> &nbsp;&nbsp;
                                                      <input type="text" name="schoolid" size="20" value="<%=mySchoolCookie.getValue()%>"/>
                                                    </label>
<%
}
if (myCookieUser == null) {
%>
<label><span class="sheet">&nbsp;&nbsp;<b><font color="#FF6600">User 
                                                    ID</font></b></span> &nbsp;&nbsp;
                                                      <input type="text" name="userid" size="20" />
                                                    </label>
<%
} else {
	System.out.println("I am here at not null");
%> 
<label><span class="sheet">&nbsp;&nbsp;<b><font color="#FF6600">User 
                                                    ID</font></b></span> &nbsp;&nbsp;
                                                      <input type="text" name="userid" size="20" value="<%=myCookieUser.getValue()%>" />
                                                    </label>
<%
}
if (myCookiePass == null) {
%>
<label><span class="sheet">&nbsp;&nbsp;<font color="#FF6600"><b>Password</b></font> </span> &nbsp;&nbsp;
                                                      <input type="password" name="password" size="20" />
                                                    </label>
<%
} else {
	System.out.println("I am here at not null");
%>
<label><span class="sheet">&nbsp;&nbsp;<font color="#FF6600"><b>Password</b></font> </span> &nbsp;&nbsp;
                                                      <input type="password" name="password" size="20" value="<%=myCookieUser.getValue()%>"/>
                                                    </label>
<%
}

%><label><span class="sheet">&nbsp;&nbsp;<font size="0"><input type="checkbox" name="selbox" title="checkbox"><b>Remember me on this computer</b></font> </span> &nbsp;&nbsp;
                                                     </label>
                                                </td>
												</tr>
											  <tr>
                                                <td width="28">&nbsp;</td>
                                                <td width="53">&nbsp;</td>
                                                <td width="14">&nbsp;</td>
                                                <td width="78">&nbsp;</td>
                                              </tr>
                                              <tr>
                                                <td width="28">&nbsp;</td>
                                                <td width="53"><a href="javascript://" onclick="validate();return false;"><img src="lb_images/submit_btn.jpg" width="53" height="20" border="0"/></a></td>
                                                <td width="14">&nbsp;</td>
                                                <td width="78"><a href="javascript://" onclick="reset();return false; "><img src="lb_images/reset_btn.jpg" width="54" height="20" border="0" /></a></td>
                                              </tr>
                                            </table>
                                              <br />
                                              <table width="171" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
																							
                                                  <td width="11"><div align="justify"></div></td>
                                                  <td width="160" class="sheet">Don't have an account? <br />
                                                    Click Here to<a href="register/StudentRegistration.jsp"><font color="#FF6600">
                                                    </font> <span class="style9">
                                                    <font color="#FF6600">Register!</font></span></a><br><br><a href='/LBCOM/schoolAdmin/' onClick='return(isEnabled);'>
													<font face="arial" size="2" color="#FF6600"><b>Admin Login</b></font></a></td>
                                                </tr>
                                            </table>
										  </td>
                                          <td width="1" background="lb_images/left line_bg.jpg"><img width="1" height="185" /></td>
                                        </tr>
                                    </table></td>
                        <td width="14" bgcolor="#F6F6F4">&nbsp;</td>
                      </tr>
                      <tr>
                        <td width="13" height="7" bgcolor="#F6F6F4">&nbsp;</td>
                        <td colspan="3" valign="top" bgcolor="#F6F6F4"><img src="lb_images/stip_top_bottom.jpg" width="173" height="7" /></td>
                        <td height="7" bgcolor="#F6F6F4">&nbsp;</td>
                      </tr>
                      <tr>
                        <td bgcolor="#F6F6F4">&nbsp;</td>
                        <td colspan="3"><img src="lb_images/news_stip.jpg" width="173" height="21" /></td>
                        <td bgcolor="#F6F6F4">&nbsp;</td>
                      </tr>
                      <tr>
                        <td bgcolor="#F6F6F4">&nbsp;</td>
                        <td width="1" valign="top" background="lb_images/left line_bg.jpg" bgcolor="#F6F6F4"><img width="1" height="148" /></td>
                        <td width="171" valign="top">
                        <table width="171" border="0" cellspacing="0" cellpadding="0" height="149">
                        <tr>
                            <td height="130" align="left" valign="top" bgcolor="#FFFFFF"><div align="justify">
                            <span class="sheet style10"></span></div></td>
                          </tr>
                        </table></td>
                        <td width="1" valign="top" background="lb_images/left line_bg.jpg" bgcolor="#F6F6F4"></td>
                        <td bgcolor="#F6F6F4">&nbsp;</td>
                      </tr>
                      <tr>
                        <td colspan="5"><table width="200" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="13" height="19" bgcolor="#F6F6F4">&nbsp;</td>
                            <td width="176" align="left" valign="top" bgcolor="#F6F6F4"><div align="center"><img src="lb_images/stip_bottom2.jpg" width="173" height="8" /></div></td>
                            <td width="12" height="19" bgcolor="#F6F6F4">&nbsp;</td>
                          </tr>
                        </table></td>
                      </tr>
                    </table></td>
                    <td width="561" valign="top" bgcolor="#FFFFFF">
                    <table width="549" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#111111">
                      <tr>
                        <td width="26">&nbsp;</td>
                        <td width="571" class="sheet">
                        <div align="justify">
<font face="Verdana" color="#303030"><br>
<b>Learnbeyond</b> is  a  complete  online  learning and collaboration solution for students. Learnbeyond  is  powered  by  <a target="_blank" href="http://www.hotschools.net/">Hotschools</a>, a   robust   Learning   Management   and Collaboration System which has numerous features such as an easy to access Course Material Interface, an  Informative  Reporting  System, Student-Student and Student-Teacher communication tools, an e-classroom, Assessment Reminders and more. 

<br>
<br>
Our <b>Courses</b> and  <b>K-caps</b> (recorded  classroom  sessions)  are  the most  affordable, 
when compared to any other online course provider.  These courses will be delivered 
by reputed teachers, who will be available to guide the  students  almost  around the 
clock.  Students  can  login  to  the  system,  read  the materials, listen to the  K-Caps, 
and take the assessments whenever and wherever they want.

<br>
<br>
<b>Learnbeyond</b> lets  parents  monitor  their  kids'  performance  in  assessments   and 
assignments.  They can also get a complete  analysis of  the  time spent by their child 
in various activities such as reading  materials,  assessments,  e-classroom, and Chat 
sessions with other students and teachers. <br>
<br>
For the current <b>summer school program</b>, Learnbeyond offers more than 20 web based 
online courses and K-Caps for students in grades 4 through 12.  These courses cover 
complete   course   schedules,     highly   informative    materials,   and  assessments/
assignments    for   each    lesson,   while   the   K-Caps  cover   the   key   areas   and 
&quot;difficult to digest&quot;  topics from various courses. <br>
<br>
So, what are you waiting for? Simply register, select the courses you want to explore 
and learn beyond with Learnbeyond!!!</font>
</div>
<div align="right">
<br>
<br>
<font face="verdana" size="2">
<a target="_blank" href="tech.html#browsers">[Browser Specific Requirements]</a></font></div>
</td>
<td width="4">&nbsp;</td>
</tr></table></td>
                  </tr>
                </table>
                          <table width="761" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td colspan="14"><img src="lb_images/stip_line1.jpg" width="761" height="6" /></td>
                            </tr>
                            <tr>
                              <td width="88" height="35" bgcolor="#FFFFFF">&nbsp;</td>
                              <td width="13" bgcolor="#FFFFFF"><img src="lb_images/bullet.jpg" width="13" height="12" /></td>
                              <td width="66" bgcolor="#FFFFFF"><span class="sheet"><a href="index.jsp">Home</a></span></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="lb_images/bullet.jpg" width="13" height="12" /></td>
                              <td width="112" bgcolor="#FFFFFF" class="sheet">
                              <a href="PrivacyPolicy.html">Privacy Policy</a></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="lb_images/bullet.jpg" width="13" height="12" /></td>
                              <td width="89" bgcolor="#FFFFFF" class="sheet">
                              <a href="SiteMap.html">Site Map</a></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="lb_images/bullet.jpg" width="13" height="12" /></td>
                              <td width="67" bgcolor="#FFFFFF" class="sheet">
                              <a href="Faqs.html">FAQs</a></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="lb_images/bullet.jpg" width="13" height="12" /></td>
                              <td width="96" bgcolor="#FFFFFF" class="sheet"><a href="ContactUs.html">Contact Us</td>
                              <td width="13" bgcolor="#FFFFFF" class="sheet"><img src="lb_images/bullet.jpg" width="13" height="12" /></td>
                              <td width="75" bgcolor="#FFFFFF" class="sheet">
                              <a href="feedback/GiveFeedback.html">Feedback</a></td>
                              <td width="90" bgcolor="#FFFFFF" class="sheet">&nbsp;</td>
                            </tr>
                            <tr>
                              <td colspan="14"><img src="lb_images/stip_line2.jpg" width="761" height="6" /></td>
                            </tr>
                            <tr>
                              <td height="35" colspan="14" bgcolor="#F3F2F0"><div align="center"><span class="sheet style14">Copyright &copy; 2007-2008 Learnbeyond. All Rights Reserved.</span></div></td>
                            </tr>
                            <tr>
                              <td colspan="14"><img src="lb_images/bottom_stip.jpg" width="761" height="7" /></td>
                            </tr>
                        </table></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
        <td width="6" background="lb_images/bg_right panel.jpg">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>
</form>	
</body>
</html>


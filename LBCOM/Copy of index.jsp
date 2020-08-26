<%@ page import = "java.sql.*,coursemgmt.ExceptionsFile,java.util.Vector,java.util.Iterator" %>
<%@ page language="java"  %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page" />

<%
  Connection con = null;
  Statement st = null;
  ResultSet rs = null;
  String cookieSchoolId = null,cookieUserId = null,cookiePass = null;
  Cookie mySchoolCookie=null,myCookieUser=null,myCookiePass=null;
	cookieSchoolId="schoolid";
	cookieUserId="userid";
	cookiePass="password";
	Cookie cookiesid [] = request.getCookies ();
	Cookie cookieuid [] = request.getCookies ();
	Cookie cookiepwd [] = request.getCookies ();
	if(cookiesid != null)
	{
	for(int i = 0; i < cookiesid.length; i++) 
	{
	if(cookiesid [i].getName().equals (cookieSchoolId))
	{
	mySchoolCookie = cookiesid[i];
	break;
	}
	}
	}
	if(cookieuid != null)
	{
	for(int i = 0; i < cookieuid.length; i++) 
	{
	if(cookieuid [i].getName().equals (cookieUserId))
	{
	myCookieUser = cookieuid[i];
	break;
	}
	}
	}
	if(cookiepwd!= null)
	{
	for(int i = 0; i < cookiepwd.length; i++) 
	{
	if(cookiepwd [i].getName().equals (cookiePass))
	{
	myCookiePass = cookiepwd [i];
	break;
	}
	}
	}
	%>

<html>
<head>
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
<title>Learnbeyond.net [Homepage]</title>
<meta name="generator" content="Namo WebEditor v5.0">
<style>A:hover {
	COLOR: red
}
A {
	TEXT-DECORATION: none
}</style>
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" leftmargin="0" marginwidth="0" topmargin="0" marginheight="0" background="images/lbeyond_bg.gif">
<form name="homepage" method="post" id="homepage" >
<table align="center" border="0" cellpadding="0" cellspacing="0" width="879" background="images/LBRT_07.gif">
    <tr>
        <td width="100%"><table id="Table_01" width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="24">
			<img id="LBRT_02" src="images/LBRT_02.gif" width="24" height="32" alt="" /></td>
		<td width="409" background="images/LBRT_03.gif" valign="middle">
                        <p align="left" style="letter-spacing:2;"><span style="font-size:8pt;"><font face="Arial">www.learnbeyond.net</font></span></p>
</td>
		<td width="409" background="images/LBRT_03.gif" valign="middle">
                        <div align="right">
                            <table border="0" cellpadding="0" cellspacing="0" width="300">
                                <tr>
                                    <td width="70" align="center" valign="bottom">
                                        <p align="right"><span style="font-size:8pt;"><font face="Arial"><img src="images/faq.gif" width="16" height="16" border="0"></font></span></p>
                                    </td>
                                    <td width="31" align="center" valign="bottom">
                                        <p><span style="font-size:8pt;"><font face="Arial"><a href="faq.html">FAQ</a></font></span></p>
                                    </td>
                                    <td width="49" align="center" valign="bottom">
                                        <p align="right"><span style="font-size:8pt;"><font face="Arial"><img src="images/sitemap.gif" width="16" height="16" border="0"></font></span></p>
                                    </td>
                                    <td width="51" align="center" valign="bottom">
                                        <p><span style="font-size:8pt;"><font face="Arial"><a href="sitemap.html">Site 
                                        Map</a></font></span></p>
                                    </td>
                                    <td width="34" align="center" valign="bottom">
                                        <p align="right"><span style="font-size:8pt;"><font face="Arial"><img src="images/contactus.gif" width="16" height="16" border="0"></font></span></p>
                                    </td>
                                    <td width="65" align="center" valign="bottom">
                                        <p align="left"><span style="font-size:8pt;"><font face="Arial">&nbsp;<a href="contactus.html">Contact 
                                        Us</a></font></span></p>
                                    </td>
                                </tr>
                            </table>
                        </div>
</td>
		<td width="36">
			<img id="LBRT_05" src="images/LBRT_05.gif" width="36" height="32" alt="" /></td>
	</tr>
</table>
        </td>
    </tr>
    <tr>
        <td width="100%">
            <table border="0" cellpadding="5" cellspacing="5" width="100%" height="100%">
                <tr>
                    <td width="431">			<a href="index.jsp"><img id="LBRT_10" src="images/LBRT_10.gif" width="251" height="75" alt="www.learnbeyond.com" / border="0"></a></td>
                    <td width="431">                        <p align="right"><img src="images/mohaninglogo.jpg" width="313" height="76" border="0"></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td width="100%">
            <table align="center" border="0" cellpadding="0" cellspacing="0" width="96%">
                <tr>
                    <td width="11">			<img id="LBRT_15" src="images/LBRT_15.gif" width="11" height="32" alt="" /></td>
                    <td width="100%" background="images/LBRT_17.gif">			
                        <table align="center" border="0" cellpadding="0" cellspacing="0" width="90%">
                            <tr>
                                <td width="24" valign="middle" height="24" align="center">
                                    <p align="center"><span style="font-size:9pt;"><font face="Arial"><img src="images/home.gif" width="16" height="17" border="0"></font></span></p>
                                </td>
                                <td width="87" valign="middle">
                                    <p><span style="font-size:9pt;"><a href="index.jsp"><font face="Arial">Home</font></a></span></p>
                                </td>
                                <td width="24" valign="middle" align="center">
                                    <p align="center"><span style="font-size:9pt;"><font face="Arial"><img src="images/abt.gif" width="15" height="18" border="0"></font></span></p>
                                </td>
                                <td width="95" valign="middle">
                                    <p><span style="font-size:9pt;"><a href="aboutus.html"><font face="Arial">About 
                                    Us</font></a></span></p>
                                </td>
                                <td width="29" valign="middle" align="center">
                                    <p align="center"><span style="font-size:9pt;"><font face="Arial"><img src="images/service.gif" width="29" height="20" border="0"></font></span></p>
                                </td>
                                <td width="157" valign="middle">
                                    <p><span style="font-size:9pt;"><a href="products.html"><font face="Arial">Products 
                                    &amp; Services</font></a></span></p>
                                </td>
                                <td width="24" valign="middle" align="center">
                                    <p align="center"><span style="font-size:9pt;"><font face="Arial"><img src="images/rigister.gif" width="21" height="21" border="0"></font></span></p>
                                </td>
                                <td width="96" valign="middle">
                                    <p><span style="font-size:9pt;"><a href="register.html"><font face="Arial">Register</font></a></span></p>
                                </td>
                                <td width="24" valign="middle" align="center">
                                    <p align="center"><span style="font-size:9pt;"><font face="Arial"><img src="images/news.gif" width="23" height="21" border="0"></font></span></p>
                                </td>
                                <td width="81" valign="middle">
                                    <p><span style="font-size:9pt;"><a href="news.html"><font face="Arial">News</font></a></span></p>
                                </td>
                                <td width="24" valign="middle" align="center">
                                    <p align="center"><span style="font-size:9pt;"><font face="Arial"><img src="images/feedback_01.gif" width="24" height="17" border="0"></font></span></p>
                                </td>
                                <td width="105" valign="middle">
                                    <p><span style="font-size:9pt;"><a href="feedback.html"><font face="Arial">Feedback</font></a></span></p>
                                </td>
                            </tr>
                        </table>
</td>
                    <td width="11">			
                        <p align="right"><img id="LBRT_18" src="images/LBRT_18.gif" width="11" height="32" alt="" /></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td width="100%" height="10">

        </td>
    </tr>
    <tr>
        <td width="100%">
            <table align="center" border="0" cellpadding="0" cellspacing="0" width="96%">
                <tr>
                    <td width="619">
                        <p><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://active.macromedia.com/flash4/cabs/swflash.cab#version=4,0,0,0" width="620" height="171">
                        <param name="Movie" value="images/main intro.swf">
                        <param name="Play" value="true">
                        <param name="Loop" value="true">
                        <param name="Quality" value="High">
                        <param name="_cx" value="5080">
                        <param name="_cy" value="5080">
                        <param name="Src" value="images/main intro.swf">
                        <param name="WMode" value="Window">
                        <param name="Menu" value="true">
                        <param name="Scale" value="ShowAll">
                        <param name="DeviceFont" value="false">
                        <param name="EmbedMovie" value="false">
                        <param name="SeamlessTabbing" value="false">
                        <param name="Profile" value="false">
                        <param name="ProfilePort" value="0">
                        <param name="AllowNetworking" value="all">
                        <param name="AllowFullScreen" value="false">
                        <embed Src="images/main intro.swf" Play="true" Loop="true" Quality="High" pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash" width="620" height="171" WMode="Window" Menu="true" Scale="ShowAll" DeviceFont="false" EmbedMovie="false" SeamlessTabbing="false" Profile="false" ProfilePort="0" AllowNetworking="all" AllowFullScreen="false"></embed>
                        </object></p>
                    </td>
                    <td width="224" align="right" valign="top">
<table id="Table_01" width="216" border="0" cellpadding="0" cellspacing="0" height="135">
	<tr>
		<td height="24">
			<img id="lbeyond_22" src="images/lbeyond_22.gif" width="216" height="24" alt="" /></td>
	</tr>
	<tr>
		<td background="images/lbeyond_24.gif">
			</td>
	</tr>
	<%
		String validFlag=request.getParameter("validFlag");
		
		if(validFlag==null)
			validFlag="";
		//if(validFlag.equals("invalid"))
		//{
%>
	<tr>
		<td background="images/lbeyond_24.gif" align="center" valign="top" height="139">
                                    <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                        <%
											if(mySchoolCookie==null)
											{
												System.out.println("mySchoolCookie is null...");
											%>
											<tr>
											<td width="55">
                                                <p><span style="font-size:9pt;"><font face="Arial">School ID</font></span></p>
                                            </td>
											<td width="147"><input type="text" name="schoolid" size="20" /></td>
											</tr>
											<%
											}
											else
											{
												System.out.println("mySchoolCookie is not null");
											%>
                                            
											<tr>
											<td width="55">
                                                <p><span style="font-size:9pt;"><font face="Arial">School ID</font></span></p>
												</td>
                                            <td width="147"><input type="text" name="schoolid" size="20" value="<%=mySchoolCookie.getValue()%>"/></td>
											</tr>
                                        
											<%
											}
											if(myCookieUser==null)
											{
											%>
											<tr>
                                            <td width="55">
                                                <p><span style="font-size:9pt;"><font face="Arial">User ID</font></span></p>
                                            </td>
											<td width="147"><input type="text" name="userid" size="20" /></td>
											</tr>
											<%
											}
											else
											{
											%>
											<tr>
                                            <td width="55">
                                                <p><span style="font-size:9pt;"><font face="Arial">User ID</font></span></p>
                                            </td>
											<td width="147"><input type="text" name="userid" size="20" value="<%=myCookieUser.getValue()%>"/></td>
                                        </tr>
											<%
											}
											if(myCookiePass==null)
											{
											%>
											<tr>
                                            <td width="55">
											<p><span style="font-size:9pt;"><font face="Arial">Password</font></span></p>
                                            </td>
                                            <td width="147"><input type="password" name="password" size="20" /></td>
											</tr>
											<%
											}
											else
											{
											%>
<tr>
                                            <td width="55">
											<p><span style="font-size:9pt;"><font face="Arial">Password</font></span></p>
                                            </td>
											<td width="147"><input type="password" name="password" size="20" value="<%=myCookiePass.getValue()%>"/></td>
											</tr>
											<%
											}
											%>
                                        
                                        <tr>
                                            <td width="50">
                                                <p align="center"><span style="font-size:10pt;"><font face="Arial">&nbsp;</font></span></p>
                                            </td>
                                            <td width="147">
                                                <p><span style="font-size:10pt;"><font face="Arial"><input type="checkbox" name="selbox" title="checkbox" checked="true">Remember 
                                                Me</font></span></p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="78" colspan="2" height="19"><a href="javascript://" onclick="validate();return false;"><img src="lb_images/submit_btn.jpg" width="53" height="20" border="0"/></a>
                                            </td>
											<td width="78"><a href="javascript://" onclick="reset();return false; "><img src="lb_images/reset_btn.jpg" width="54" height="20" border="0" /></a></td>
                                        </tr>
                                    </table>
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
	</tr>
	<tr>
		<td height="8">
			<img id="lbeyond_25" src="images/lbeyond_25.gif" width="216" height="10" alt="" /></td>
	</tr>
</table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td width="100%" height="10">
        </td>
    </tr>
    <tr>
        <td width="100%">
            <table align="center" border="0" cellpadding="0" cellspacing="0" width="96%">
                <tr>
                    <td width="106" valign="top">
                        <table border="0" cellpadding="0" cellspacing="0" width="198" height="100%">
                            <tr>
                                <td width="100%" height="24">			<img id="lbeyond_28" src="images/lbeyond_28.gif" width="198" height="24" alt="" /></td>
                            </tr>
                            <tr>
                                <td width="100%" background="images/lbeyond_32.gif" height="100%" bgcolor="#CCCCCC">
                                    <p><br><br><br><br><br><br><br><br><br><br><br>&nbsp;</p>
                                </td>
                            </tr>
                            <tr>
                                <td width="100%" height="13">			<img id="lbeyond_35" src="images/lbeyond_35.gif" width="198" height="13" alt="" /></td>
                            </tr>
                        </table>
                    </td>
                    <td width="721" valign="top" align="right">
                        <table id="Table_01" border="0" cellpadding="0" cellspacing="0" height="240" width="639">
	<tr>
		<td height="14" valign="top">
			<img id="lbeyond_30" src="images/lbeyond_30.gif" width="639" height="14" alt="" /></td>
	</tr>
	<tr>
		<td height="100%" background="images/lbeyond_31.gif" valign="top">
                                    <table border="0" cellpadding="0" cellspacing="5" width="100%">
                                        <tr>
                                            <td width="629">
                                                <p align="justify"><FONT face="Arial" color=#303030><B><span style="font-size:10pt;">Learnbeyond</span></B><span style="font-size:10pt;"> is a complete online learning and collaboration solution for 
students. Learnbeyond is powered by </span><A href="http://www.hotschools.net/" 
target=_blank><span style="font-size:10pt;">Hotschools</span></A><span style="font-size:10pt;">, a robust Learning Management and Collaboration 
System which has numerous features such as an easy to access Course Material 
Interface, an Informative Reporting System, Student-Student and Student-Teacher 
communication tools, an e-classroom, Assessment Reminders and more. <BR><BR>Our 
                                                </span><B><span style="font-size:10pt;">Courses</span></B><span style="font-size:10pt;"> and </span><B><span style="font-size:10pt;">K-caps</span></B><span style="font-size:10pt;"> (recorded classroom sessions) are the most 
affordable, when compared to any other online course provider. These courses 
will be delivered by reputed teachers, who will be available to guide the 
students almost around the clock. Students can login to the system, read the 
materials, listen to the K-Caps, and take the assessments whenever and wherever 
they want. <BR><BR></span><B><span style="font-size:10pt;">Learnbeyond</span></B><span style="font-size:10pt;"> lets parents monitor their kids' 
performance in assessments and assignments. They can also get a complete 
analysis of the time spent by their child in various activities such as reading 
materials, assessments, e-classroom, and Chat sessions with other students and 
teachers. <BR><BR>For the current </span><B><span style="font-size:10pt;">summer school program</span></B><span style="font-size:10pt;">, Learnbeyond 
offers more than 20 web based online courses and K-Caps for students in grades 4 
through 12. These courses cover complete course schedules, highly informative 
materials, and assessments/ assignments for each lesson, while the K-Caps cover 
the key areas and &quot;difficult to digest&quot; topics from various courses. <BR><BR>So, 
what are you waiting for? Simply register, select the courses you want to 
explore and learn beyond with Learnbeyond.</span></FONT></td>
                                        </tr>
                                    </table>
			</td>
	</tr>
	<tr>
		<td height="13" valign="bottom">
			<img id="lbeyond_36" src="images/lbeyond_36.gif" width="639" height="13" alt="" /></td>
	</tr>
</table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td width="100%" height="10">

        </td>
    </tr>
    <tr>
        <td width="100%">
            <table align="center" border="0" cellpadding="0" cellspacing="0" width="96%">
                <tr>
                    <td width="11">			<img id="LBRT_15" src="images/LBRT_15.gif" width="11" height="32" alt="" /></td>
                    <td width="100%" background="images/LBRT_17.gif">                        <table align="center" border="0" width="70%" height="32">
                            <tr>
                                <td width="274" align="center" valign="middle">
                                    <p><font face="Arial"><span style="font-size:9pt;"><a href="browserhelp.html">Browser 
                                    Specific Requirements</a></span></font></p>
                                </td>
                                <td width="-1" align="center" valign="middle">
                                    <p><font face="Arial"><span style="font-size:9pt;">|</span></font></p>
                                </td>
                                <td width="74" align="center" valign="middle">
                                    <p align="left"><font face="Arial"><span style="font-size:9pt;"><a href="faq.html">FAQ's</a></span></font></p>
                                </td>
                                <td width="4" align="center" valign="middle">
                                    <p><font face="Arial"><span style="font-size:9pt;">|</span></font></p>
                                </td>
                                <td width="103" align="center" valign="middle">
                                    <p align="left"><font face="Arial"><span style="font-size:9pt;"><a href="sitemap.html">Site 
                                    Map</a></span></font></p>
                                </td>
                                <td width="3" align="center" valign="middle">
                                    <p><font face="Arial"><span style="font-size:9pt;">|</span></font></p>
                                </td>
                                <td width="87" align="center" valign="middle">
                                    <p align="left"><font face="Arial"><span style="font-size:9pt;"><a href="feedback.html">Feedback</a></span></font></p>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="11">			
                        <p align="right"><img id="LBRT_18" src="images/LBRT_18.gif" width="11" height="32" alt="" /></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td width="100%"><table id="Table_01" width="100%" border="0" cellpadding="0" cellspacing="0" background="images/LBRT_46.gif">
	<tr>
		<td width="16">
			<img id="LBRT_43" src="images/LBRT_43.gif" width="16" height="27" alt="" /></td>
		<td width="846">
                        <p align="center"><font face="Arial"><span style="font-size:9pt;">Copyright 
                        © 2007-2008 <b>Learnbeyond</b>. All Rights Reserved.</span></font></p>
</td>
		<td width="17">
			<img id="LBRT_47" src="images/LBRT_47.gif" width="17" height="27" alt="" /></td>
	</tr>
</table>
        </td>
    </tr>
</table>
</body>

</html>


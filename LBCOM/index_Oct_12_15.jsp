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
	response.sendRedirect("/LBCOM/session/");

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
<META http-equiv=Content-Type content="text/html; charset=windows-1252">
<META content="MSHTML 6.00.6000.16850" name=GENERATOR>
<STYLE>A:hover {
	COLOR: red
}
A {
	TEXT-DECORATION: none
}
</STYLE>
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
<script language="javascript" src="images/index/validationscripts"></script>
<script type="text/javascript" src="/LBCOM/com/js/jquery-1.4.2.min.js"></script>
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
<meta name="generator" content="Microsoft FrontPage 5.0">
<style>A:hover {
	COLOR: red
}
A {
	TEXT-DECORATION: none
}</style>
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" leftmargin="0" marginwidth="0" topmargin="0" marginheight="0" background="images/lbeyond_bg.gif">

<!-- 
<script type="text/javascript">

    if(window.location.href.indexOf("k12assessments") > -1)  // This doesn't work, any suggestions?
    {
       window.location.href="http://nj.k12assessments.com/LBCOM/cookie/";
    }
	else
	{
		//window.location.href="/LBCOM/cookie/login.jsp";
		window.location.href="/LBCOM/cookie/";

	}

</script>
-->
<form name="homepage" method="post" id="homepage" >


</body>

</html>
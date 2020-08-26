<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import = "java.sql.*,coursemgmt.ExceptionsFile,java.util.Vector,java.util.Iterator,java.text.*, java.util.Date" %>
<%@ page language="java"  %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page" />
<html lang="en">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/bootstrap-responsive.css" rel="stylesheet">
    <link rel="stylesheet" href="css/Learnbeyond-login.css">

<head>
<meta charset="utf-8">
<title>Login page - Learnbeyond</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="Responsive HTML template for Your company" name="description">
<meta content=" " name="author">

<link href="favicon.ico" rel="shortcut icon">
	<script src="js/jquery.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/backstretch.js"></script>
    <script src="js/Learnbeyond-login.js"></script>
	<SCRIPT LANGUAGE="JavaScript">
<!--
	
	function popupsCheck()
	{
		var mine = window.open('','','width=1,height=1,left=0,top=0,scrollbars=no',target="_blank");
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
	}

//-->
</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" src="/LBCOM/common/Validations.js"></SCRIPT>
<script language="JavaScript">
<!-- 
var usr;
var popUpsBlocked=false;
var popmessage="";
var cookiemess="";
var uid="";
var pwd="";
var sid="";
var errmsg="";res=true;
var x = navigator;
function validate(frm){
	
	var homepage=document.homepage;
	if((popUpsBlocked)||(!x.cookieEnabled)){
		alert("please ensure that browser is configured as recommended in 'Browser Specific Requirements'");
//		window.location="/LBCOM/tech.html#browsers";
//		return false;
	}
	
	if(homepage.schoolid.value=="")
	{
		alert("Please enter Facility ID");
		homepage.schoolid.focus();
		return false;
	}
	else
		sid=homepage.schoolid.value;

	if(homepage.userid.value=="")
	{
		alert("Please enter Username");
		homepage.userid.focus();
		return false;
	}
	else
     uid=homepage.userid.value;
	if(homepage.password.value=="")
	{
		alert("Please enter Password");
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

					
	 window.location.href="/LBCOM/GetUserType?schoolid="+sid+"&userid="+uid+"&password="+pwd+"&checked="+chk;
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
<%
  Connection con = null;
  Statement st = null;
  ResultSet rs = null;
  String cookieSchoolId = null,cookieUserId = null,cookiePass = null;
  Cookie mySchoolCookie=null,myCookieUser=null,myCookiePass=null;

  SimpleDateFormat sdfInput =null;
%>
<%
try
{
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
</head>
<body onload="popupsCheck(); return false;">
<div class="navbar navbar-fixed-top">
<div class="navbar-inner">
<div class="container">

<a class="brand" href="/LBCOM/">
<img alt="Learnbeyond" src="images/logo.png">
</a>
</div>
</div>
</div>
<div class="container">
<div id="login-wraper">
<form name="homepage" method="post" id="homepage" class="form login-form" onSubmit="validate();return false;">

<legend>
Sign in to
<span class="blue">Learnbeyond</span>
</legend>
<div class="body">
<label>Facility ID</label>
 <%
			if(mySchoolCookie==null)
			{
%>
				<input type="text" name="schoolid" tabindex="1" placeholder="" required>
				
<%		}
else
	{
%>	<input type="text" name="schoolid" tabindex="1" placeholder="" value="<%=mySchoolCookie.getValue()%>">
		
<%}
%>
<label>Username</label>
<%	
if(myCookieUser==null)
	{
%>	<input type="text" name="userid" tabindex="2" placeholder="" required>
		
<%
	}
else
	{
%>	<input type="text" name="userid" tabindex="2" placeholder="" value="<%=myCookieUser.getValue()%>">
		
<%}
%>
<label>Password</label>
<%
	
if(myCookiePass==null)
	{
%>	
			<input type="password" tabindex="3" name="password" value="" required>
		  	
<%
	}
else
	{
%>
		   <input type="password" tabindex="3" name="password" value="<%=myCookiePass.getValue()%>">
		
<%
	}
%>

</div>
<div class="footer">
<label class="checkbox inline">
<%
	
if(myCookiePass==null)
	{
%>	
		   <input type="checkbox" name="selbox" tabindex="4" checked>&nbsp;Remember me</label>
		   
		
<%
	}
else
	{
%>
		<input type="checkbox" name="selbox" tabindex="4" checked>&nbsp;Remember me</label>
		
		
		
<%
	}

}
catch(Exception e)
{
	ExceptionsFile.postException("index.jsp","Operations on database","Exception",e.getMessage());
	System.out.println("Error in index.jsp:  -" + e.getMessage());
}
finally
{
	try
	{
		if(st!=null)
			st.close();
		if(con!=null && !con.isClosed())
			con.close();
	}
	catch(SQLException se)
	{
		ExceptionsFile.postException("index.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		System.out.println("SQL Error in index.jsp"+se.getMessage());
	}
}
	
%>
<!-- <input id="inlineCheckbox1" type="checkbox" value="option1"> -->

</label>
<button class="btn btn-success" type="submit">Sign in</button>
</div>
</form>
</div>
</div>
<footer class="white navbar-fixed-bottom">
Don't have an account yet?
<a class="btn btn-black" href="register.html">Register</a>
</footer>

<div class="backstretch" style="left: 0px; top: 0px; overflow: hidden; margin: 0px; padding: 0px; height: 74px; width: 1349px; z-index: -999999; position: fixed;">
<img style="position: absolute; margin: 0px; padding: 0px; border: medium none; width: 1349px; height: 758.442px; max-width: none; z-index: -999999; left: 0px; top: -342.221px;" src="images/bg3.png" class="deleteable">
<img style="position: absolute; margin: 0px; padding: 0px; border: medium none; width: 1349px; height: 758.442px; max-width: none; z-index: -999999; left: 0px; top: -342.221px; opacity: 0.0690969;" src="images/bg4.png">
</div>
</body>
</html>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import = "java.sql.*,coursemgmt.ExceptionsFile,java.util.Vector,java.util.Iterator" %>
<%@ page language="java"  %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <title>Learnbeyond's - K12 Credit Recovery - Contact Us</title><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="Generator" content="EditPlus">
  <meta name="Author" content="Learnbeyond, Inc">
  <meta name="Keywords" content="Credit Recovery, eLearning, K-12 learning, School Courses, High School, Middle School, Virtual School, Online Learning, Assessments, Assignments, Failing Schools, Standards based testing, Corporate Learning, online school, online courses, summer school online, high school credits online, online high school courses, home bound students, home schools">
  <meta name="Description" content="Learnbeyond's K12 Credit Recovery is an ideal program that helps Students who have failed a course to recover credit by redoing the course work, or at least the work which they failed to master in the original course.">

<link type='text/css' href='css/basic.css' rel='stylesheet' media='screen' />
<link href="css/style.css" rel="stylesheet" type="text/css" />

<style>
#loginForm {
    float: left;
    padding: 20px 30px;
    position: relative;
    width: 300px;
}
html.rtl #loginForm {
    float: right;
}
#loginForm label {
    display: block;
    font-weight: bold;
    padding: 4px 0;
}
#loginForm input {
    border: 1px solid #D8D8D8;
    font-family: Arial,sans-serif;
    font-size: 16px;
    padding: 4px;
    width: 292px;
}
#forgottenUsername, #forgottenPassword {
    display: block;
    padding: 4px 0 10px;
}
#loginForm input:focus {
    border: 1px solid #00AFF0;
    outline: medium none;
    padding: 4px;
}
.signInContainer {
    clear: both;
    padding-top: 14px;
}
#partnerLogins {
    float: left;
    padding: 20px 30px 20px 0;
    width: 300px;
}
html.rtl #partnerLogins {
    float: right;
    padding: 20px 0 20px 30px;
}
#alternativeSignInTitle {
    font-weight: bold;
    padding: 4px 0;
}
#microsoftLogin, #facebookLogin {
    cursor: pointer;
    display: block;
    font-size: 14px;
    height: 20px;
    line-height: 20px;
    margin-top: 14px;
    padding: 0 25px;
}
#microsoftLogin {
    background: url("../images/linking/msAccount.png") no-repeat scroll left center transparent;
}
#facebookLogin {
    background: url("../images/linking/fb.png") no-repeat scroll left center transparent;
}
html.rtl #microsoftLogin, html.rtl #facebookLogin {
    background-position: right center;
}

</style>
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
	
		sid=homepage.schoolid.value;

	if(homepage.userid.value=="")
	{
		alert("Please enter User ID");
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
<div id="wapper">
  
  <!-- \CONTROLLER/ -->


  
  <div id="container">
  
    <!-- \CENTER PANEL/ -->
  
    <div class="centerPanel">
  
      <!-- \ MAIN CONTROLLER PANEL / -->
  
      <div id="mainController">
  
        <!-- \TOP SEARCH PANEL / -->
		
		
			<div class="clear"></div>
			
			
				<div id="topPanel">
				
		<!-- \ LOGO PANEL / -->
	              <div class="logoPanel">
				    <a href="#"><img src="images/logo.png" alt="" border="0" /></a>
					
					 </div>
					
						<div class="centerWrapper">
   <span><img src="images/ico-phone.png" alt="Phone" width="20" height="16" hspace="2" align="left" /> Phone:</span>1-855-28-LEARN
            <span></span>(855-285-3276)
            <br/> <br/> <span><img src="images/ico-fax.png" alt="Fax" width="10" height="16" hspace="2" align="left" /> support:</span>732-658-5384&nbsp; <span><img src="images/ico-email.png" alt="Email" width="20" height="16" hspace="2"  align="absmiddle" /> Email:</span> <a href="mailto:creditrecovery@learnbeyond.com ">creditrecovery@learnbeyond.com</a></div>
   			 <!-- \ NAVIGATION PANEL / -->
   					
						<div id="login-btn" style="display: block; margin-left:20px;">
<a href="http://www.k12creditrecovery.com/"  >Home </a>
</div>		
      
				
				</div>
				
				 <!-- \ MAIN HEADER PANEL / -->
	    <div id="mainHeaderPanel42">
			
		  <div class="headerRighBox1">
			<h2 style="padding:0;"><!-- Login --><h6 ><b>Credit Recovery / Summer Courses Login</b></h6> </h2>
			<span class="headerTxt"></span>
							
		
		  </div>
		  
		   <!-- \ MAIN MIDDLE PANEL / -->
		  
		  <div id="mainMiddleBox">
			   <div class="middleController">
		  		
				  <!-- \ 	LEFT BOX / -->
 <%
		String validFlag=request.getParameter("validFlag");
		
		if(validFlag==null)
			validFlag="";
		//if(validFlag.equals("invalid"))
		//{
%>
				<div id="leftBox">
				 	<div class="leftContent">
					 <div class="box" align="center">
	

	
<form name="homepage" method="post" id="homepage" onSubmit="validate();return false;">

<div style="margin:0; width:80%; padding:0;display:inline"></div>

	  <div class="field text-field">
      <h6 align="left"><b>User Login </b></h6>
	    <label for="user_session_login">Username</label><br />
<%	
if(myCookieUser==null)
	{
%><input class="text-field" id="user_session_login" name="userid" size="30" type="text" />
<%
	}
else
	{
%><input class="text-field" id="user_session_login" name="userid" size="30" type="text"  value="<%=myCookieUser.getValue()%>" />
<%}
%>

	    <!-- <input class="text-field" id="user_session_login" name="userid" size="30" type="text" /> -->
	  </div>
	  <div class="field text-field">
	    <label for="user_session_password">Password</label><br />

 <%
	
if(myCookiePass==null)
	{
%><input class="text-field" id="user_session_password" name="password" size="30" type="password" />
<%
	}
else
	{
%>
<input class="text-field" id="user_session_password" name="password" size="30" type="password"  value="<%=myCookiePass.getValue()%>"/>
<%
	}
%>
	    <!-- <input class="text-field" id="user_session_password" name="password" size="30" type="password" /> -->
	  </div>
<%
if(myCookieUser==null)
	{
%>
		<div class="field">
	    <input name="user_session[remember_me]" type="hidden" value="0" />
		<input id="user_session_remember_me" name="selbox" type="checkbox" />
		<label for="user_session_remember_me" class="">Keep me logged in</label>
	  </div>
<%
	}
else
	{
%>
		<div class="field">
	    <input name="user_session[remember_me]" type="hidden" value="0" />
		<input id="user_session_remember_me" name="selbox" type="checkbox" checked="true" value="ON"/>
		<label for="user_session_remember_me" class="">Keep me logged in</label>
	  </div>
<%
	}
 %>
	  <div class="actions">
	    <input class="button" name="commit" type="submit" value="Login" /> <a href="/password_resets/new" class="forgotten-password" data-skip-pjax="true"><!-- Forgotten password? --></a>
	  </div>
</div>
					
				<div>
			
			
			
       
         
			
			
			
			
			
			
			</div>
					
					
						
			 	  </div>
					
					
					
					
					
				</div>
				
		<!-- \ 	RIGHT BOX / -->
		
	
		<div id="rightBox">
	   <div id="rightBox" style="width: 350px;">
    	
		<div class="rightContent">
        <h4> No Account yet? &nbsp; <a href="/LBCOM/cookie/StudentSignUp.jsp" class='basic'> Enroll Now </a></h4> 
        <br/><br/>
        
  
        
        <h6 style="color:#055b7f;">
        
         Learnbeyond is an effective platform that enables students to learn at their own pace, and also provides Unit Pretests to exempt students from previously-mastered concepts.</h6>
         <a href="http://k12creditrecovery.com/referwin">
<img border="0" align="left" alt="Refer & Win" src="http://k12creditrecovery.com/blog/wp-content/uploads/2013/05/referwin1.jpg">
</a>
	
	  
		</div>
		
		
		<!-- \ 	SEC RIGHT BOX / -->
		
	
		
		</div>
		
		</div>
			<div class="clear"></div>
	   </div>		
			
		   	<div class="clear"></div>
		</div>
	
		
		
		<!-- \ 	SEC RIGHT BOX / -->
		
		<br/>
        <br/><br/><br/>
        <br/><br/>
		
		</div>
		
		</div>
			<div class="clear"></div>
	   </div>		
			
		   	<div class="clear"></div>
		</div>
	
			
		
      </div>
    </div>
  </div>
  
  <!-- \ 	FOOTER BOX / -->
 <div id="main_footer_panel">
  <div class="main_footer_controller">
    <div class="centerPanel">
      <div class="main_footer_details">
	  <p><a href="#">Home </a>| <a href="about-us.html"> About Us </a> |<a href="howitworks.html">How it works</a> |<a href="catalog.html">Course Catalog </a> |<a href="contact-us.php"> Contact Us</a>|  </p>
        <h4>&copy; www.k12creditrecovery.com  powered  by <a href="http://learnbeyond.com/" target="_blank"><font color="#FFFF00"> Learnbeyond</font></a>.  All Rights Reserved</h4>
        
      </div>
    </div>
  </div>
</div>
</div>
<div id="basic-modal-content" align="left">
			<!-- <form name="homepage" method="post" style="float:left; " id="homepage" action="http://demo.learnbeyond.com:8080/LBCOM/cookie/Save12Contacts.jsp" onsubmit="return validate(this);" target="_parent"> -->
<div>  
<h4 align="center">Sign-Up for Summer Courses
                              <br/>
                              Please complete the following details. A LEARNBEYOND representative will contact you shortly. </h4>
<table class="table" width="100%" border="0" cellpadding="0" cellspacing="1" bordercolor="#111111" id="AutoNumber2" style="border-collapse: collapse; margin-left:10px;">
                       
							
                            <tr class="td">
                              <td colspan="2" class="td">&nbsp;</td>
                              </tr>
                            <tr class="td">
                              <td class="tdleft" align="left" width="40%">Student First Name</td>
                                    <td  >
                                      <input type="text" name="firstname" id="firstname" maxlength="100" size="50"><font color="#ff0000"> *</font></td></tr>
                                       <tr class="td">
                              <td class="tdleft" align="left">Student Last Name</td>
                                      <td><input type="text" name="lastname" id="lastname" maxlength="100" size="50"><font color="#ff0000"> *</font></td>
                                </tr>
								<tr >
                            <td   class="tdleft" align="left" height="32">Grade Courses interested in? &nbsp;</td>
                                  <td  class="td" height="20">
                                    <select name="studentgrade" id="studentgrade" size="1" style="width:320px;" >
                                      <option value=none selected>Select Grade</option>
                                      <option value="6thGrade">6thGrade
                                      <option value="7thGrade">7thGrade
                                      <option value="8thGrade">8thGrade
                                      <option value="9thGrade">9thGrade
                                      <option value="10thGrade">10thGrade
                                      <option value="11thGrade">11thGrade
                                      <option value="12thGrade">12thGrade
                                      </select><font color="#ff0000"> *</font></td>
                                </tr>
									<tr class="td">
                            <td  class="tdleft" align="left" height="24">Email Address &nbsp;</td>
                                  <td height="24" >
                                    <input type="text" name="studentmailid" id="studentmailid" maxlength="100" size="50"><font color="#ff0000"> *</font></td>
                                </tr>
                            <tr class="td">
                              <td  class="tdleft" align="left">Gender &nbsp;</td>
                                    <td >
                                      <select size="1" name="studentgender" style="width:320px;">
                                        <option value=none selected>Select</option>
                                        <option value="male" >Male</option>
                                        <option value="female" >Female</option>
                                      </select>                                  </td>
                                </tr>
                            <!-- <tr class="td">
                              <td class="tdleft" align="left">Date of Birth</td>
                                    <td >
                                      <SELECT name="mm"  id="mm" size="1">
                                        <OPTION value=0 selected>MONTH      
                                        <OPTION 
value=1>January      
                                        <OPTION value=2>February      
                                        <OPTION value=3>March      
                                        <OPTION 
value=4>April      
                                        <OPTION value=5>May      
                                        <OPTION value=6>June      
                                        <OPTION value=7>July      
                                        <OPTION 
value=8>August      
                                        <OPTION value=9>September      
                                        <OPTION value=10>October      
                                        <OPTION 
value=11>November      
                                        <OPTION value=12>December</OPTION>
                                      </SELECT>
                                      
                                      <select size="1" id="dd" name="dd">
                                        <option selected value="0">DD</option>
                                        <option value="01" >01</option>
                                        <option value="02" >02</option>
                                        <option value="03">03</option>
                                        <option value="04">04</option>
                                        <option value="05">05</option>
                                        <option value="06">06</option>
                                        <option value="07"> 07</option>
                                        <option value="08">08</option>
                                        <option value="09">09</option>
                                        <option value="10">10</option>
                                         <option value="11" >11</option>
                                         <option value="12" >12</option>
                                         <option value="13" >13</option>
                                         <option value="14" >14</option>
                                         <option value="15" >15</option>
                                         <option value="16" >16</option>
                                         <option value="17" >17</option>
                                         <option value="18" >18</option>
                                         <option value="19" >19</option>
                                         <option value="20" >20</option>
                                         <option value="21" >21</option>
                                         <option value="22" >22</option>
                                         <option value="23" >23</option>
                                         <option value="24" >24</option>
                                         <option value="25" >25</option>
                                         <option value="26" >26</option>
                                         <option value="27" >27</option>
                                         <option value="28" >28</option>
                                         <option value="29" >29</option>
                                         <option value="30" >30</option>
                                         <option value="31" >31</option>
                                      </select>
                                      <select size="1" name="yy" id="yy">
                                         <option value="1980" >1980</option>
                                         <option value="1981" >1981</option>
                                         <option value="1982" >1982</option>
                                         <option value="1983" >1983</option>
                                         <option value="1984" >1984</option>
                                         <option value="1985" >1985</option>
                                         <option value="1986" >1986</option>
                                         <option value="1987" >1987</option>
                                         <option value="1988" >1988</option>
                                         <option value="1989" >1989</option>
                                         <option value="1990" >1990</option>
                                         <option value="1991" >1991</option>
                                         <option value="1992" >1992</option>
                                         <option value="1993" >1993</option>
                                         <option value="1994" >1994</option>
                                         <option value="1995" >1995</option>
                                         <option value="1996" >1996</option>
                                         <option value="1997" >1997</option>
                                         <option value="1998" >1998</option>
                                         <option value="1999" >1999</option>
                                         <option value="2000" >2000</option>
                                         <option value="2001" >2001</option>
                                         <option value="2002" >2002</option>
                                         <option value="2003" >2003</option>
                                        <option value="0" selected>YYYY</option>
                                      </select></td>
                                </tr> -->
                            
                            <tr class="td">
                              <td class="tdleft" align="left"  > Address &nbsp;</td>
                                    <td ><input name="studentaddress" type="text" size="50" maxlength="250"></td>
                                </tr>
                            <tr class="td">
                              <td class="tdleft" align="left"  > City &nbsp;</td>
                                    <td ><input name="studentcity" type="text" size="50" maxlength="100"></td>
                                </tr>
                            <tr class="td">
                              <td class="tdleft" align="left"  > State &nbsp;</td>
                                    <td ><input name="studentstate" type="text" size="50" maxlength="30"></td>
                                </tr>
                            <tr class="td">
                              <td class="tdleft" align="left"  > Zip Code &nbsp;</td>
                                    <td ><input name="studentzipcode" type="text" size="50" maxlength="30"></td>
                                </tr>
                            <tr class="td">
                              <td class="tdleft" align="left"  > Country &nbsp;</td>
                                  <td >
                                      <SELECT size=1 name=country 
lf="forms[0].ADMI_CONTACT_COUNTRY" style="width:320px;">
                                        <OPTION value=US selected>United States        
                                        <OPTION value=AF>Afghanistan        
                                        <OPTION value=AL>Albania        
                                        <OPTION 
value=DZ>Algeria        
                                        <OPTION value=AS>American Samoa        
                                        <OPTION value=AD>Andorra        
                                        <OPTION 
value=AO>Angola        
                                        <OPTION value=AI>Anguilla        
                                        <OPTION value=AQ>Antarctica        
                                        <OPTION 
value=AG>Antigua and Barbuda        
                                        <OPTION value=AR>Argentina        
                                        <OPTION 
value=AM>Armenia        
                                        <OPTION value=AW>Aruba        
                                        <OPTION value=AU>Australia        
                                        <OPTION 
value=AT>Austria        
                                        <OPTION value=AZ>Azerbaijan        
                                        <OPTION value=BS>Bahamas        
                                        <OPTION 
value=BH>Bahrain        
                                        <OPTION value=BD>Bangladesh        
                                        <OPTION value=BB>Barbados        
                                        <OPTION 
value=BY>Belarus        
                                        <OPTION value=BE>Belgium        
                                        <OPTION value=BZ>Belize        
                                        <OPTION 
value=BJ>Benin        
                                        <OPTION value=BM>Bermuda        
                                        <OPTION value=BT>Bhutan        
                                        <OPTION 
value=BO>Bolivia        
                                        <OPTION value=BA>Bosnia-Herzegovina        
                                        <OPTION 
value=BW>Botswana        
                                        <OPTION value=BV>Bouvet Island        
                                        <OPTION value=BR>Brazil        
                                        <OPTION 
value=IO>British Indian Ocean Territories        
                                        <OPTION value=BN>Brunei Darussalam        
                                        <OPTION value=BG>Bulgaria        
                                        <OPTION value=BF>Burkina Faso        
                                        <OPTION 
value=BI>Burundi        
                                        <OPTION value=KH>Cambodia        
                                        <OPTION value=CM>Cameroon        
                                        <OPTION 
value=CA>Canada        
                                        <OPTION value=CV>Cape Verde        
                                        <OPTION value=KY>Cayman Islands        
                                        <OPTION 
value=CF>Central African Republic        
                                        <OPTION value=TD>Chad        
                                        <OPTION 
value=CL>Chile        
                                        <OPTION value=CN>China        
                                        <OPTION value=CX>Christmas Island        
                                        <OPTION 
value=CC>Cocos (Keeling) Island        
                                        <OPTION value=CO>Colombia        
                                        <OPTION 
value=KM>Comoros        
                                        <OPTION value=CG>Congo        
                                        <OPTION value=CD>Congo, Democratic republic of the (former Zaire)        
                                        <OPTION value=CK>Cook Islands        
                                        <OPTION 
value=CR>Costa Rica        
                                        <OPTION value=CI>Cote D'ivoire        
                                        <OPTION value=HR>Croatia        
                                        <OPTION 
value=CY>Cyprus        
                                        <OPTION value=CZ>Czech Republic        
                                        <OPTION value=DK>Denmark        
                                        <OPTION 
value=DJ>Djibouti        
                                        <OPTION value=DM>Dominica        
                                        <OPTION value=DO>Dominican Republic        
                                        <OPTION value=TP>East Timor        
                                        <OPTION value=EC>Ecuador        
                                        <OPTION 
value=EG>Egypt        
                                        <OPTION value=SV>El Salvador        
                                        <OPTION value=GQ>Equatorial Guinea        
                                        <OPTION value=ER>Eritrea        
                                        <OPTION value=EE>Estonia        
                                        <OPTION 
value=ET>Ethiopia        
                                        <OPTION value=FK>Falkland Islands (Malvinas)        
                                        <OPTION 
value=FO>Faroe Islands        
                                        <OPTION value=FJ>Fiji        
                                        <OPTION value=FI>Finland        
                                        <OPTION 
value=FR>France        
                                        <OPTION value=FX>France (Metropolitan)        
                                        <OPTION value=GF>French Guiana        
                                        <OPTION value=PF>French Polynesia        
                                        <OPTION value=TF>French Southern Territories        
                                        <OPTION value=GA>Gabon        
                                        <OPTION value=GM>Gambia        
                                        <OPTION 
value=GE>Georgia        
                                        <OPTION value=DE>Germany        
                                        <OPTION value=GH>Ghana        
                                        <OPTION 
value=GI>Gibraltar        
                                        <OPTION value=GR>Greece        
                                        <OPTION value=GL>Greenland        
                                        <OPTION 
value=GD>Grenada        
                                        <OPTION value=GP>Guadeloupe (French)        
                                        <OPTION value=GU>Guam (United States)        
                                        <OPTION value=GT>Guatemala        
                                        <OPTION value=GN>Guinea        
                                        <OPTION 
value=GW>Guinea-bissau        
                                        <OPTION value=GY>Guyana        
                                        <OPTION value=HT>Haiti        
                                        <OPTION 
value=HM>Heard &amp; McDonald Islands
                                        <OPTION value=VA>Holy See (Vatican City State)        
                                        <OPTION value=HN>Honduras        
                                        <OPTION value=HK>Hong Kong        
                                        <OPTION 
value=HU>Hungary        
                                        <OPTION value=IS>Iceland        
                                        <OPTION value=IN>India        
                                        <OPTION 
value=ID>Indonesia        
                                        <OPTION value=IQ>Iraq        
                                        <OPTION value=IE>Ireland        
                                        <OPTION 
value=IL>Israel        
                                        <OPTION value=IT>Italy        
                                        <OPTION value=JM>Jamaica        
                                        <OPTION 
value=JP>Japan        
                                        <OPTION value=JO>Jordan        
                                        <OPTION value=KZ>Kazakhstan        
                                        <OPTION 
value=KE>Kenya        
                                        <OPTION value=KI>Kiribati        
                                        <OPTION value=KR>Korea Republic of        
                                        <OPTION 
value=KW>Kuwait        
                                        <OPTION value=KG>Kyrgyzstan        
                                        <OPTION value=LA>Lao People's Democratic Republic        
                                        <OPTION value=LV>Latvia        
                                        <OPTION value=LB>Lebanon        
                                        <OPTION 
value=LS>Lesotho        
                                        <OPTION value=LR>Liberia        
                                        <OPTION value=LI>Liechtenstein        
                                        <OPTION 
value=LT>Lithuania        
                                        <OPTION value=LU>Luxembourg        
                                        <OPTION value=MO>Macau        
                                        <OPTION 
value=MK>Macedonia The Former Yugoslav Republic of        
                                        <OPTION 
value=MG>Madagascar        
                                        <OPTION value=MW>Malawi        
                                        <OPTION value=MY>Malaysia        
                                        <OPTION 
value=MV>Maldives        
                                        <OPTION value=ML>Mali        
                                        <OPTION value=MT>Malta        
                                        <OPTION 
value=MH>Marshall Islands        
                                        <OPTION value=MQ>Martinique        
                                        <OPTION 
value=MR>Mauritania        
                                        <OPTION value=MU>Mauritius        
                                        <OPTION value=YT>Mayotte        
                                        <OPTION 
value=MX>Mexico        
                                        <OPTION value=FM>Micronesia Federated States of        
                                        <OPTION 
value=MD>Moldavia Republic of        
                                        <OPTION value=MC>Monaco        
                                        <OPTION 
value=MN>Mongolia        
                                        <OPTION value=MS>Montserrat        
                                        <OPTION value=MA>Morocco        
                                        <OPTION 
value=MZ>Mozambique        
                                        <OPTION value=NA>Namibia        
                                        <OPTION value=NR>Nauru        
                                        <OPTION 
value=NP>Nepal        
                                        <OPTION value=NL>Netherlands        
                                        <OPTION value=AN>Netherlands Antilles        
                                        <OPTION value=NC>New Caledonia        
                                        <OPTION value=NZ>New Zealand        
                                        <OPTION 
value=NI>Nicaragua        
                                        <OPTION value=NE>Niger        
                                        <OPTION value=NG>Nigeria        
                                        <OPTION 
value=NU>Niue        
                                        <OPTION value=NF>Norfolk Island        
                                        <OPTION value=MP>Northern Mariana Island        
                                        <OPTION value=NO>Norway        
                                        <OPTION value=OM>Oman        
                                        <OPTION 
value=PK>Pakistan        
                                        <OPTION value=PW>Palau        
                                        <OPTION value=PA>Panama        
                                        <OPTION 
value=PG>Papua New Guinea        
                                        <OPTION value=PY>Paraguay        
                                        <OPTION value=PE>Peru        
                                        <OPTION 
value=PH>Philippines        
                                        <OPTION value=PN>Pitcairn        
                                        <OPTION value=PL>Poland        
                                        <OPTION 
value=PT>Portugal        
                                        <OPTION value=PR>Puerto Rico        
                                        <OPTION value=QA>Qatar        
                                        <OPTION 
value=RE>Reunion        
                                        <OPTION value=RO>Romania        
                                        <OPTION value=RU>Russian Federation        
                                        <OPTION value=RW>Rwanda        
                                        <OPTION value=SH>Saint Helena        
                                        <OPTION 
value=KN>Saint Kitts and Nevis        
                                        <OPTION value=LC>Saint Lucia        
                                        <OPTION value=PM>Saint Pierre and Miquelon        
                                        <OPTION value=VC>Saint Vincent and the Grenadines        
                                        <OPTION 
value=WS>Samoa        
                                        <OPTION value=SM>San Marino        
                                        <OPTION value=ST>Sao Tome and Principe        
                                        <OPTION value=SA>Saudi Arabia        
                                        <OPTION value=SN>Senegal        
                                        <OPTION 
value=SC>Seychelles        
                                        <OPTION value=SL>Sierra Leone        
                                        <OPTION 
value=SG>Singapore        
                                        <OPTION value=SK>Slovakia (Slovak Republic)        
                                        <OPTION 
value=SI>Slovenia        
                                        <OPTION value=SB>Solomon Islands        
                                        <OPTION value=SO>Somalia        
                                        <OPTION 
value=ZA>South Africa        
                                        <OPTION value=GS>South Georgia and South Sandwich Islands        
                                        <OPTION value=ES>Spain        
                                        <OPTION value=LK>Sri Lanka        
                                        <OPTION 
value=SR>Suriname        
                                        <OPTION value=SJ>Svalbard &amp; Jan Mayen Islands
                                        <OPTION 
value=SZ>Swaziland        
                                        <OPTION value=SE>Sweden        
                                        <OPTION value=CH>Switzerland        
                                        <OPTION 
value=TW>Taiwan Province of China        
                                        <OPTION value=TJ>Tajikistan        
                                        <OPTION 
value=TZ>Tanzania United Republic of        
                                        <OPTION value=TH>Thailand        
                                        <OPTION 
value=TG>Togo        
                                        <OPTION value=TK>Tokelau        
                                        <OPTION value=TO>Tonga        
                                        <OPTION 
value=TT>Trinidad &amp; Tobago
                                        <OPTION value=TN>Tunisia        
                                        <OPTION 
value=TR>Turkey        
                                        <OPTION value=TM>Turkmenistan        
                                        <OPTION value=TC>Turks &amp; Caicos Islands
                                        <OPTION value=TV>Tuvalu        
                                        <OPTION value=UG>Uganda        
                                        <OPTION 
value=UA>Ukraine        
                                        <OPTION value=AE>United Arab Emirates        
                                        <OPTION value=GB>United Kingdom        
                                        <OPTION value=UM>United States Minor Outlying Islands        
                                        <OPTION 
value=UY>Uruguay        
                                        <OPTION value=UZ>Uzbekistan        
                                        <OPTION value=VU>Vanuatu        
                                        <OPTION 
value=VE>Venezuela        
                                        <OPTION value=VN>Viet Nam        
                                        <OPTION value=VG>Virgin Islands (British)        
                                        <OPTION value=VI>Virgin Islands (United States)        
                                        <OPTION value=WF>Wallis &amp; Futuna Islands
                                        <OPTION value=EH>Western Sahara        
                                        <OPTION value=YE>Yemen        
                                        <OPTION 
value=YU>Yugoslavia        
                                        <OPTION value=ZM>Zambia</OPTION>
                                      </SELECT>                                  </td>
                                </tr>
                            <tr class="td">
                              <td class="tdleft" align="left">Contact Phone&nbsp;</td>
                                    <td ><input name="studentphone" id="studentphone" type="text" size="50" maxlength="30"><font color="#ff0000"> *</font></td>
                                </tr>
                            <!-- <tr class="td">
                              <td class="tdleft" align="left">Fax</td>
                                    <td ><input name="studentfax" type="text" size="20" maxlength="30"></td>
                                </tr> 
                            <tr class="td">
                              <td class="tdleft" align="left">Personal Website &nbsp;</td>
                                    <td><input name="studentwebsite" type="text" size="20" maxlength="250"></td>
                                </tr> -->

								<tr class="td">
                              <td class="tdleft" align="left" >Name of the Parent/Guardian&nbsp;</td>
                                    <td >
                                      <input type="text"  id="parentname" name="parentname" maxlength="100" size="50"><font color="#ff0000"> *</font></td>
                                </tr>
                            <tr class="td">
                              <td class="tdleft" align="left" >Parent's&nbsp; Email 
                              Address &nbsp;</td>
                                    <td >
                                      <input type="text" id="parentmailid" name="parentmailid" maxlength="100" size="50"><font color="#ff0000"> *</font></td>
                                </tr>
								 <tr class="td">
                              <td class="tdleft" align="left" >Reference Code: (if you have one?)&nbsp;</td>
                                    <td >
                                      <textarea id="refcode" name="refcode" rows="1" cols="50"></textarea></font></td>
                                </tr>
                            </table></td>
                          </tr>
                        </table>
                        
                        <table width="100%"  border="0" cellpadding="0" cellspacing="0">
                        <tr><td>&nbsp;</td></tr>
						  <tr  align="center">
                              <td colspan="2" >
                              
                                <input type="submit" name="submit" value="  Submit  " >
                                <input type="reset" name="reset" value="  Reset  "></td>
                                </tr>
                        </table>



                        
</div>
<input type="hidden" name="schoolid" value="training">
		  </div>
</form>
		
<script type='text/javascript' src='js/jquery.js'></script>
<script type='text/javascript' src='js/jquery.simplemodal.js'></script>
<script type='text/javascript' src='js/basic.js'></script>
<%		
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
</body>
</html>

<%@page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" scope="page" class="sqlbean.DbBean"/>
<%
	java.util.Date fdate=null,tdate=null;
	int tdays=0,cdays=0,uType=0;
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>New Page 1</title>
<script language="javascript" src="/LBCOM/validationscripts.js"></script>
<script language="JavaScript">
<!--
function dateConvert(){
	var win=window.document.MyFrm;
	var mon=parseInt(win.fmonth.value)+1;
	win.fromdate.value=win.fyear.value+'/'+mon+'/'+win.fdate.value;
	mon=parseInt(win.month.value)+1;
	win.lastdate.value=win.year.value+'/'+mon+'/'+win.date.value;
		
}

function validateDate(dd,mm,yy){
	var toDay;
	if(isValidDate(dd,mm,yy)==true){
		var dob=new Date(yy.value,mm.value,dd.value);
		var to=new Date();
		if(navigator.appName=="Netscape")
			toDay=new Date(to.getYear()+1900,to.getMonth(),to.getDate());
		else
			toDay=new Date(to.getYear(),to.getMonth(),to.getDate());
		if((dob-toDay)<0){
			alert("You cannot represent past date!");
			dd.focus();
			return false;
		}
		else
		{
			return true;
		}
	}
	else
		return false;
}

function isValidDate(dd,mm,yy){
   d=dd.value;
   m=parseInt(mm.value)+1;
   y=yy.value;

   var dinm = new Array(0,31,28,31,30,31,30,31,31,30,31,30,31);
   tday=new Date();
   if(y <=1900 ||isNaN(y)){
     alert("Enter valid year");
     return false;
   }
   else
     if(y %4==0 &&(y%100!=0 ||y%400==0))
       dinm[2]=29;
   if((m > 12 || m < 1)|| isNaN(m)){
      alert("Enter valid month");
      return false;
   }
   if((d<1 || d >dinm[m])||isNaN(d)){
     alert("Enter valid Date");
     return false;
   }
   return true;
}
function addOptions(){
		var frm=document.MyFrm;
		var date=new Date();
		var month=new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
		frm.fmonth.length=13;
		frm.fdate.length=32;
		frm.fyear.length=10;
		frm.fmonth[0]=new Option("MM","");
		for(i=0;i<12;i++)
			frm.fmonth[i+1]=new Option(month[i],i);
		frm.fdate[0]=new Option("DD","");
		for(i=1;i<=31;i++)
			frm.fdate[i]=new Option(i,i);
		frm.fyear[0]=new Option("YYYY","");
		for(i=date.getFullYear(),j=1;i<date.getFullYear()+10;i++,j++)
			frm.fyear[j]=new Option(i,i);

		frm.month.length=13;
		frm.date.length=32;
		frm.year.length=10;
		frm.month[0]=new Option("MM","");
		for(i=0;i<12;i++)
			frm.month[i+1]=new Option(month[i],i);
		frm.date[0]=new Option("DD","");
		for(i=1;i<=31;i++)
			frm.date[i]=new Option(i,i);
		frm.year[0]=new Option("YYYY","");
		for(i=date.getFullYear(),j=1;i<date.getFullYear()+10;i++,j++)
			frm.year[j]=new Option(i,i);

		frm.fmonth.value=date.getMonth();
		frm.fyear.value=date.getYear();
		if(navigator.appName=="Netscape")
			frm.fyear.value=date.getYear()+1900;
		frm.fdate.value=date.getDate();
		frm.month.value="";
		frm.year.value="";
		frm.date.value="";
		return false;
	}
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
// -->
function validate(frm)
{

	if(trim(frm.schoolid.value)=="")
	{
		alert("Please enter schoolid");
		frm.schoolid.focus();
		return false;
	}
	if(trim(frm.password.value)=="")
	{
		alert("Please enter password");
		frm.password.focus();
		return false;
	}
	if(trim(frm.ConfPassword.value)=="")
	{
		alert("Please enter confirm password");
		frm.ConfPassword.focus();
		return false;
	}
	if(trim(frm.schoolname.value)=="")
	{
		alert("Please enter School Name");
		frm.schoolname.focus();
		return false;
	}
	
	if(trim(frm.state.value)=="")
	{
		alert("Please enter state");
		frm.state.focus();
		return false;
	}
	
	if(isValidEmail(frm.emailid.value)==false)
	{
		frm.emailid.focus();
		return false;
	}
	
	if(trim(frm.nonstaff.value)=="")
		frm.nonstaff.value="0";

	if(trim(frm.noofteachers.value)=="")
		frm.noofteachers.value="0";
	
	replacequotes();


	if(frm.fdate.disabled==false)
		if(validateDate(frm.fdate,frm.fmonth,frm.fyear)==false)
			return false;

	if(validateDate(frm.date,frm.month,frm.year)==false)
			return false;
	dateConvert();

	frm.fdate.disabled=false;
	frm.fmonth.disabled=false;
	frm.fyear.disabled=false;
		
	if(frm.mod_permission[0].checked)
	{
		frm.modify_profile.value="1";	
	}
	else if(frm.mod_permission[1].checked)
	{
		frm.modify_profile.value="0";	
	}
	
	
}

</script>

</head>

<body>
<form name="MyFrm" action="/LBCOM/registration.RegisterAdmin" onSubmit="return validate(this);" target="_self" method="post">
<!-- <form name="MyFrm" action="#" onSubmit="return validate(this);" target="_self" method="post"> -->
<input type="hidden" name="fromdate">
<input type="hidden" name="lastdate">
<input type="hidden" name="comments">
<div align="center">
  <center>
  <table border="0" cellspacing="1" width="70%">
    <tr>
      <td width="100%" colspan="2" height="27" bgcolor="#C28256">
      <font face="Verdana" size="2">&nbsp;<b>Facility Registration</b></font></td>
    </tr>
    <tr>
      <td width="38%" height="19" bgcolor="#DDB9A2"><font face="Verdana" size="2">&nbsp;Facility ID</font></td>
      <td width="62%" height="19" bgcolor="#EEDDD2">
                  
          <font face=Verdana size=2>
          <!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="100" -->
		  <input maxlength="100" name="schoolid" size="20"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NameOnly(this, event)">
          <font color="#FF0000">*</font></font></td>
    </tr>
    <tr>
      <td width="38%" height="19" bgcolor="#DDB9A2"><font face="Verdana" size="2">&nbsp;Password</font></td>
      <td width="62%" height="19" bgcolor="#EEDDD2"> 
              <input type="password" name="password" size="20"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return pwdOnly(this, event)"><font color="#FF0000" face="Verdana" size="2"> 
              *</font></td>
    </tr>
    <tr>
      <td width="38%" height="19" bgcolor="#DDB9A2"><font face="Verdana" size="2">&nbsp;Confirm Password</font></td>
      <td width="62%" height="19" bgcolor="#EEDDD2"> 
              <input type="password" name="ConfPassword" size="20"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return pwdOnly(this, event)">
              <font color="#FF0000" face="Verdana" size="2">*</font></td>
    </tr>
    </table>
<br>
  </center>
</div>
<div align="center">
  <center>
  <table border="0" cellspacing="1" width="70%">
    <tr>
      <td width="100%" colspan="2" height="30" bgcolor="#C28256">
      <font face="Verdana" size="2"><b>&nbsp;Facility Information</b></font></td>
    </tr>
    <tr>
      <td width="38%" height="19" bgcolor="#DDB9A2"><font face="Verdana" size="2">&nbsp;Name of the 
      Facility</font></td>
      <td width="62%" height="19" bgcolor="#EEDDD2"> 
          
          <font face=Verdana size=2>
          <!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="100" -->
		  <input maxlength=100 name="schoolname" size="20"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NameOnly(this, event)">
          <font color="#FF0000">*</font></font></td>
    </tr>
    <tr>
      <td width="38%" height="19" bgcolor="#DDB9A2"><font face="Verdana" size="2">&nbsp;Department Type</font></td>
      <td width="62%" height="19" bgcolor="#EEDDD2"> 
		<select size=1 name=schooltype>
			<option value="Boys" selected>Boys</option>
            <option value="Girls">Girls</option>
            <option value="Co-education">Co-education</option>
            <option value="Military">Military</option>
            <option value="Elementary">Elementary</option>
            <option value="Junior">Junior</option>
            <option value="Secondary">Secondary</option>
          </select>
		</td>
    </tr>
    <tr>
      <td width="38%" height="19" bgcolor="#DDB9A2"><font face="Verdana" size="2">&nbsp;Address</font></td>
      <td width="62%" height="19" bgcolor="#EEDDD2"><textarea rows="3" name="address" cols="28"></textarea></td>
    </tr>
    <tr>
      <td width="38%" height="19" bgcolor="#DDB9A2"><font face="Verdana" size="2">&nbsp;City</font></td>
      <td width="62%" height="19" bgcolor="#EEDDD2"> 
          
          <font face=Verdana size=2>
          <!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="25" -->
		  <input maxlength="25" name="city" size="20"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return AlphaNumbersOnly(this, event)"> </font></td>
    </tr>
    <tr>
      <td width="38%" height="19" bgcolor="#DDB9A2"><font face="Verdana" size="2">&nbsp;State</font></td>
      <td width="62%" height="19" bgcolor="#EEDDD2"> 
          <font face=Verdana size=2>
          <!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="25" -->
		  <input maxlength="25" name="state" size="20"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return  NameOnly(this, event)">
          <font color="#FF0000">*</font></font></td>
    </tr>
    <tr>
      <td width="38%" height="19" bgcolor="#DDB9A2"><font face="Verdana" size="2">&nbsp;Zip Code</font></td>
      <td width="62%" height="19" bgcolor="#EEDDD2"> 
          <font face=Verdana size=2>
          <!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="25" -->
		  <input maxlength="25" name="zipcode" size="20"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NumbersOnly(this, event)"></font></td>
    </tr>
    <tr>
      <td width="38%" height="19" bgcolor="#DDB9A2"><font face="Verdana" size="2">&nbsp;Country</font></td>
      <td width="62%" height="19" bgcolor="#EEDDD2"> 
          
<SELECT size=1 name="country" 
lf="forms[0].ADMI_CONTACT_COUNTRY"><OPTION value="US" selected>United States
<OPTION value=AF>Afghanistan<OPTION value=AL>Albania<OPTION 
value=DZ>Algeria<OPTION value=AS>American Samoa<OPTION value=AD>Andorra<OPTION 
value=AO>Angola<OPTION value=AI>Anguilla<OPTION value=AQ>Antarctica<OPTION 
value=AG>Antigua and Barbuda<OPTION value=AR>Argentina<OPTION 
value=AM>Armenia<OPTION value=AW>Aruba<OPTION value=AU>Australia<OPTION 
value=AT>Austria<OPTION value=AZ>Azerbaijan<OPTION value=BS>Bahamas<OPTION 
value=BH>Bahrain<OPTION value=BD>Bangladesh<OPTION value=BB>Barbados<OPTION 
value=BY>Belarus<OPTION value=BE>Belgium<OPTION value=BZ>Belize<OPTION 
value=BJ>Benin<OPTION value=BM>Bermuda<OPTION value=BT>Bhutan<OPTION 
value=BO>Bolivia<OPTION value=BA>Bosnia-Herzegovina<OPTION 
value=BW>Botswana<OPTION value=BV>Bouvet Island<OPTION value=BR>Brazil<OPTION 
value=IO>British Indian Ocean Territories<OPTION value=BN>Brunei 
Darussalam<OPTION value=BG>Bulgaria<OPTION value=BF>Burkina Faso<OPTION 
value=BI>Burundi<OPTION value=KH>Cambodia<OPTION value=CM>Cameroon<OPTION 
value=CA>Canada<OPTION value=CV>Cape Verde<OPTION value=KY>Cayman Islands<OPTION 
value=CF>Central African Republic<OPTION value=TD>Chad<OPTION 
value=CL>Chile<OPTION value=CN>China<OPTION value=CX>Christmas Island<OPTION 
value=CC>Cocos (Keeling) Island<OPTION value=CO>Colombia<OPTION 
value=KM>Comoros<OPTION value=CG>Congo<OPTION value=CD>Congo, Democratic 
republic of the (former Zaire)<OPTION value=CK>Cook Islands<OPTION 
value=CR>Costa Rica<OPTION value=CI>Cote D'ivoire<OPTION value=HR>Croatia<OPTION 
value=CY>Cyprus<OPTION value=CZ>Czech Republic<OPTION value=DK>Denmark<OPTION 
value=DJ>Djibouti<OPTION value=DM>Dominica<OPTION value=DO>Dominican 
Republic<OPTION value=TP>East Timor<OPTION value=EC>Ecuador<OPTION 
value=EG>Egypt<OPTION value=SV>El Salvador<OPTION value=GQ>Equatorial 
Guinea<OPTION value=ER>Eritrea<OPTION value=EE>Estonia<OPTION 
value=ET>Ethiopia<OPTION value=FK>Falkland Islands (Malvinas)<OPTION 
value=FO>Faroe Islands<OPTION value=FJ>Fiji<OPTION value=FI>Finland<OPTION 
value=FR>France<OPTION value=FX>France (Metropolitan)<OPTION value=GF>French 
Guiana<OPTION value=PF>French Polynesia<OPTION value=TF>French Southern 
Territories<OPTION value=GA>Gabon<OPTION value=GM>Gambia<OPTION 
value=GE>Georgia<OPTION value=DE>Germany<OPTION value=GH>Ghana<OPTION 
value=GI>Gibraltar<OPTION value=GR>Greece<OPTION value=GL>Greenland<OPTION 
value=GD>Grenada<OPTION value=GP>Guadeloupe (French)<OPTION value=GU>Guam 
(United States)<OPTION value=GT>Guatemala<OPTION value=GN>Guinea<OPTION 
value=GW>Guinea-bissau<OPTION value=GY>Guyana<OPTION value=HT>Haiti<OPTION 
value=HM>Heard &amp; McDonald Islands<OPTION value=VA>Holy See (Vatican City 
State)<OPTION value=HN>Honduras<OPTION value=HK>Hong Kong<OPTION 
value=HU>Hungary<OPTION value=IS>Iceland<OPTION value=IN>India<OPTION 
value=ID>Indonesia<OPTION value=IQ>Iraq<OPTION value=IE>Ireland<OPTION 
value=IL>Israel<OPTION value=IT>Italy<OPTION value=JM>Jamaica<OPTION 
value=JP>Japan<OPTION value=JO>Jordan<OPTION value=KZ>Kazakhstan<OPTION 
value=KE>Kenya<OPTION value=KI>Kiribati<OPTION value=KR>Korea Republic of<OPTION 
value=KW>Kuwait<OPTION value=KG>Kyrgyzstan<OPTION value=LA>Lao People's 
Democratic Republic<OPTION value=LV>Latvia<OPTION value=LB>Lebanon<OPTION 
value=LS>Lesotho<OPTION value=LR>Liberia<OPTION value=LI>Liechtenstein<OPTION 
value=LT>Lithuania<OPTION value=LU>Luxembourg<OPTION value=MO>Macau<OPTION 
value=MK>Macedonia The Former Yugoslav Republic of<OPTION 
value=MG>Madagascar<OPTION value=MW>Malawi<OPTION value=MY>Malaysia<OPTION 
value=MV>Maldives<OPTION value=ML>Mali<OPTION value=MT>Malta<OPTION 
value=MH>Marshall Islands<OPTION value=MQ>Martinique<OPTION 
value=MR>Mauritania<OPTION value=MU>Mauritius<OPTION value=YT>Mayotte<OPTION 
value=MX>Mexico<OPTION value=FM>Micronesia Federated States of<OPTION 
value=MD>Moldavia Republic of<OPTION value=MC>Monaco<OPTION 
value=MN>Mongolia<OPTION value=MS>Montserrat<OPTION value=MA>Morocco<OPTION 
value=MZ>Mozambique<OPTION value=NA>Namibia<OPTION value=NR>Nauru<OPTION 
value=NP>Nepal<OPTION value=NL>Netherlands<OPTION value=AN>Netherlands 
Antilles<OPTION value=NC>New Caledonia<OPTION value=NZ>New Zealand<OPTION 
value=NI>Nicaragua<OPTION value=NE>Niger<OPTION value=NG>Nigeria<OPTION 
value=NU>Niue<OPTION value=NF>Norfolk Island<OPTION value=MP>Northern Mariana 
Island<OPTION value=NO>Norway<OPTION value=OM>Oman<OPTION 
value=PK>Pakistan<OPTION value=PW>Palau<OPTION value=PA>Panama<OPTION 
value=PG>Papua New Guinea<OPTION value=PY>Paraguay<OPTION value=PE>Peru<OPTION 
value=PH>Philippines<OPTION value=PN>Pitcairn<OPTION value=PL>Poland<OPTION 
value=PT>Portugal<OPTION value=PR>Puerto Rico<OPTION value=QA>Qatar<OPTION 
value=RE>Reunion<OPTION value=RO>Romania<OPTION value=RU>Russian 
Federation<OPTION value=RW>Rwanda<OPTION value=SH>Saint Helena<OPTION 
value=KN>Saint Kitts and Nevis<OPTION value=LC>Saint Lucia<OPTION value=PM>Saint 
Pierre and Miquelon<OPTION value=VC>Saint Vincent and the Grenadines<OPTION 
value=WS>Samoa<OPTION value=SM>San Marino<OPTION value=ST>Sao Tome and 
Principe<OPTION value=SA>Saudi Arabia<OPTION value=SN>Senegal<OPTION 
value=SC>Seychelles<OPTION value=SL>Sierra Leone<OPTION 
value=SG>Singapore<OPTION value=SK>Slovakia (Slovak Republic)<OPTION 
value=SI>Slovenia<OPTION value=SB>Solomon Islands<OPTION value=SO>Somalia<OPTION 
value=ZA>South Africa<OPTION value=GS>South Georgia and South Sandwich 
Islands<OPTION value=ES>Spain<OPTION value=LK>Sri Lanka<OPTION 
value=SR>Suriname<OPTION value=SJ>Svalbard &amp; Jan Mayen Islands<OPTION 
value=SZ>Swaziland<OPTION value=SE>Sweden<OPTION value=CH>Switzerland<OPTION 
value=TW>Taiwan Province of China<OPTION value=TJ>Tajikistan<OPTION 
value=TZ>Tanzania United Republic of<OPTION value=TH>Thailand<OPTION 
value=TG>Togo<OPTION value=TK>Tokelau<OPTION value=TO>Tonga<OPTION 
value=TT>Trinidad &amp; Tobago<OPTION value=TN>Tunisia<OPTION 
value=TR>Turkey<OPTION value=TM>Turkmenistan<OPTION value=TC>Turks &amp; Caicos 
Islands<OPTION value=TV>Tuvalu<OPTION value=UG>Uganda<OPTION 
value=UA>Ukraine<OPTION value=AE>United Arab Emirates<OPTION value=GB>United 
Kingdom<OPTION value=UM>United States Minor Outlying Islands<OPTION 
value=UY>Uruguay<OPTION value=UZ>Uzbekistan<OPTION value=VU>Vanuatu<OPTION 
value=VE>Venezuela<OPTION value=VN>Viet Nam<OPTION value=VG>Virgin Islands 
(British)<OPTION value=VI>Virgin Islands (United States)<OPTION value=WF>Wallis 
&amp; Futuna Islands<OPTION value=EH>Western Sahara<OPTION value=YE>Yemen<OPTION 
value=YU>Yugoslavia<OPTION value=ZM>Zambia</OPTION></SELECT>
<font color="#FF0000" face="Verdana" size="2">*</font></td>
    </tr>
    <tr>
      <td width="38%" height="19" bgcolor="#DDB9A2"><font face="Verdana" size="2">&nbsp;Phone</font></td>
      <td width="62%" height="19" bgcolor="#EEDDD2"> 
          
          <font face=Verdana size=2>
          <!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="25" -->
		  <input maxlength="25" name="phone" size="20"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return PhoneOnly(this, event)">
          <font color="#FF0000">*</font></font></td>
    </tr>
    <tr>
      <td width="38%" height="19" bgcolor="#DDB9A2"><font face="Verdana" size="2">&nbsp;Fax</font></td>
      <td width="62%" height="19" bgcolor="#EEDDD2"> 
          
          <font face=Verdana size=2>
          <!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="25" -->
		  <input maxlength="25" name="fax" size="20"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return PhoneOnly(this, event)"></font></td>
    </tr>
    <tr>
      <td width="38%" height="19" bgcolor="#DDB9A2"><font face="Verdana" size="2">&nbsp;Email Id</font></td>
      <td width="62%" height="19" bgcolor="#EEDDD2"> 
          
          <font face=Verdana size=2>
          <!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="50" -->
		  <input maxlength="50" name="emailid" size="20">
          <font color="#FF0000">*</font></font></td>
    </tr>
    <tr>
      <td width="38%" height="19" bgcolor="#DDB9A2"><font face="Verdana" size="2">&nbsp;Web site</font></td>
      <td width="62%" height="19" bgcolor="#EEDDD2"> 
          
          <font face=Verdana size=2>
          <!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="50" -->
		  <input maxlength="50" name="website" size="20"></font></td>
    </tr>
    <tr>
      <td width="38%" height="19" bgcolor="#DDB9A2"><font face="Verdana" size="2">&nbsp;No of Teachers</font></td>
      <td width="62%" height="19" bgcolor="#EEDDD2"> 
          
          <font face=Verdana size=2>
          <!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="3" -->
		  <input maxlength="3" size="5" name="noofteachers"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NumbersOnly(this, event)" value="0"></font></td>
    </tr>
	<tr>
	 <td width="38%" height="19" bgcolor="#DDB9A2"><font face="Verdana" size="2">&nbsp;Licenses Type</font></td>
		<td bgcolor="#EEDDD2">
				<font face="Arial" size="2"><input type="radio" name="license" value='seat' title="Seat Licenses - default" checked>&nbsp;Seat&nbsp;&nbsp;<input type="radio" name="license" value="student" title="Student Licenses">&nbsp;Student&nbsp;&nbsp;<input type="radio" name="license" value="concurrent" title="Concurrent Licenses">&nbsp;Concurrent</font>
			</td>
	</tr>
    <tr>
      <td width="38%" height="19" bgcolor="#DDB9A2"><font face="Verdana" size="2">&nbsp;No.of Student Licenses</font></td>
      <td width="62%" height="19" bgcolor="#EEDDD2"> 
          
         <!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="3" -->
		 <input maxlength="3" size="5" name="nonstaff" oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NumbersOnly(this, event)" value="0">&nbsp;<font face="verdana" color="#FF0000" size="1">*</font></td>
    </tr>
    <tr>
      <td width="38%" height="19" bgcolor="#DDB9A2"><font face="Verdana" size="2">&nbsp;Achievements</font></td>
      <td width="62%" height="19" bgcolor="#EEDDD2"> 
          
          <font size=2>
          <!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="200" -->
		  <textarea name="awards" rows="3" cols="29"></textarea></font></td>
    </tr>
	<TR>
			<TD bgcolor="#DDB9A2">
				<font face="Arial" size="2">Make Available From</font></TD>
			<TD bgcolor="#EEDDD2">
				<select size='1' name='fmonth'></select>
				<select size='1' name='fdate'></select>
				<select size='1' name='fyear'></select>
			</TD>
		</TR>
	<TR>
			<TD bgcolor="#DDB9A2">
				<font face="Arial" size="2">Make Available Up to&nbsp;</font></TD>
			<TD bgcolor="#EEDDD2">
				<select size='1' name='month'></select>
				<select size='1' name='date'></select>
				<select size='1' name='year'></select>
			</TD>
		</TR>
		<SCRIPT LANGUAGE="JavaScript">
<!--
addOptions();
//-->
</SCRIPT>
    <tr>
      <td width="100%" colspan="2" height="19">&nbsp;</td>
    </tr>
    <tr>
      <td width="100%" colspan="2" height="19" bgcolor="#C28256">
      <p align="center"><input type="submit" value="Submit" name="B1">&nbsp;&nbsp;
      <input type="reset" value="Reset" name="B2"></td>
    </tr>
  </table>
  </center>
</div>


		
  <input type="hidden" name="modify_profile" value="1"/>
  <input type="hidden" name="step" value="step2">
</form>

</body>

</html>
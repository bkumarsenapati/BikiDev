<%@ page language="java" import="java.io.*,java.util.*,java.sql.*,teacherAdmin.*,utility.FileUtility" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<% String schoolId="",passWord=""; %>
<%
	/*String standardsPath=application.getInitParameter("standards_path");
	Vector states=new Vector(2,2);
	FileUtility fu=null;
	
	if(fu.checkFile(standardsPath)){
		StateStandardsParser ssp=null;
		ssp=new StateStandardsParser(standardsPath);
		states=ssp.getChildAttributes("state","name");
	}else{
		states=null;
	}
	
	*/

	
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0"><meta name="author" content="Hotschoos, Inc.">
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

	if(trim(frm.schoolname.value)==""){
		alert("School Name should have atleast three characters");
		frm.schoolname.focus();
		return false;
		}
	if(trim(frm.state.value)==""){
		alert("Please enter state");
		frm.state.focus();
		return false;
	}

	if(isValidEmail(frm.emailid.value)==false){
		frm.emailid.focus();
		return false;
	}

	if(trim(frm.nonstaff.value)=="")
		frm.nonstaff.value="0";

	if(trim(frm.noofteachers.value)=="")
		frm.noofteachers.value="0";
	replacequotes();
//	alert(frm.mod_permission[0].checked);
	if(frm.mod_permission[0].checked){
		frm.modify_profile.value="1";	
	}else if(frm.mod_permission[1].checked){
		frm.modify_profile.value="0";	
	}


}

</script>

</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="MyFrm" action="/LBCOM/registration.RegisterAdmin" onSubmit="return validate(this);" target="_self" method="post">



<%
schoolId=request.getParameter("schoolid");
passWord=request.getParameter("password");
%>

<input type="hidden" name="schoolid" value=<%= schoolId %>>
<input type="hidden" name="password" value=<%= passWord %>>
<!--<input type="hidden" name="tag" value=<%= request.getParameter("tag") %>>-->
<input type="hidden" name="step" value="step2">
<div id="Layer2" style="width:571px; height:569px; position:absolute; left:110px; top:118px; z-index:2; overflow: visible"> 
    <table width="100%" border=0 align="center">
      <tbody> 
      <tr> 
        <td width="43%"> 
                    <p align="left"><font face="Verdana,Arial" size="2" color="#CE6500">Virtual School 
            Name</font>        </td>
        <td width="57%"> 
          
          <font face=Verdana size=2><!--webbot bot="Validation"
          B-Value-Required="TRUE" I-Maximum-Length="100" --><input maxlength=100 name=schoolname size="20"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NameOnly(this, event)">
          <font 
      color=#ff0000>*</font></font></td>
      </tr>
      <tr> 
        <td valign=top width="43%"> 
                    <p align="left"><font size="2" color="#CE6500" face="Verdana,Arial">Description 
            <br>
            <i>Enter a brief description of your </i></font><font face="Verdana,Arial" size="2" color="#CE6500">Virtual School</font><font size="2" color="#CE6500" face="Verdana,Arial"><i>, to appear on the login 
            page</i></font>        </td>
        <td width="57%"> 
          
          <font size=2><!--webbot bot="Validation" B-Value-Required="TRUE"
          I-Maximum-Length="100" --><textarea name=description rows=3 cols=30></textarea>
          </font></td>
      </tr>
      <tr> 
        <td width="43%"> 
                    <p align="left"><font face="Verdana,Arial" size="2" color="#CE6500">Virtual School</font><font size="2" color="#CE6500" face="Verdana,Arial"> 
            Type</font>        </td>
        <td width="57%"> 
          <font size=2><select size=1 name=schooltype>
            <option value=Boys selected>Select Type</option>
			<option 
        value=Junior>Grade K - 12</option>
            <option 
        value=Girls>K - 3</option>
            <option 
        value=Co-education>4 - 6 </option>
            <option 
        value=Military>Middle School</option>
            <option 
        value=Elementary>High School</option>
            <option 
        value=Junior>Junior</option>
            <option 
      value=Secondary>Other</option>
          </select>
          &nbsp;</font><font 
      color=#ff0000>*</font></font></td>
      </tr>
      <tr> 
        <td width="43%"> 
                    <p align="left"><font face="Verdana" size="2" color="#CE6500">Address</font>        </td>
        <td width="57%"> 
          
          <font face=Verdana size=2><!--webbot bot="Validation"
          B-Value-Required="TRUE" I-Maximum-Length="25" --><input maxlength=25  name=address size="20"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return AlphaNumbersOnly(this, event)">
          </font></td>
      </tr>
      <tr>
        <td width="43%"> 
                    <font face="Verdana" size="2" color="#CE6500">City</font>        </td>
        <td width="57%"> 
          
          <font face=Verdana size=2><!--webbot bot="Validation"
          B-Value-Required="TRUE" I-Maximum-Length="25" --><input maxlength=25 
    name=city size="20"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return AlphaNumbersOnly(this, event)">
          </font></td>
      </tr>
      <tr>
        <td width="43%"> 
                    <p align="left"><font size="2" color="#CE6500" face="Verdana,Arial">State</font>        </td>
        <td width="57%"> 
          <font face=Verdana size=2><!--webbot bot="Validation"
          B-Value-Required="TRUE" I-Maximum-Length="25" -->
		  <input maxlength="25" name="state" size="20"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return  NameOnly(this, event)"></font><font size=2>
          <font face="Verdana" color="#ff0000">*</font></font></td>
      </tr>
      <tr>
        <td width="43%"> 
                    <p align="left"><font size="2" color="#CE6500" face="Verdana,Arial">Zip
                    Code</font>        </td>
        <td width="57%"> 
          <font face=Verdana size=2><!--webbot bot="Validation"
          B-Value-Required="TRUE" I-Maximum-Length="25" --><input 
      maxlength="25" name="zipcode" size="20"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NumbersOnly(this, event)"></font><font size=2>
          &nbsp;</font></td>
      </tr>
      <tr>
        <td width="43%"> 
                    <p align="left"><font face="Verdana,Arial" size="2" color="#CE6500">Country</font>        </td>
        <td width="57%"> 
          
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
value=YU>Yugoslavia<OPTION value=ZM>Zambia</OPTION></SELECT><font face=Verdana 
      color=#ff0000>*</font></td>
      </tr>
      <tr> 
        <td width="43%"> 
                    <p align="left"><font face="Verdana,Arial" size="2" color="#CE6500">Phone</font>        </td>
        <td width="57%"> 
          
          <font face=Verdana size=2><!--webbot bot="Validation"
          B-Value-Required="TRUE" I-Maximum-Length="25" --><input 
      maxlength=25 name=phone size="20"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return PhoneOnly(this, event)">
          &nbsp;</font></td>
      </tr>
      <tr> 
        <td width="43%"> 
                    <p align="left"><font face="Verdana,Arial" size="2" color="#CE6500">Fax</font>        </td>
        <td width="57%"> 
          
          <font face=Verdana size=2><!--webbot bot="Validation"
          B-Value-Required="TRUE" I-Maximum-Length="25" --><input 
      maxlength=25 name=fax size="20"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return PhoneOnly(this, event)">
          </font></td>
      </tr>
      <tr> 
        <td width="43%" height="29"> 
                    <p align="left"><font face="Verdana,Arial" size="2" color="#CE6500">Email 
            Address</font>        </td>
        <td width="57%" height="29"> 
          
          <font face=Verdana size=2><!--webbot bot="Validation"
          B-Value-Required="TRUE" I-Maximum-Length="50" --><input maxlength=50 name=emailid size="20">
          <font 
      color=#ff0000>*</font></font></td>
      </tr>
      <tr> 
        <td width="43%"> 
                    <p align="left"><font face="Verdana,Arial" size="2" color="#CE6500">Web-site&nbsp;</font>        </td>
        <td width="57%"> 
          
          <font face=Verdana size=2><!--webbot bot="Validation"
          B-Value-Required="TRUE" I-Maximum-Length="50" --><input maxlength=50 
  name=website size="20">
          </font></td>
      </tr>
      <!-- <tr> 
        <td width="43%"> 
                    <p align="left"><font size="2" color="#CE6500" face="Verdana,Arial">Number 
            of teachers working</font>        </td>
        <td width="57%"> 
          
          <font face=Verdana size=2><!--webbot bot="Validation"
          B-Value-Required="TRUE" I-Maximum-Length="3" 
		  <input 
      maxlength=3 size=5 name=noofteachers  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NumbersOnly(this, event)" value=0>
          </font></td>
      </tr>
      <tr> 
        <td width="43%"> 
                    <p align="left"><font face="Verdana,Arial" size="2" color="#CE6500">Number 
            of non-teaching staff</font>        </td>
        <td width="57%"> 
          
          <font face=Verdana size=2><!--webbot bot="Validation"
          B-Value-Required="TRUE" I-Maximum-Length="3" <input 
      maxlength=3 size=5 name=nonstaff oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NumbersOnly(this, event)" value=0>
          </font></td>
      </tr> -->
	   
		  <%
		  /*
			if(states!=null && !states.isEmpty()){ 
				out.println("<tr> <td width='43%'><p align='left'><font face='Verdana,Arial' size='2' color='#CE6500'>State Standards</font></td>");
				out.println("<td width='57%'> <font face=Verdana size=2>");
			    out.println("<select id='st' name='states'><option value='none'>Select the State Standards</option>");
				Enumeration enum=states.elements();
				String state="";
				while(enum.hasMoreElements()){
					state=(String)enum.nextElement();
					out.println("<option value='"+state+"'>"+state+"</option>");
				}
				out.println("</select></td></tr>");
			}
		*/

		  %>
	  <!-- <tr> 
        <td valign=top width="50%"> 
            <p align="left"><font size="2" color="#CE6500" face="Verdana,Arial">Can Student modify his own profile:</font></td>
	        <td width="50%"><font size="2" face="Verdana,Arial"> <input type="radio" value="1" checked name="mod_permission"/>Yes  <input type="radio" value="0" name="mod_permission"/>No</font></td>
      </tr>   -->
     <!--  <tr> 
        <td valign=top width="50%"> 
                    <p align="left"><font size="2" color="#CE6500" face="Verdana,Arial">Your 
            </font><font face="Verdana,Arial" size="2" color="#CE6500">Virtual School</font><font size="2" color="#CE6500" face="Verdana,Arial">'s Achievements</font>        </td>
        <td width="50%"> 
          
          <font size=2><!--webbot bot="Validation" B-Value-Required="TRUE"
          I-Maximum-Length="200" <textarea name=awards rows=4 cols=30></textarea>
          </font></td>
      </tr> -->
      <!-- <tr> 
        <td width="100%" colspan="2">
          <p align="center"> 
          
          &nbsp;</p>
        </td>
      </tr> -->
      <tr> 
        <td width="100%" colspan=2> 
                    <p align="right">&nbsp;<font size=2><input style="font-family:Verdana; font-weight:bold; font-size:8pt; color:black;" type=submit value="Submit" name=B3></font>        </td>
                <td>          <p align="right"> 
<font size=2><input style="font-family:Verdana; font-weight:bold; font-size:8pt; color:black;" type=reset value="Reset" name=B2></font></p>
                </td>
      </tr>
      </tbody> 
    </table>
</div>
  <p align=center><b><font color=#ce6500 face="Verdana"><span style="font-size:10pt;"><br>Virtual School Details<br></span></font></b><font size=2 face="Arial"><font color=#000080>Note: All fields 
            marked with ' </font><font color=#ff0000>*</font><font color=#000080> ' are mandatory.</font></font><b><font color=#ce6500 face="Verdana"><span style="font-size:10pt;">&nbsp;</span></font></b></p>
  <p><font face=Verdana size=2><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></font><font face="Verdana" size="2" color="blue"><b>Step 
    2:</b> &nbsp;</font></p>
&nbsp; 
  <p><font size=2>&nbsp;&nbsp;&nbsp;</font> </p>
  <input type="hidden" name="modify_profile" value="1"/>
</form>
</body>

</html>

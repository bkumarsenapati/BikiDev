<%@ page import = "java.sql.*,java.lang.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<!-- CODE FOR SESSION HANDELING -->
<%@ include file="/common/checksession.jsp" %> 	
<!-- CODE FOR SESSION HANDELING -->
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page" />
<jsp:setProperty name="db" property="*" />

<%
	String mode="",schoolid="",status="";
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	java.util.Date reg_date=null;
	char reg_cat='g';
	int ddd=0,dmm=0,dyy=0;
	//PrintWriter out=null;

%>

<html>
<head>
<title></title>
<script language="JavaScript" src="/LBCOM/validationscripts.js"></script>
<script language="javascript">

   function changePassword(){
	      password_window = window.open("/LBCOM/ChangePassword.jsp","password_window","width=570,height=420");
	      password_window.moveTo(250,221);
  }
  function validate(frm){
		if(trim(frm.schoolname.value)==""){
		       alert("Please enter school name");
		       frm.schoolname.focus();
		       return false;
		}
		if(show_key(frm.schoolname)==false){
			alert("Enter alphabet only");
			frm.schoolname.focus();
			return false;
		}
		if(allowed_symbols(frm.address)==false){
		     alert("Special symbols are not supported");
		     frm.address.focus();
		     return false;
		}
		if (show_key(frm.state)==false){
			alert("Enter alphabet only");
			frm.state.focus();
			return false;
		}
		if (show_key(frm.state)==false){
			alert("Enter alphabet only");
			frm.state.focus();
			return false;
		}
		if(trim(frm.non_staff.value)=="")
		       frm.non_staff.value="0";

	        if(trim(frm.no_of_teachers.value)=="")
		         frm.no_of_teachers.value="0";
			 
		if(!isValidEmail(frm.emailid.value)){
           	frm.emailid.focus();
			return false;
		   
		}
		if (show_key(frm.state)==false) {
			alert("Enter alphabet only");
			frm.state.focus();
			return false;
		}
		if (show_key(frm.city)==false) {
			alert("Enter alphabet only");
			frm.city.focus();
			return false;
		}
		if (allowed_symbols(frm.website)==false) {
			alert("Special symbols are not supported");
			frm.website.focus();
			return false;
		}
		if (allowed_symbols(frm.description)==false) {
			alert("Special symbols are not supported");
			frm.description.focus();
			return false;
		}
		if (allowed_symbols(frm.state_standards)==false) {
			alert("Special symbols are not supported");
			frm.state_standards.focus();
			return false;
		}
		if (allowed_symbols(frm.awards)==false) {
			alert("Special symbols are not supported");
			frm.awards.focus();
			return false;
		}		
		if (isNaN(trim(frm.phone.value))) {
			alert("Enter numbers only");
			frm.phone.focus();
			return false;
		}
		if (isNaN(trim(frm.zipcode.value))) {
			alert("Enter numbers only");
			frm.zipcode.focus();
			return false;
		}
		if(trim(frm.country.value)=="none"){
			alert("Please select country");
		    frm.country.focus();
		    return false;
		}
}
	
  
	   function show_key(field)
	    {	var the_key=" abcdefghijklmnopqrstuvwxyz";

		var the_value=(field.value).toLowerCase();
		var the_char;
		var len=the_value.length;
		for(var i=0;i<len;i++){
		the_char=the_value.charAt(i);
		if(the_key.indexOf(the_char)==-1) {
			return false;
		    }
		}
	      }
	   
	 function allowed_symbols(field)
	    {	var the_key=" 0123456789abcdefghijklmnopqrstuvwxyz._-=+,)(*&^%$#@!~/\>><?";

		var the_value=(field.value).toLowerCase();
		var the_char;
		var len=the_value.length;
		for(var i=0;i<len;i++){
		the_char=the_value.charAt(i);
		if(the_key.indexOf(the_char)==-1) {
			return false;
		    }
		}
	      }
	  
	      	
</script>
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
<form name="TeacherReg" method="post" action="/LBCOM/schoolAdmin.ModifyAdmin" onsubmit="return validate(this);">

<table border="0" align="center" cellpadding="3" cellspacing="3" width="800">
	<tr>
		<td width="604" align="left" bgcolor="#EEBA4D">
		    <font face="Arial" size="2"><b>School Administrator Profile :</b></font></td>
   	</tr>
</table>

<table border="0" align="center" cellpadding="3" cellspacing="3" width="800">
<%
    session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
         if(sessid==null){
			response.sendRedirect("/LBCOM/NoSession.html");
	}

	schoolid=(String)session.getAttribute("schoolid");
	
	mode ="modify";// request.getParameter("mode");
		
	try
	{
		con = db.getConnection();	
		st = con.createStatement();
		System.out.println("11111111");
		rs=st.executeQuery("select * from school_profile where schoolid='"+schoolid+"'");
		if(rs.next())
		{
			if(mode.equals("modify"))
			{
%>
        
    <tr>
	     <td colspan="9" align="right">
			<FONT face=Arial><B>  
				<input type="button" name="cngpwd_button" value="Change Password" onclick="JavaScript : changePassword();" style="height: 21; border-style: solid; border-width: 1px">
                        </b></font></span>
         </td>
   </tr>   
   <TR>
                   <td width="262" colspan="2" align="left" valign="middle">
		   <p><span style="font-size:10pt;"><font face="Arial">School ID</font></span></p>
		   </TD>
		   <td width="8" align="center" valign="middle">
                          <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
                   </td>
                   <TD width="316" colspan="3">
		        <p><span style="font-size:10pt;"><font face="Arial">
                       <INPUT type="text" maxLength="50" size=25 name="schoolid" lf="forms[0].USER_NAME" value='<%=rs.getString("schoolid")%>' disabled></font></span>&nbsp<font color="red">*</font></p>
		   </TD>
	       </TR>
               
	       
	        <TR>
                   <td width="262" colspan="2" align="left" valign="middle">
		   <p><span style="font-size:10pt;"><font face="Arial">School Name</font></span></p>
		   </TD>
		   <td width="8" align="center" valign="middle">
                          <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
                   </td>
                   <TD width="316" colspan="3">
		        <p><span style="font-size:10pt;"><font face="Arial">
                       <INPUT type="text" maxLength="50" size=25 name="schoolname" value='<%=rs.getString("schoolname")%>' oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NameOnly(this, event)" ></font></span>&nbsp<font color="red">*</font></p>
		   </TD>
	       </TR>
       
	               
      <tr>
        <td width="262" colspan="2" align="left" valign="middle">
            <p><span style="font-size:10pt;"><font face="Arial">School Type</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
            <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="316" colspan="3">
	      <p>
		  <select size=1 name=schooltype>
		   <option value=Boys>Boys</option>
           <option  value=Girls>Girls</option>
           <option value=Co-education>Co-education</option>
           <option value=Military>Military</option>
           <option value=Elementary>Elementary</option>
           <option value=Junior>Junior</option>
           <option value=Secondary>Secondary</option>
          </select>
	  &nbsp<font color="red">*</font></p>
        </td>
    </tr>     
    <tr>
              <td width="262" colspan="2" align="left" valign="middle">
                 <span style="font-size:10pt;"><font face="Arial">Address</font></span>
              </td>
              <td width="8" align="center" valign="middle">
                 <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
              </td>
              <td width="316" colspan="3">
                 <p><input type="text" name="address" maxlength="50" size="25" value='<%=rs.getString("address")%>'><font color="red"> </font></p>
              </td>
         </tr>
        
	  <tr>
               <td width="262" colspan="2" align="left" valign="middle">
                   <p><span style="font-size:10pt;"><font face="Arial">City </font></span></p>
               </td>
               <td width="8" align="center" valign="middle">
                   <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
               </td>
               <td width="316" colspan="3">
                   <p><input type="text" name="city" maxlength="30" size="25" value='<%=rs.getString("city")%>' oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return AlphaNumbersOnly(this, event)"><font color="red"> </font></p>
               </td>
         </tr>
	 
          <tr>
                <td width="262" colspan="2" align="left" valign="middle">
                   <span style="font-size:10pt;"><font face="Arial">Zip Code</font></span>
                </td>
                <td width="8" align="center" valign="middle">
                    <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
                </td>
                <td width="316" colspan="3">
                    <p><input type="text" name="zipcode" maxlength="30" size="25" value='<%=rs.getString("zipcode")%>'   oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NumbersOnly(this, event)"></p>
                </td>
          </tr>
        
	   <tr>
                 <td width="262" colspan="2" align="left" valign="middle" >
                     <span style="font-size:10pt;"><font face="Arial">State</font></span>
                 </td>
                 <td width="8" align="center" valign="middle" height="30">
                      <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
                 </td>
                 <td width="316" colspan="3" >
				 <p><input type="text" name="state" maxlength="30" size="25" value='<%=rs.getString("state")%>' oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return  NameOnly(this, event)"></p>
                 </td>
            </tr>
        	    <tr>
                  <td colspan="2" align="left" valign="middle">
                      <p><span style="font-size:10pt;"><font face="Arial">Country</font></span></p>
                  </td>
                  <td align="center" valign="middle">
                      <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
                  </td>
                  <td colspan="3">
                      <p><SELECT size=1 name=country >
<OPTION value='none' selected>Select country
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
value=IO>British Indian Ocean Territories<OPTION value=BN>Brunei Darussalam<OPTION value=BG>Bulgaria<OPTION value=BF>Burkina
                  Faso<OPTION 
value=BI>Burundi<OPTION value=KH>Cambodia<OPTION value=CM>Cameroon<OPTION 
value=CA>Canada<OPTION value=CV>Cape Verde<OPTION value=KY>Cayman Islands<OPTION 
value=CF>Central African Republic<OPTION value=TD>Chad<OPTION 
value=CL>Chile<OPTION value=CN>China<OPTION value=CX>Christmas Island<OPTION 
value=CC>Cocos (Keeling) Island<OPTION value=CO>Colombia<OPTION 
value=KM>Comoros<OPTION value=CG>Congo<OPTION value=CD>Congo, Democratic
                  republic of the (former Zaire)<OPTION value=CK>Cook Islands<OPTION 
value=CR>Costa Rica<OPTION value=CI>Cote D'ivoire<OPTION value=HR>Croatia<OPTION 
value=CY>Cyprus<OPTION value=CZ>Czech Republic<OPTION value=DK>Denmark<OPTION 
value=DJ>Djibouti<OPTION value=DM>Dominica<OPTION value=DO>Dominican Republic<OPTION value=TP>East
                  Timor<OPTION value=EC>Ecuador<OPTION 
value=EG>Egypt<OPTION value=SV>El Salvador<OPTION value=GQ>Equatorial Guinea<OPTION value=ER>Eritrea<OPTION value=EE>Estonia<OPTION 
value=ET>Ethiopia<OPTION value=FK>Falkland Islands (Malvinas)<OPTION 
value=FO>Faroe Islands<OPTION value=FJ>Fiji<OPTION value=FI>Finland<OPTION 
value=FR>France<OPTION value=FX>France (Metropolitan)<OPTION value=GF>French
                  Guiana<OPTION value=PF>French Polynesia<OPTION value=TF>French
                  Southern Territories<OPTION value=GA>Gabon<OPTION value=GM>Gambia<OPTION 
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
value=NP>Nepal<OPTION value=NL>Netherlands<OPTION value=AN>Netherlands Antilles<OPTION value=NC>New
                  Caledonia<OPTION value=NZ>New Zealand<OPTION 
value=NI>Nicaragua<OPTION value=NE>Niger<OPTION value=NG>Nigeria<OPTION 
value=NU>Niue<OPTION value=NF>Norfolk Island<OPTION value=MP>Northern Mariana
                  Island<OPTION value=NO>Norway<OPTION value=OM>Oman<OPTION 
value=PK>Pakistan<OPTION value=PW>Palau<OPTION value=PA>Panama<OPTION 
value=PG>Papua New Guinea<OPTION value=PY>Paraguay<OPTION value=PE>Peru<OPTION 
value=PH>Philippines<OPTION value=PN>Pitcairn<OPTION value=PL>Poland<OPTION 
value=PT>Portugal<OPTION value=PR>Puerto Rico<OPTION value=QA>Qatar<OPTION 
value=RE>Reunion<OPTION value=RO>Romania<OPTION value=RU>Russian Federation<OPTION value=RW>Rwanda<OPTION value=SH>Saint
                  Helena<OPTION 
value=KN>Saint Kitts and Nevis<OPTION value=LC>Saint Lucia<OPTION value=PM>Saint
                  Pierre and Miquelon<OPTION value=VC>Saint Vincent and the
                  Grenadines<OPTION 
value=WS>Samoa<OPTION value=SM>San Marino<OPTION value=ST>Sao Tome and Principe<OPTION value=SA>Saudi
                  Arabia<OPTION value=SN>Senegal<OPTION 
value=SC>Seychelles<OPTION value=SL>Sierra Leone<OPTION 
value=SG>Singapore<OPTION value=SK>Slovakia (Slovak Republic)<OPTION 
value=SI>Slovenia<OPTION value=SB>Solomon Islands<OPTION value=SO>Somalia<OPTION 
value=ZA>South Africa<OPTION value=GS>South Georgia and South Sandwich Islands<OPTION value=ES>Spain<OPTION value=LK>Sri
                  Lanka<OPTION 
value=SR>Suriname<OPTION value=SJ>Svalbard &amp; Jan Mayen Islands<OPTION 
value=SZ>Swaziland<OPTION value=SE>Sweden<OPTION value=CH>Switzerland<OPTION 
value=TW>Taiwan Province of China<OPTION value=TJ>Tajikistan<OPTION 
value=TZ>Tanzania United Republic of<OPTION value=TH>Thailand<OPTION 
value=TG>Togo<OPTION value=TK>Tokelau<OPTION value=TO>Tonga<OPTION 
value=TT>Trinidad &amp; Tobago<OPTION value=TN>Tunisia<OPTION 
value=TR>Turkey<OPTION value=TM>Turkmenistan<OPTION value=TC>Turks &amp; Caicos
                  Islands<OPTION value=TV>Tuvalu<OPTION value=UG>Uganda<OPTION 
value=UA>Ukraine<OPTION value=AE>United Arab Emirates<OPTION value=GB>United
                  Kingdom<OPTION value=US >United States<OPTION value=UM>United States Minor Outlying Islands<OPTION 
value=UY>Uruguay<OPTION value=UZ>Uzbekistan<OPTION value=VU>Vanuatu<OPTION 
value=VE>Venezuela<OPTION value=VN>Viet Nam<OPTION value=VG>Virgin Islands
                  (British)<OPTION value=VI>Virgin Islands (United States)<OPTION value=WF>Wallis
                  &amp; Futuna Islands<OPTION value=EH>Western Sahara<OPTION value=YE>Yemen<OPTION 
value=YU>Yugoslavia<OPTION value=ZM>Zambia</OPTION></SELECT>&nbsp<font color="red">*</font></p>
                     </td>
              </tr>
        
	       <tr>
                      <td width="262" colspan="2" align="left" valign="middle">
                          <p><span style="font-size:10pt;"><font face="Arial">Phone</font></span></p>
                      </td>
                      <td width="8" align="center" valign="middle">
                          <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
                      </td>
                      <td width="316" colspan="3">
                      <p><input type="text" name="phone" maxlength="30" size="25" value='<%=rs.getString("phone")%>'   oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return PhoneOnly(this, event)"></p>
                      </td>
              </tr>
        
	       <tr>
                       <td width="262" colspan="2" align="left" valign="middle">
                            <p><span style="font-size:10pt;"><font face="Arial">Fax</font></span></p>
                       </td>
                       <td width="8" align="center" valign="middle">
                            <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
                       </td>
                       <td width="316" colspan="3">
                            <p><input type="text" name="fax" maxlength="30" size="25" value='<%=rs.getString("fax")%>'   oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NumbersOnly(this, event)"></p>
                       </td>
              </tr>
        
	      <tr>
                       <td width="262" colspan="2" align="left" valign="middle">
                            <p><span style="font-size:10pt;"><font face="Arial">Email 
                            Id</font></span></p>
                       </td>
                       <td width="8" align="center" valign="middle">
                            <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
                       </td>
                       <td  colspan="1">
                             <p><input type="text" name="emailid" maxlength="30" size="25" value='<%=rs.getString("emailid")%>'></p>
		       </td>
					<td align="left"> 
						<font face="arial" color="red" size="1">(Enter only valid email address)</font>
						<font color="red">*</font>
		       </td>
              </tr>
              <tr>
                      <td width="262" colspan="2" align="left" valign="middle">
                          <p><span style="font-size:10pt;"><font face="Arial">Website</font></span></p>
                      </td>
                      <td width="8" align="center" valign="middle">
                           <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
                      </td>
                      <td width="316" colspan="3">
                            <p><input type="text" name="website" maxlength="50" size="25" value='<%=rs.getString("website")%>'></p>
                      </td>
              </tr>
          
	       <tr>
                      <td width="262" colspan="2" align="left" valign="middle">
                             <p><span style="font-size:10pt;"><font face="Arial">Number of Teachers</font></span></p>
                      </td>
                      <td width="8" align="center" valign="middle">
                            <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
                      </td>
                      <td width="316" colspan="3">
                             <p><input type="text" name="no_of_teachers" maxlength="30" size="25" value='<%=rs.getString("no_of_teachers")%>'   oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NumbersOnly(this, event)"></p>
                       </td>
                </tr>
              
	       <tr>
                        <td width="262" colspan="2" align="left" valign="middle">
                             <p><span style="font-size:10pt;"><font face="Arial">Non Staff</font></span></p>
                        </td>
                        <td width="8" align="center" valign="middle">
                             <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
                        </td>
                        <td width="316" colspan="3">
                             <p><input type="text" name="non_staff" maxlength="30" size="25" value='<%=rs.getString("non_staff")%>'   oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NumbersOnly(this, event)"></p>
                        </td>
               </tr>
	       
	       
	        <tr>
                       <td width="262" colspan="2" align="left" valign="middle">
                           <p><span style="font-size:10pt;"><font face="Arial">Description of the School </font></span></p>
                       </td>
                       <td width="8" align="center" valign="center">
                           <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
                       </td>
                       <td width="316" colspan="3" align="left" valign="middle">
                               <p>
							   <textarea name="description" rows="3" cols="20"><%=rs.getString("description")%></textarea></p>
			    
			<!--    <p><textarea name="description" rows="4" cols="25"><%=rs.getString("description")%></textarea></p>
                         -->
		       </td>
                </tr>
        
	       
        
	       <tr>
                       <td width="262" colspan="2" align="left" valign="middle">
                              <p><span style="font-size:10pt;"><font face="Arial">State Standards</font></span></p>
                       </td>
                       <td width="8" align="center" valign="middle">
                              <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
                       </td>
                       <td width="316" colspan="3">
                               <p><input type="text" name="state_standards" maxlength="30" size="25" value='<%=rs.getString("state_standards")%>'></p>
                      </td>
                </tr>
        
	        <tr>
                      <td width="262" colspan="2" align="left" valign="middle">
                          <p><span style="font-size:10pt;"><font face="Arial">Awards</font></span></p>
                      </td>
                      <td width="8" align="center" valign="middle">
                           <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
                      </td>
                      <td width="316" colspan="3">
                           <p><input type="text" name="awards" maxlength="30" size="25" value='<%=rs.getString("awards")%>'></p>
                      </td>
                </tr>
        
	      	         
               <tr style="visibility:hidden">
                    <td width="262" colspan="2" align="left" valign="middle">
                          <p><span style="font-size:10pt;"><font face="Arial">Status</font></span></p>
                    </td>
                    <td width="8" align="center" valign="middle">
                          <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
                    </td>
	            	<%
			   if(rs.getString("status").equals("1"))
			   {
	         	%>
                     <td width="183">
                           <p>&nbsp;<input type="radio" value="1" checked name="status">Active
                     </td>
                     <td width="161" colspan="2">
                        <input type="radio" name="status" value="0">Inactive
                    </td>
		        <%
			    }
		        	else
			   {
		        %>
		     <td width="59">
                        <p>&nbsp;<input type="radio" value="1" name="status">Active
                    </td>
                   <td width="102">
                        <input type="radio" name="status" checked value="0">Inactive
                   </td>
		      <%
			}
		      %>
            </tr>
	
	        
	     <tr>
                  <td width="58">&nbsp;</td>
                  <td  align="right"><input type="submit" name="submit" value="Submit"></td>
                  <td width="8">&nbsp;</td>
				  <td align="left"><input type="button" name="init" onclick="clearfields()" value="Reset"></td>
				  <td >&nbsp;</td>
                  <td width="65" align="center" colspan="3">&nbsp;</td>
                 <td width="9">&nbsp;</td>
             </tr>
		    <input type="hidden" name="mode" value='<%=mode%>'>
	<%
	}else
	{
	%>
	
	<tr>
        <td width="604" colspan="6" height="80">
            <p><font face="Arial"><b><span style="font-size: 10pt">You can not Modify School Profile</span></b></font><span style="font-size:10pt;"><font face="Arial"><b>: </b></font></span></p>
        </td>
	
    </tr>
    
    <tr>
	     <td width="604" colspan="6">
                       <p> <SPAN style="FONT-SIZE: 10pt"><FONT face=Arial><B>  
		       <input type="button" name="cngpwd_button" value="Change Password" onclick="JavaScript : changePassword();" >
                        </b></font></span>
			</p>
            </td>
    </tr>   	
	<%
	}
	}
	%>	    	
   </table>
   <SCRIPT LANGUAGE="JavaScript">
   <!--
   function init(){
		document.TeacherReg.schooltype.value="<%=rs.getString("schooltype")%>";
		document.TeacherReg.country.value="<%=rs.getString("country")%>";
	}
	init();
   function clearfields(){
		document.TeacherReg.reset();
		init();


   }
   //-->
   </SCRIPT>
 </form>
   <%
		
		}
		catch(SQLException se){
			
			ExceptionsFile.postException("modifyTeacherReg.jsp","operations on database","SQLException",se.getMessage());
			
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("modifyTeacherReg.jsp","operations on database","Exception",e.getMessage());
			out.println("EXception :"+e);
		}
		finally
		{
			try
			{
				if(out!=null)
					out.close();
				if(rs!=null)
					rs.close();
				if(st!=null)
					st.close();
				if(con!=null)
					con.close();
			}
			catch(Exception ee){
				ExceptionsFile.postException("modifyTeacherReg.jsp","closing statement,resultset and connection objects","Exception",ee.getMessage());
			}
		}
%>
</body>
</html>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <title>Learnbeyond's - K12 Credit Recovery - Contact Us</title><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="Generator" content="EditPlus">
  <meta name="Author" content="Learnbeyond, Inc">
  <meta name="Keywords" content="Credit Recovery, eLearning, K-12 learning, School Courses, High School, Middle School, Virtual School, Online Learning, Assessments, Assignments, Failing Schools, Standards based testing, Corporate Learning, online school, online courses, summer school online, high school credits online, online high school courses, home bound students, home schools">
  <meta name="Description" content="Learnbeyond's K12 Credit Recovery is an ideal program that helps Students who have failed a course to recover credit by redoing the course work, or at least the work which they failed to master in the original course.">

<link type='text/css' href='css/basic.css' rel='stylesheet' media='screen' />
<link href="css/style.css" rel="stylesheet" type="text/css" />

<SCRIPT LANGUAGE="JavaScript" src="/LBCOM/common/Validations.js"></SCRIPT>

      
</head>
<body>
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
					
					
   			 <!-- \ NAVIGATION PANEL / -->
   			
          <div class="navigationPanel">
            <ul class="navList">
             <li><a href="index.html" ><span>Home</span> </a></li>
              <li><a href="about-us.html" ><span>About Us </span></a></li>
              <li><a href="howitworks.html" ><span>How it Works </span></a></li>
              <li><a href="catalog.html" ><span>Course Catalog </span></a></li>
              <li><a href="contact-us.html" class="over"><span>Contact Us</span></a></li>
               <a class="portlet-followus" target="_blank" title="Follow us on Facebook" href="http://www.facebook.com/pages/k12creditrecoverycom/369638543156291?ref=stream"><img src="images/fb.png" style="margin-left:10px; width:28px; height:29px;" /></a>
         <a class="portlet-followus" title="Follow us on Twitter" href="http://twitter.com/K12creditrecove" target="_blank"><img src="images/twit.png" style="margin-left:10px; width:28px; height:29px;"/></a>
            
            </ul>
			 <div class="clear"></div>
          </div>
					
				
				</div>
				<?php
if(isset($_POST['submit']) && $_POST['submit']!=''){ 
if($_POST['email']==''){ $error[0]="Please enter email";} else if (!eregi("^[A-Z0-9._%-]+@[A-Z0-9._%-]+\.[A-Z]{2,4}$", $_POST['email'])) 
{$error[0]="Please enter valid email";
	}
if($_POST['subject']==''){$error[1]="Please Enter subject";}
if($_POST['name']==''){ $error[2]="Please Enter Name";}
if($_POST['message']==''){ $error[3]="Please Enter Message";}
if(count($error)==0){
if(isset($_POST['submit'])){
 $subject = $_POST['subject'];
 $Name=$_POST['name'];
 $comments=$_POST['message'];
 $Email=$_POST['email'];
 


$email='info@learnbeyond.com';
$to       = $email; //Send email to our user
	
					$subject = 'Contact information'; //// Give the email a subject 
					$message = "Name:$Name,Subect:$subject,Message:$comments,Email:$Email";
					$headers = 'From:info@learnbeyond.com' . "\r\n"; // Set from headers
					$ok = @mail($to, $subject, $message, $headers); // Send the email	

if($ok) {
echo "<font face=verdana size=2><center><script>alert('Your request has been submitted.')</script>
</center>";
} else {
die(" <script>alert('Sorry but the email could not be sent. Please go back and try again!')</script>");
}}}}

?>
				 <!-- \ MAIN HEADER PANEL / -->
<div id="mainHeaderPanel4">
			
<div class="headerRighBox">
<h2>We’d love to hear from you! </h2>

			<span class="headerTxt">Please fill out the form below so we may assist you.<span class="invertedCode"><img src="images/inverted_code.gif" alt="" /></span></span>
							
			<div id='basic-modal'>
			<span class="blackButt"><a href='#' class='basic'>Enroll Now >></a></span></div>
						</div>
			 	 
		  </div>
		  
		   <!-- \ MAIN MIDDLE PANEL / -->
		  
		  <div id="mainMiddleBox">
			   <div class="middleController">
		  		
				  <!-- \ 	LEFT BOX / -->
				
				<div id="leftBox">
				 	<div class="leftContent">
					<h1>Contact <span>Us</span></h1>		 
					
					
				<div>
			
			
			
             	  <div class="maps_view">
          <div> <br />
            <h6><img src="images/map.png" alt="" width="280" height="180" class="project-img" /> Learnbeyond, Inc.<br />
50 Cragwood Road, <br />Suite 108B <br />
South Plainfield NJ 07080<br />
            </h6>
            <p>  <span><img src="images/ico-phone.png" alt="Phone" width="20" height="16" hspace="2" /> Phone:</span>1-855-28-LEARN<br/>
            <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>(855-285-3276)<br />
              <span><img src="images/ico-fax.png" alt="Fax" width="20" height="16" hspace="2" /> Support:</span>732-658-5384<br />
              <span><img src="images/ico-email.png" alt="Email" width="20" height="16" hspace="2" /> Email:</span> <a href="mailto:info@learnbeyond.com">info@learnbeyond.com</a><a href="mailto:info@mycompany.com"></a><br />
             
        </p>
          </div>
<p>Our friendly customer service representatives are committed to answering all your questions and meeting any need you may have. Please fill out the form below so we may assist you. </p>
<div class="bg"></div>
<form method="post" action="" id="contactform">
              <ol>
                <li>
                  <label for="name">Name*</label>
                  <input id="name" name="name" class="text"/><br /><span style="color:red;"><br>
                    <?php if(isset($error[2]) && $error[2]!=""){ echo $error[2];}?>
                    </span>
                </li>
                <li>
                  <label for="email">Email*</label>
                  <input id="email" name="email" class="text" /><br /><span style="color:red;"><br>
                    <?php if(isset($error[0]) && $error[0]!=""){ echo $error[0];}?>
                    </span>
                </li>
               
                <li>
                  <label for="subject">Subject*</label>
                  <input id="subject" name="subject" class="text"/><br /><span style="color:red;"><br>
                    <?php if(isset($error[1]) && $error[1]!=""){ echo $error[1];}?>
                    </span>
                </li>
                <li>
                  <label for="message">Message*</label>
                  <textarea id="message" name="message" rows="6" cols="50" ></textarea><br /><span style="color:red;"><br>
                    <?php if(isset($error[3]) && $error[3]!=""){ echo $error[3];}?>
                    </span>
                </li>
                <li class="buttons">
                  <input type="submit" class="button" value="Submit" name="submit" />
                  <div class="clr"></div>
                  <br/>
                </li>
                <br/>
              </ol>
          </form>
<div class="clr"></div>
<br/>
<br/>
</div>
          
         
			
			
			
			
			
			
			</div>
					
					
						
			 	  </div>
					
					
					
					
					
				</div>
				
		<!-- \ 	RIGHT BOX / -->
		
	
		<div id="rightBox">
	    
		<div class="rightContent">
		<span class="img4"><a href="parents-students.html"><img src="images/parent-students.png" width="291" height="79" alt="Student or Parents" /></a></span>
	  
		</div>
		<div class="rightContent">
		<span class="img5"><a href="schooladmin.html"><img src="images/schooladmin.png" width="291" height="79" alt="School admin" /></a></span>
	    <span class="rightTxt"></span>
		</div>
		
		<!-- \ 	SEC RIGHT BOX / -->
		
		<div class="rightContent">
		<span class="img6"><iframe src="https://www.facebook.com/video/embed?video_id=103875976392101" frameborder="0" style="float: left; margin-left:10px; width: 283px; height: 212px"></iframe></span>
	  
		</div>
		
		
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
	  <p><a href="#">Home </a>| <a href="about-us.html"> About Us </a> |<a href="howitworks.html">How it Works</a> |<a href="catalog.html">Course Catalog </a> |<a href="contact-us.html"> Contact Us</a>|  </p>
        <h4>&copy; www.k12creditrecovery.com  powered  by <a href="http://learnbeyond.com/" target="_blank"><font color="#FFFF00"> Learnbeyond</font></a>.  All Rights Reserved</h4>
        
      </div>
    </div>
  </div>
</div>
</div>
  <div id="basic-modal-content" align="left">
			<form name="homepage" method="post" id="homepage" action="http://demo.learnbeyond.com:8080/LBCOM/cookie/Save12Contacts.jsp" onsubmit="return validate(this);" target="_parent">
  
   
   	<div style="float:left;line-height:30px; color:#2e2e2e;" id="testimonials">
<CENTER>
<TABLE name="errshow" id="errshow"><TR><TD style="color:blue" align=left></TD></TR></TABLE></CENTER>

<table class="table"border="0" cellpadding="0" cellspacing="1" bordercolor="#111111" id="AutoNumber2" style="border-collapse: collapse">
                            <tr class="mainhead">
                              <td colspan="2"><h2 style="padding:0px; margin:0px;">Sign-Up for Summer Courses</h2>
<h4>Please complete the following details. A LEARNBEYOND representative will contact you shortly. </h4></td>
                                </tr>
							
                            <tr class="td">
                              <td colspan="2" class="td">&nbsp;</td>
                              </tr>
                            <tr class="td">
                              <td class="tdleft" align="right">Name of the Student(First, Last) &nbsp;</td>
                                    <td  >
                                      <input type="text" name="firstname" id="firstname" maxlength="100" size="30"><font color="#ff0000"> *</font>
                                      &nbsp; &nbsp; <input type="text" name="lastname" id="lastname" maxlength="100" size="30"><font color="#ff0000"> *</font></td>
                                </tr>
								<tr >
                            <td   class="tdleft" align="right" height="32">Grade Courses interested in? &nbsp;</td>
                                  <td  class="td" height="20">
                                    <select name="studentgrade" id="studentgrade" size="1">
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
                            <td  class="tdleft" align="right" height="24">Email Address &nbsp;</td>
                                  <td height="24" >
                                    <input type="text" name="studentmailid" id="studentmailid" maxlength="100" size="40"><font color="#ff0000"> *</font></td>
                                </tr>
                            <tr class="td">
                              <td  class="tdleft" align="right">Gender &nbsp;</td>
                                    <td >
                                      <select size="1" name="studentgender">
                                        <option value=none selected>Select</option>
                                        <option value="male" >Male</option>
                                        <option value="female" >Female</option>
                                      </select>                                  </td>
                                </tr>
                         
                            
                            <tr class="td">
                              <td class="tdleft" align="right"  > Address &nbsp;</td>
                                    <td ><input name="studentaddress" type="text" size="30" maxlength="250"></td>
                                </tr>
                            <tr class="td">
                              <td class="tdleft" align="right"  > City &nbsp;</td>
                                    <td ><input name="studentcity" type="text" size="30" maxlength="100"></td>
                                </tr>
                            <tr class="td">
                              <td class="tdleft" align="right"  > State &nbsp;</td>
                                    <td ><input name="studentstate" type="text" size="20" maxlength="30"></td>
                                </tr>
                            <tr class="td">
                              <td class="tdleft" align="right"  > Zip Code &nbsp;</td>
                                    <td ><input name="studentzipcode" type="text" size="20" maxlength="30"></td>
                                </tr>
                            <tr class="td">
                              <td class="tdleft" align="right"  > Country &nbsp;</td>
                                  <td >
                                      <SELECT size=1 name=country 
lf="forms[0].ADMI_CONTACT_COUNTRY">
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
                              <td class="tdleft" align="right">Contact Phone&nbsp;</td>
                                    <td ><input name="studentphone" id="studentphone" type="text" size="20" maxlength="30"><font color="#ff0000"> *</font></td>
                                </tr>
                            <!-- <tr class="td">
                              <td class="tdleft" align="right">Fax</td>
                                    <td ><input name="studentfax" type="text" size="20" maxlength="30"></td>
                                </tr> 
                            <tr class="td">
                              <td class="tdleft" align="right">Personal Website &nbsp;</td>
                                    <td><input name="studentwebsite" type="text" size="20" maxlength="250"></td>
                                </tr> -->

								<tr class="td">
                              <td class="tdleft" align="right" >Name of the Parent/Guardian&nbsp;</td>
                                    <td >
                                      <input type="text"  id="parentname" name="parentname" maxlength="100" size="30"><font color="#ff0000"> *</font></td>
                                </tr>
                            <tr class="td">
                              <td class="tdleft" align="right" >Parent's&nbsp; Email 
                              Address &nbsp;</td>
                                    <td >
                                      <input type="text" id="parentmailid" name="parentmailid" maxlength="100" size="40"><font color="#ff0000"> *</font></td>
                                </tr>
								 <tr class="td">
                              <td class="tdleft" align="right" >Reference Code: (if you have one?)&nbsp;</td>
                                    <td >
                                      <textarea id="refcode" name="refcode" rows="4" cols="30"></textarea></font></td>
                                </tr>
                            </table>
                       
                              <table align="center" width="100%">
                              <tr> <td>&nbsp;  </td><td>&nbsp;  </td></tr>
                              <tr><td width="40%" >
                                <input type="submit" name="submit" value="  Submit  " style=" float:right" ></td>
                               <td width="40%" align="left"> <input type="reset" name="reset" value="  Reset  "></td></tr></table>
                               

	

</form>
		</div>
<script type='text/javascript' src='js/jquery.js'></script>
<script type='text/javascript' src='js/jquery.simplemodal.js'></script>
<script type='text/javascript' src='js/basic.js'></script>
</body>
</html>

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
					
								<div id="login-btn" style="display: block;">
<a class="login" title="login" href="http://my.k12creditrecovery.com" style="display: inline;">Sign In</a>
</div>		
   			 <!-- \ NAVIGATION PANEL / -->
   			
          <div class="navigationPanel">
            <ul class="navList">
             <li><a href="index.html" ><span>Home</span> </a></li>
              <li><a href="about-us.html" ><span>About Us </span></a></li>
              <li><a href="howitworks.html" ><span>How it Works </span></a></li>
              <li><a href="catalog.html" ><span>Course Catalog </span></a></li>
              <li><a href="contact-us.php" class="over"><span>Contact Us</span></a></li>
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

			<span class="headerTxt"><span class="invertedCode"><img src="images/inverted_code.gif" alt="" /></span>Please fill out the form below so we may assist you.<span class="invertedCode"><img src="images/inverted_code.gif" alt="" /></span></span>
							
			<div id='basic-modal'>
			<span class="blackButt"><a href="http://my.k12creditrecovery.com:9080/LBCOM/cookie/StudentSignUp.jsp" class='basic'>Enroll Now>> </a></span></div>
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
	  <p><a href="#">Home </a>| <a href="about-us.html"> About Us </a> |<a href="howitworks.html">How it Works</a> |<a href="catalog.html">Course Catalog </a> |<a href="contact-us.php"> Contact Us</a>|  </p>
        <h4>&copy; www.k12creditrecovery.com  powered  by <a href="http://learnbeyond.com/" target="_blank"><font color="#FFFF00"> Learnbeyond</font></a>.  All Rights Reserved</h4>
        
      </div>
    </div>
  </div>
</div>
</div>

</body>
</html>


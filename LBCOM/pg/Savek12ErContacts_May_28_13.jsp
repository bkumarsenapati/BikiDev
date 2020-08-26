
<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.text.*,java.util.*" %>
<%@page import = "com.oreilly.servlet.MultipartRequest,javax.activation.DataHandler,javax.activation.FileDataSource,javax.mail.*,javax.mail.internet.*,javax.servlet.*,javax.servlet.http.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
String fName="",lName="",gender="",mm="",yy="",dd="",dob="",studentmailid="",addr="",city="",zip="",state="",cType="",ccnumber="",cexp="",cvv="",nameonCard="",bphone="",saveStatus="",enrollType="",altaddr="",country="",totAmount="";
String succMsg="";
String phone="",fax="",persweb="",grade="",parentname="",parentmailid="",refCode="",userName="",gradeDesc="",pName="",usRD="";
 String cookieSchoolId = null,cookieUserId = null,cookiePass = null;
  Cookie mySchoolCookie=null,myCookieUser=null,myCookiePass=null;
  String stuEmail ="",bEmail="",courseId="",courseName="",courseNames="";
	ResultSet  rs=null,rs1=null;
	Connection con=null;
	Statement st=null,st1=null;
	int lastDigits=0;

	try
	{
		
		
		String sessId=(String)session.getAttribute("sessid");

			if(sessId==null){
				out.println("<html><script> window.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
					
		stuEmail = request.getParameter("emailid");
		//bEmail = request.getParameter("bemailid");
		userName = request.getParameter("fname");

		if(stuEmail==null)
		{
			stuEmail="";
		}
		if(bEmail==null)
		{
			bEmail="";
		}
		if(!stuEmail.equals(""))
		{

			con=con1.getConnection();
			st=con.createStatement();

			
			rs=st.executeQuery("select *,AES_DECRYPT(ccnumber,'ccnumber') as ccn from payment_details where userid='"+userName+"'");
			if(rs.next())
			{
				fName=rs.getString("fname");
				lName=rs.getString("lname");
				cType=rs.getString("cType");
				ccnumber=rs.getString("ccnumber");
				cexp=rs.getString("cexp");
				cvv=rs.getString("cvv");
				int nameonCard1=rs.getInt("ccn");
				lastDigits =nameonCard1 % 10000;
							
				bphone=rs.getString("bphone");
				bEmail=rs.getString("bemail");
				saveStatus=rs.getString("save_status");
				enrollType=rs.getString("enroll_type");
				addr=rs.getString("addr");
				altaddr=rs.getString("altaddr");
				city=rs.getString("city");
				state=rs.getString("state");
				country=rs.getString("country");
				zip=rs.getString("zip");
				totAmount=rs.getString("tot_amount");
				grade=rs.getString("grade");
				pName=rs.getString("parent_name");


			}
			gradeDesc=grade+"<sup>th</sup> Grade";
			if(enrollType.equals("er"))
			{
				enrollType="Enrichment enrollment";
				usRD="<script language=\"JavaScript\">function Redirect(){	window.location.href='/LBCOM/';}";
			}
			else
			{
				enrollType="CreditRecovery enrollment";
				usRD="<script language=\"JavaScript\">function Redirect(){	window.location.href='/LBCOM/cookie/Welcome.jsp';}";
			}
			rs.close();
			st.close();
			int count=0;
			st=con.createStatement();
			rs=st.executeQuery("select * from enroll_courses where userid='"+userName+"'");
			while(rs.next())
			{
				courseId=rs.getString("course_id");
				
				
				st1=con.createStatement();
				rs1=st1.executeQuery("select course_name from lbcms_dev_course_master where course_id='"+courseId+"'");
				if(rs1.next())
				{
					courseName=rs1.getString("course_name");
					if(count==0)
					{
						courseNames=courseName;
					}
					else
					{
					   courseNames=courseNames+","+courseName;
					}
					count++;
				}
				st1.close();

			}
			rs1.close();
			rs.close();
			st.close();
			



// Sending Mail user
		HttpServletRequest httpservletrequest=null;
		HttpServletResponse httpservletresponse=null;
		String fileString=null,from=null,to=null,body=null,subject=null,username=null,schoolid=null,attach=null,fileName=null;
		final String user="learnk12com@gmail.com";//change accordingly
		final String password="Lbey0ndk12";//change accordingly
		//HttpSession httpsession = httpservletrequest.getSession(true);
		//httpservletresponse.setContentType("text/html");
		ServletContext application1=getServletContext();
		//String host=application1.getInitParameter("host");
		String host="smtp.gmail.com";
		fileString=application1.getInitParameter("attachments_path");
		//String sessid=(String)httpsession.getAttribute("sessid");
	
		//fileString="C:/Tomcat 5.0/webapps/BUNDLE/mailattachmentdocs/";
		
       from = "creditrecovery@schools.learnbeyond.net";
        to = stuEmail;
        subject = "Summer Enrollment at Learnbeyond";
		//body = "Hello "+stuEmail+",\n\nThank you for your interest in Summer and Credit Recovery courses with Learnbeyond. One of our program coordinators will get back to you soon.\n\nThank you\nLearnbeyond Credit Recovery Team\ncreditrecovery@learnbeyond.com\n1-855-28-LEARN";
		
		body="Hello "+userName+",\n\nThank you for signing up  for the Summer Credit-Recovery/Summer Enrichment courses at Learnbeyond."+"\n\nHere are your subscription details:"+"\n\nStudent :\n"+fName+lName+"\n\nGrade:\n"+gradeDesc+"("+enrollType+")"+"\n\nCourses:\n"+courseNames+"\n\nAddress:\n"+addr+"\n\nParent/Guardian Name:\n"+pName+"\n\nPhone No:\n"+bphone+"\n\nE-Mail Address:\n"+bEmail+"\n\nMode of Payment:\n"+cType+" ending with ****"+lastDigits+"\n\nBill Amount:\n$"+totAmount+"\n\nYou will soon receive sign-in details for the courses you have subscribed.\nPlease let us know if you have any questions.\n\nThank you\nLearnbeyond Credit Recovery Team\ncreditrecovery@learnbeyond.com\n1-855-28-LEARN\n732-658-5384";

		//succMsg=body;
		

        try
        {
            java.util.Properties properties = System.getProperties();
           //properties.put("mail.smtp.host", host);
			//properties.put("mail.smtp.auth", "true");

			properties .put("mail.smtp.starttls.enable", "true");
			properties .put("mail.smtp.host", host);
			properties .put("mail.smtp.user", user);
			properties .put("mail.smtp.password", password);
			properties .put("mail.smtp.port", "587");
			properties .put("mail.smtp.auth", "true");
           //javax.mail.Session session = javax.mail.Session.getInstance(properties, null);
			 Session session1 = Session.getInstance(properties,
	new javax.mail.Authenticator() {
    protected PasswordAuthentication getPasswordAuthentication() {
	return new PasswordAuthentication(user,password);
      }
    });
			
            MimeMessage mimemessage = new MimeMessage(session1);
            InternetAddress internetaddress = new InternetAddress(from);
            mimemessage.setFrom(internetaddress);
            InternetAddress ainternetaddress[] = InternetAddress.parse(to);
            mimemessage.setRecipients(javax.mail.Message.RecipientType.TO, ainternetaddress);
            mimemessage.setSubject(subject);
            mimemessage.setText(body);
			Transport transport=session1.getTransport("smtp");
			if (transport!=null)
			{			
				transport.send(mimemessage);
			}
					
}
 catch(AddressException addressexception)
        {
           
	        out.println("<body><font face=verdana size=2>"+addressexception+"..</font></body></html>");
		    out.close();
        }
        catch(SendFailedException sendfailedexception)
        {
           
			out.println("<body><font face=verdana size=2>"+sendfailedexception+"..</font></body></html>");
			out.close();
        }
        catch(MessagingException messagingexception)
        {
           
			out.println("<body><font face=verdana size=2>"+messagingexception+"..</font></body></html>");
		    out.close();
        }
		catch (Exception genaralException)
		{
			System.out.println("Exception:"+genaralException.toString());
		}
       
    


// Sending Mail upto here

// Sending Mail Parent
		
		
        from = "creditrecovery@schools.learnbeyond.net";
        to = bEmail;
        subject = "Summer Enrollment at Learnbeyond";
		
		//body = "Hello "+stuEmail+",\n\nThank you for your interest in Summer and Credit Recovery courses with Learnbeyond. One of our program coordinators will get back to you soon.\n\nThank you\nLearnbeyond Credit Recovery Team\ncreditrecovery@learnbeyond.com\n1-855-28-LEARN";
		
		body="Hello "+userName+",\n\nThank you for signing up  for the Summer Credit-Recovery/Summer Enrichment courses at Learnbeyond."+"\n\nHere are your subscription details:"+"\n\nStudent :\n"+fName+lName+"\n\nGrade:\n"+gradeDesc+"("+enrollType+")"+"\n\nCourses:\n"+courseNames+"\n\nAddress:\n"+addr+"\n\nParent/Guardian Name:\n"+pName+"\n\nPhone No:\n"+bphone+"\n\nE-Mail Address:\n"+bEmail+"\n\nMode of Payment:\n"+cType+" ending with ****"+lastDigits+"\n\nBill Amount:\n$"+totAmount+"\n\nYou will soon receive sign-in details for the courses you have subscribed.\nPlease let us know if you have any questions.\n\nThank you\nLearnbeyond Credit Recovery Team\ncreditrecovery@learnbeyond.com\n1-855-28-LEARN\n732-658-5384";

        try
        {
			
            java.util.Properties properties = System.getProperties();
            //properties.put("mail.smtp.host", host);
			//properties.put("mail.smtp.auth", "true");

			properties .put("mail.smtp.starttls.enable", "true");
			properties .put("mail.smtp.host", host);
			properties .put("mail.smtp.user", user);
			properties .put("mail.smtp.password", password);
			properties .put("mail.smtp.port", "587");
			properties .put("mail.smtp.auth", "true");
           //javax.mail.Session session = javax.mail.Session.getInstance(properties, null);
			 Session session2 = Session.getInstance(properties,
	new javax.mail.Authenticator() {
    protected PasswordAuthentication getPasswordAuthentication() {
	return new PasswordAuthentication(user,password);
      }
    });
			
            MimeMessage mimemessage = new MimeMessage(session2);
            InternetAddress internetaddress = new InternetAddress(from);
            mimemessage.setFrom(internetaddress);
            InternetAddress ainternetaddress[] = InternetAddress.parse(to);
            mimemessage.setRecipients(javax.mail.Message.RecipientType.TO, ainternetaddress);
            mimemessage.setSubject(subject);
            mimemessage.setText(body);
			Transport transport=session2.getTransport("smtp");
			if (transport!=null)
			{		
				transport.send(mimemessage);
			}
					
}
 catch(AddressException addressexception)
        {
           
	        out.println("<body><font face=verdana size=2>"+addressexception+"..</font></body></html>");
		    out.close();
        }
        catch(SendFailedException sendfailedexception)
        {
           
			out.println("<body><font face=verdana size=2>"+sendfailedexception+"..</font></body></html>");
			out.close();
        }
        catch(MessagingException messagingexception)
        {
           
			out.println("<body><font face=verdana size=2>"+messagingexception+"..</font></body></html>");
		    out.close();
        }
		catch (Exception genaralException)
		{
			System.out.println("Exception:"+genaralException.toString());
		}
       
    

// Sending Mail upto here


// Sending Mail to enroll@lb
		
		
        from = "creditrecovery@schools.learnbeyond.net";
        //to = "enroll@learnbeyond.com";
		to = "hsnsanthosh@gmail.com";
	    Date today = Calendar.getInstance().getTime();

        //subject = "Summer Enrollment at Learnbeyond for "+fName+" "+lName+"";
		subject = "Summer Enrollment at Learnbeyond for "+stuEmail;
		//body = "Name of the Student(First, Last): "+fName+" "+lName+"\nGrade: "+grade+"\nEmail Address: "+studentmailid+"\nGender:  "+gender+"\nParent Name: "+parentname+"\nParent Email Id: "+parentmailid+"\nAddress: "+address+"\nCity: "+city+"\nZip Code: "+zip+"\nState: "+state+"\nCountry: "+country+"\nContact: "+phone+"\nPersonal Website: "+persweb+"\nRegistered on: "+today+"\nReference Code: "+refCode+"\n";
		
		//body = "Hello "+stuEmail+",\n\nThank you for your interest in Summer and Credit Recovery courses with Learnbeyond. One of our program coordinators will get back to you soon.\n\nThank you\nLearnbeyond Credit Recovery Team\ncreditrecovery@learnbeyond.com\n1-855-28-LEARN";
		
		body="Hello "+userName+",\n\nThank you for signing up  for the Summer Credit-Recovery/Summer Enrichment courses at Learnbeyond."+"\n\nHere are your subscription details:"+"\n\nStudent :\n"+fName+lName+"\n\nGrade:\n"+gradeDesc+"("+enrollType+")"+"\n\nCourses:\n"+courseNames+"\n\nAddress:\n"+addr+"\n\nParent/Guardian Name:\n"+pName+"\n\nPhone No:\n"+bphone+"\n\nE-Mail Address:\n"+bEmail+"\n\nMode of Payment:\n"+cType+" ending with ****"+lastDigits+"\n\nBill Amount:\n$"+totAmount+"\n\nYou will soon receive sign-in details for the courses you have subscribed.\nPlease let us know if you have any questions.\n\nThank you\nLearnbeyond Credit Recovery Team\ncreditrecovery@learnbeyond.com\n1-855-28-LEARN\n732-658-5384";

        try
        {
			
            java.util.Properties properties = System.getProperties();
            //properties.put("mail.smtp.host", host);
			//properties.put("mail.smtp.auth", "true");

			properties .put("mail.smtp.starttls.enable", "true");
			properties .put("mail.smtp.host", host);
			properties .put("mail.smtp.user", user);
			properties .put("mail.smtp.password", password);
			properties .put("mail.smtp.port", "587");
			properties .put("mail.smtp.auth", "true");

           //javax.mail.Session session = javax.mail.Session.getInstance(properties, null);
			 Session session2 = Session.getInstance(properties,
	new javax.mail.Authenticator() {
    protected PasswordAuthentication getPasswordAuthentication() {
	return new PasswordAuthentication(user,password);
      }
    });
			
            MimeMessage mimemessage = new MimeMessage(session2);
            InternetAddress internetaddress = new InternetAddress(from);
            mimemessage.setFrom(internetaddress);
            InternetAddress ainternetaddress[] = InternetAddress.parse(to);
            mimemessage.setRecipients(javax.mail.Message.RecipientType.TO, ainternetaddress);
            mimemessage.setSubject(subject);
            mimemessage.setText(body);
			Transport transport=session2.getTransport("smtp");
			if (transport!=null)
			{		
				transport.send(mimemessage);
			}
					
}
 catch(AddressException addressexception)
        {
           
	        out.println("<body><font face=verdana size=2>"+addressexception+"..</font></body></html>");
		    out.close();
        }
        catch(SendFailedException sendfailedexception)
        {
           
			out.println("<body><font face=verdana size=2>"+sendfailedexception+"..</font></body></html>");
			out.close();
        }
        catch(MessagingException messagingexception)
        {
           
			out.println("<body><font face=verdana size=2>"+messagingexception+"..</font></body></html>");
		    out.close();
        }
		catch (Exception genaralException)
		{
			System.out.println("Exception:"+genaralException.toString());
		}
		
           
// Sending Mail upto here



	}
	else
	{
		response.sendRedirect("/LBCOM/cookie/StudentReg.jsp");
	}



%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.sql.*,coursemgmt.ExceptionsFile,java.util.Vector,java.util.Iterator" %>
<%@ page language="java"  %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page" />
<html>
 <head>
  <title> Learnbeyond, Inc. - eLearning Solution & Content Provider for K-12 Schools</title>
  <meta name="Generator" content="EditPlus">
  <meta name="Author" content="LearnBeyond, Inc.">
  <meta name="Keywords" content="eLearning, K-12 learning, School Courses, High School, Middle School, Primary School, Virtual School, Online Learning, Assessments, Assignments, Failing Schools, Standards based testing, Corporate Learning, SCORM, IMSQT, Common Core Standards, LearnBeyond Testimonials">
  <meta name="Description" content="LearnBeyond is a next-generation eLearning solution that offers learners (individuals / schools / organizations) the ability to create, manage and deliver learning programs and assessments - completely online. Built on proprietary LMS and CMS (called CourseBuilder), both of which are extremely robust and scalable, LearnBeyond offers eLearning possibilities that are way ahead of the market">
  <link rel="stylesheet" type="text/css" media="all" href="main.css" />
  <link rel="stylesheet" href="themes/default/default.css" type="text/css" media="screen" />
    
    <link rel="stylesheet" href="nivo-slider.css" type="text/css" media="screen" />
  <!-- script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script-->
 <link rel="icon" 
      type="image/png" 
      href="favicon-32-2.ico">

 </head>
<SCRIPT LANGUAGE="JavaScript">
<!--
	
	function popupsCheck()
	{
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
	}

//-->
</SCRIPT>
<script language="javascript" src="images/index/validationscripts"></script>

 <body>

 
   
   
   
<div id="testimonials" style="width:530px;float:left;padding-left:25px;padding-top:20px;line-height:20px;margin-left:25px;padding-right:25px;"><font color="red" siz="3">Hello <%=userName%>,<br/>Thank you for signing up  for the Summer Credit-Recovery/Summer Enrichment courses at Learnbeyond.<br/><br/>Here are your subscription details:<br/>Student :<%=fName%><%=lName%><br/>Grade:<%=gradeDesc%>(<%=enrollType%>)<br/>Courses:<%=courseNames%><br/>Mail has been sent to :<%=stuEmail%>,<%=bEmail%><br/>You will soon receive sign-in details for the courses you have subscribed.<br/>Please let us know if you have any questions.<br/><br/>Thank you<br/>Learnbeyond Credit Recovery Team<br/>creditrecovery@learnbeyond.com<br/>1-855-28-LEARN<br/>732-658-5384</font>
<%
out.println("<html><head><title></title>");
		
		//out.println("<script language=\"JavaScript\">function Redirect(){	window.location.href='http://www.k12creditrecovery.com';}");

		//out.println("<script language=\"JavaScript\">function Redirect(){	window.location.href='/LBCOM/';}");
		out.println(usRD);
		out.println("function RedirectWithDelay(){ window.setTimeout('Redirect();',30000);}</script></head>");
		out.println("<body onload=\"RedirectWithDelay();\"><br><center><b><i><font face=\"Arial\" size=\"2\" align=\"center\">&nbsp;</font></i></b></center></body></html>");
		%>
</div>


	<script type="text/javascript">
$(document).ready(function($){
	$('#mega-menu-1').dcMegaMenu({
		rowItems: '3',
		speed: 0,
		effect: 'slide',
		event: 'hover',
		fullWidth: true
	});
		$('.rollover').hover(function() {
        var currentImg = $(this).attr('src');
        $(this).attr('src', $(this).attr('hover'));
        $(this).attr('hover', currentImg);
    }, function() {
        var currentImg = $(this).attr('src');
        $(this).attr('src', $(this).attr('hover'));
        $(this).attr('hover', currentImg);
    });
	
});
</script>
    <script type="text/javascript">
    $(window).load(function() {
        $('#slider').nivoSlider({
		animSpeed: 500, 
        pauseTime: 5000
		});
    });
    </script>

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


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
		/*
		
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
*/
			con=con1.getConnection();
			st=con.createStatement();

			
			rs=st.executeQuery("select *,AES_DECRYPT(ccnumber,'ccnumber') as ccn from payment_details ");
			if(rs.next())
			{
				fName=rs.getString("fname");
				lName=rs.getString("lname");
				cType=rs.getString("cType");
				ccnumber=rs.getString("ccnumber");
				//cexp=rs.getString("cexp");
				//cvv=rs.getString("cvv");
				int nameonCard1=rs.getInt("ccn");
				lastDigits =nameonCard1 % 10000;
							
				bphone=rs.getString("bphone");
				bEmail=rs.getString("bemail");
				//saveStatus=rs.getString("save_status");
				//enrollType=rs.getString("enroll_type");
				//addr=rs.getString("addr");
				//altaddr=rs.getString("altaddr");
				//city=rs.getString("city");
				//state=rs.getString("state");
				//country=rs.getString("country");
				//zip=rs.getString("zip");
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
			


//delete starts here
/*




*/
//delete ends here

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

 
  <div  height='702' width='800' style='background-color:#b9f2ff;'><center><table border='0' cellpadding='0' cellspacing='0' height='602' width='650'  style='padding:20px;' bgcolor='#FFFFFF'><tbody><tr><td><a href='http://www.k12creditrecovery.com' target='_blank'><img src='http://www.k12creditrecovery.com/images/logo.png' width='254' height='73' alt='k12credirecovery' align='right' /></a></td></tr><tr><td><table width='100%'  ><tr><td> Hi  <%=userName%>,<br /><p> Thank you for signing up  for the Summer Credit-Recovery/Summer Enrichment courses at <a href='http://www.k12creditrecovery.com'>Learnbeyond</a>.<p>Here are your subscription details:<br /><table style='margin:0px;border:1px solid #ebebeb;padding-left:15px;width:100%;border-collapse:collapse'><tr><td width='204'  style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:bold;border:1px solid #ebebeb;'> Student </td><td width='327' style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:normal;border:1px solid #ebebeb;'><%=fName%><%=lName%></td></tr><tr><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:bold;border:1px solid #ebebeb;'>Grade:</td><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:normal;border:1px solid #ebebeb;'><%=grade%><sup>th</sup> </td></tr><tr><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:bold;border:1px solid #ebebeb;'> Parent/Guardian Name: </td><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:normal;border:1px solid #ebebeb;'><%=pName%></td></tr><tr><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:bold;border:1px solid #ebebeb;'> Phone No: </td><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:normal;border:1px solid #ebebeb;'><%=bphone%></td></tr><tr><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:bold;border:1px solid #ebebeb;'> E-Mail Address: </td><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:normal;border:1px solid #ebebeb;'><%=bEmail%></td></tr><tr><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:bold;border:1px solid #ebebeb;'> Mode of Payment: </td><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:normal;border:1px solid #ebebeb;'> <%=cType%> ending with ****<%=lastDigits%></td></tr><tr><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:bold;border:1px solid #ebebeb;'> Bill Amount: </td><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:normal;border:1px solid #ebebeb;'><%=totAmount%></td></tr></table></td></tr><tr><td>&nbsp;</td></tr><tr><td>You will soon receive sign-in details for the courses you have subscribed. Please let us know if you have any questions.</td></tr><tr><td>&nbsp;</td></tr><tr><td>  Thank you<br /> Learnbeyond Credit Recovery Team<br/>creditrecovery@learnbeyond.com<br/>1-855-28-LEARN<br/>732-658-5384</td></tr></table></td></tr></tbody></table></center></div>
     
 

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

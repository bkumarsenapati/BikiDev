<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.text.*,java.util.*" %>
<%@page import = "com.oreilly.servlet.MultipartRequest,javax.activation.DataHandler,javax.activation.FileDataSource,javax.activation.*,javax.mail.*,javax.mail.internet.*,javax.servlet.*,javax.servlet.http.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%

String fname="",lname="",gender="",mm="",yy="",dd="",dob="",email="",addr="",city="",zip="",state="",cType="",ccnumber="",cexp="",cvv="",cardName="",billingphone="",saveStatus="",enrollType="",altaddr="",country="",totAmount="";

String phone="",fax="",persweb="",grade="",parentname="",email1="",refCode="",userName="",gradeDesc="",pName="",usRD="",address1="",address2="",cardNumber="",cardType="",expMon="",expYear="",btpp="",spi="",ids="",total="",expDate="",username="",eType="";

String sessId="",courseNames="",courseName="";
int count=0;

	ResultSet  rs=null,rs1=null;
	Connection con=null;
	Statement st=null,st1=null;


			try
			{

				session.setAttribute("sessid","unuser");
				//System.out.println("Before.....sessId..."+sessId);
				sessId=(String)session.getAttribute("sessid");
				//System.out.println("After ....sessId..."+sessId);
				eType= request.getParameter("enroll");

				System.out.println("After ....eType..."+eType);

				if(eType==null || eType.equals(""))
				{

					out.println("<html><script> window.location.href='/LBCOM/cookie/StudentSignUp.jsp'; \n </script></html>");
					return;
				}

				if(eType.equals("er"))
				{
					enrollType="Enrichment enrollment";
					
				}
				else
				{
					enrollType="CreditRecovery enrollment";
					
				}
				fname = request.getParameter("firstname");
				lname = request.getParameter("lastname");
				grade = request.getParameter("studentgrade");
				gender = request.getParameter("studentgender");
				mm = request.getParameter("mm");
				dd = request.getParameter("dd");
				yy = request.getParameter("yy");
				dob = yy + "-" + mm + "-" + dd ;
				parentname = request.getParameter("parentname");
				//parentocc = request.getParameter("parentocc");
				 // parentocc="";														// not cahnged
				email = request.getParameter("email");
				//address = request.getParameter("stuaddress");
				
				city = request.getParameter("city");
				zip = request.getParameter("zip");
				state = request.getParameter("standard-dropdown");
				country = request.getParameter("country");	
				phone = request.getParameter("stuphone");
				fax = request.getParameter("stufax");
				persweb = request.getParameter("stuwebsite");
				
				address1 = request.getParameter("add");
				address2 = request.getParameter("add1");
				billingphone = request.getParameter("bphone");
				

				/* Credit card Info */
				cardNumber = request.getParameter("CardNumber");
				cardType = request.getParameter("CardType");
				expMon = request.getParameter("ExpMon");
				expYear = request.getParameter("ExpYear");
				expDate= "20"+expYear+expMon;
				cvv = request.getParameter("cvv");
				cardName = request.getParameter("cardname");
				btpp = request.getParameter("btpp");
				spi = request.getParameter("spi");
				if(spi==null)
				{
					spi="n";
				}
				email1 = request.getParameter("bemail");

				ids=request.getParameter("selids");
				
				//tot=Integer.parseInt(request.getParameter("tot_amount"));
				total	=request.getParameter("tot_amount");

				con=con1.getConnection();
				st=con.createStatement();

				StringTokenizer idsTkn=new StringTokenizer(ids,",");
					while(idsTkn.hasMoreTokens())
					{
							String courseId=idsTkn.nextToken();

							//System.out.println("courseId..."+courseId);
				
						rs=st.executeQuery("select course_name from lbcms_dev_course_master where course_id='"+courseId+"'");
						if(rs.next())
						{
							courseName=rs.getString("course_name");
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
						


					}
					st.close();
					rs.close();

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
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <title>Learnbeyond's - K12 Credit Recovery - Contact Us</title><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="Generator" content="EditPlus">
  <meta name="Author" content="Learnbeyond, Inc">
  <meta name="Keywords" content="Credit Recovery, eLearning, K-12 learning, School Courses, High School, Middle School, Virtual School, Online Learning, Assessments, Assignments, Failing Schools, Standards based testing, Corporate Learning, online school, online courses, summer school online, high school credits online, online high school courses, home bound students, home schools">
  <meta name="Description" content="Learnbeyond's K12 Credit Recovery is an ideal program that helps Students who have failed a course to recover credit by redoing the course work, or at least the work which they failed to master in the original course.">

<link type='text/css' href='css/basic.css' rel='stylesheet' media='screen' />
<link href="css/style.css" rel="stylesheet" type="text/css" />

<script language="JavaScript">

function cancelTrans()
 {
   window.location.href="/LBCOM/cookie/StudentSignUp.jsp";
 }
 </script>
</head>
<body>

<form name="StudentReg" method="post" action="/LBCOM/studentAdmin.Registerk12Student">

<div  height='650' width='800' style='background-color:#b9f2ff;'><center><table border='0' cellpadding='0' cellspacing='0' height='550' width='650'  style='padding:20px;' bgcolor='#FFFFFF'><tbody><tr><td><a href='http://www.k12creditrecovery.com' target='_blank'><img src='http://my.k12creditrecovery.com/LBCOM/cookie/images/logo.png' width='254' height='73' alt='k12credirecovery' align='left' /></a></td></tr><tr><td><br></td></tr><tr><td>

<table width='100%'  ><tr><td><a href='http://www.k12creditrecovery.com'>Learnbeyond</a>.<p>Here are your subscription details:<br /><table style='margin:0px;border:1px solid #ebebeb;padding-left:15px;width:100%;border-collapse:collapse'><tr><td width='204'  style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:bold;border:1px solid #ebebeb;'> Student </td><td width='327' style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:normal;border:1px solid #ebebeb;'><%=fname%> <%=lname%></td></tr><tr><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:bold;border:1px solid #ebebeb;'>Grade:</td><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:normal;border:1px solid #ebebeb;'><%=grade%><sup>th</sup> (<%=enrollType%>)</td></tr><tr><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:bold;border:1px solid #ebebeb;'>Courses:</td><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:normal;border:1px solid #ebebeb;'><%=courseNames%></td></tr><tr><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:bold;border:1px solid #ebebeb;'> Parent/Guardian Name: </td><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:normal;border:1px solid #ebebeb;'><%=parentname%></td></tr><tr><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:bold;border:1px solid #ebebeb;'> Phone No: </td><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:normal;border:1px solid #ebebeb;'><%=billingphone%></td></tr><tr><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:bold;border:1px solid #ebebeb;'> E-Mail Address: </td><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:normal;border:1px solid #ebebeb;'><%=email1%></td></tr><tr><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:bold;border:1px solid #ebebeb;'> Mode of Payment: </td><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:normal;border:1px solid #ebebeb;'> <%=cardType%> /<%=cardNumber%></td></tr><tr><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:bold;border:1px solid #ebebeb;'> Bill Amount: </td><td style='color:#1a2d39;font-size:12px;font-family:Arial;padding-top:10px;font-weight:normal;border:1px solid #ebebeb;'><%=total%></td></tr></table></td></tr><tr><td>&nbsp;</td></tr><tr><td>Please verify the payment details to confirm your subscription.</td></tr><tr><td>&nbsp;</td></tr><tr><td>Learnbeyond Credit Recovery Team<br/>creditrecovery@learnbeyond.com<br/>1-855-28-LEARN<br/>732-658-5384</td></tr></table></td></tr></tbody></table>

<table>
<tr>
        <td colspan="5" width="">
               
                <p align="center">
				<input type="submit" name="submit" value="Confirm" class="button">&nbsp;&nbsp;
                <input type="reset" name="cancel" value="Cancel" class="button" onClick="cancelTrans();">  </p>         

        </td>
        </tr>
</table>

</center>



</div>




<input type="hidden" name="enroll" value="<%=eType%>">
<input type="hidden" name="firstname" value="<%=fname%>">
<input type="hidden" name="lastname" value="<%=lname%>">
<input type="hidden" name="studentgrade" value="<%=grade%>">
<input type="hidden" name="studentgender" value="<%=gender%>">
<input type="hidden" name="mm" value="<%=mm%>">
<input type="hidden" name="dd" value="<%=dd%>">
<input type="hidden" name="yy" value="<%=yy%>">
<input type="hidden" name="parentname" value="<%=parentname%>">
<input type="hidden" name="email" value="<%=email%>">
<input type="hidden" name="city" value="<%=city%>">
<input type="hidden" name="zip" value="<%=zip%>">
<input type="hidden" name="standard-dropdown" value="<%=state%>">
<input type="hidden" name="country" value="<%=country%>">
<input type="hidden" name="stuphone" value="<%=phone%>">
<input type="hidden" name="stufax" value="<%=fax%>">
<input type="hidden" name="stuwebsite" value="<%=persweb%>">
<input type="hidden" name="add" value="<%=address1%>">
<input type="hidden" name="add1" value="<%=address2%>">
<input type="hidden" name="bphone" value="<%=billingphone%>">
<input type="hidden" name="CardNumber" value="<%=cardNumber%>">
<input type="hidden" name="CardType" value="<%=cardType%>">
<input type="hidden" name="ExpMon" value="<%=expMon%>">
<input type="hidden" name="ExpYear" value="<%=expYear%>">
<input type="hidden" name="cvv" value="<%=cvv%>">
<input type="hidden" name="cardname" value="<%=cardName%>">
<input type="hidden" name="btpp" value="<%=btpp%>">
<input type="hidden" name="spi" value="<%=spi%>">
<input type="hidden" name="bemail" value="<%=email1%>">
<input type="hidden" name="selids" value="<%=ids%>">
<input type="hidden" name="tot_amount" value="<%=total%>">

<input type="hidden" name="mode" value="adminreg">
<input type="hidden" name="schoolid" value="training">

<script type='text/javascript' src='js/jquery.js'></script>
<script type='text/javascript' src='js/jquery.simplemodal.js'></script>
<script type='text/javascript' src='js/basic.js'></script>
</body>
</html>


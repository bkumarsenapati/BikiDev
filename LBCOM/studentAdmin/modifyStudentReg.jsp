<%@ page language="java" %>
<%@ page import = "java.sql.*,java.lang.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page" />
<jsp:setProperty name="db" property="*" />
<%
	String mode=null,schoolid=null,username=null,gen=null,cntry=null,grade=null;
	Connection con=null;
	Statement st=null,stmt=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rss=null,rs2=null;
	java.util.Date dob=null;
	mode = request.getParameter("mode");
	int ddd=0,dmm=0,dyy=0;
	int noOfStudents=0,regStudents=0;
	String schoolId="",userId="",licenseType="";
	//PrintWriter out=null;
%>
<html>
<head>
<title></title>
<meta name="generator" content="Microsoft FrontPage 5.0">
</head>
<script language="javascript" src="../validationscripts.js"></script>
<!-- start of rajesh code -->
<%String formid="F00002";%> <!-- Don't change this is for access control -->
<%@ include file="/accesscontrol/accesscontrol.jsp" %> 	
<!-- end of rajesh code -->
<script language="JavaScript">

function changePassword()
{
	parent.studenttopframe.studentPasswordWin = window.open("/LBCOM/ChangePassword.jsp","password_window","width=550,height=300");
}

function checkdate(d,m,y)
{
  var frm=window.document.StudentReg
  var k=1
  var dinm = new Array(0,31,28,31,30,31,30,31,31,30,31,30,31);
  tday=new Date();
  
  if(y <=1900 || y >= parseInt(tday.getFullYear()) ||isNaN(y))
  {
   alert("Please enter valid year");
   frm.yy.focus();
   frm.yy.select();
   return 0;
  }
else
  if(y %4==0 &&(y%100!=0 ||y%400==0))
   dinm[2]=29;

if((m > 12 || m < 1)|| isNaN(m))
{
   alert("Please enter valid month");
   frm.mm.focus();
   return 0;
}

if((d<1 || d >dinm[m])||isNaN(d) )
{
   alert("Please enter valid date");
   frm.dd.focus();
   frm.dd.select();
   return 0;
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

function validate(frm)
{
	if(trim(frm.username.value)=="")
	{
		alert("Username should have atleast six characters");
		frm.username.focus();
		return false;
	}
	<%
		if(mode.equals("admodify")){
	%>
	if(trim(frm.password.value)=="")
	{
		alert("Please enter password");
		frm.password.focus();
		return false;
	}
	if (trim(frm.password.value).length<6) {
		alert("Password should have atleast six characters");
		frm.password.focus();
		return false;
	}
	if(frm.password.value!=frm.cpassword.value)
	{									//Six characters or more; capitalization matters!

		alert("Your password entries did not match. Please try again.");
		frm.cpassword.value="";
		frm.password.value="";
		frm.password.focus();
		return false;
	}
	<%}%>
	if(frm.studentgrade.value=="none")
	{
		alert("Please select grade");
		frm.studentgrade.focus();
		return false;
	}	
	if(frm.dd.value!="" || frm.mm.value>0 || frm.yy.value!="")
	{
	if(checkdate(parseInt(frm.dd.value),parseInt(frm.mm.value),parseInt(frm.yy.value))==false)
		  return false
	}
	if(frm.firstname.value=="")
	{
		alert("Please enter first name");
		frm.firstname.focus();
		return false;
	}
	if(frm.lastname.value=="")
	{
		alert("Please enter last name");
		frm.lastname.focus();
		return false;
	}
	if(frm.parentname.value=="")
	{
		alert("Please enter parent or guardian name");
		frm.parentname.focus();
		return false;
	}	
	if(isValidEmail(frm.email.value)==false)
	{
		frm.email.focus();
		return false;
	}
	if(isValidEmail(frm.email.value)==false)
	{
		frm.email.focus();
		return false;
	}
	if (isNaN(trim(frm.stuzipcode.value))) {
		alert("Please enter numbers only");
		frm.stuzipcode.focus();
		return false;
	}
	if (show_key(frm.stustate)==false) {
		alert("Please enter alphabet only");
		frm.stustate.focus();
		return false;
	}
	if (isNaN(trim(frm.stuphone.value))) {
		alert("Please enter numbers only");
		frm.stuphone.focus();
		return false;
	}
  frm.schoolid.disabled = false;
  frm.username.disabled = false;
  frm.studentgrade.disabled = false;
  replacequotes();
}

function getsubids(id) 
{
	clear();
	var j=1;
	var i;
	for(i=0;i<subsections.length;i++)
	{
		if(subsections[i][0]==id)
		{
			document.StudentReg.subsection[j]=new Option(subsections[i][2],subsections[i][1]);
			j=j+1;
		}
	} 
}

function clear() 
{
	var i;
	var temp=document.StudentReg.subsection;
	for(i=temp.length;i>0;i--)
	{
		if(temp.options[i]!=null)
		{
			temp.options[i]=null;
		}
	}
}
</script>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" onload=addcontrol()>
<form name="StudentReg" method="post" action="/LBCOM/studentAdmin.RegisterStudent" onsubmit="return validate(this);">

<table border="0" align="center" cellpadding="3" cellspacing="3" width="800">
<%
    session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}

	String subsectionId="";	
	schoolid=(String)session.getAttribute("schoolid");
	if(mode.equals("admodify"))
		username=request.getParameter("user");
	else
		username=(String)session.getAttribute("emailid");

	try
	{
		con = db.getConnection();
		st = con.createStatement();
		st1 = con.createStatement();
		stmt = con.createStatement();		
		rs = st.executeQuery("select * from school_profile where schoolid='"+schoolid+"'");
		if (rs.next()) 
		{
			licenseType=rs.getString("license_type");	
			noOfStudents=rs.getInt("non_staff");
		}
		rs.close();
		st.close();
		rs1=st1.executeQuery("select count(*) from studentprofile where schoolid='"+schoolid+"' and status='1' and username NOT LIKE  '%_vstudent%'");
		if (rs1.next()) 
		{
			regStudents=rs1.getInt(1);
		}
		rs1.close();
		st1.close();
		st = con.createStatement();
		rs=st.executeQuery("select * from studentprofile where emailid='"+username+"' and schoolid='"+schoolid+"'");
		if(rs.next())
		{
			dob = rs.getDate("birth_date");
			cntry = rs.getString("country");
			grade = rs.getString("grade");
			subsectionId=rs.getString("subsection_id");
			if(dob!=null)
			{
				ddd = dob.getDate();
				dmm = dob.getMonth();
			    dmm++;
			    dyy = dob.getYear();
			    dyy+=1900;
			}
			else
			{
				dmm=0;dyy=0;ddd=0;
			}
		
			if(!mode.equals("admodify"))
			{
%>
				<tr>
					<td colspan="8" valign="middle" bgcolor="#E0D1E0">
						<font face="Arial" size="2"><b>Modify Profile :</b></font></td>
				</tr>
				<tr>
					<td colspan="7">
						<font face="Arial" size="2"><b>Your Personal Details :</b></font></td>
					<td align="right">
						<input type="button" name="cngpwd_button" value="Change Password" onclick="JavaScript : changePassword();">
					</td>
				</tr>
<%
			}
			else
			{
%>
				<tr>
					<td width="491" colspan="5" bgcolor="#EEBA4D">
					<font face="Arial" size="2"><b>Modify Student Profile :</b></font></td>
				</tr>
<%
			}
%>
</table>

<table border="0" align="center" cellpadding="3" cellspacing="3" width="800">
	<TBODY>
	<TR>
		<TD width="262" align="left">
			<font face="Arial" size="2">School ID</font>
		</TD>
		<td width="8" align="center" valign="middle">
			<b><font face="Arial" size="2">:</font></b>
		</td>
		<TD align="left">
			<font face="Arial" size="2">
			<INPUT type="text" maxLength="50" size=25 name="schoolid" lf="forms[0].USER_NAME" value="<%=rs.getString("schoolid")%>" disabled></font>
		</TD>
	</TR>
	<TR>
		<TD width="262" align="left">
			<font face="Arial" size="2">User ID</font>
		</TD>
		<td width="8" align="center" valign="middle">
			<b><font face="Arial" size="2">:</font></b>
		</td>
		<TD align="left">
			<font face="Arial" size="2" align="left">
			<INPUT maxLength="50" size=25 name=username 
lf="forms[0].USER_NAME" value="<%=rs.getString("emailid")%>" disabled></font>
		</TD>
	</TR>
<%
	if(mode.equals("admodify"))
	{
%>
	<TR>
		<TD width="262" align="left">
			<font face="Arial" size="2">Password</font></TD>
		<td width="8" align="center">
			<b><font face="Arial" size="2">:</font></b></td>
		<TD align="left">
			<font face="Arial" size="2" align="left">
			<INPUT type=password maxLength="14" size="18" value="<%=rs.getString("password")%>" name=password lf="forms[0].password"  oncontextmenu="return false" onkeypress="return pwdOnly(this, event)" ></font>
			<font color="red">*</font></TD>
	</TR>
	<TR>
		<TD width="262" align="left">
			<font face="Arial" size="2">Confirm Password</font></TD>
		<td width="8" align="center">
			<b><font face="Arial" size="2">:</font></b></td>
		<TD align="left">
			<font face="Arial" size="2" align="left">
			<INPUT type=password maxLength="14" size="18" value="<%=rs.getString("password")%>" name=cpassword lf="forms[0].password1"  oncontextmenu="return false" onkeypress="return pwdOnly(this, event)"></font>
			<font color="red">*</font></TD>
	</TR>
<%
	}
	else
	{
%>
		<INPUT TYPE="hidden" value="<%=rs.getString("password")%>" name=password >
		<INPUT TYPE="hidden" value="<%=rs.getString("password")%>" name=cpassword>	
<%
	}
%>
	<TR>
		<TD colspan="3" align="left"><hr></TD>
	</TR>
</TBODY>
</TABLE>
<table border="0" align="center" cellpadding="3" cellspacing="3" width="800">
			<tr>
		        <td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">First Name</font>
		        </td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">:</font></b>
				</td>
				<td width="313" colspan="2">
					<input type="text" name="firstname" maxlength="25" size="20" value="<%=rs.getString("fname")%>"  oncontextmenu="return false" onkeypress="return NameOnly(this, event)">
					<font color="red">*</font>
				</td>
			</tr>
			<tr>
				<td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">Last Name</font>
				</td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">:</font></b>
				</td>
				<td width="313" colspan="2">
					<input type="text" name="lastname" maxlength="25" size="20" value="<%=rs.getString("lname")%>"  oncontextmenu="return false" onkeypress="return NameOnly(this, event)">
					<font color="red">*</font>
		        </td>
			</tr>
			<tr>
				<td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">Class ID</font>
				</td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">:</font></b>
				</td>
<%
		if(mode.equals("admodify"))
		{
%>
				<td width="100" colspan="2">
					<select name="studentgrade" size="1" onchange="getsubids(this.value);">
						<option value=none selected>.. Select ..</option>
<%
			try
			{
				rss = stmt.executeQuery("select class_id,class_des from class_master where school_id='"+schoolid+"' order by class_des");
				while(rss.next())
				{
					out.println("<option value='"+rss.getString("class_id")+"'>"+rss.getString("class_des")+"</option>");
				}	
				rss.close();
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("modifyStudentReg.jsp","operations on database","SQLException",se.getMessage());
				System.out.println("SQL Error in modifyStudentReg.jsp is...:"+se);		
			}
%>
					</select>
					<font color="red">*</font>
				</td>
			<tr>
				<td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">Subsection ID</font>
				</td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">:</font></b>
				</td>
				<td width="313" colspan="2">
					<select name="subsection" size="1">
						<option value='nil' selected>.. Select ..</option>
<%
			try
			{
				out.println("<SCRIPT Language='JavaScript'>");
				out.println("var subsections=new Array();");
				rss=stmt.executeQuery("select * from subsection_tbl where school_id='"+schoolid+"'");
				for(int i=0,j=1;rss.next();i++)
				{
					if(rss.getString("class_id").equals(grade))
					{
						out.println("document.StudentReg.subsection["+j+++"]=new Option('"+rss.getString("subsection_des")+"','"+rss.getString("subsection_id")+"');");
						if(rss.getString("subsection_id").equals(subsectionId))
						{
							out.println("document.StudentReg.subsection.value='"+rss.getString("subsection_id")+"'");
						}
					}
					out.println("subsections["+i+"]=new Array('"+rss.getString("class_id")+"','"+rss.getString("subsection_id")+"','"+rss.getString("subsection_des")+"');");
				}
				out.println("</script>");
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("modifyTeacherReg.jsp","operations on database","SQLException",se.getMessage());
				System.out.println("SQL Error in modifyStudentReg.jsp is...:"+se);		
			}
%>
					</select>
				</td>
			</tr>
<%
		}
		else
		{
			rss = stmt.executeQuery("select class_des from class_master where school_id='"+schoolid+"' and class_id='"+grade+"' order by class_des");
			if(rss.next())
			{
%>
				<td width="316" colspan="2">
					<input type="text" name="studentgrade" maxlength="25" size="20" value='<%=rss.getString("class_des")%>' disabled>
				</td>
			</tr>
<%
			}
		
			rss = stmt.executeQuery("select subsection_des from subsection_tbl where school_id='"+schoolid+"' and  subsection_id='"+subsectionId+"'");
			if(rss.next())
			{
%>
				<tr>
					<td width="262" colspan="2" align="left" valign="middle">
						<font face="Arial" size="2">Subsection ID</font>
			        </td>
					<td width="8" align="center" valign="middle">
						<b><font face="Arial" size="2">:</font></b>
					</td>
					<td width="313" colspan="2">
						<input type="text" name="subsection" maxlength="25" size="20" value='<%=rss.getString("subsection_des")%>' disabled>
					</td>
				</tr>
<%		
			}
		}
%>
			<tr>
				<td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">Gender</font>
				</td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">:</font></b>
				</td>
				<td width="313" colspan="2">
					<select size="1" name="studentgender">
<%
	if((gen=rs.getString("gender")).equals("m"))
	{
%>
						<option selected value="<%=gen%>">Male</option>
						<option value="female" >Female</option>
<%
	}
	else if((gen=rs.getString("gender")).equals("f"))
	{
%>
						<option selected value="<%=gen%>">Female</option>
						<option value="male" >Male</option>
<%
	}
	else
	{
%>
						<option selected value="none">Gender</option>
						<option value="male" >Male</option>
						<option value="female" >Female</option>
<%
	}
%>
					</select>
				</td>
			</tr>
			<tr>
				<td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">Date of Birth</font>
				</td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">:</font></b>
		        </td>
				<td width="500" colspan="5">
					<font face="Arial" size="2">
					<SELECT name="mm" size="1">
						<OPTION value=0 selected>[Select One]
						<OPTION value=1>January
						<OPTION value=2>February
						<OPTION value=3>March
						<OPTION value=4>April
						<OPTION value=5>May
						<OPTION value=6>June
						<OPTION value=7>July
						<OPTION value=8>August
						<OPTION value=9>September
						<OPTION value=10>October
						<OPTION value=11>November
						<OPTION value=12>December</OPTION>
					</SELECT>
<%
			if(ddd==0 || dyy==0)
			{
%>
					<INPUT maxLength=2 size=2 name="dd">
					<INPUT maxLength=4 size=4 name="yy"></font>
<%		
			}
			else
			{
%>
					<INPUT maxLength=2 size=2 name="dd" value="<%=ddd%>">
					<INPUT maxLength=4 size=4 name="yy" value="<%=dyy%>">
					</font>
<%
			}
%>
					<FONT class=content_help face="Times New Roman" color="red"><i>(Month DD, YYYY)</i></FONT>
					<font face="Arial" size="2"></font>
				</td>
			</tr>
			<tr>
				<td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">Parent/Guardian Name</font>
				</td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">:</font></b>
				</td>
				<td width="313" colspan="2">
					<input type="text" name="parentname" maxlength="25" size="20" value="<%=rs.getString("parent_name")%>">
					<font color="red"> *</font>
				</td>
			</tr>
			<tr>
				<td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">District</font>
				</td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">:</font></b>
				</td>
				<!-- <td width="313" colspan="2">
					<input type="text" name="parentocc" maxlength="25" size="20" value="<%=rs.getString("parent_occ")%>">
					<font color="red"></font>
				</td> -->
				<!-- District disply --->
				
				<td width="100" colspan="2">
					<select name="parentocc" size="1">
						<option value=none selected>.. Select ..</option>
<%				
					//System.out.println("***********");
			try
			{
					st2 = con.createStatement();
					//System.out.println("select * from dist_master where school_id='"+schoolid+"' order by dist_desc");
				rs2 = st2.executeQuery("select * from dist_master where school_id='"+schoolid+"' order by dist_desc");
				while(rs2.next())
				{
					//System.out.println("In while...");
					if(rs.getString("parent_occ").equals(rs2.getString("dist_id")))
					{
						out.println("<option value='"+rs2.getString("dist_id")+"' selected>"+rs2.getString("dist_desc")+"</option>");
					}
					else
					{
						out.println("<option value='"+rs2.getString("dist_id")+"'>"+rs2.getString("dist_desc")+"</option>");
					}
				}	
				rs2.close();
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("modifyStudentReg.jsp","operations on database","SQLException",se.getMessage());
				System.out.println("SQL Error in modifyStudentReg.jsp is...:"+se);		
			}
			finally{
			try{
				if(st2!=null)
					st2.close();
				
			}catch(Exception e){
				ExceptionsFile.postException("modifyStudentReg.jsp","Closing the  connection object ","Exception",e.getMessage());
			}
		}
		
%>
					</select>
					
				</td>


				<!-- Upto here -->
				
			</tr>
			<tr>
				<td width="262" height="27" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">Email</font>
				</td>
				<td width="8" height="27" align="center" valign="middle">
					<b><font face="Arial" size="2">:</font></b>
				</td>
				<td width="313" height="27" colspan="2">
					<input type="text" name="email" maxlength="50" size="20" value="<%=rs.getString("con_emailid")%>"> 
					<font face="Times New Roman" color="red"><i>(Valid email address)</i></font>
					<font color="red">*</font>
				</td>
			</tr>
			<tr>
				<td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">Address</font>
				</td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">:</font></b>
				</td>
				<td width="313" colspan="2">
					<input type="text" name="stuaddress" maxlength="50" size="20" value="<%=rs.getString("address")%>">
				</td>
			</tr>
			<tr>
				<td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">City </font>
				</td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">:</font></b>
				</td>
				<td width="313" colspan="2">
					<input type="text" name="stucity" maxlength="30" size="20" value="<%=rs.getString("city")%>">
				</td>
			</tr>
			<tr>
				<td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">Zip Code</font>
				</td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">&nbsp;:</font></b></p>
				</td>
				<td width="313" colspan="2">
					<input type="text" name="stuzipcode" maxlength="30" size="20" value="<%=rs.getString("zip")%>"  oncontextmenu="return false" onkeypress="return NumbersOnly(this, event)">
				</td>
			</tr>
			<tr>
				<td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">State</font>
				</td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">&nbsp;:</font></b>
				</td>
				<td width="313" colspan="2">
					<input type="text" name="stustate" maxlength="30" size="20" value="<%=rs.getString("state")%>">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">Country</font>
				</td>
				<td align="center" valign="middle">
					<b><font face="Arial" size="2">&nbsp;:</font></b></p>
				</td>
				<td colspan="2">
					<SELECT size=1 name=country lf="forms[0].ADMI_CONTACT_COUNTRY">
						<OPTION value=US selected>United States<OPTION value=AF>Afghanistan<OPTION value=AL>Albania<OPTION 
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
                  Kingdom<OPTION value=US selected>United States<OPTION value=UM>United States Minor Outlying Islands<OPTION 
value=UY>Uruguay<OPTION value=UZ>Uzbekistan<OPTION value=VU>Vanuatu<OPTION 
value=VE>Venezuela<OPTION value=VN>Viet Nam<OPTION value=VG>Virgin Islands
                  (British)<OPTION value=VI>Virgin Islands (United States)<OPTION value=WF>Wallis
                  &amp; Futuna Islands<OPTION value=EH>Western Sahara<OPTION value=YE>Yemen<OPTION 
value=YU>Yugoslavia<OPTION value=ZM>Zambia</OPTION></SELECT>
				</td>
			</tr>
			<tr>
				<td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">Phone</font>
				</td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">&nbsp;:</font></b></p>
				</td>
				<td width="313" colspan="2">
					<input type="text" name="stuphone" maxlength="30" size="20" value="<%=rs.getString("phone")%>"  oncontextmenu="return false" onkeypress="return PhoneOnly(this, event)">
				</td>
			</tr>
			<tr>
				<td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">Fax</font>
				</td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">&nbsp;:</font></b></p>
				</td>
				<td width="313" colspan="2">
					<input type="text" name="stufax" maxlength="30" size="20" value="<%=rs.getString("fax")%>"  oncontextmenu="return false" onkeypress="return PhoneOnly(this, event)"></p>
				</td>
			</tr>
			<tr>
				<td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">Personal Website</font></p>
				</td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">&nbsp;:</font></b></p>
				</td>
				<td width="313" colspan="2">
					<input type="text" name="stuwebsite" maxlength="30" size="20" value="<%=rs.getString("pers_web_site")%>"></p>
				</td>
			</tr>
<%
		}
		rs1=stmt.executeQuery("select * from student_school_det where student_id='"+username+"' and school_id='"+schoolid+"'");

		if(rs1.next() && !mode.equals("admodify"))
		{
%>
			<tr>
		        <td width="491" colspan="5" align="left" valign="middle">
			        <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
				        <tr>
					        <td width="148">
								<font face="Arial" size="2"><b>Your School Details :</b></font>
							</td>
							<td width="456"><hr></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">School Name</font></p>
				</td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">:</font></b></p>
				</td>
				<td width="313" colspan="2">
					<input type="text" name="schoolname" maxlength="50" size="20" value="<%=rs1.getString("school_name")%>"></p>
				</td>
			</tr>
			<tr>
				<td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">School Type</font></p>
				</td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">&nbsp;:</font></b></p>
				</td>
				<td width="313" colspan="2">
					<input type="text" name="schooltype" maxlength="30" size="20" value="<%=rs1.getString("school_id")%>"></p>
				</td>
	        </tr>
		    <tr>
				<td width="262" colspan="2" align="left" valign="top">
					<font face="Arial" size="2">Enter a brief description of the School </font></p>
		        </td>
				<td width="8" align="center" valign="top">
					<b><font face="Arial" size="2">&nbsp;:</font></b></p>
		        </td>
				<td width="313" colspan="2" align="left" valign="middle">
					<textarea name="schooldetails" rows="4" cols="20"><%=rs1.getString("school_des")%></textarea></p>
		        </td>
			</tr>
	        <tr>
			    <td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">Address</font></p>
				</td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">&nbsp;:</font></b></p>
				</td>
				<td width="313" colspan="2">
					<input type="text" name="schaddress" maxlength="30" size="20" value="<%=rs1.getString("address")%>"></p>
				</td>
			</tr>
			<tr>
		        <td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">City</font></p>
		        </td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">:</font></b></p>
		        </td>
				<td width="313" colspan="2">
					<input type="text" name="schcity" maxlength="30" size="20" value="<%=rs1.getString("city")%>"></p>
		        </td>
			</tr>
	        <tr>
			    <td width="262" colspan="2" align="left" valign="middle">
				    <font face="Arial" size="2">Zip Code</font></p>
		        </td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">:</font></b></p>
		        </td>
				<td width="313" colspan="2">
					<input type="text" name="schzip" maxlength="30" size="20" value="<%=rs1.getString("zip_code")%>"  oncontextmenu="return false" onkeypress="return NumbersOnly(this, event)"></p>
		        </td>
			</tr>
			<tr>
		        <td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">State</font></p>
		        </td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">:</font></b></p>
				</td>
				<td width="313" colspan="2">
					<input type="text" name="schstate" maxlength="25" size="20" value="<%=rs1.getString("state")%>"></p>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">Country</font></p>
				</td>
		        <td align="center" valign="middle" >
			        <b><font face="Arial" size="2">:</font></b></p>
		        </td>
				<td colspan="2" align="left" valign="middle">
					<SELECT size=1 name="schcountry" 
lf="forms[0].ADMI_CONTACT_COUNTRY"><OPTION value=US selected>United States<OPTION value=AF>Afghanistan<OPTION value=AL>Albania<OPTION 
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
              Kingdom<OPTION value=UM>United States Minor Outlying Islands<OPTION 
value=UY>Uruguay<OPTION value=UZ>Uzbekistan<OPTION value=VU>Vanuatu<OPTION 
value=VE>Venezuela<OPTION value=VN>Viet Nam<OPTION value=VG>Virgin Islands
              (British)<OPTION value=VI>Virgin Islands (United States)<OPTION value=WF>Wallis
              &amp; Futuna Islands<OPTION value=EH>Western Sahara<OPTION value=YE>Yemen<OPTION 
value=YU>Yugoslavia<OPTION value=ZM>Zambia</OPTION></SELECT>
				</td>
			</tr>
			<tr>
				<td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">Phone</font></p>
				</td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">:</font></b></p>
				</td>
				<td width="313" colspan="2">
					<input type="text" name="schphone" maxlength="25" size="20" value="<%=rs1.getString("phone")%>"  oncontextmenu="return false" onkeypress="return PhoneOnly(this, event)"></p>
		        </td>
			</tr>
	        <tr>
			    <td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">Fax</font></p>
				</td>
		        <td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">:</font></b></p>
		        </td>
				<td width="313" colspan="2">
					<input type="text" name="schfax" maxlength="25" size="20" value="<%=rs1.getString("fax")%>" oncontextmenu="return false" onkeypress="return PhoneOnly(this, event)"></p>
		        </td>
			</tr>
			<tr>
		        <td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">School Email</font></p>
		        </td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">:</font></b></p>
		        </td>
				<td width="313" colspan="2">
					<input type="text" name="schemail" maxlength="50" size="20" value="<%=rs1.getString("school_email")%>"></p>
		        </td>
			</tr>
	        <tr>
			    <td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">School Website</font></p>
		        </td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">:</font></b></p>
		        </td>
				<td width="313" colspan="2">
					<input type="text" name="schoolwebsite" maxlength="30" size="20" value="<%=rs1.getString("school_web_site")%>"></p>
		        </td>
			</tr>

		<script>
				document.StudentReg.schcountry.value = "<%=rs1.getString("country")%>";
		</script>
<%
		}
		if(mode.equals("admodify"))
		{
%>
			<tr>
			    <td width="262" colspan="2" align="left" valign="middle">
					<font face="Arial" size="2">Status</font></p>
		        </td>
				<td width="8" align="center" valign="middle">
					<b><font face="Arial" size="2">:</font></b></p>
		        </td>
<%
			if(rs.getString("status").equals("1"))
			{
				
	%>
				<td width="250" align="left" valign="middle">
					<input type="radio" value="1" checked name="status">Active
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		            <input type="radio" name="status" value="0">Inactive</td>
<%
				
			}
			else
			{
				
				if(licenseType.equals("student"))
				{
					if(noOfStudents<regStudents)
					{
						
%>
		        <td width="250" align="left" valign="middle">
						<input type="radio" name="status" value="0" checked>Inactive</td>
<%
					}
					else
						{
						
%>
						<td width="250" align="left" valign="middle">
						<input type="radio" value="1" name="status">Active
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="status" value="0" checked>Inactive</td>
<%
					}
				}
				else if(licenseType.equals("seat"))
				{
					if(noOfStudents<=regStudents)
					{
						
						%>
					<td width="250" align="left" valign="middle">
						<input type="radio" name="status" value="0" checked>Inactive<p align="left"><span style="font-size:10pt;"><font face="Arial"  color="red">Exceeded the maximum number of student licenses allowed.</font></span></p></td>						
<%

					}
					else
					{
%>
					<td width="250" align="left" valign="middle">
					<input type="radio" value="1" name="status">Active
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		            <input type="radio" name="status" value="0" checked>Inactive</td>
						
<%

					}
				}
				else
				{
%>
				<td width="250" align="left" valign="middle">
					<input type="radio" value="1" name="status">Active
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			        <input type="radio" name="status" checked value="0">Inactive</td>
<%
			}
			}
%>
	        </tr>

		<input type="hidden" name="usertype" value='<%=rs.getString("user_type")%>'>
<%
		}
%>
			<tr>
				<td width="36">&nbsp;</td>
		        <td width="107" align="right">
					<input type="submit" name="submit" value="  Submit  "></p>
				</td>
				<td width="8">&nbsp;</td>
		        <td width="148">
					<input type="button" name="re" value="   Reset  " onclick="window.document.forms[0].reset();init();" ></p>
				</td>
		        <td width="156">&nbsp;</td>
			</tr>
	
			<input type="hidden" name="mode" value='<%=mode%>'>
		</table>
</form>
<%
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("modifyStudentReg.jsp","operations on database object","Exception",e.getMessage());
		out.println("There is an exception raised in Modifying Student Profile :"+e);
	}
	finally
	{
		try
		{
			if(rs!=null)
				rs.close();
			if(rs1!=null)
				rs1.close();
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(stmt!=null)
				stmt.close();
			if(con!=null && !con.isClosed())
			con.close();
		}
		catch(Exception ee){
			ExceptionsFile.postException("SelSubs.jsp","closing statement,resultset and connection objects","Exception",ee.getMessage());
		}
	}
%>
</body>
<script>
function init(){
	document.StudentReg.country.value = "<%=cntry%>";
	document.StudentReg.mm.value = "<%=dmm%>";
	<%if(mode.equals("admodify")){%>
		document.StudentReg.studentgrade.value = "<%=grade%>";
	<%}%>
}init();
</script>
</html>
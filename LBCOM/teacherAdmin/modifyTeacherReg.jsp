<%@ page import = "java.sql.*,java.lang.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page" />
<jsp:setProperty name="db" property="*" />

<%
	String mode="",schoolid="",username="",gen="",cntry="",grade="",status="",dobs="",subsectionId="";
	Connection con=null;
	Statement st=null,stmt=null;
	ResultSet rs=null,rs1=null,rss=null;
	java.util.Date dob=null;
	int ddd=0,dmm=0,dyy=0;
	//PrintWriter out=null;
%>
<html>
<head>
<title></title>
<meta name="generator" content="Microsoft FrontPage 6.0">
</head>
<script language="javascript" src="../validationscripts.js"></script>
<%String formid="F00001";%> 
<%@ include file="/accesscontrol/accesscontrol.jsp" %> 	
<script language="JavaScript">
  function changePassword()
	  {
	      password_window = window.open("/LBCOM/ChangePassword.jsp","password_window","width=600,height=300");
	      password_window.moveTo(300,230);
      }
 
 function checkdate(d,m,y){
 var frm=window.document.TeacherReg
  var k=1
  var dinm = new Array(0,31,28,31,30,31,30,31,31,30,31,30,31);
  tday=new Date();
  
  if(y <=1900 || y >= parseInt(tday.getFullYear()) ||isNaN(y))
  {
   alert("Enter valid year");
   frm.yy.focus();
   frm.yy.select();
   return 0;
  }
else
  if(y %4==0 &&(y%100!=0 ||y%400==0))
   dinm[2]=29;

if((m > 12 || m < 1)|| isNaN(m))
{
   alert("Enter valid month");
   frm.mm.focus();
   return 0;
}

if((d<1 || d >dinm[m])||isNaN(d) )
{
	
   alert("Enter valid Date");
   frm.dd.focus();
   frm.dd.select();
   return 0;
}

}

function show_key(field)
{	var the_key=" abcdefghijklmnopqrstuvwxyz";
	//alert("hai");
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
			alert("School Name should have atleast six characters");
			frm.username.focus();
			return false;
		}
		<%
			if(!mode.equals("admodify")){%>
		if(trim(frm.password.value)=="")
		{
			alert("Please enter password");
			frm.password.focus();
			return false;
		}
		if (trim(frm.password.value).length<6) {
			alert("Password should be atleast 6 characters");
			frm.password.focus();
			return false;
		}
		if(frm.password.value!=frm.cpassword.value)
		{
			alert("password fields mismatch \n Please enter again");
			frm.cpassword.value="";
			frm.password.value="";
			frm.password.focus();
			return false;
		}
		<%}%>
		if(trim(frm.firstname.value)=="")
		{
			alert("Enter your First Name");
			frm.firstname.focus();
			return false;
		}else if(show_key(frm.firstname)==false) {
			alert("Enter only alphabets");
			frm.firstname.focus();
			return false;
		}
		if(trim(frm.lastname.value)=="")
		{
			alert("Enter your Last Name");
			frm.lastname.focus();
			return false;
		}else if(show_key(frm.lastname)==false) {
			alert("Enter only alphabets");
			frm.lastname.focus();
			return false;
		}

		if(frm.teachergrade.value=="none")
		{
			alert("Select ClassID");
			frm.teachergrade.focus();
			return false;
		}
		if(frm.dd.value!="" || frm.mm.value>0 || frm.yy.value!="")
		{
		if(checkdate(parseInt(frm.dd.value,10),parseInt(frm.mm.value,10),parseInt(frm.yy.value,10))==false)
		  return false;
		}
		if(isValidEmail(frm.email.value)==false)
		{
			frm.email.focus();
			return false;
		}
		if (isNaN(trim(frm.stuzipcode.value))) {
			alert("Enter only numbers");
			frm.stuzipcode.focus();
			return false;
		}
		if (show_key(frm.stustate)==false) {
			alert("Enter only alphabets");
			frm.stustate.focus();
			return false;
		}
		if (isNaN(trim(frm.stuphone.value))) {
			alert("Enter only numbers");
			frm.stuphone.focus();
			return false;
		}

	  frm.schoolid.disabled = false;
	  frm.username.disabled = false;
	  frm.teachergrade.disabled = false;
	  replacequotes();

	}

	function getsubids(id) {
		clear();
		var j=1;
		var i;
		for (i=0;i<subsections.length;i++){
			if(subsections[i][0]==id){
				document.TeacherReg.subsection[j]=new Option(subsections[i][2],subsections[i][1]);
				j=j+1;
			}
		} 
	}

	function clear() {
		var i;
		var temp=document.TeacherReg.subsection;
		for (i=temp.length;i>0;i--){
			if(temp.options[i]!=null){
				temp.options[i]=null;
			}
		}
	}
</script>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" onload=addcontrol()>
<form name="TeacherReg" method="post" action="/LBCOM/teacherAdmin.RegisterTeacher" onsubmit="return validate(this);">
&nbsp;<table border="0" align="center" cellpadding="3" cellspacing="3" width="861">
<%
    session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	schoolid=(String)session.getAttribute("schoolid");
	
	mode = request.getParameter("mode");
	if(mode.equals("admodify"))
		username=request.getParameter("user");
	else
		username=(String)session.getAttribute("emailid");

	try
	{
		con = db.getConnection();	
		st = con.createStatement();
		stmt = con.createStatement();
		rs=st.executeQuery("select * from teachprofile where email='"+username+"' and schoolid='"+schoolid+"'");
		if(rs.next())
		{
	    	dob = rs.getDate("birth_date");
			subsectionId=rs.getString("subsection_id");
			cntry = rs.getString("country");
			grade = rs.getString("class_id");
			if(dob!=null)
			{ddd = dob.getDate();
			 dmm = dob.getMonth();
			 dmm++;
			 dyy = dob.getYear();
			 dyy+=1900;
			}
			else
			{dmm=0;dyy=0;ddd=0;
			}
			
		
if(!mode.equals("admodify"))
{
%>
    <tr>
        <td width="492" colspan="5" valign="middle">
            <p><font face="Arial"><b><span style="font-size: 12pt">Modify
            Profile</span></b></font><span style="font-size:10pt;"></p>
        </td>
    </tr>
    <tr>
        <td width="492" colspan="5">
            <p><font face="Arial"><b><span style="font-size: 10pt">Your Personal Details</span></b></font><span style="font-size:10pt;"><font face="Arial"><b>
            : </b></font></span></p>
        </td>
	
        <td width="348" colspan="5">
            <p><font face="Arial"><b><span style="font-size: 10pt">
	     <input type="button" name="cngpwd_button" value="Change Password" onclick="JavaScript : changePassword();" >
            </span></b></font><span style="font-size:10pt;"><font face="Arial"><b>
            </b></font></span></p>
        </td>
       
    </tr>
<%
}
else
{
%>
  <tr>
        <td width="492" colspan="5">
            <p><font face="Arial"><b><span style="font-size: 10pt">Modify Teacher's
            Profile</span></b></font><span style="font-size:10pt;"><font face="Arial"><b>
            : </b></font></span></p>
        </td>
		<%if(!mode.equals("admodify")){%>
        <td width="348" colspan="5">
            <p><font face="Arial"><b><span style="font-size: 10pt">
	     <input type="button" name="cngpwd_button" value="Change Password" onclick="JavaScript : changePassword();" >
            </span></b></font><span style="font-size:10pt;"><font face="Arial"><b>
           </b></font></span></p>
        </td>
		<%}%>
    </tr>
<%
}
%>

     <tr>
        <td width="492" colspan="5">
                <table align="center" cellpadding="0" cellspacing="0" width="100%">

<TR>
<TD width="598"><TABLE cellSpacing="2" cellPadding="2" border=0 width="70%" align="center">
<TBODY>
<TR>
<TD width=20 height=10 rowSpan="6"><span style="font-size:10pt;"><font face="Arial">&nbsp;</font></span></TD>
<TD noWrap height=10></TD></TR>
<TR>
<TD class=medgray width=150><span style="font-size:10pt;"><font face="Arial">School 
                                        ID</font></span></TD>
<TD><span style="font-size:10pt;"><font face="Arial">
<INPUT type="text" maxLength="50" size=25 name="schoolid" lf="forms[0].USER_NAME" value="<%=rs.getString("schoolid")%>" disabled></font></span></TD></TR>
<TR>
<TD class=medgray width=150><span style="font-size:10pt;"><font face="Arial">User ID</font></span></TD>
<TD><span style="font-size:10pt;"><font face="Arial">
<!--webbot bot="Validation" b-value-required="TRUE" i-minimum-length="3" i-maximum-length="50" --><INPUT maxLength="50" size=25 name=username 
lf="forms[0].USER_NAME" value="<%=rs.getString("email")%>" disabled></font></span></TD></TR>
<%if(mode.equals("admodify"))
{
%>
<TR>
<TD class=medgray><span style="font-size:10pt;"><font face="Arial">password</font></span></TD>
<TD><span style="font-size:10pt;"><font face="Arial">
<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="14" --><INPUT type=password maxLength="14" size="18" value="<%=rs.getString("password")%>" name=password 
lf="forms[0].password"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return pwdOnly(this, event)" ></font></span><font color="red">*</font></TD></TR>
<TR>
<TD class=medgray><span style="font-size:10pt;"><font face="Arial">Confirm password</font></span></TD>
<TD><span style="font-size:10pt;"><font face="Arial">
<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="14" --><INPUT type=password maxLength="14" size="18" value="<%=rs.getString("password")%>" name=cpassword 
lf="forms[0].password1"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return pwdOnly(this, event)" ></font></span><font color="red">*</font></TD></TR><TR>
<%}else{%>
<INPUT TYPE="hidden" value="<%=rs.getString("password")%>" name=password ><INPUT TYPE="hidden" value="<%=rs.getString("password")%>" name=cpassword >
<%}%>
<TD class=medgray>
                                        <p>&nbsp;</p>
</TD>
<TD>
                                        <p>&nbsp;</p>
</TD></TR></TBODY></TABLE></TD>
</TR>
                </table>
        </td>
    </tr>
    <tr>
        <td width="262" colspan="2" align="left" valign="middle">
            <p><span style="font-size:10pt;"><font face="Arial">First Name</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
            <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2">
            <p><span style="font-size:10pt;"><font face="Arial">&nbsp;</font></span><!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="25" --><input type="text" name="firstname" maxlength="25" size="20" value="<%=rs.getString("firstname")%>"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NameOnly(this, event)" ><font color="red">*</font></p>
        </td>
    </tr>
    <tr>
        <td width="262" colspan="2" align="left" valign="middle">
            <p><span style="font-size:10pt;"><font face="Arial">Last Name</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
            <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2">
            <p><span style="font-size:10pt;"><font face="Arial">&nbsp;</font></span><!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="25" --><input type="text" name="lastname" maxlength="25" size="20" value="<%=rs.getString("lastname")%>"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NameOnly(this, event)" ><font color="red">*</font></p>
        </td>
    </tr>
    <tr>
        <td width="262" colspan="2" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">Class ID</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
<%
	if(mode.equals("admodify"))
	{
		if(schoolid.equals("talprimary"))
		{
%>
        <td width="314" colspan="2">
                <p>&nbsp;<select name="teachergrade" size="1">
		<option value=none selected>Select Grade</option>
		<option value="1stGrade">1st Grade
		<option value="2ndGrade">2nd Grade
		<option value="3rdGrade">3rd Grade
		<option value="4thGrade">4th Grade
		<option value="5thGrade">5th Grade
	</select></p>
        </td>
		
<%
		}
		else if(schoolid.equals("talmiddle"))
		{
%>
        <td width="135" colspan="2">
               <p>&nbsp;<select name="teachergrade" size="1">
			<option value=none selected>Select Grade</option>
			<option value="6thGrade">6th Grade
			<option value="7thGrade">7th Grade
			<option value="8thGrade">8th Grade
			</select></p>
        </td>
<%
		}
		else if(schoolid.equals("talhigher"))
		{
%>
       <td width="316" colspan="2">
       <p>&nbsp;<select name="teachergrade" size="1">
		<option value=none selected>Select Grade</option>
		<option value="9thGrade">9th Grade
		<option value="10thGrade">10th Grade
		<option value="11thGrade">11th Grade
		<option value="12thGrade">12th Grade
		</select></p>
        </td>
<%
		}
		else
		{
%>
		<td width="86" colspan="2">
        <p>&nbsp;<select name="teachergrade" size="1" onchange="getsubids(this.value);">

		<option value=none>.. Select ..</option>
		<%

			try	{

				//rss = db.execSQL("select class_des from class_master where school_id='"+schoolid+"' order by class_des");

			   rss = stmt.executeQuery("select class_id,class_des from class_master where school_id='"+schoolid+"' order by class_des");
		
				while(rss.next()){
				
					out.println("<option value='"+rss.getString("class_id")+"'>"+rss.getString("class_des")+"</option>");
				}	
				rss.close();
			}
			catch(SQLException se){
				ExceptionsFile.postException("modifyTeacherReg.jsp","operations on database","SQLException",se.getMessage());
				System.out.println("SQL Error");		
			}

		%>

		</select></p>
        </td>
		 <tr>
        <td width="262" colspan="2" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">Subsection ID</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2">
                <p>&nbsp;<select name="subsection" size="1">
		<option value="nil" selected>Select Subsection</option>

	<%	
			try{
				out.println("<SCRIPT Language='JavaScript'>");
				out.println("var subsections=new Array();");
				rss=stmt.executeQuery("select * from subsection_tbl where school_id='"+schoolid+"'");
				for(int i=0,j=1;rss.next();i++){
					
					if(rss.getString("class_id").equals(grade)){
						out.println("document.TeacherReg.subsection["+j+++"]=new Option('"+rss.getString("subsection_des")+"','"+rss.getString("subsection_id")+"');");
						if(rss.getString("subsection_id").equals(subsectionId)){
							out.println("document.TeacherReg.subsection.value='"+rss.getString("subsection_id")+"'");
						}
					}
					out.println("subsections["+i+"]=new Array('"+rss.getString("class_id")+"','"+rss.getString("subsection_id")+"','"+rss.getString("subsection_des")+"');");
				}
					out.println("</script>");

				
			}
			catch(SQLException se){
				ExceptionsFile.postException("modifyTeacherReg.jsp","operations on database","SQLException",se.getMessage());
				System.out.println("SQL Error");		
			}
			%>
		</select></p>
        </td>
	 </tr>
<%
		}
	}
	else
	{
		rss = stmt.executeQuery("select class_des from class_master where school_id='"+schoolid+"' and  class_id='"+grade+"' order by class_des");
		if(rss.next()){
%>
		<td width="316" colspan="2">
            <p><span style="font-size:10pt;"><font face="Arial">&nbsp;</font></span><!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="25" --><input type="text" name="teachergrade" maxlength="25" size="20" value='<%=rss.getString("class_des")%>' disabled></p>
        </td>
	 </tr>
		<%}
			rss = stmt.executeQuery("select subsection_des from subsection_tbl where school_id='"+schoolid+"' and  subsection_id='"+subsectionId+"'");
			if(rss.next()){
			%>
			<tr>
        <td width="262" colspan="2" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">Subsection ID</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
			<td width="314" colspan="2">
            <p><span style="font-size:10pt;"><font face="Arial">&nbsp;</font></span><!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="25" --><input type="text" name="subsection" maxlength="25" size="20" value='<%=rss.getString("subsection_des")%>' disabled></p>
        </td>
		 </tr>
	<%
			}
			}
		%>
   
    <tr>
        <td width="262" colspan="2" align="left" valign="middle">
            <p><span style="font-size:10pt;"><font face="Arial">Gender</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
            <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2">
            <p><span style="font-size:10pt;"><font face="Arial">&nbsp;</font></span><select size="1" name="teachergender">
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
      </select></p>
        </td>
    </tr>
    <tr>
        <td width="262" colspan="2" align="left" valign="middle">
            <span style="font-size:10pt;"><font face="Arial">Date of Birth</font></span>
        </td>
        <td width="8" align="center" valign="middle">
            <b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b>
        </td>
        <td width="400" colspan="4">
            <span style="font-size:10pt;"><font face="Arial">&nbsp;
			<SELECT name="mm" size="1">
			<OPTION value=0 selected>[Select One]<OPTION value=1>January<OPTION value=2>February<OPTION value=3>March<OPTION 
				value=4>April<OPTION value=5>May<OPTION value=6>June<OPTION value=7>July<OPTION 
				value=8>August<OPTION value=9>September<OPTION value=10>October<OPTION 
				value=11>November<OPTION value=12>December</OPTION></SELECT>&nbsp; 
<%
			if(ddd==0 || dyy==0)
			{
%>&nbsp;
			<INPUT maxLength=2 size=2 name="dd">
			<INPUT maxLength=4 size=4 name="yy">
			<%		
			}
			else
			{
%>
			<INPUT maxLength=2 size=2 name="dd" value="<%=ddd%>">&nbsp;
			<INPUT maxLength=4 size=4 name="yy" value="<%=dyy%>">
	<%
			}
%>
			</font></span><FONT class=content_help face="Times New Roman" color="red">
			<span style="font-size:10pt;"><i>(Month DD, YYYY)</i></span></FONT>
		 </td>
    </tr>
	<tr>
        <td width="262" colspan="2" align="left" valign="middle">
            <span style="font-size:10pt;"><font face="Arial">Email 
                </font></span>
        </td>
        <td width="8"  align="center" valign="middle">
            <b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b>
        </td>
        <td width="314" colspan="2">
            <span style="font-size:10pt;"><font face="Arial">&nbsp;</font></span><!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="50" --><input type="text" name="email" maxlength="50" size="20" value="<%=rs.getString("con_emailid")%>"> 
                <span style="font-size:10pt;"><font face="Times New Roman" color="red"><i>(Valid 
                email address) </i></font></span><font color="red">*</font>
        </td>
    </tr>
	<tr>
        <td width="262" colspan="2" align="left" valign="middle">
            <p><span style="font-size:10pt;"><font face="Arial">Educational Qualification</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
            <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2">
            <p><span style="font-size:10pt;"><font face="Arial">&nbsp;</font></span><!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="25" --><input type="text" name="eduquali" maxlength="25" size="20" value="<%=rs.getString("qualification")%>"><font color="red"></font></p>
        </td>
    </tr>
	<tr>
        <td width="262" colspan="2" align="left" valign="middle">
            <p><span style="font-size:10pt;"><font face="Arial">Current Working Location</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
            <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2">
            <p><span style="font-size:10pt;"><font face="Arial">&nbsp;</font></span><!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="25" --><input type="text" name="currentworkinglocation" maxlength="25" size="20" value="<%=rs.getString("present_working")%>"><font color="red"></font></p>
        </td>
    </tr>
	<tr>
        <td width="262" colspan="2" align="left" valign="middle">
            <p><span style="font-size:10pt;"><font face="Arial">Previous Experience</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
            <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2">
            <p><span style="font-size:10pt;"><font face="Arial">&nbsp;</font></span><!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="25" --><input type="text" name="previousexperience" maxlength="25" size="20" value="<%=rs.getString("previous_exp")%>"><font color="red"></font></p>
        </td>
    </tr>
	<tr>
        <td width="262" colspan="2" align="left" valign="top">
      <p align="left"><font face="Arial"><span style="font-size:10pt;">Additional Information</span></font>        </td>
        <td width="8" align="center" valign="top">
                <p><span style="font-size:10pt;"><font face="Arial"><b>&nbsp;:</b></font></span></p>
        </td>
        <td width="314" colspan="2">
		<textarea rows="4" cols="20"  name="rewards" maxlength=50><%=rs.getString("add_info")%></textarea>        </td>
    </tr>
    <tr>
        <td width="262" colspan="2" align="left" valign="middle">
            <p><span style="font-size:10pt;"><font face="Arial">Address</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
            <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2">
            <p><span style="font-size:10pt;"><font face="Arial"><b>&nbsp;</b></font></span><!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="50" --><input type="text" name="stuaddress" maxlength="50" size="20" value="<%=rs.getString("address")%>"></p>
        </td>
    </tr>
        <tr>
        <td width="262" colspan="2" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">City </font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2">
            <p>&nbsp;<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="30" --><input type="text" name="stucity" maxlength="30" size="20" value="<%=rs.getString("city")%>"></p>
        </td>
        </tr>
        <tr>
        <td width="262" colspan="2" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">Zip Code</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2">
            <p>&nbsp;<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="30" --><input type="text" name="stuzipcode" maxlength="30" size="20" value="<%=rs.getString("zip")%>"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NumbersOnly(this, event)" ></p>
        </td>
        </tr>
        <tr>
        <td width="262" colspan="2" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">State</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2">
            <p>&nbsp;<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="30" --><input type="text" name="stustate" maxlength="30" size="20" value="<%=rs.getString("state")%>"></p>
        </td>
        </tr>
        <tr>
        <td colspan="2" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">Country</font></span></p>
        </td>
        <td align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td colspan="2">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;</font></span></b><SELECT size=1 name=country 
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
                  Kingdom<OPTION value=US selected>United States<OPTION value=UM>United States Minor Outlying Islands<OPTION 
value=UY>Uruguay<OPTION value=UZ>Uzbekistan<OPTION value=VU>Vanuatu<OPTION 
value=VE>Venezuela<OPTION value=VN>Viet Nam<OPTION value=VG>Virgin Islands
                  (British)<OPTION value=VI>Virgin Islands (United States)<OPTION value=WF>Wallis
                  &amp; Futuna Islands<OPTION value=EH>Western Sahara<OPTION value=YE>Yemen<OPTION 
value=YU>Yugoslavia<OPTION value=ZM>Zambia</OPTION></SELECT></p>
        </td>
        </tr>
        <tr>
        <td width="262" colspan="2" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">Phone</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2">
            <p>&nbsp;<input type="text" name="stuphone" maxlength="30" size="20" value="<%=rs.getString("phone")%>"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return PhoneOnly(this, event)" ></p>
        </td>
        </tr>
        <tr>
        <td width="262" colspan="2" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">Fax</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2">
            <p>&nbsp;<input type="text" name="stufax" maxlength="30" size="20" value="<%=rs.getString("fax")%>"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return PhoneOnly(this, event)" ></p>
        </td>
        </tr>
        <tr>
        <td width="262" colspan="2" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">Personal 
                Website</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2">
            <p>&nbsp;<input type="text" name="stuwebsite" maxlength="30" size="20" value="<%=rs.getString("pers_web_site")%>"></p>
        </td>
        </tr>
        <tr>
        <td width="492" colspan="5" align="left" valign="middle">
                <p>&nbsp;</p>
        </td>
        </tr>
		<script>				
		</script>
		<%
		}
		//stmt = con.createStatement();
		rs1=stmt.executeQuery("select * from teacher_school_det where teacher_id='"+username+"' and school_id='"+schoolid+"'");
		if(rs1.next() && !mode.equals("admodify"))
		{
		%>
        <tr>
        <td width="492" colspan="5" align="left" valign="middle">
                <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td width="148">            <p><span style="font-size:10pt;"><font face="Arial"><b>Your 
                            School&nbsp;Details 
                            :</b></font></span></p>
                        </td>
                        <td width="456">
                            <hr></td>
                    </tr>
                </table>
        </td>
        </tr>
        <tr>
        <td width="262" colspan="2" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">School Name</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2">
            <p>&nbsp;<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="50" --><input type="text" name="schoolname" maxlength="50" size="20" value="<%=rs1.getString("school_name")%>"></p>
        </td>
        </tr>
        <tr>
        <td width="262" colspan="2" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">School Type</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2">
            <p>&nbsp;<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="30" --><input type="text" name="schooltype" maxlength="30" size="20" value="<%=rs1.getString("school_id")%>"></p>
        </td>
        </tr>
        <tr>
        <td width="262" colspan="2" align="left" valign="top">
                <p><span style="font-size:10pt;"><font face="Arial">Enter a 
                brief description of the School </font></span></p>
        </td>
        <td width="8" align="center" valign="top">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2" align="left" valign="middle">
            <p>&nbsp;<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="200" --><textarea name="schooldetails" rows="4" cols="20"><%=rs1.getString("school_des")%></textarea></p>
        </td>
        </tr>
        <tr>
        <td width="262" colspan="2" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">Address</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2">
            <p>&nbsp;<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="30" --><input type="text" name="schaddress" maxlength="30" size="20" value="<%=rs1.getString("address")%>"></p>
        </td>
        </tr>
        <tr>
        <td width="262" colspan="2" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">City</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2">
            <p>&nbsp;<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="30" --><input type="text" name="schcity" maxlength="30" size="20" value="<%=rs1.getString("city")%>"></p>
        </td>
        </tr>
        <tr>
        <td width="262" colspan="2" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">Zip Code</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2">
            <p>&nbsp;<input type="text" name="schzip" maxlength="30" size="20" value="<%=rs1.getString("zip_code")%>"></p>
        </td>
        </tr>
        <tr>
        <td width="262" colspan="2" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">State</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2">
            <p>&nbsp;<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="25" --><input type="text" name="schstate" maxlength="25" size="20" value="<%=rs1.getString("state")%>"></p>
        </td>
        </tr>
        <tr>
        <td colspan="2" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">Country</font></span></p>
        </td>
        <td align="center" valign="middle" >
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td colspan="2" align="left" valign="middle">
            <p>&nbsp;<SELECT size=1 name="schcountry" 
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
value=YU>Yugoslavia<OPTION value=ZM>Zambia</OPTION></SELECT></p>
        </td>
        </tr>
        <tr>
        <td width="262" colspan="2" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">Phone</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2">
            <p>&nbsp;<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="25" --><input type="text" name="schphone" maxlength="25" size="20" value="<%=rs1.getString("phone")%>"></p>
        </td>
        </tr>
        <tr>
        <td width="262" colspan="2" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">Fax</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2">
            <p>&nbsp;<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="25" --><input type="text" name="schfax" maxlength="25" size="20" value="<%=rs1.getString("fax")%>"></p>
        </td>
        </tr>
        <tr>
        <td width="262" colspan="2" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">School Email</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2">
            <p>&nbsp;<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="50" --><input type="text" name="schemail" maxlength="50" size="20" value="<%=rs1.getString("school_email")%>"></p>
        </td>
        </tr>
        <tr>
        <td width="262" colspan="2" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">School Website</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="314" colspan="2">
            <p>&nbsp;<input type="text" name="schoolwebsite" maxlength="30" size="20" value="<%=rs1.getString("school_web_site")%>"></p>
        </td>
        </tr>
		<script>
				document.TeacherReg.schcountry.value = "<%=rs1.getString("country")%>";
		</script>
		<%
		}
		if(mode.equals("admodify"))
		{
		%>
		<tr>
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
        <td width="149">
            <p>&nbsp;<input type="radio" value="1" checked name="status">Active
        </td>
        <td width="156">
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
        <td width="67">
                <input type="radio" name="status" checked value="0">Inactive
        </td>
		<%
			}
		%>
        </tr>
		<!--<tr>
        <td width="262" colspan="2" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">User Type</font></span></p>
        </td>
		<td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <%
			//if(rs.getString("user_type").equals("1"))
			//{
		%>
        <td width="161">
            <p>&nbsp;<input type="radio" value="1" checked name="usertype">Registered
        </td>
        <td width="161">
                <input type="radio" name="usertype" value="2">Trial
        </td>
		<%
		//	}
	//		else
	//		{
		%>
		<td width="161">
            <p>&nbsp;<input type="radio" value="1" name="usertype">Registered
        </td>
        <td width="161">
                <input type="radio" name="usertype" checked value="2">Trial
        </td>
		<%
		//	}
		%>
        </tr>-->

		<%
		}
		%>
        <tr>
        <td width="36">
                <p>&nbsp;</p>
        </td>
        <td width="107">
                <p align="right"><input type="submit" name="submit" value="Submit"></p>
        </td>
        <td width="8">
                <p>&nbsp;</p>
        </td>
        <td width="149">
                <p>&nbsp;<input type="button" name="re" value="Reset" onclick="window.document.forms[0].reset();init();" ></p>
        </td>
        <td width="156">
                <p>&nbsp;</p>
        </td>
        </tr>
		<input type="hidden" name="mode" value='<%=mode%>'>
		
</table>
</form>
<script>
function init(){
	<%if(mode.equals("admodify")){%>
		document.TeacherReg.teachergrade.value = "<%=grade%>";
	<%}%>
	document.TeacherReg.country.value = "<%=cntry%>";
	document.TeacherReg.mm.value = "<%=dmm%>";
}init();
</script>
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
				if(rs1!=null)
					rs1.close();
				if(st!=null)
					st.close();
				if(stmt!=null)
					stmt.close();
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

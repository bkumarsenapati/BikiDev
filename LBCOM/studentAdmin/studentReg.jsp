<jsp:useBean id="db" class="sqlbean.DbBean" scope="page" />
<jsp:setProperty name="db" property="*" />
<%@page import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>

<%	
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null,rs1=null;
	String classId=null,classDes=null;
	String mode=null,schoolid=null,tag=null,regTag=null;
	String studentStaus="",licenseType="";
	try
	{
		session=request.getSession();
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		schoolid = (String)session.getAttribute("schoolid");
		studentStaus=request.getParameter("stustatus");
		licenseType=request.getParameter("ltype");
		
		con=db.getConnection();
		st=con.createStatement();
		//rs = db.execSQL("select class_des from class_master where school_id='"+schoolid+"' order by class_des");
		rs = st.executeQuery("select class_id,class_des from class_master where school_id='"+schoolid+"' order by class_des");
	}
	catch(SQLException se){
		ExceptionsFile.postException("studentReg.jsp","operations on database","SQLException",se.getMessage());
		try{
			  if(st!=null)
				st.close();
			  if(con!=null && !con.isClosed())
				  con.close();
		}catch(Exception e){
		  System.out.println("Exception while closing connection object in StudentBulkReg.jsp is "+e);
		}
		
	}

	tag=request.getParameter("mode");
	if (tag.equals("trial"))
		regTag="30 Day Free Trial Account";
	else
		regTag="";
%>

<html>
<head>
<title></title>
<meta name="generator" content="Microsoft FrontPage 6.0">
<script language="javascript" src="../validationscripts.js"></script>
<script language="JavaScript">

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
	if(isUserName(trim(frm.username.value))==false)
	{
		frm.username.focus();
		return false;
	}
	if(trim(frm.password.value)=="")
	{
		alert("Please enter password");
		frm.password.focus();
		return false;
	}
	if(trim(frm.firstname.value)=="")
	{
		alert("Please enter firstname");
		frm.firstname.focus();
		return false;
	}
	if(trim(frm.lastname.value)=="")
	{
		alert("Please enter lastname");
		frm.lastname.focus();
		return false;
	}
	if (trim(frm.password.value).length<6) {
		alert("Password should be of atleast 6 characters long");
		frm.password.focus();
		return false;
	}
	if(frm.password.value!=frm.cpassword.value)
	{
		alert("Password fields did not match. Please enter once again.");
		frm.cpassword.value="";
		frm.password.value="";
		frm.password.focus();
		return false;
	}
	
	if(frm.studentgrade.value=="none")
	{
		alert("Please select grade");
		frm.studentgrade.focus();
		return false;
	}
	/*if(frm.studentgender.value=="none")
	{
		alert("Select Gender");
		frm.studentgender.focus();
		return false;
	}*/
	if(frm.dd.value!="" || frm.mm.value>0 || frm.yy.value!="")
	{
	if(checkdate(parseInt(frm.dd.value),parseInt(frm.mm.value),parseInt(frm.yy.value))==false)
		  return false
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
	if (isNaN(trim(frm.stuzipcode.value))) {
		alert("Please enter only numbers");
		frm.stuzipcode.focus();
		return false;
	}
	if (show_key(frm.stustate)==false) {
		alert("Please enter only alphabet");
		frm.stustate.focus();
		return false;
	}
	if (isNaN(trim(frm.stuphone.value))) {
		alert("Please enter only numbers");
		frm.stuphone.focus();
		return false;
	}
	frm.schoolid.disabled = false;
	replacequotes();
}

function getsubids(id) {
		clear();
		var j=1;
		var i;
		for (i=0;i<subsections.length;i++){
			if(subsections[i][0]==id){
				document.StudentReg.subsection[j]=new Option(subsections[i][2],subsections[i][1]);
				j=j+1;
			}
		} 
	}

function clear() {
		var i;
		var temp=document.StudentReg.subsection;
		for (i=temp.length;i>0;i--){
			if(temp.options[i]!=null){
				temp.options[i]=null;
			}
		}
}
</script>
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
<form name=StudentReg method="post" action="/LBCOM/studentAdmin.RegisterStudent" onsubmit="return validate(this);">
&nbsp;

<center><FONT 
face="Arial" color="red"><B><%= regTag %></B></FONT><b> </b></center>

 

<table border="0" align="center" cellpadding="3" cellspacing="3" width="800">
<%
	mode = request.getParameter("mode");
	
%>
    <tr>
        <td width="604" colspan="5">
           <p align="center"><span style="font-size:10pt;"><font face="Arial"><b>Student Registration 
                : </b></font></span></p>
        </td>
    </tr>
	<TR>
		<TD class=medgray width="800" colspan="5">
<%
		if(studentStaus.equals("inactive"))
		{
%>
			<p align="left"><span style="font-size:10pt;"><font face="Arial"  color="red">Exceeded the maximum number of student licenses allowed. Any new registrations will be in in-active status.</font></span>
<%
		}
%>
</TD>
</TR>
    <tr>
        <td width="604" colspan="5">
<p align="right"><font face="Times New Roman"><b><i><font size="2">Fields marked with(</font></i></b></font><font color="red">*</font><font size="2"><i><font face="Times New Roman"><b>)</b>
 
</font><b><font face="Times New Roman">are mandatory</font></b></i></font>        </td>
    </tr>
<%
	if(!mode.equals("adminreg"))
	{
%>
    <tr>
        <td width="604" colspan="5">
                <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td width="154">
						<p><span style="font-size:10pt;"><font face="Arial"><b>Your Personal  Detail :</b></font></span></p>
                        </td>
                        <td width="450">
                            <hr></td>
                    </tr>
                </table>
        </td>
    </tr>
<%
	}
%>
    <tr>
        <td width="604" colspan="5">
                <table align="center" cellpadding="0" cellspacing="0" width="100%">

<TR>
<TD width="598">

<TABLE cellSpacing="2" cellPadding="2" border=0 width="70%" align="center">
<TBODY>
<TR>
<TD noWrap width=150 height=10><span style="font-size:10pt;"><font face="Arial">&nbsp;</font></span></TD>
<TD width=20 height=10 rowSpan="6"><span style="font-size:10pt;"><font face="Arial">&nbsp;</font></span></TD>
<TD noWrap height=10><span style="font-size:10pt;"><font face="Arial">&nbsp;</font></span></TD></TR>
<%
	if(mode.equals("adminreg"))
	{

%>

<TR>
<TD class=medgray width=150><span style="font-size:10pt;"><font face="Arial">School 
                                        ID</font></span></TD>
<TD><span style="font-size:10pt;"><font face="Arial">
<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="50" --><INPUT type="text" maxLength="50" size=25 name="schoolid" lf="forms[0].USER_NAME" value='<%=schoolid%>' disabled></font></span></TD></TR>
<%
	}	
	else
	{
%>
<TR>
<TD class=medgray width=150><span style="font-size:10pt;"><font face="Arial">School 
                                        </font></span></TD>
<TD><span style="font-size:10pt;"><font face="Arial"><INPUT type="text" maxLength="50" size=25 name="schoolid" lf="forms[0].USER_NAME" value="Think-And-Learn" disabled></font></span></TD></TR> 
<%
	}
 %>
<TR>
<TD class=medgray width=150><span style="font-size:10pt;"><font face="Arial">User ID</font></span></TD>
<TD><span style="font-size:10pt;"><font face="Arial">
	<INPUT maxLength="50" size=25 name=username if="forms[0].USER_NAME"  oncontextmenu="return false" onkeypress="return UIDOnly(this, event)" ></font></span><font color="red">*</font></TD></TR>
<TR>
<TD class=medgray><span style="font-size:10pt;"><font face="Arial">Password</font></span></TD>
<TD><span style="font-size:10pt;"><font face="Arial">
<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="14" --><INPUT type=password maxLength="14" size="18" value="" name=password 
lf="forms[0].password"  oncontextmenu="return false" onkeypress="return pwdOnly(this, event)" ></font></span><font color="red">*</font></TD></TR>
<TR>
<TD class=medgray><span style="font-size:10pt;"><font face="Arial">Confirm password</font></span></TD>
<TD><span style="font-size:10pt;"><font face="Arial">
<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="14" --><INPUT type=password maxLength="14" size="18" value="" name=cpassword 
lf="forms[0].password1"  oncontextmenu="return false" onkeypress="return pwdOnly(this, event)"  ></font></span><font color="red">*</font></TD></TR><TR>
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
</table>
<table align="center" cellpadding="0" cellspacing="0" width="750">
    <tr>
        <td width="243" align="left" valign="middle">
            <p><span style="font-size:10pt;"><font face="Arial">First Name</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
            <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="335" colspan="3">
            <p><span style="font-size:10pt;"><font face="Arial">&nbsp;</font></span><!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="25" --><input type="text" name="firstname" maxlength="25" size="20"  oncontextmenu="return false" onkeypress="return NameOnly(this, event)"><font color="red">*</font></p>
        </td>
    </tr>
    <tr>
        <td width="243" align="left" valign="middle">
            <p><span style="font-size:10pt;"><font face="Arial">Last Name</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
            <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="335" colspan="3">
            <p><span style="font-size:10pt;"><font face="Arial">&nbsp;</font></span><!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="25" --><input type="text" name="lastname" maxlength="25" size="20"  oncontextmenu="return false" onkeypress="return NameOnly(this, event)"><font color="red">*</font></p>
        </td>
    </tr>
    <tr>
        <td width="243" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">Class ID</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
           
		<!--  kshdkfj hsakjdfashdkfhsakdhf -->
<%
	if(!mode.equals("adminreg"))
	{
%>
        <td width="316" colspan="2">
        <p>&nbsp;<select name="studentgrade" size="1">
		<option value=none selected>Select Grade</option>
		<option value="1stGrade">AuthorIt1 </option>		
		</select><font color="red">*</font></p>
        </td>
<%
	}
	else if(schoolid.equals("talprimary"))
	{
%>
		<td valign=left >
        <select name="studentgrade" size="1">
		<option value=none selected>Select Grade</option>
		<option value="1stGrade">1st Grade
		<option value="2ndGrade">2nd Grade
		<option value="3rdGrade">3rd Grade
		<option value="4thGrade">4th Grade
		<option value="5thGrade">5th Grade
		</select><font color="red">*</font>
        </td>
<%
	}
	else if(schoolid.equals("talmiddle"))
	{
%>
		<td width="316">
        <p>&nbsp;<select name="studentgrade" size="1">
		<option value=none selected>Select Grade</option>
		<option value="6thGrade">6th Grade
		<option value="7thGrade">7th Grade
		<option value="8thGrade">8th Grade
		</select><font color="red">*</font></p>
        </td>
<%
	}
	else if(schoolid.equals("talhigher"))
	{
%>
		<td width="316">
        <p>&nbsp;<select name="studentgrade" size="1">
		<option value=none selected>Select Grade</option>
		<option value="9thGrade">9th Grade
		<option value="10thGrade">10th Grade
		<option value="11thGrade">11th Grade
		<option value="12thGrade">12th Grade
		</select><font color="red">*</font></p>
        </td>
<%
	}
	else
	{
%>
		<td width="316" colspan="2">
        <p>&nbsp;<select name="studentgrade" size="1" onchange="getsubids(this.value);">
		<option value=none selected>.. Select .. </option>
		<%
	    try{
			while(rs.next()){
				
				out.println("<option value='"+rs.getString("class_id")+"'>"+rs.getString("class_des")+"</option>");
			}
			out.println("<SCRIPT Language='JavaScript'>");
			out.println("var subsections=new Array();");
		    rs=st.executeQuery("select * from subsection_tbl where school_id='"+schoolid+"'");
			for(int i=0;rs.next();i++){
				out.println("subsections["+i+"]=new Array('"+rs.getString("class_id")+"','"+rs.getString("subsection_id")+"','"+rs.getString("subsection_des")+"');");
			}
			
			out.println("</script>");
        }catch(Exception e){

		    ExceptionsFile.postException("studnetReg.jsp","Reterving the values from the resultset","Exception",e.getMessage());
		}finally{
			try{
				if(st!=null)
					st.close();

			}catch(Exception e){
				ExceptionsFile.postException("studnetReg.jsp","Closing the  connection object ","Exception",e.getMessage());
			}
		}

		%>
		</select><font color="red">*</font></p>
        </td>
<%
	}
%>
		

    </tr>

	<tr>
        <td width="243" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">Subsection ID</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
		<td width="316" colspan="2">
        <p>&nbsp;<select name="subsection" size="1">
		<option value='nil' selected>.. Select .. </option>
		</select></p>
        </td>
	</tr>

    <tr>
        <td width="243" align="left" valign="middle">
            <p><span style="font-size:10pt;"><font face="Arial">Gender</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
            <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="335" colspan="3">
            <p><span style="font-size:10pt;"><font face="Arial">&nbsp;</font></span><select size="1" name="studentgender">
		<option value="n" selected>Select</option>
        <option value="m" >Male</option>
        <option value="f" >Female</option>
      </select><font color="red"></font></p>
        </td>
    </tr>
    <tr>
        <td width="243" align="left" valign="middle">
            <p><span style="font-size:10pt;"><font face="Arial">Date of Birth</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
            <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="335" colspan="3">
            <p><span style="font-size:10pt;"><font face="Arial">&nbsp;<SELECT name="mm" size="1"><OPTION value=0 selected>[Select
              One]<OPTION 
value=1>January<OPTION value=2>February<OPTION value=3>March<OPTION 
value=4>April<OPTION value=5>May<OPTION value=6>June<OPTION value=7>July<OPTION 
value=8>August<OPTION value=9>September<OPTION value=10>October<OPTION 
value=11>November<OPTION value=12>December</OPTION></SELECT>&nbsp;
			<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="2" --> <INPUT 
maxLength=2 size=2 name="dd" >&nbsp;
			<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="4" -->  <INPUT maxLength=4 size=4 name="yy" ></font></span><FONT 
class=content_help face="Times New Roman" color="red"><span style="font-size:10pt;"><i>(Month, DD, YYYY)</i></span></FONT><span style="font-size:10pt;"><font face="Arial"> </font></span></p>
        </td>
    </tr>
	<tr>
        <td width="243" align="left" valign="middle">
            <p><span style="font-size:10pt;"><font face="Arial">Parent/Guardian Name</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
            <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="335" colspan="3">
            <p><span style="font-size:10pt;"><font face="Arial">&nbsp;</font></span><!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="25" --><input type="text" name="parentname" maxlength="25" size="20"><font color="red">*</font></p>
        </td>
    </tr>
	<tr>
        <td width="243" align="left" valign="middle">
            <p><span style="font-size:10pt;"><font face="Arial">District</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
            <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>

		 <!-- 
		 <td width="335" colspan="3">
            <p><span style="font-size:10pt;"><font face="Arial">&nbsp;</font></span><!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="25" --><!-- <input type="text" name="parentocc" maxlength="25" size="20"></p>
        </td> -->
<!-- Adding Districts from here... -->

		<td width="316" colspan="2">
        <p>&nbsp;<select name="parentocc" size="1">
		<option value="none" selected>.. Select .. </option>
		<%
	    try{

			st1=con.createStatement();
			 rs1=st1.executeQuery("select * from dist_master where school_id='"+schoolid+"'");
			while(rs1.next())
			{
				
				out.println("<option value='"+rs1.getString("dist_id")+"'>"+rs1.getString("dist_desc")+"</option>");
			}
			
		   }catch(Exception e){

		    ExceptionsFile.postException("studnetReg.jsp","Reterving the values from the resultset","Exception",e.getMessage());
		}finally{
			try{
				if(st1!=null)
					st1.close();
				
			}catch(Exception e){
				ExceptionsFile.postException("studnetReg.jsp","Closing the  connection object ","Exception",e.getMessage());
			}
		}

		%>
		</select><font color="red">*</font></p>
        </td>

<!-- Upto here ---->

       
    </tr>
    <tr>
        <td width="243" height="27" align="left" valign="middle">
            <p><span style="font-size:10pt;"><font face="Arial">Email 
                </font></span></p>
        </td>
        <td width="8" height="27" align="center" valign="middle">
            <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="335" height="27" colspan="3">
            <p><span style="font-size:10pt;"><font face="Arial">&nbsp;</font></span><!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="50" --><input type="text" name="email" maxlength="50" size="20"> 
                <span style="font-size:10pt;"><font face="Times New Roman" color="red"><i>(Valid 
                email address)*</i></font></span></p>
        </td>
    </tr>
    <tr>
        <td width="243" align="left" valign="middle">
            <p><span style="font-size:10pt;"><font face="Arial">Address</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
            <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="335" colspan="3">
            <p><span style="font-size:10pt;"><font face="Arial"><b>&nbsp;</b></font></span><!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="50" --><input type="text" name="stuaddress" maxlength="50" size="20"></p>
        </td>
    </tr>
        <tr>
        <td width="243" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">City </font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="335" colspan="3">
            <p>&nbsp;<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="30" --><input type="text" name="stucity" maxlength="30" size="20"></p>
        </td>
        </tr>
        <tr>
        <td width="243" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">Zip Code</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="335" colspan="3">
            <p>&nbsp;<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="30" --><input type="text" name="stuzipcode" maxlength="30" size="20"></p>
        </td>
        </tr>
        <tr>
        <td width="243" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">State</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="335" colspan="3">
            <p>&nbsp;<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="30" --><input type="text" name="stustate" maxlength="30" size="20"></p>
        </td>
        </tr>
        <tr>
        <td align="left" valign="middle" width="243">
                <p><span style="font-size:10pt;"><font face="Arial">Country</font></span></p>
        </td>
        <td align="center" valign="middle" width="8">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td colspan="3" width="335">
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
                  Kingdom<OPTION value=UM>United States Minor Outlying Islands<OPTION 
value=UY>Uruguay<OPTION value=UZ>Uzbekistan<OPTION value=VU>Vanuatu<OPTION 
value=VE>Venezuela<OPTION value=VN>Viet Nam<OPTION value=VG>Virgin Islands
                  (British)<OPTION value=VI>Virgin Islands (United States)<OPTION value=WF>Wallis
                  &amp; Futuna Islands<OPTION value=EH>Western Sahara<OPTION value=YE>Yemen<OPTION 
value=YU>Yugoslavia<OPTION value=ZM>Zambia</OPTION></SELECT></p>
        </td>
        </tr>
        <tr>
        <td width="243" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">Phone</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="335" colspan="3">
            <p>&nbsp;<input type="text" name="stuphone" maxlength="30" size="20"></p>
        </td>
        </tr>
        <tr>
        <td width="243" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">Fax</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="335" colspan="3">
            <p>&nbsp;<input type="text" name="stufax" maxlength="30" size="20"></p>
        </td>
        </tr>
        <tr>
        <td width="243" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">Personal 
                Website</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="335" colspan="3">
            <p>&nbsp;<input type="text" name="stuwebsite" maxlength="30" size="20"></p>
        </td>
        </tr>
      <!--  <tr>
        <td width="604" colspan="5" align="left" valign="middle">
                <p>&nbsp;</p>
        </td>
        </tr> -->
<%
	if(!mode.equals("adminreg"))
	{
%>
        <tr>
        <td width="604" colspan="5" align="left" valign="middle">
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
        <td width="243" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">School Name</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="335" colspan="3">
            <p>&nbsp;<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="50" --><input type="text" name="schoolname" maxlength="50" size="20"></p>
        </td>
        </tr>
        <tr>
        <td width="243" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">School Type</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="335" colspan="3">
            <p>&nbsp;<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="30" --><input type="text" name="schooltype" maxlength="30" size="20"></p>
        </td>
        </tr>
        <tr>
        <td width="243" align="left" valign="top">
                <p><span style="font-size:10pt;"><font face="Arial">Enter a 
                brief description of the School </font></span></p>
        </td>
        <td width="8" align="center" valign="top">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="335" colspan="3" align="left" valign="middle">
            <p>&nbsp;<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="200" --><textarea name="schooldetails" rows="4" cols="20"></textarea></p>
        </td>
        </tr>
        <tr>
        <td width="243" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">Address</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="335" colspan="3">
            <p>&nbsp;<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="30" --><input type="text" name="schaddress" maxlength="30" size="20"></p>
        </td>
        </tr>
        <tr>
        <td width="243" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">City</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="335" colspan="3">
            <p>&nbsp;<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="30" --><input type="text" name="schcity" maxlength="30" size="20"></p>
        </td>
        </tr>
        <tr>
        <td width="243" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">Zip Code</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="335" colspan="3">
            <p>&nbsp;<input type="text" name="schzip" maxlength="30" size="20"  oncontextmenu="return false" onkeypress="return PhoneOnly(this, event)"></p>
        </td>
        </tr>
        <tr>
        <td width="243" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">State</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="335" colspan="3">
            <p>&nbsp;<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="25" --><input type="text" name="schstate" maxlength="25" size="20"></p>
        </td>
        </tr>
        <tr>
        <td align="left" valign="middle" width="243">
                <p><span style="font-size:10pt;"><font face="Arial">Country</font></span></p>
        </td>
        <td align="center" valign="middle" width="8" >
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td colspan="3" align="left" valign="middle" width="335">
            <p>&nbsp;<SELECT size=1 name=schcountry 
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
        <td width="243" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">Phone</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="335" colspan="3">
            <p>&nbsp;<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="25" --><input type="text" name="schphone" maxlength="25" size="20"></p>
        </td>
        </tr>
        <tr>
        <td width="243" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">Fax</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="335" colspan="3">
            <p>&nbsp;<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="25" --><input type="text" name="schfax" maxlength="25" size="20"></p>
        </td>
        </tr>
        <tr>
        <td width="243" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">School Email</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="335" colspan="3">
            <p>&nbsp;<!--webbot bot="Validation" b-value-required="TRUE" i-maximum-length="50" --><input type="text" name="schemail" maxlength="50" size="20"></p>
        </td>
        </tr>
        <tr>
        <td width="243" align="left" valign="middle">
                <p><span style="font-size:10pt;"><font face="Arial">School Website</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
        <td width="335" colspan="3">
            <p>&nbsp;<input type="text" name="schoolwebsite" maxlength="30" size="20"></p>
        </td>
        </tr>
<%
	}
	else
	{
%>
		<tr>
        <td width="243" align="left" valign="middle">
              <p><span style="font-size:10pt;"><font face="Arial">Status</font></span></p>
        </td>
        <td width="8" align="center" valign="middle">
                <p><b><span style="font-size:10pt;"><font face="Arial">&nbsp;:</font></span></b></p>
        </td>
       
		<%
		if(studentStaus.equals("inactive"))
		{
	// inactive
%>
            <td width="75" colspan="2">
                <font face="Arial" size="2"><input type="radio" name="status" value="0" checked>Inactive</font>
        </td>
<%
		}
		else
		{
	%>
			 <td width="75"><p> <font face="Arial" size="2">&nbsp;<input type="radio" value="1" checked name="status">Active</font></td>
        <td width="75" colspan="1">
                <font face="Arial" size="2"><input type="radio" name="status" value="0">Inactive</font>
        </td>
       
<%
		}

%>
        </tr>
<font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#FF9900"> 
<%
	}
%>
        <tr>
        <td colspan="5" width="604">
               
                <p align="center"><input type="submit" name="submit" value="Submit" > 
                <input type="reset" name="reset" value="Reset">           

        </td>
        </tr>
		<input type="hidden" name="mode" value='<%=mode%>'>
</table>
</Form>
</body>
<script>
	document.StudentReg.studentgrade.value='C000';
	getsubids('C000');
</script>

</html>

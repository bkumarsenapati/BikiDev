<%@ page language="java" import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	String month[]={"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
%>
<%
	session=request.getSession();
	String s=(String)session.getAttribute("sessid");
	if(s==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}	
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rs2=null;
	String grade="",schoolid="",teacherid="";
	String stateName="",stateGrade="",stateSubject="";
	boolean stateStandards=false;
	try
	{
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		schoolid=(String)session.getAttribute("schoolid");
		String classFlag="";
		rs=st.executeQuery("select class_flag from school_profile where schoolid='"+schoolid+"'");
		if(rs.next())
		{
			classFlag=rs.getString(1);
		}
		rs.close();
		stateGrade=request.getParameter("grade");
		stateSubject=request.getParameter("subject");
		if(stateName==null || stateName.equals("none"))
		{
			stateName="Alabama";
		}
		if (stateGrade==null || stateGrade.equals("none")){
			stateGrade="";
			stateName="Alabama";
			stateStandards=false;
		}
		else
		{
			stateStandards=true;
		}
		if(stateSubject==null || stateSubject.equals("none"))
			stateSubject="";
%>

<html>
<head>
<title></title>
</head>
<script language="javascript" src="/LBCOM/validationscripts.js"></script>
<script>

//To add years from current year to current year+10 year

function initYears(){
	var dt=new Date();
	var year;
	year=dt.getFullYear()-1;
	for(var i=1;i<=10;i++)
	{
		year=year+1;
		window.document.createcourse.yyyy.options[i]=new Option(year,year);
	}
	  
	//for selecting today date
	var date=dt.getDate();
}

function clearfileds()					//resets the create course form
{
	window.document.createcourse.reset();
	return false;
}

function validate(frm)					//checks whether  all the required fields are filled or not
{
	if(trim(frm.coursename.value)=="")   //if the course name  field is empty
	{
		alert("Please enter the course name");
		frm.coursename.focus();
		return false;
	}
	if(frm.classid.value=="")           //if the class id field is empty 
	{
		alert("Please select a class");
		frm.classid.focus();
		return false;
	}
	if(frm.subject.value=="")			//if the subject id field is empty	
	{
		alert("Please enter the subject");
		frm.subject.focus();
		return false;
	}
	//Start/////////////////////////////////////////////////////Added by Rajeh
	if(frm.yyyy.value=='0000' || frm.mm.value=='00' || frm.dd.value=='0'){
		alert("Please enter date");
		frm.dd.focus();
		return false;
	}
	//End/////////////////////////////////////////////////////Added by Rajeh
	
	if(frm.yyyy.value!='0000' || frm.mm.value!='00' || frm.dd.value!='0'){
		var dt=new Date(frm.yyyy.value,(frm.mm.value)-1,frm.dd.value);
		var  d=new Date();
		var dt1=new Date(d.getFullYear(),d.getMonth(),d.getDate());
			
			
		if(validateDate(frm.dd.value,frm.mm.value,frm.yyyy.value)==false){
			alert("Please enter valid date");
			return false;
		}
		if(dt-dt1<=0){
			alert("The course completion date should be greater than today's date");
			return false;
		}
	}
	replacequotes();
	
}

function validateDate(dt,month,year){
	month=parseInt(month);
	switch(parseInt(month)){
		case  4:
		case  6:
		case  9:
		case 11:
				if(dt>30)
					return false;
				break;
		case  2: varMaxDay=isLeapYear(year);
				 if(dt>varMaxDay)
					 return false;
				 break;
	}
}

function isLeapYear(yr)
{
  if      (yr % 4 != 0)   return 28;
  else if (yr % 400 == 0) return 29;
  else if (yr % 100 == 0) return 28;
  else                    return 29;
}

function go()
{
	var classname;
	var x=document.getElementsByName("classid");
	document.createcourse.classname.value=x[0].options[x[0].selectedIndex].text;
}

function setTeacher()
{
	var teachername;
	var x=document.getElementsByName("teacherid");
	document.createcourse.teachername.value=x[0].options[x[0].selectedIndex].text;
	
}

</script>

<body topmargin='0' onload="initYears();">

<form action="/LBCOM/coursemgmt.AdminAddCourse?mode=add" name="createcourse" onSubmit="return validate(this);" method="post">
<br>
<p align="right">
	<a href='javascript:history.go(-1);'><font face="Arial" size="2"><b>Back</b></font></a>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
<div align="center">
<center>
<table cellspacing="0" width="484" cellpadding="2">
    <tr>		
      <td width="232" bgcolor="#E7D57C" height="1" bordercolor="#E7D57C">
      <font face="Arial">&nbsp;<font color="#800000"><b>Create Course</b></font></font></td>
      <td bgcolor="#E7D57C" width="263" height="1" bordercolor="#E7D57C">
      <p align="right"><font face="Verdana" size="1">* fields are mandatory.</font></td>
    </tr>
<%
		if(!stateStandards)
		{
%>
     
	<tr> 
		<td width="232" height="22"> <b> <font face="Arial" size="2">Course Name</font></b></td>
	    <td width="263" height="22"> 
	    <font face="Arial" size="2"><input type=text name=coursename size="28"  value="<%=stateSubject%>" oncontextmenu="return false" onkeypress="return AlphaNumbersOnly(this, event)">  <!-- allows the user to enter only text  -->
		<font color="#FF0000">*</font></font></td>
	</tr>
<%
		}
%>
    <tr> 
      <td width="232" height="49"> <b> <font face="Arial" size="2">Description</font></b></td>
      <td width="263" height="49"> 
        <font face="Arial" size="2"> 
        <textarea rows="3" cols="28" name="coursedescription"  oncontextmenu="return false" onkeypress="return AlphaNumbersOnly(this, event)" ></textarea>  <!--allows the user to enter only text   -->
        </font>
      </td>
    </tr>
<%
			if(!stateStandards)
			{
				if(classFlag.equals("1"))
				{
%>
    <tr> 
      <td width="232" height="22"><b>
		<font face="Arial" size="2">Class ID</font></b></td>
      <td width="263" height="22">
		<font face="Arial" size="2">
		<select name="classid" size="1" onchange="go();return false;">
		<option value="">- - - - - - - - - - -Select - - - - - - - -</option>
<%
					rs=st.executeQuery("select class_id,class_des from class_master where school_id='"+schoolid+"'  and class_id= any(select distinct(grade) from studentprofile where schoolid='"+schoolid+"')");
					while(rs.next())	//adds the grades available in the school to the list box
					{
						grade=rs.getString("class_id");
						out.println("<option value="+grade+">"+rs.getString("class_des")+"</option>");      
					}
%>	
			</select>
		<font color="#FF0000">*</font></font></td>
    </tr>
	<input type="hidden" name="classdes" value="">
	<input type="hidden" name="classname" value="">
<%
				}
				else
				{
%>	
					<input type="hidden" name="classdes" value="C001">
					<input type="hidden" name="classname" value="C001">
					<input type="hidden" name="classid" value="C001">

<%
				}
			}
%>
	<tr> 
      <td width="232" height="22"><b>
		<font face="Arial" size="2">Teacher ID</font></b></td>
      <td width="263" height="22">
		<font face="Arial" size="2">
		<select name="teacherid" id="teacherid" size="1" onchange="setTeacher();return false;">
			<option value="">Assign Teacher Later</option>
<%
				rs1=st1.executeQuery("select username from teachprofile where schoolid='"+schoolid+"' and status=1");
				while(rs1.next())	
				{
					out.println("<option value="+rs1.getString("username")+">"+rs1.getString("username")+"</option>");      
				}
%>	
			</select>
		</font></td>
    </tr>

    <tr> 
      <td width="232" height="22"><b><font face="Arial" size="2">Subject</font></b></td>
      <td width="263" height="22"> 
        <font face="Arial" size="2"> 
        <input type="text" name="subject"  oncontextmenu="return false" onkeypress="return AlphaNumbersOnly(this, event)" size="28"><font color="#FF0000">*</font> <!--allows only text to enter-->
        </font>
      </td>
    </tr>
    <tr> 
      <td width="232" height="22"><b><font face="Arial" size="2">Course Credit</font></b></td>
     <!--  <td width="263" height="22"> 
        <font face="Arial" size="2"><input type="text" name="sess"  oncontextmenu="return false" onkeypress="return AlphaNumbersOnly(this, event)" size="28">
        </font>
      </td> -->
	  <td width="263" height="22">
	  <p>&nbsp;<select name="sess" size="1">
		<option value="none" selected>.. Select .. </option>
		<option value="0.5">0.5</option>
		<option value="1.0">1.0</option>
		</select></p>
        </td>
    </tr>
    <tr> 
      <td width="232" height="22"><b><font face="Arial" size="2">Academic Year</font></b></td>
      <td width="263" height="22"> 
        <font face="Arial" size="2"><input type="text" name="acyear"  size="28">
        </font>
      </td>
    </tr>
	 <tr> 
      <td width="232" height="33"><b><font face="Arial" size="2">Course 
      Completion Date</font></b></td>
      <td width="263" height="33"> 
        <font face="Arial" size="2"><select id="dd_id" name="dd">
		<option value='0'>DD</option>
		<% for (int i=1;i<=31;i++)
			out.println("<option value='"+i+"'>"+i+"</option>");
		%>
		</select>
		<select id='mm_id' name='mm'>
			<option selected value="00">MMM</option>
		    <option value="1">Jan</option>
			<option value="2">Feb</option>
			<option value="3">Mar</option>
			<option value="4">Apr</option>
			<option value="5">May</option>
			<option value="6">Jun</option>
			<option value="7">Jul</option>
			<option value="8">Aug</option>
			<option value="9">Sep</option>
			<option value="10">Oct</option>
			<option value="11">Nov</option>
			<option value="12">Dec</option>
		</select><select id='yyyy_id' name='yyyy'>
			<option value="0000" selected >YYYY</option>
		</select> <font color="#FF0000">*</font></font></td>
    </tr>
   
    

		<tr> 
      <td width="232" height="22"><b>
		<font face="Arial" size="2">Course from Builder</font></b></td>
      <td width="263" height="22">
		<font face="Arial" size="2">
		<select name="lbcmsid" size="1">
			<option value="">Select Course</option>
<%
			st2=con.createStatement();		
			rs2=st2.executeQuery("select course_id,course_name from lbcms_dev_course_master where status>=0 order by course_name");
				while(rs2.next())	
				{
					out.println("<option value="+rs2.getString("course_id")+">"+rs2.getString("course_name")+"</option>");      
				}
				st2.close();
				rs2.close();
%>	
			</select>
		</font></td>
    </tr>
 <tr> 
      <td width="232" bgcolor="#E7D57C" height="16" bordercolor="#E7D57C"> </td>
      <td bgcolor="#E7D57C" width="263" height="16" bordercolor="#E7D57C"> 
      </td>
    </tr>

    <tr align="center" valign="middle"> 
      <td colspan=2 width="497" height="36"> 
        <font face="Arial" size="2"> 
        <!--<input type=submit value="Create">-->
        <input type=image src="images/submit.gif" width="80" height="33">
        <input type=image src="images/reset.jpg" onClick="return clearfileds();" width="80" height="36">
        </font>
      </td>
    </tr>
  </table>
    </center>
</div>
<%
	if(stateStandards)
	{
%>
	<input type="hidden" name="coursename" value="<%=stateSubject%>">
	<input type="hidden" name="classid" value="<%=stateGrade%>">
<%
	}
%>
  <input type="hidden" name="state" value="<%=stateName%>">
  <input type="hidden" name="state_subject" value="<%=stateSubject%>">
  <input type="hidden" name="state_grade" value="<%=stateGrade%>">
  <input type="hidden" name="teachername" value="">


</form>
<%
	}
	catch(SQLException se){
		 ExceptionsFile.postException("CreateCourse.jsp","operations on database","SQLException",se.getMessage());	 
	     System.out.println("Error: SQL -" + se.getMessage());
	}
	catch(Exception e){
		ExceptionsFile.postException("CreateCourse.jsp","operations on database","Exception",e.getMessage());	 
		System.out.println("Error:  -" + e.getMessage());

	}

	finally{     //closes the database connections at the end
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(st2!=null)
				st2.close();
			if(con!=null && !con.isClosed())
				con.close();
		}catch(SQLException se){
			ExceptionsFile.postException("CreateCourse.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println(se.getMessage());
		}
	}
%>
</body>
<script>
	document.createcourse.classid.value='C000';
	go();
</script>

</html>
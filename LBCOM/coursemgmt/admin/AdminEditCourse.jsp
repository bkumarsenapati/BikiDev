<%@ page language="java" import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.StringTokenizer" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%!
	String month[]={"MMM","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
%>

<%
String schoolId="",grade="",teacherId="",courseName="",courseDes="",state="",classId="",subject="",sess="",acYear="",courseId="",className="";
ResultSet rs=null,rs1=null,rs2=null;
Connection con=null;
Statement st=null,st1=null,st2=null;
String lastDate="",classFlag="",cbuilderId="";
%>
<%
	String yyyy="0000";
    int mm=0;
	int dd=0;
	try
	{
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}	
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		session=request.getSession(true);
		schoolId = (String)session.getAttribute("schoolid");
		teacherId = request.getParameter("teacherid");
		courseName=request.getParameter("coursename");
		classId=request.getParameter("classid");
		courseId=request.getParameter("courseid");
		className=request.getParameter("classname");
		

		
		rs=st.executeQuery("select class_flag from school_profile where schoolid='"+schoolId+"'");
		if(rs.next())
		{
			classFlag=rs.getString(1);
		}
		rs.close();
		rs=st.executeQuery("select course_des,state_grade,subject,sess,ac_year,last_date,cbuilder_id from coursewareinfo where course_id='"+courseId+"' and school_id='"+schoolId+"'");
		rs.next();
		courseDes=rs.getString("course_des");
		state=rs.getString("state_grade");
		subject=rs.getString("subject");
			sess=rs.getString("sess");
		acYear=rs.getString("ac_year");
		if(rs.getString("last_date")==null)
		{
			lastDate="0000-0-0";
		}
		else
		{
			lastDate=rs.getString("last_date");
		}
		cbuilderId=rs.getString("cbuilder_id");
		if(cbuilderId==null)
		{
			cbuilderId="";
		}
		StringTokenizer stk=new StringTokenizer(lastDate,"-");
		 
		if(stk.hasMoreTokens())
		{
			yyyy=stk.nextToken();
			mm=Integer.parseInt(stk.nextToken());
			dd=Integer.parseInt(stk.nextToken());
		}
%>

<html>
<head>
<title></title>
</head>
<script language="javascript" src="validationscripts.js"></script>
<script language="javascript" src="../../validationscripts.js"></script>
<script>

function editYears()
{
	var dt=new Date();
	var year;
	year=dt.getFullYear()-4;
	for(var i=1;i<=14;i++)
	{
		year=year+1;
		window.document.editcourse.yyyy.options[i]=new Option(year,year);
	}
}

function clearfileds()    //clears all the fields
{
	document.editcourse.reset();
	editYears();
	init();
	return false;
}
//checks whether  all the required fields are filled by user or not

function validate(frm)     
{
	if(trim(frm.coursename.value)=="")   //if the course name is empty
	{
		alert("Please enter the course name");
		frm.coursename.focus();
		return false;
	}
	var i=0;
	var desc =frm.coursedescription.value;
	while(i<desc.length){
		if ((desc.charAt(i)=="\"")||(desc.charAt(i)=="\'")){
			alert("Characters \" and \' are not allowed");
			return false;
		}
		i++;
	}

	if(frm.classid.value=="")			//if the class id is empty
	{
		alert("Please select a class");
		frm.classid.focus();
		return false;
	}
	if(frm.subject.value=="")			//if the subject is empty
	{
		alert("Please enter the subject");
		frm.subject.focus();
		return false;
	}
	if(frm.yyyy.value=='0000' && frm.mm.value=='0' && frm.dd.value=='0'){
		alert("Please enter date");
		frm.dd.focus();
		return false;
	}
	if(frm.yyyy.value!='0000' || frm.mm.value!='0' || frm.dd.value!='0'){
		
		var dt=new Date(frm.yyyy.value,(frm.mm.value)-1,frm.dd.value);
		var  d=new Date();
		var dt1=new Date(d.getFullYear(),d.getMonth(),d.getDate());
			
			
		if(validateDate(frm.dd.value,frm.mm.value,frm.yyyy.value)==false){
			alert("Please enter valid date");
			return false;
		}
		if(dt-dt1<=0)
		{
			alert("Course completion date should be greater than today's date");
			return false;
		}
	}
	replacequotes();

}

function validateDate(dt,month,year)
{
	month=parseInt(month);
	switch(parseInt(month))
	{
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
</script>

<body topmargin='0'>
<form action="/LBCOM/coursemgmt.AdminAddCourse?mode=mod" name="editcourse" onSubmit="return validate(this);" method="post">
<br><br>
<input type="hidden" name="state" value="Alabama">
<p align="right">
	<a href='javascript:history.go(-1);'><font face="Arial" size="2"><b>Back</b></font></a>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
<table cellspacing="0" width="525" align="center">
    <tr bgcolor="#E7D57C"> 
      <td height="18" width="523"><font face="arial" size="3"><b>Edit Course</b></font></td>
	  <td height="19" width="313" align="right"><font size="1" face="Arial">* fields are mandatory.</font></td>
    </tr>
    <tr> 
      <td width="208" height="33"> <b> <font face="Arial" size="2">Course Name</font></b></td>
      <td width="313" height="33"> 
        <font face="Arial" size="2"><input type="text" name="coursename" size="28" value="<%= courseName %>">
        <font color="#FF0000">*</font></font></td>
    </tr>
    <tr> 
      <td width="208" height="49"> <b> <font face="Arial" size="2">Description </font></b> </td>
      <td width="313" height="49"> 
        <font face="Arial" size="2"> 
        <textarea rows="3" cols="28" name="coursedescription" ><%= courseDes %></textarea>   <!-- allows the user to enter only text -->
        </font>
      </td>
    </tr>
<%
	if(classFlag.equals("1"))
	{
			rs=st.executeQuery("select class_id,class_des from class_master where school_id='"+schoolId+"'  and class_id = any(select distinct(grade) from studentprofile where schoolid='"+schoolId+"')");

%>
  <tr> 
		<td width="208" height="26"><b><font face="Arial" size="2">Class ID</font></b></td>
		<td width="313" height="26"><font face="Arial" size="2">
			<select name="classid" size="1">
			<option value="">- - - - - - - - - - -Select - - - - - - - -</option>
<%
			while(rs.next())      //adds all the available grades in the school to the list
			{
				grade=rs.getString("class_id");
				out.println("<option value="+grade+">"+rs.getString("class_des")+"</option>");
			}
%>	
</select><font color="#FF0000">*</font></font></td>
	</tr>
<%
	}
	else
	{
%>
		<input type="hidden" name="classid" value="C001">
<%
	}	
%>
	<tr> 
		<td width="232" height="22"><b><font face="Arial" size="2">Teacher ID</font></b></td>
		<td width="263" height="22"><font face="Arial" size="2">
			<select name="teacherid" id="teacherid" size="1">
			<option value="">Assign Teacher Later</option>
<%
				rs1=st1.executeQuery("select username from teachprofile where schoolid='"+schoolId+"' and status=1");
				while(rs1.next())	
				{
					out.println("<option value="+rs1.getString("username")+">"+rs1.getString("username")+"</option>");      
				}
%>	
			</select>
		</font></td>
    </tr>
	<tr> 
		<td width="208" height="28"><b><font face="Arial" size="2">Subject</font></b></td>
      <td width="313" height="28"> 
        <font face="Arial" size="2"> 
        <input type="text" name="subject" onKeyPress="if ((event.keyCode==34) || (event.keyCode==39) || (event.keyCode > 32 && event.keyCode < 48) || (event.keyCode > 32 && event.keyCode < 48) || (event.keyCode > 57 && event.keyCode < 65)) event.returnValue = false;" size="28" value="<%= subject %>"> <!-- allows the user to enter only text-->
        <font color="#FF0000">*</font></font></td>
    </tr>
    <tr> 
      <td width="208" height="30"><b><font face="Arial" size="2">Course Credit</font></b></td>
      <!-- <td width="313" height="30"> 
        <font face="Arial" size="2"><input type="text" name="sess" onKeyPress="if ((event.keyCode==34) || (event.keyCode==39) || (event.keyCode > 32 && event.keyCode < 48) || (event.keyCode > 32 && event.keyCode < 48) || (event.keyCode > 57 && event.keyCode < 65)) event.returnValue = false;" size="28"  value="<%= sess %>">
        </font>
      </td> -->
	  <td width="263" height="22">
	  <p>&nbsp;<select name="sess" size="1">
<%
		  if(sess.equals("0.5"))
		{
%>
		  <option value="0.5" selected>0.5</option>
		  <option value="1.0">1.0</option>
<%

		}
		else if(sess.equals("1.0"))
		{
%>
			<option value="0.5">0.5</option>
			<option value="1.0" selected>1.0</option>
<%
		}
		else
		{
%>
			<option value="none" selected>.. Select .. </option>
			<option value="0.5">0.5</option>
			<option value="1.0">1.0</option>
<%
		}

%>
		</select></p>
        </td>
    </tr>
    <tr> 
      <td width="208" height="27"><b>
		<font face="Arial" size="2">Academic Year</font></b></td>
      <td width="313" height="27"> 
		<font face="Arial" size="2"><input type="text" name="acyear"  size="28" value="<%= acYear %>"></font>
      </td>
    </tr>
	<tr> 
      <td width="208" height="35"><b>
		<font face="Arial" size="2">Course Completion Date</font></b></td>
      <td width="313" height="35">
		<font face="Arial" size="2"><select id="dd_id" name="dd">
		<option value='0'>DD</option>
<% 
			for (int i=1;i<=31;i++)
			{
				if(dd==i)
				{
					out.println("<option selected value='"+i+"'>"+i+"</option>");
				}
				else
				{
					out.println("<option value='"+i+"'>"+i+"</option>");
				}
			}
%>
		</select>
		<select id='mm_id' name='mm'>
<%
			for(int i=0;i<=12;i++)
			{
				if(mm==i)
				{
					out.println("<option selected value='"+i+"'>"+month[i]+"</option>");
				}
				else
				{
					out.println("<option value='"+i+"'>"+month[i]+"</option>");
				}
			}
%>
		</select>
		<select id='yyyy_id' name='yyyy'>
			<option value="0000">YYYY</option>
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
      <td width="208" bgcolor="#E7D57C" height="18"></td>
      <td bgcolor="#E7D57C" width="313" height="18">
		<font face="Arial" size="2">&nbsp;</font></td>
    </tr>
    
    <tr align="center" valign="middle"> 
      <td colspan=2 width="523"> 
        <font face="Arial" size="2"> 
        <input type=image src="images/submit.gif">
        <input type=image src="images/reset.jpg" onClick="return clearfileds();">
        </font>
      </td>
    </tr>
  </table>

<input type="hidden" name="extclassid" value="<%=classId%>">
<input type="hidden" name="courseid" value="<%=courseId%>">

</form>
</body>

<script language="javascript">
editYears();
function init()
{
	document.editcourse.yyyy.value="<%=yyyy%>";
	document.editcourse.classid.value="<%=classId%>";
	document.editcourse.teacherid.value="<%=teacherId%>";
	document.editcourse.lbcmsid.value="<%=cbuilderId%>";
}
init();
</script>

<%
	}
	catch(SQLException se)
	{
		ExceptionsFile.postException("EditCourse.jsp","operations on database","SQLException",se.getMessage());	 
		System.out.println("Error in AdminEditCourse.jsp : SQL -" + se.getMessage());
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("EditCourse.jsp","operations on database","Exception",e.getMessage());	 
		System.out.println("Error in AdminEditCourse.jsp :  -" + e.getMessage());
	}

	finally     //closes all the database connections at the end
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
			ExceptionsFile.postException("AdminEditCourse.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println("Error in AdminEditCourse.jsp :"+se.getMessage());
		}
	}
%>
</html>
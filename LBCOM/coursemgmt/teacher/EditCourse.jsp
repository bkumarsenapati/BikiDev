<!-- edits the course details-->

 
<%@ page language="java" import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.StringTokenizer" %>

<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
String      month[]={"MMM","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
%>
<%
String schoolId="",grade="",teacherId="",courseName="",courseDes="",state="",classId="",subject="",sess="",acYear="",courseId="",className="";
ResultSet rs=null;
Connection con=null;
Statement st=null;
String lastDate="";
%>
<%
	String yyyy="0000";
    int mm=0;
	int dd=0;
	try
	{

	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}	

	con=con1.getConnection();
	st=con.createStatement();
	session=request.getSession(true);
	teacherId = (String)session.getAttribute("emailid");
	schoolId = (String)session.getAttribute("schoolid");

	courseName=request.getParameter("coursename");
	classId=request.getParameter("classid");
	courseId=request.getParameter("courseid");
	className=request.getParameter("classname");
	
	
	//selects the details of the course which we want to modfiy
	rs=st.executeQuery("select course_des,state_grade,subject,sess,ac_year,last_date from coursewareinfo where course_id='"+courseId+"' and school_id='"+schoolId+"'");
	rs.next();
	courseDes=rs.getString("course_des");
	state=rs.getString("state_grade");
	subject=rs.getString("subject");
    	sess=rs.getString("sess");
	acYear=rs.getString("ac_year");
	if(rs.getString("last_date")==null){
		lastDate="0000-0-0";
	}else{
	    lastDate=rs.getString("last_date");
		
	}
     StringTokenizer stk=new StringTokenizer(lastDate,"-");
	 
	 if(stk.hasMoreTokens()){
		 yyyy=stk.nextToken();
		 mm=Integer.parseInt(stk.nextToken());
		 dd=Integer.parseInt(stk.nextToken());

	 }
	
	//select the grades that are available in the school	
	//rs=st.executeQuery("select distinct grade from studentprofile where schoolid='"+schoolId+"' order by grade" );
	rs=st.executeQuery("select class_id,class_des from class_master where school_id='"+schoolId+"'  and class_id = any(select distinct(grade) from studentprofile where schoolid='"+schoolId+"')");
	%>

<html>
<head>
<title></title>
</head>

<script language="javascript" src="validationscripts.js"></script>
<script language="javascript" src="../../validationscripts.js"></script>

<script>
function editYears(){
	var dt=new Date();
	var year;
	//var x=document.getElementsByName("toYear");
	//alert(x.options[x.selectedIndex].index);
	//window.document.editcourse.yyyy.options[0]=new Option("YYYY","0000");
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
	editYears();init();
	return false;
}
//checks whether  all the required fields are filled by user or not
function validate(frm)     
{
	if(trim(frm.coursename.value)=="")   //if the course name is empty
	{
		alert("Please enter course name");
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
		alert("Please enter subject");
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
			alert("Course completion date should be greater than or equal to today's date");
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

</script>


<body topmargin='0'>
<!--<form action="/servlet/coursemgmt.AddCourse?mode=mod" name="editcourse" onSubmit="return validate(this);" method="post">-->
<form action="/LBCOM/coursemgmt.AddCourse?mode=mod" name="editcourse" onSubmit="return validate(this);" method="post">
  <table border="0" width="100%" cellspacing="1" height="25">
    <tr>
      <td width="100%" align="left" bgcolor="#D0D9E8" height="22">
      		<font face='Arial' size='2' color="#800080"><b>
      		<a href="CoursesList.jsp">Courses</a> </b></font>
      		<b><font face='Arial' size='1' color="#800080">&gt;&gt;</font>
      		<font face='Arial' size='2' color="#800080"> Edit Course Details</font></b>
      </td>
    </tr>
  </table>
  <br>
  <!--<form action="../coursewaremanager/StoreFolderDetails.jsp" name="f1" onSubmit="return checkfields();">-->
   <table cellspacing="0" width="525" bordercolordark="#48A0E0" bordercolorlight="#48A0E0" style="border-collapse:collapse;" align="center" height="413">
    <tr> 
      <td width="523" colspan="2" height="47"><br>
      <img border="0" src="../images/createtab.gif" width="151" height="28"></td>
    </tr>
    <tr bgcolor="#40A0E0"> 
      <td colspan="2" height="18" width="523"> 
        <div align="center"></div>
      </td>
    </tr>
    <tr>		
      <td width="208" bgcolor="#A8B8D0" height="19"><font face="Arial" size="2">&nbsp;</font></td>
      <td bgcolor="#A8B8D0" width="313" height="19">
      <p align="right"><font size="1" face="Arial"><font color="red">*</font> fields are mandatory.</font></td>
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
    <tr> 
      <td width="208" height="26"> <b> <font face="Arial" size="2">Class ID </font>
      </b> 
      </td>
      <td width="313" height="26"><font face="Arial" size="2"><select name="classid" size="1">
		<option value="">- - - - - - - - - - -Select - - - - - - - -</option>
	<%
		while(rs.next()){     //adds all the available grades in the school to the list
			grade=rs.getString("class_id");
			out.println("<option value="+grade+">"+rs.getString("class_des")+"</option>");
		}

	}
	catch(SQLException se){
		ExceptionsFile.postException("EditCourse.jsp","operations on database","SQLException",se.getMessage());	 
			System.out.println("Error: SQL -" + se.getMessage());
	}
	catch(Exception e){
		ExceptionsFile.postException("EditCourse.jsp","operations on database","Exception",e.getMessage());	 
		System.out.println("Error:  -" + e.getMessage());

	}

	finally{   //closes all the database connections at the end
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
		}catch(SQLException se){
			ExceptionsFile.postException("EditCourse.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println(se.getMessage());
		}
	}


	%>	
</select> <font color="#FF0000">*</font></font></td>

    </tr>
    <tr> 
      <td width="208" height="28"><b><font face="Arial" size="2">Subject</font></b></td>
      <td width="313" height="28"> 
        <font face="Arial" size="2"> 
        <input type="text" name="subject" onKeyPress="if ((event.keyCode==34) || (event.keyCode==39) || (event.keyCode > 32 && event.keyCode < 48) || (event.keyCode > 32 && event.keyCode < 48) || (event.keyCode > 57 && event.keyCode < 65)) event.returnValue = false;" size="28" value="<%= subject %>"> <!-- allows the user to enter only text-->
        <font color="#FF0000">*</font></font></td>
    </tr>
    <tr> 
      <td width="208" height="30"><b><font face="Arial" size="2">Session</font></b></td>
      <td width="313" height="30"> 
        <font face="Arial" size="2"><input type="text" name="sess" onKeyPress="if ((event.keyCode==34) || (event.keyCode==39) || (event.keyCode > 32 && event.keyCode < 48) || (event.keyCode > 32 && event.keyCode < 48) || (event.keyCode > 57 && event.keyCode < 65)) event.returnValue = false;" size="28"  value="<%= sess %>"> <!-- allows the user to enter only text  -->
        </font>
      </td>
    </tr>
    <tr> 
      <td width="208" height="27"><b><font face="Arial" size="2">Academic Year</font></b></td>
      <td width="313" height="27"> 
        <font face="Arial" size="2"><input type="text" name="acyear"  size="28" value="<%= acYear %>">
        </font>
      </td>
    </tr>
	<tr> 
      <td width="208" height="35"><b><font face="Arial" size="2">Course 
      Completion Date</font></b></td>
      <td width="313" height="35"> 
        <font face="Arial" size="2"><select id="dd_id" name="dd">
		<option value='0'>DD</option>
		<% 
			
			for (int i=1;i<=31;i++){
//			System.out.println("date is "+lastDate.getDate());	
			if(dd==i){
				out.println("<option selected value='"+i+"'>"+i+"</option>");
			}else{
				out.println("<option value='"+i+"'>"+i+"</option>");
			}
		}
		%>
		</select>
		<select id='mm_id' name='mm'>
		<% 
			
			for (int i=0;i<=12;i++){

			if(mm==i){
				out.println("<option selected value='"+i+"'>"+month[i]+"</option>");
			}else{
				out.println("<option value='"+i+"'>"+month[i]+"</option>");
			}
		}
		%>
			
		  
		</select><select id='yyyy_id' name='yyyy'>
			<option value="0000">YYYY</option>
		</select> <font color="#FF0000">*</font></font></td>
    </tr>
    <tr> 
      <td width="208" bgcolor="#A8B8D0" height="18"></td>
      <td bgcolor="#A8B8D0" width="313" height="18"><font face="Arial" size="2">&nbsp;</font></td>
    </tr>
    <tr> 
      <td width="208" bgcolor="#40A0E0" height="19"></td>
      <td bgcolor="#40A0E0" width="313" height="19">&nbsp;</td>
    </tr>
    <tr> 
      <td width="208" bgcolor="#40A0E0" height="1"> </td>
      <td bgcolor="#40A0E0" width="313" height="1"> 
        <input type="hidden" name="state" value="Alabama">
      </td>
    </tr>
    
    <tr align="center" valign="middle"> 
      <td colspan=2 width="523" height="36"> 
        <font face="Arial" size="2"> 
        <!--<input type=submit value="Create">-->
        <input type=image src="../images/submit.gif" width="88" height="33">
        <input type=image src="../images/reset.gif" onClick="return clearfileds();" width="91" height="33">
        </font>
      </td>
    </tr>
  </table>
<!-- stores the class id ,course name ,courseid in the hidden fields-->
<input type="hidden" name="extclassid" value="<%= classId %>">

<input type="hidden" name="courseid" value="<%= courseId %>">
<!--<script>
	//window.document.editcourse.yyyy.options[11]=new Option(<%=yyyy%>,<%=yyyy%>);
	//window.document.editcourse.yyyy.options[11].selected=true;
 </script>-->
</form>

</body>
<script language="javascript">
	editYears();init();
	function init(){
		document.editcourse.yyyy.value="<%=yyyy%>";
		document.editcourse.classid.value="<%= classId %>";
	}
	init();
</script>

</html>
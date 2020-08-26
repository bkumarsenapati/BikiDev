<!--creates the courses -->


<%@ page language="java" import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	String      month[]={"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};

%>
<%
	

	session=request.getSession();

	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}	
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String grade="",schoolid="",teacherid="";
	String stateName="",stateGrade="",stateSubject="";
	boolean stateStandards=false;

try
{
	con=con1.getConnection();
	st=con.createStatement();
	teacherid = (String)session.getAttribute("emailid");
	schoolid = (String)session.getAttribute("schoolid");
	stateGrade=request.getParameter("grade");
	//stateName=request.getParameter("statename");
	
	stateSubject=request.getParameter("subject");
	if(stateName==null || stateName.equals("none")){
		stateName="Alabama";
	}
	if (stateGrade==null || stateGrade.equals("none")){
		stateGrade="";
		stateName="Alabama";
		stateStandards=false;
	}else{
		stateStandards=true;
	}
	if (stateSubject==null || stateSubject.equals("none"))
		stateSubject="";
	
	//selects the grades available in the school
	//rs=st.executeQuery("select distinct grade from studentprofile where schoolid='"+schoolid+"' order by grade" );
	rs=st.executeQuery("select class_id,class_des from class_master where school_id='"+schoolid+"'  and class_id= any(select distinct(grade) from studentprofile where schoolid='"+schoolid+"')");
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
		alert("Enter the course name");
		frm.coursename.focus();
		return false;
	}
	/*var i=0;
	var desc =frm.coursedescription.value;
	while(i<desc.length){
		if ((desc.charAt(i)=="\"")||(desc.charAt(i)=="\'")){
			alert(" Characters \" and \' are not valid ");
			return false;
		}
		i++;
	}
	*/
	if(frm.classid.value=="")           //if the class id field is empty 
	{
		alert("Select a class ");
		frm.classid.focus();
		return false;
	}
	if(frm.subject.value=="")			//if the subject id field is empty	
	{
		alert("Enter the subject ");
		frm.subject.focus();
		return false;
	}
	//Start/////////////////////////////////////////////////////Added by Rajeh
	if(frm.yyyy.value=='0000' || frm.mm.value=='00' || frm.dd.value=='0'){
		alert("Enter Date");
		frm.dd.focus();
		return false;
	}
	//End/////////////////////////////////////////////////////Added by Rajeh
	
	if(frm.yyyy.value!='0000' || frm.mm.value!='00' || frm.dd.value!='0'){
		var dt=new Date(frm.yyyy.value,(frm.mm.value)-1,frm.dd.value);
		var  d=new Date();
		var dt1=new Date(d.getFullYear(),d.getMonth(),d.getDate());
			
			
		if(validateDate(frm.dd.value,frm.mm.value,frm.yyyy.value)==false){
			alert("Enter valid date");
			return false;
		}
		if(dt-dt1<=0){
			alert("Last Date Should be Greater than  Today's Date");
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


function go(){
		var classname;
		var x=document.getElementsByName("classid");
		document.createcourse.classname.value=x[0].options[x[0].selectedIndex].text;
}
</script>
<body topmargin='0' onload="initYears();">
<!--<form action="/servlet/coursemgmt.AddCourse?mode=add" name="createcourse" onSubmit="return validate(this);" method="post">     
<form action="/LBCOM/coursemgmt.AddCourse?mode=add" name="createcourse" onSubmit="return validate(this);" method="post">      -->

<form action="/LBCOM/coursemgmt.AddCourse?mode=add" name="createcourse" onSubmit="return validate(this);" method="post">
<!--<form action="" name="createcourse" onSubmit="return validate(this);" method="post">-->


 <!-- <table border="0" width="100%" cellspacing="1">
    <tr>
      <td width="100%" valign="middle" align="left" bgcolor="#E8ECF4"><font color="#800080"><a href="CoursesList.jsp">Courses</a>
        </font>&gt; Create Course</td>
    </tr>
  </table>-->
  
  <div align="center">
    <center>
  <table cellspacing="0" width="484" bordercolordark="#48A0E0" bordercolorlight="#48A0E0" style="border-collapse:collapse;" cellpadding="2" height="375">
    <tr> 
      <td width="497" align="left" colspan="2" height="28"><font face="Arial" size="2"><img border="0" src="../images/createtab.gif" width="151" height="28"></font></td>
    </tr>
    <tr bgcolor="#40A0E0"> 
      <td colspan="2" height="16" width="497"> 
        <div align="center"></div>
      </td>
    </tr>
    <tr>		
      <td width="232" bgcolor="#A8B8D0" height="19"><font face="Arial" size="2">&nbsp;</font></td>
      <td bgcolor="#A8B8D0" width="263" height="19">
      <p align="right"><font face="Verdana" size="1">* fields are mandatory.</font></td>
    </tr>
	<% if(!stateStandards){%>
     

      <!--<tr>
	  <td width="50%" height="20"> <font face="Arial" size="2">Course Name</font></td>
      <td> 
        <font face="Arial" size="2"><input type=text name=coursename size="28"  value="<%=stateSubject%>" oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return AlphaNumbersOnly(this, event)">  <!-- allows the user to enter only text  -->
        <!--</font>
		  </td>
	    </tr>-->
		<tr> 
		<td width="232" height="22"> <b> <font face="Verdana" size="2">Course Name</font></b></td>
	    <td width="263" height="22"> 
	    <font face="Arial" size="2"><input type=text name=coursename size="28"  value="<%=stateSubject%>" oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return AlphaNumbersOnly(this, event)">  <!-- allows the user to enter only text  -->
		<font color="#FF0000">*</font></font></td>
		</tr>
	<%}%>
    <tr> 
      <td width="232" height="49"> <b> <font face="Verdana" size="2">Description</font><font face="Verdana">
      </font></b> </td>
      <td width="263" height="49"> 
        <font face="Arial" size="2"> 
        <textarea rows="3" cols="28" name="coursedescription"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return AlphaNumbersOnly(this, event)" ></textarea>  <!--allows the user to enter only text   -->
        </font>
      </td>
    </tr>
	<%if(!stateStandards){%>
    <tr> 
      <td width="232" height="22"> <b> <font face="Verdana" size="2">Class ID</font><font face="Verdana">
      </font></b> 
      </td>
      <td width="263" height="22"><font face="Arial" size="2"><select name="classid" size="1" onchange="go();return false;">
		<option value="">- - - - - - - - - - -Select - - - - - - - -</option>
	<%
		while(rs.next()){					//adds the  grades available in the school to the list box
			grade=rs.getString("class_id");
			out.println("<option value="+grade+">"+rs.getString("class_des")+"</option>");      
		}


	

	%>	
</select> <font color="#FF0000">*</font></font></td>

    </tr>
	<%}
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
			if(con!=null && !con.isClosed())
				con.close();
		}catch(SQLException se){
			ExceptionsFile.postException("CreateCourse.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println(se.getMessage());
		}
	}
%>
    <tr> 
      <td width="232" height="22"><b><font face="Verdana" size="2">Subject</font></b></td>
      <td width="263" height="22"> 
        <font face="Arial" size="2"> 
        <input type="text" name="subject"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return AlphaNumbersOnly(this, event)" size="28"><font color="#FF0000">*</font> <!--allows only text to enter-->
        </font>
      </td>
    </tr>
    <tr> 
      <td width="232" height="22"><b><font face="Verdana" size="2">Session</font></b></td>
      <td width="263" height="22"> 
        <font face="Arial" size="2"><input type="text" name="sess"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return AlphaNumbersOnly(this, event)" size="28"> <!-- allows only text to enter-->
        </font>
      </td>
    </tr>
    <tr> 
      <td width="232" height="22"><b><font face="Verdana" size="2">Academic Year</font></b></td>
      <td width="263" height="22"> 
        <font face="Arial" size="2"><input type="text" name="acyear"  size="28">
        </font>
      </td>
    </tr>
	 <tr> 
      <td width="232" height="33"><b><font face="Verdana" size="2">Course 
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
      <td width="232" bgcolor="#A8B8D0" height="16"></td>
      <td bgcolor="#A8B8D0" width="263" height="16"><font face="Arial" size="2">&nbsp;</font></td>
    </tr>
    <tr> 
      <td width="232" bgcolor="#40A0E0" height="16"> </td>
      <td bgcolor="#40A0E0" width="263" height="16"> 
      </td>
    </tr>
    
    <tr align="center" valign="middle"> 
      <td colspan=2 width="497" height="36"> 
        <font face="Arial" size="2"> 
        <!--<input type=submit value="Create">-->
        <input type=image src="../images/submit.gif" width="88" height="33">
        <input type=image src="../images/reset.gif" onClick="return clearfileds();" width="91" height="33">
        </font>
      </td>
    </tr>
  </table>
    </center>
</div>
  <%if(stateStandards){%>
	<input type="hidden" name="coursename" value="<%=stateSubject%>">
	<input type="hidden" name="classid" value="<%=stateGrade%>">
  <%}%>
  <input type="hidden" name="state" value="<%=stateName%>">
  <input type="hidden" name="state_subject" value="<%=stateSubject%>">
    <input type="hidden" name="state_grade" value="<%=stateGrade%>">
  <input type="hidden" name="classname" value="">

</form>

</body>
</html>
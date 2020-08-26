  <%@page import="java.io.*,java.sql.*,java.util.*,java.util.Date,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%!
	String      month[]={"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
%>
<%
	String		courseId="",sessid="",examType="",mode="",examId="",fromDate="",toDate="",mm="",dd="",yyyy="",hh="",min="",pasword="0",grading="0";
	String		examName="",examInstructions="",qidList="",fromTime="",toTime="",schoolId="",createdDate="",cours_last_date="",cours_last_datedb="";
	

	StringTokenizer stk=null;
	Connection con=null;
	Statement st=null;
	ResultSet   rs=null;
	int enable=0,maxAttempts=0,noOfGrps=0;
	byte flag=0,durMins=0,durHrs=0,shortType=0;

	String totRecords,start,sortBy,sortType;

%>


<%
	try{
		
		//checking For session is valid or not
		session=request.getSession();
		examId=null;
		sessid=(String)session.getAttribute("sessid");
		if(sessid==null) {
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	    }

		schoolId=(String)session.getAttribute("schoolid");
		examType=request.getParameter("examtype");	
		examName=request.getParameter("examName");	
		mode=request.getParameter("mode");
		courseId=(String)session.getAttribute("courseid");

		sortType=request.getParameter("sorttype");
		sortBy=request.getParameter("sortby");
		start=request.getParameter("start");
		totRecords=request.getParameter("totrecords");

		
		
		con=db.getConnection();
		st=con.createStatement();
		String dbString11="select DATE_FORMAT(last_date,'%m/%d/%Y') as last_date,DATE_FORMAT(last_date,'%Y-%m-%d') as last_datedb from coursewareinfo where course_id='"+courseId+"' and school_id='"+schoolId+"'";
		rs=st.executeQuery(dbString11);
		boolean b=rs.next();
		cours_last_date=rs.getString(1);
		cours_last_datedb=rs.getString(2);
		examId=request.getParameter("examid");

		if (mode.equals("create")){ 

			flag=0;
			maxAttempts=0;
			enable=0;
			grading="0";
			pasword="0";
			fromDate="0000-00-00";
			fromTime="00-00";
			toDate=cours_last_datedb;
			//toDate="0000-00-00";
			toTime="00-00";
			createdDate="0000-00-00";
			noOfGrps=0;

		}
        
		//if(flag==1){
		if (mode.equals("edit")){
		
			String dbString="select exam_name,from_date,to_date,from_time,to_time,mul_attempts,create_date,password,grading from exam_tbl where exam_id='"+examId+"' and school_id='"+schoolId+"'";
			rs=st.executeQuery(dbString);
			if(rs.next()){
				Date fd= new Date();
				examName=rs.getString("exam_name");
				createdDate=rs.getString("create_date");
				fromDate=rs.getString("from_date");
				toDate=rs.getString("to_date");
				fromTime=rs.getString("from_time");
				toTime=rs.getString("to_time");				
				maxAttempts=rs.getInt("mul_attempts");
				pasword=rs.getString("password");
				grading=rs.getString("grading");				
				if(toDate==null)
					toDate="0000-00-00";
				if(fromDate==null){
					int k=fd.getYear()+1900;
					int l=fd.getDate()-1;
					fromDate=""+k+"-"+fd.getMonth()+"-"+l+"";//"0000-00-00";
				}
								
		    }
			rs.close();

	}
	
	
%>

<html>
<head>
<title></title>
<!--<META HTTP-EQUIV="Pragma" CONTENT="no-cache, must-revalidate>" 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-store, must-revalidate">
<META HTTP-EQUIV="Expires" CONTENT="0">-->
<script language="javascript" src="../validationscripts.js"></script> 

</head>
<%if (mode.equals("edit")) {%>
<body>
<%}else{	%>
<body onload="initYears();">
<%}%>


<form name="examdetails" method="post" onsubmit="return checkAllFields();" action="/LBCOM/exam.CreateSaveExam?mode=ctrl&examType=<%=examType%>&sortby=<%=sortBy%>&sorttype=<%=sortType%>&totrecords=<%=totRecords%>&start=<%=start%>" >
<script>

function setFromDate() {
  var win=window.document.examdetails;
  if (win.enable[0].checked==true) {
	  win.fromDate.disabled=false;
	  win.fromMonth.disabled=false;	
	  win.fromYear.disabled=false;
	  win.fromHour.disabled=false;
	  win.fromMin.disabled=false;
  }
  else{
	  win.fromDate.disabled=true;
	  win.fromMonth.disabled=true;	
	  win.fromYear.disabled=true;
	  win.fromHour.disabled=true;
	  win.fromMin.disabled=true;
  }
}
function setToDate() {
  var win=window.document.examdetails;
  if (win.toCheck.checked==true) {
	  win.toDate.disabled=false;
	  win.toMonth.disabled=false;	
	  win.toYear.disabled=false;
	  win.toHour.disabled=false;
	  win.toMin.disabled=false;
	  win.toCheck.value="1";
  }
  else{
	  win.toDate.disabled=true;
	  win.toMonth.disabled=true;	
	  win.toYear.disabled=true;
	  win.toHour.disabled=true;
	  win.toMin.disabled=true;
	  win.toCheck.value="0";
  }
   
}

function openExam()
{	var win=window.open("ExistingExams.jsp?examType=<%=examType%>","ExistingExams",'dependent=yes,width=500,height=220, scrollbars=yes,left=175,top=200');
 	 win.focus();
}


//To add years from current year to current year+10 year
function initYears(){
	var dt=new Date();
	var year;
	for(var i=0;i<10;i++)
	{
		year=dt.getFullYear()+i;
		window.document.examdetails.fromYear.options[i]=new Option(year,year);
		window.document.examdetails.toYear.options[i]=new Option(year,year);
	}

	//for selecting today date
	var date=dt.getDate()-1;     
	var to_dt=new Date("<%=cours_last_date%>");
	var to_date=to_dt.getDate()-1;
	window.document.examdetails.fromDate.options[date].selected=true;
	window.document.examdetails.fromMonth.options[dt.getMonth()].selected=true;
	window.document.examdetails.toDate.options[to_date].selected=true;
	window.document.examdetails.toMonth.options[to_dt.getMonth()].selected=true;


	}

function editYears(){
	var dt=new Date();
	var year;
	//var x=document.getElementsByName("toYear");
	//alert(x.options[x.selectedIndex].index);
	year=dt.getFullYear()-4;
	//window.document.examdetails.fromYear.options[0]=new Option("YYYY","0000");
	for(var i=0;i<=10;i++)
	{		
		year=year+1;
		window.document.examdetails.fromYear.options[i]=new Option(year,year);
	//	window.document.examdetails.toYear.options[i]=new Option(year,year);
	}
}
function setDate(type){
	var  d=new Date();
	var t_d=new Date("<%=cours_last_date%>");
	var mon;
	if(d.getMonth()<10)
		mon="0"+d.getMonth();
	if(type=="from"){
		document.examdetails.fromDate.value=d.getDate();
		document.examdetails.fromMonth.value=mon;
		document.examdetails.fromYear.value=d.getYear();
	}else if(type=="to"){
		if(t_d.getMonth()<10)
		mon="0"+t_d.getMonth();
		document.examdetails.toDate.value=t_d.getDate();
		document.examdetails.toMonth.value=mon;
		document.examdetails.toYear.value=t_d.getYear();
	}
	//dt1.=new Date(d.getFullYear(),d.getMonth(),d.getDate());
}
function editToYear(){
	var dt=new Date();
	var year;
	//var x=document.getElementsByName("toYear");
	//alert(x.options[x.selectedIndex].index);
	year=dt.getFullYear()-4;
	//window.document.examdetails.fromYear.options[0]=new Option("YYYY","0000");
	for(var i=0;i<=14;i++)
	{
		
		year=year+1;
	//	window.document.examdetails.fromYear.options[i]=new Option(year,year);
		window.document.examdetails.toYear.options[i]=new Option(year,year);
	}
}
function checkAllFields(){
	var win=window.document.examdetails;
	//checking for Exam name valid or not
		var dt=new Date(win.fromYear.value,win.fromMonth.value,win.fromDate.value);
		var t_dt=new Date(win.toYear.value,win.toMonth.value,win.toDate.value);
		var  d=new Date();
		var course_l_date=new Date("<%=cours_last_date%>");
		if(course_l_date<t_dt){
			if(win.toCheck.checked){
				alert("End date should be less than or equal to the course end date");
				return false;
			}
		}
		var dt1=new Date(d.getFullYear(),d.getMonth(),d.getDate());		
		if(win.enable[0].checked){
			if(validateDate(win.fromDate.value,win.fromMonth.value,win.fromYear.value)==false){
				alert("Please enter a valid start date");
				return false;
			}
			if(dt-dt1<0){
				alert("Start date should be greater than or equal to today's date");
				return false;
			}
			var month=win.fromMonth.value;
			month++;
			window.document.examdetails.frmDate.value=win.fromYear.value+"-"+month+"-"+win.fromDate.value;
		}else{
		window.document.examdetails.frmDate.value=d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
		//window.document.examdetails.frmDate.value="0000-00-00";
	}

	if(win.toCheck.checked){

		if(validateDate(win.toDate.value,win.toMonth.value,win.toYear.value)==false){
			alert("Enter a valid end date");
			return false;
		}
		var dt=new Date(win.toYear.value,win.toMonth.value,win.toDate.value);
		if(dt-dt1<0){
			alert("End date should be greater than or equal to today's date");
			return false;
		}

	
			var month=win.toMonth.value;
			month++;
	
window.document.examdetails.tDate.value=win.toYear.value+"-"+month+"-"+win.toDate.value;

}else{
		window.document.examdetails.toDate.value=d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
		window.document.examdetails.tDate.value="0000-00-00";

	}



		dt1=new Date(win.toYear.value,win.toMonth.value,win.toDate.value);
		dt=new Date(win.fromYear.value,win.fromMonth.value,win.fromDate.value);



	if(win.toCheck.checked)
		if((dt1-dt)<0){
			alert("End date must be greater than or equal to start date");
			return false;
		}

  

	if (win.password.checked){
		win.pasword.value="1";
	}
	else
		win.pasword.value="0";
	replacequotes();

	
	
}

function validateDate(dt,month,year){
	month=parseInt(month)+1;
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




function validData(the_key_val){//begin function validData
	var the_key;

	if(the_key_val=="")
	return false;
	if(the_key_val!="")
	for(var i=0;i<the_key_val.length;i++)	{
	the_key=the_key_val.charAt(i);
	if(!((the_key>='0' && the_key<='9') || (the_key>='A' && the_key<='Z') || (the_key==' ') ||(the_key=='_')|| (the_key>='a' && the_key<='z') || (the_key=='.') ||( the_key=="-"))){
	return false;

	}

	}
	}//end function validData

</script>

<div align="center">
  <center>

<table border="0" width="754"  cellspacing="0" bordercolor="#DFE2F4">
  <tr>
    <td width="750" height="32" bgcolor="#FFFFFF" colspan="5" bordercolor="#FFFFFF" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF"><img border="0" src="../coursemgmt/images/createtab.gif" width="151" height="28"></td>
  </tr>
  <tr>
    <td width="750" height="23" bgcolor="#4AA2E7" colspan="5" bordercolor="#FFFFFF" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">&nbsp;</td>
  </tr>
  <tr>
    <td width="115" height="27" bgcolor="#FFFFFF" bordercolor="#DFE2F4"><font face="Arial" size="2">Assessment Name</font></td>
    <td width="4" height="27" bgcolor="#FFFFFF" bordercolor="#DFE2F4"><b><font face="Arial" size="2">:</font></b></td>
    <td width="623" height="27" colspan="3" bgcolor="#FFFFFF" bordercolor="#DFE2F4"><font face="Arial" size="2">
	<%=examName%>
    </font></td>
  </tr>
  <tr>
    <td width="115" height="20" bgcolor="#FFFFFF" bordercolor="#DFE2F4" valign="middle" align="left"><font face="Arial" size="2">Availability&nbsp;</font></td>
    <td width="4" height="20" bgcolor="#FFFFFF" bordercolor="#DFE2F4" valign="middle" align="left"><b><font face="Arial" size="2">:</font></b></td>
	<%
	  
	
	if ((fromDate.compareTo(createdDate)!=0)&&(mode.equals("edit"))) {%>
      <td width="139" height="20" bgColor="#FFFFFF" bordercolor="#DFE2F4" valign="middle" align="left"><font face="Arial" size="2"><input type="radio" name="enable" value="1" checked onclick="setFromDate();" >Enable</font></td>
	  <td width="166" height="20" bgColor="#FFFFFF" bordercolor="#DFE2F4" valign="middle" align="left"><font face="Arial" size="2"><input type="radio" name="enable" value="0" onclick="setFromDate();">Disable</font></td>
	<%}else {%>
	  <td width="139" height="20" bgColor="#FFFFFF" bordercolor="#DFE2F4" valign="middle" align="left"><font face="Arial" size="2"><input type="radio" name="enable" value="1" onclick="setFromDate();" >Enable</font></td>
	  <td width="166" height="20" bgColor="#FFFFFF" bordercolor="#DFE2F4" valign="middle" align="left"><font face="Arial" size="2"><input type="radio" name="enable" checked value="0" onclick="setFromDate();">Disable</font></td>
	<%}%>

  </tr>
  <tr>	
    <td width="123" height="20" colspan="2" bgcolor="#FFFFFF" bordercolor="#DFE2F4" valign="top" align="left">&nbsp;</td>
    <td width="309" height="20" colspan="2" bgcolor="#FFFFFF" bordercolor="#DFE2F4" valign="top" align="left"><font face="Arial" size="2">
      From :</font><select size="1" name="fromDate" >
	 
   	<%  for(byte i=1;i<=31;i++){
	    	out.println("<option value='"+i+"' >"+i+"</option>");
	
       }
	%>
	<font face="Arial" size="2"></select>
    <select size="1" name="fromMonth" >
		
    <option selected value="00">Jan</option>
    <option value="01">Feb</option>
    <option value="02">Mar</option>
    <option value="03">Apr</option>
    <option value="04">May</option>
    <option value="05">Jun</option>
    <option value="06">Jul</option>
    <option value="07">Aug</option>
    <option value="08">Sep</option>
    <option value="09">Oct</option>
    <option value="10">Nov</option>
    <option value="11">Dec</option>
  </select><select size="1" name="fromYear" >
  
  </select></font><font face="Arial" size="2">
  <select size="1" name="fromHour" >
     <option value="00" selected>HH</option>
  <%  for(byte i=0;i<=23;i++) {
	    	out.println("<option value='"+i+"' >"+i+"</option>");
			
	}
  %>
	
  </select><select size="1" name="fromMin" >
    <option value="00" selected>MM</option>
  <%  for(byte i=0;i<=55;i+=5){
			if(i<10)
	    		out.println("<option value='0"+i+"' >0"+i+"</option>");
			else
				out.println("<option value='"+i+"' >"+i+"</option>");

  }
  %>
 </select>
      </font></td>
	   <% 
	   
	    if ((fromDate.compareTo(createdDate)!=0)&&(mode.equals("edit"))) {
			
		   stk=new StringTokenizer(fromDate+"-"+fromTime.replace(':','-'),"-");
		   if(stk.hasMoreTokens()) {
			   yyyy=stk.nextToken();
			   mm=stk.nextToken();
			   dd=stk.nextToken();
			  
			   hh=stk.nextToken();
			   min=stk.nextToken();
			    
			   
			
		   }
	  %>
	      <script>
		 function init(){		  
			  window.document.examdetails.fromDate.disabled=false;
			  window.document.examdetails.fromMonth.disabled=false;
			  window.document.examdetails.fromYear.disabled=false;
			  window.document.examdetails.fromHour.disabled=false;
			  window.document.examdetails.fromMin.disabled=false;		  
			  window.document.examdetails.fromDate.options[<%=dd%>-1].selected=true;		
			  window.document.examdetails.fromMonth.options[<%=mm%>-1].selected=true;
			  editYears();
			// window.document.examdetails.fromYear.options[0]=new Option(<%=yyyy%>,<%=yyyy%>);
			// window.document.examdetails.fromYear.options[0].selected=true;
			  window.document.examdetails.fromYear.value="<%=yyyy%>";
			  var x=window.document.getElementsByName("fromHour");
			  x[0].selectedIndex=<%=hh%>+1;
			  x=window.document.getElementsByName("fromMin");
			  x[0].selectedIndex=(<%=min%>/5)+1;
		}init();
		  
	      </script>
	  <%}
		  else {%>
		  <script>
		function init(){
		  editYears();
		  setDate("from");
	      window.document.examdetails.fromDate.disabled=true;
		  window.document.examdetails.fromMonth.disabled=true;
		  window.document.examdetails.fromYear.disabled=true;
		  window.document.examdetails.fromHour.disabled=true;
		  window.document.examdetails.fromMin.disabled=true;
		}init();
		  </script>
    <%}

    if ((!(toDate.equals("0000-00-00")))&&(mode.equals("edit"))) {
	
	%>

		<td width="310" height="20" bgcolor="#FFFFFF" bordercolor="#DFE2F4" valign="top" align="left"><font face="Arial" size="2"><input type="checkbox" name="toCheck"  checked value="0" onclick="setToDate();"> 
		
    <%} else {%>
		<td width="310" height="20" bgcolor="#FFFFFF" bordercolor="#DFE2F4" valign="top" align="left"><font face="Arial" size="2"><input type="checkbox" name="toCheck" value="1" onclick="setToDate();"> 
	<%}%>
	To :<select size="1" name="toDate" disabled>
	<%  for(byte i=1;i<=31;i++) {
	    	out.println("<option value='"+i+"' >"+i+"</option>");
     }
    %>

  </select><select size="1" name="toMonth" disabled>
    <option value="00" selected>Jan</option>
    <option value="01">Feb</option>
    <option value="02">Mar</option>
    <option value="03">Apr</option>
    <option value="04">May</option>
    <option value="05">Jun</option>
    <option value="06">Jul</option>
    <option value="07">Aug</option>
    <option value="08">Sep</option>
    <option value="09">Oct</option>
    <option value="10">Nov</option>
    <option value="11">Dec</option>
  </select><select size="1" name="toYear" disabled>
  </select><select size="1" name="toHour" disabled>
	<option value="00" selected>HH</option>
	<%  for(byte i=0;i<=23;i++)
		    	out.println("<option value='"+i+"' >"+i+"</option>");
    %>

  </select><select size="1" name="toMin" disabled>
    <option value="00" selected>MM</option>
	  <%  for(byte i=0;i<=55;i+=5)
			if(i<10)
	    		out.println("<option value='0"+i+"' >0"+i+"</option>");
			else
				out.println("<option value='"+i+"' >"+i+"</option>");
  %>
  </select></font></td>
 
   <%
   if ((!toDate.equals("0000-00-00"))&&(mode.equals("edit"))) {
	       toDate=(toDate+"-"+toTime).replace(':','-');
		   stk=new StringTokenizer(toDate,"-");
		   if(stk.hasMoreTokens()) {			   
			   yyyy=stk.nextToken();			   
			   mm=stk.nextToken();
			   dd=stk.nextToken();
			   hh=stk.nextToken();
			   min=stk.nextToken();
			   
			}
	  %>
	  <script>
		function init1(){
			window.document.examdetails.toDate.disabled=false;
			window.document.examdetails.toMonth.disabled=false;
			window.document.examdetails.toYear.disabled=false;
			window.document.examdetails.toHour.disabled=false;
			window.document.examdetails.toMin.disabled=false;
			editToYear();
			document.examdetails.toYear.value="<%=yyyy%>";
			window.document.examdetails.toDate.options[<%=dd%>-1].selected=true;
			window.document.examdetails.toMonth.options[<%=mm%>-1].selected=true;	
			//  window.document.examdetails.toYear.options[11]=new Option(<%=yyyy%>,<%=yyyy%>);	
			// window.document.examdetails.toYear.options[11].selected=true;
		    var x=window.document.getElementsByName("toHour");
			x[0].selectedIndex=<%=hh%>+1;
			x=window.document.getElementsByName("toMin");
			x[0].selectedIndex=(<%=min%>/5)+1;
		}
		init1();
		  </script>
	  <%}else{%>
		  <script>
			function init1(){
			  editToYear();
			  setDate("to");
			  window.document.examdetails.toDate.disabled=true;
			  window.document.examdetails.toMonth.disabled=true;
			  window.document.examdetails.toYear.disabled=true;
			  window.document.examdetails.toHour.disabled=true;
			  window.document.examdetails.toMin.disabled=true;
		  }
		  init1();
		  </script>
    <%}%>
  </tr>
  <tr>
    <td width="115" height="18" bgcolor="#FFFFFF" bordercolor="#DFE2F4">&nbsp;</td>
    <td width="4" height="18" bgcolor="#FFFFFF" bordercolor="#DFE2F4"></td>
    <td width="309" height="18" colspan="2" bgcolor="#FFFFFF" bordercolor="#DFE2F4"><font face="Arial" size="2">&nbsp;

  </font>
  </td>
    <td width="310" height="18" bgcolor="#FFFFFF" bordercolor="#DFE2F4">&nbsp;
  </td>
  </tr>

  <tr>
    <td width="115" height="23" bgcolor="#FFFFFF" bordercolor="#DFE2F4"><font face="Arial" size="2">&nbsp;</font></td>
    <td width="4" height="23" bgcolor="#FFFFFF" bordercolor="#DFE2F4"></td>
    
	<%if (pasword.equals("1")) {%> 
	    <td width="623" height="23" colspan="3" bgcolor="#FFFFFF" bordercolor="#DFE2F4">
	    <input type="checkbox" name="password" value="1" checked><font face="Arial" size="2">Password Based Access Control</font></td>
   <%}else {%>
		<td width="623" height="23" colspan="3" bgcolor="#FFFFFF" bordercolor="#DFE2F4">
		 <input type="checkbox" name="password" value="0"><font face="Arial" size="2">Password Based Access Control</font></td>
   <%}%>
  </tr>
  <tr>
	 <td width="115" height="25" bgcolor="#FFFFFF" bordercolor="#DFE2F4"><font face="Arial" size="2">Max. Attempts&nbsp;</font></td>
	  <td width="4" height="25" bgcolor="#FFFFFF" bordercolor="#DFE2F4"><b><font face="Arial" size="2">:</font></b></td>
	  <td width="623" height="25" colspan="3" bgcolor="#FFFFFF" bordercolor="#DFE2F4">
       <select name="multipleattempts">	
	     <option value="-1" selected>-</option>
	   <%for(byte i=1;i<=10;i++)
	        if(i==maxAttempts)
     		   out.println("<option value='"+i+"' selected>"+i+"</option>");
			else
			   out.println("<option value='"+i+"' >"+i+"</option>");	
	   %>
	   </td>
  </tr>
   <tr>
	 <td width="115" height="34" bgcolor="#FFFFFF" bordercolor="#DFE2F4"><font face="Arial" size="2">Grading based on&nbsp;</font></td>
	  <td width="4" height="34" bgcolor="#FFFFFF" bordercolor="#DFE2F4"><b><font face="Arial" size="2">:</font></b></td>
	  <%			
	  if (grading.equals("0")) {%>
		   <td width="139" height="34" bgcolor="#FFFFFF" bordercolor="#DFE2F4">
		   <input type="radio" name="grading" value="0" checked>Best
		   </td>
		   <td width="166" height="34" bgcolor="#FFFFFF" bordercolor="#DFE2F4">
		   <input type="radio" name="grading" value="1">Last
		   </td>
		   <td width="310" height="34" bgcolor="#FFFFFF" bordercolor="#DFE2F4">
		   <input type="radio" name="grading" value="2">Average
		   </td>
	   <%}else if (grading.equals("1")) {%>
		   <td width="139" height="34" bgcolor="#FFFFFF" bordercolor="#DFE2F4">
		   <input type="radio" name="grading" value="0" >Best
		   </td>
		   <td width="166" height="34" bgcolor="#FFFFFF" bordercolor="#DFE2F4">
		   <input type="radio" name="grading" value="1" checked>Last
		   </td>
		   <td width="310" height="34" bgcolor="#FFFFFF" bordercolor="#DFE2F4">
		   <input type="radio" name="grading" value="2">Average
		   </td>
	   <%}else{%>
		   <td width="139" height="34" bgcolor="#FFFFFF" bordercolor="#DFE2F4">
		   <input type="radio" name="grading" value="0" >Best
		   </td>
		   <td width="166" height="34" bgcolor="#FFFFFF" bordercolor="#DFE2F4">
		   <input type="radio" name="grading" value="1" >Last
		   </td>
		   <td width="310" height="34" bgcolor="#FFFFFF" bordercolor="#DFE2F4">
		   <input type="radio" name="grading" value="2" checked>Average
		   </td>
	   <%}%>
	   </tr>
   <tr>
    <td width="583" height="35" colspan="6">
      <p align="center">&nbsp;&nbsp;&nbsp;<font face="Arial" size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="image" src="images/submit.jpg" > <input type="image" src="images/reset.jpg" value="Reset" name="Reset" onclick="document.examdetails.reset();init();init1();return false;"></font></p>
    </td>
  </tr>
</table>


  </center>
</div>


<input type="hidden" name="frmDate">
<input type="hidden" name="tDate">
<input type="hidden" name="pasword">
<input type="hidden" name='selExId' value='<%=examId%>'>
<INPUT TYPE="hidden" name="course_last_date" value="<%=cours_last_datedb%>">

</form>
</body>


</html>
<%
	}catch(Exception e){
		ExceptionsFile.postException("CreateExam.jsp","operations on database","Exception",e.getMessage());
		//e.printStackTrace();
    }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
			    con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("CreateExam.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }

%>

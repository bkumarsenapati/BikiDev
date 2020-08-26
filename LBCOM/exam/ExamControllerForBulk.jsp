<%@page import="java.io.*,java.sql.*,java.text.*,java.util.*,java.util.Date,coursemgmt.ExceptionsFile"%>
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
	int enable=0,maxAttempts=0;
	byte flag=0,durMins=0,durHrs=0,shortType=0;

	String courseName,teacherId="",recPage="";
	String argSelIds;
	String argUnSelIds;
	String cLabel="",cTitle="";

	Hashtable htSelAsmtIds=null,htUnAsgndAsmtIds=null;

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

		mode=request.getParameter("mode");  // IU - request came from import utility , AM - request came from Assessments
		schoolId=(String)session.getAttribute("schoolid");
	
		if (mode.equals("IU")){
			courseName=request.getParameter("coursename");
			courseId=request.getParameter("courseid");
			teacherId=request.getParameter("teacherid");
		    cTitle=courseName;
			cLabel="Course Name :";

		}else{
			courseId=(String)session.getAttribute("courseid");
			teacherId = (String)session.getAttribute("emailid");
			courseName = (String)session.getAttribute("coursename");
			examType=request.getParameter("examtype");
			recPage=request.getParameter("nrec");

		    cTitle=courseName;
			cLabel="Course Name :";

			if(mode.equals("SL")){
			   session.putValue("seltAsmtIds",null);
			   examId=request.getParameter("examid");
			   cTitle=request.getParameter("examname");
			   cLabel="Assessment Name :";
			   htSelAsmtIds=new Hashtable();
			   htSelAsmtIds.put(examId,examId);
			   session.putValue("seltAsmtIds",htSelAsmtIds);
			   mode="AM";
			}else{
			
				htSelAsmtIds=(Hashtable)session.getAttribute("seltAsmtIds");				
				htUnAsgndAsmtIds=(Hashtable)session.getAttribute("unAsgndAsmtIds");

				argSelIds=request.getParameter("checked");
				argUnSelIds=request.getParameter("unchecked");   


				if (htSelAsmtIds==null){
				   htSelAsmtIds=new Hashtable();
		
				}else{
					
					if(argUnSelIds!="" & argUnSelIds!=null){
						StringTokenizer unsel=new StringTokenizer(argUnSelIds,",");
						String id;

						while(unsel.hasMoreTokens()){
							id=unsel.nextToken();
							if(htSelAsmtIds.containsKey(id))
								htSelAsmtIds.remove(id);
						}
		
					}
				}
		
					
				if(argSelIds!="" && argSelIds!=null) {

					StringTokenizer sel=new StringTokenizer(argSelIds,",");
					String id;			
				
					while(sel.hasMoreTokens())
					{
						id=sel.nextToken();
						htSelAsmtIds.put(id,id);
					}			

				}

				if (htUnAsgndAsmtIds!=null){
					String id=null;
					for(Enumeration asmtIds=htUnAsgndAsmtIds.keys();asmtIds.hasMoreElements();){
						id=(String)htUnAsgndAsmtIds.get(asmtIds.nextElement());						
						if(htSelAsmtIds.containsKey(id))
								htSelAsmtIds.remove(id);

					}
		
				}

			}
		}
		con=db.getConnection();
		st=con.createStatement();
		String dbString11="select DATE_FORMAT(last_date,'%m/%d/%y') as last_date,DATE_FORMAT(last_date,'%Y-%m-%d') as last_datedb from coursewareinfo where course_id='"+courseId+"' and school_id='"+schoolId+"'";
		rs=st.executeQuery(dbString11);
		if(rs.next()){
			cours_last_date=rs.getString(1);
			cours_last_datedb=rs.getString(2);
		}
		rs.close();	
		
	
%>

<html>
<head>
	<title></title>
	<LINK media=screen href="images/default.css" type=text/css rel=stylesheet>
	<LINK media=print href="images/print.css" type=text/css rel=stylesheet>
	<SCRIPT language=javascript src="../common/Calendar/CalendarPopup.js"></SCRIPT>
	<SCRIPT language=javascript>document.write(getCalendarStyles());</SCRIPT>
	<SCRIPT language=javascript>var cal = new CalendarPopup('mydiv');</SCRIPT>
	<link rel="stylesheet" type="text/css" href="/LBCOM/common/Validations.css" /></style>
	<SCRIPT LANGUAGE="JavaScript" src='/LBCOM/common/Validations.js'>	</script>
	<script language="javascript" src="../validationscripts.js"></script> 
</head>
<body topmargin="20">

<form name="form" method="post" onsubmit="return validate();" action="/LBCOM/MakeAsmtAvailable?examtype=<%=examType%>&nrec=<%=recPage%>&teacherid=<%=teacherId%>&courseid=<%=courseId%>&mode=<%=mode%>" >
<!-- code for errors -->
	<CENTER><TABLE name="errshow" id="errshow" width="636"><TR><TD style="color:blue"></TD></TR></TABLE></CENTER>
<!-- code for errors -->

<script language="javascript" >
///////////////////////////////////////////////////////////////////////////////////////
var eleids = new Array("fromDate,tDate");			//Array of element ids which we have to validate
var elenames = new Array("From Date,To Date");	//Array of element Names which we have to validate for display
var errmsg="";res=true;

function convertsqlDate(date11){		//Converting m/d/yy to yyyy-mm-dd
	var k=date11.split("/");
	var year;
	if((parseInt(k[2]),10)<2000)
		year=parseInt(k[2],10)+2000
	else
		year=parseInt(k[2],10);
    var month;
	if((parseInt(k[0]),10)<10)
		month='0'+parseInt(k[0],10)
	else
		month=parseInt(k[0],10);

    var d;
	if((parseInt(k[1],10))<10)
		d='0'+parseInt(k[1],10)
	else
		d=parseInt(k[1],10);

	return year+"-"+month+"-"+d;

}
function validate(){
	var win=window.document.form;
	var msg=""
	var from_date=document.getElementById("fromDate").value;
	var to_date=document.getElementById("tDate").value;
	var today=gettodate();
	if(compareDates(today,"M/d/yy",from_date,"M/d/yy")==1){
		msg=msg+"<LI><font face=Verdana size=1 color=black>Assessment From Date should be greater than Today's Date</font>";
		res=false;
	}
	/*if(compareDates(today,"M/d/yy",to_date,"M/d/yy")==1){
		msg=msg+"<LI><font face=Verdana size=1 color=black>Assessment To Date should be greater than Today's Date</font>";
		res=false;
	}
	*/
	if(compareDates(from_date,"M/d/yy",to_date,"M/d/yy")==1){
		msg=msg+"<LI><font face=Verdana size=1 color=black>Assessment From Date should be less than To Date</font>";
		res=false;
	}
		
	Required("fromDate,tDate");
	var  d=new Date();
	var course_l_date="<%=cours_last_date%>";
	if(win.toCheck.checked){
		if(compareDates(to_date,"M/d/yy",course_l_date,"M/d/yy")==1){
			document.getElementById("tDate").value="<%=cours_last_date%>";
			
			msg=msg+"<LI><font face=Verdana size=1 color=black>Assessment To date should be less than or equal to the course end date(<%=cours_last_date%>)</font>";
			res=false;
		}
	}
	else{
		document.getElementById("tDate").value="<%=cours_last_date%>";
		to_date=document.getElementById("tDate").value;

	}
	if(res==true){
		document.getElementById("fromDate").value=convertsqlDate(from_date);
		document.getElementById("tDate").value=convertsqlDate(to_date);
		document.getElementById("toDate").value=convertsqlDate(to_date);
	document.getElementById("submit").disabled=true;

	}
	//ShowErrors(errmsg+msg);
	
	//return false;
	
	return ShowErrors(errmsg+msg)==true
		
}
function setToDate() {
  var win=window.document.form;
  if (win.toCheck.checked==true) {
	  win.tDate.disabled=false;
	  win.tHour.disabled=false;
	  win.tMin.disabled=false;
	  win.toCheck.value="1";
  }
  else{
	  win.tDate.disabled=true;
	  win.tHour.disabled=true;
	  win.tMin.disabled=true;
	  win.toCheck.value="0";
  }

}


</script>

<div align="center">
  <center>

<table border="0" width="601"  cellspacing="0" bordercolor="#DFE2F4" height="213">
  
  <tr>
    <td width="591" height="28" bgcolor="#F4F5FB" bordercolor="#DFE2F4" colspan="5">
    <font face="Arial" size="4">&nbsp;Assessment Control Information</font></td>
  </tr>
  
  <tr>
    <td width="111" height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4"><font face="Arial" size="2"><%=cLabel%></font></td>
    <td width="4" height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4"><b><font face="Arial" size="2">:</font></b></td>
    <td width="20" height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4">&nbsp;</td>
    <td  colspan=2 height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4">
    <font face="Arial" size="2"><%=cTitle%>
    </font></td>
  </tr>
  <tr>
    <td width="111" height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4" valign="middle" align="left"><font face="Arial" size="2">Availability&nbsp;</font></td>
    <td width="4" height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4" valign="middle" align="left"><b><font face="Arial" size="2">:</font></b></td>
    <td height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4" valign="top" align="left" width="20">&nbsp;</td>    
    <td height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4" align="left" width="32"><font face="Arial" size="2"><font color=red>*&nbsp;</font>From</font></td>
    <td height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4" align="left" width="424" >
    <font face="Arial"><input type="text" name="fromDate"  id="fromDate" size="20" value="" readonly><font size="2" >
    </font>
  <select size="1" name="fromHour" >
     <option value="00" selected>HH</option>
	  <%  for(byte i=0;i<=23;i++) {
	    	out.println("<option value='"+i+"' >"+i+"</option>");
			
	}
  %>

  </select><font size="2"> </font>
  
  <select size="1" name="fromMin" >
    <option value="00" selected>MM</option>
  <%  for(byte i=0;i<=55;i+=5){
			if(i<10)
	    		out.println("<option value='0"+i+"' >0"+i+"</option>");
			else
				out.println("<option value='"+i+"' >"+i+"</option>");

  }
  %>
	</select><font size="2">
      </font></font></font>
<A id=from_date_anchor style="FONT-SIZE: 11px; COLOR: #27408b" href="#"                  onclick="form.fromDate.value='';cal.select(document.forms['form'].fromDate,'from_date_anchor','M/d/yy');&#10;                      return false;" name=from_date_anchor>Pick Date</A>	  
</td>

    
  </tr>

  
  <tr>
    <td width="111" height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4">&nbsp;</td>
    <td width="4" height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4"></td>
    <td width="20" height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4"><font face="Arial" size="2"><input type="checkbox" name="toCheck"  value="0" onclick="setToDate();"></font></td>
    <td width="32" height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4"><font face="Arial" size="2">
    To</font></td>
    <td width="424" height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4">
    <font face="Arial">
    <input type="text" name="tDate"  id="tDate" disabled size="20" readonly value="<%=cours_last_date%>"></font><font face="Arial" size="2">
	<select size="1" name="tHour" disabled>
	<option value="00" selected>HH</option>
	<%  for(byte i=0;i<=23;i++)
		    	out.println("<option value='"+i+"' >"+i+"</option>");
    %>
	</select>&nbsp;<select size="1" name="tMin" disabled>
    <option value="00" selected>MM</option>
	  <%  for(byte i=0;i<=55;i+=5)
			if(i<10)
	    		out.println("<option value='0"+i+"' >0"+i+"</option>");
			else
				out.println("<option value='"+i+"' >"+i+"</option>");
	  %>
	</select></font>
	<A id=to_date_anchor 
                  style="FONT-SIZE: 11px; COLOR: #27408b" 
                  onclick="form.tDate.value='';cal.select(document.forms['form'].tDate,'to_date_anchor','M/d/yy');&#10;                      return false;" 
                  href="#" 
                  name=to_date_anchor>Pick Date
	</A>
	</td>	
  </tr>

 
  <tr>
	 <td width="111" height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4"><font face="Arial" size="2">Max. Attempts&nbsp;</font></td>
	  <td width="4" height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4"><b><font face="Arial" size="2">:</font></b></td>
	  <td width="20" height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4">
       &nbsp;</td>
	  <td width="32" height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4">
       <font face="Arial">
       <select name="multipleattempts">	
	     <option value="-1" selected>-</option>
	   <%
		for(byte i=1;i<=10;i++)
			   out.println("<option value='"+i+"' >"+i+"</option>");	
	   %>
	   </font>
	   </td>
	  <td width="424" height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4">
       &nbsp;</td>
  </tr>
   <tr>
	 <td width="111" height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4"><font face="Arial" size="2">Grading based on&nbsp;</font></td>
	  <td width="4" height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4"><b><font face="Arial" size="2">:</font></b></td>

		   <td width="20" height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4">
		   &nbsp;</td>

		   <td width="458" height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4" colspan="2" align="left">
		   <font face="Arial">
		   <input type="radio" name="grading" value="0" checked><font size="2">Best&nbsp;
           </font>
		   <input type="radio" name="grading" value="1"><font size="2">Last
           </font>
		   <input type="radio" name="grading" value="2"><font size="2">Average
           </font></font>
		   </td>

	   </tr>
   <tr>
    <td width="599" height="72" colspan="5">
      <p align="left"><font face="Arial" size="2">
      <input id="submit" type="submit" name="submit" value="Submit"></font></p>
	  <DIV id=mydiv style="VISIBILITY: hidden; POSITION: absolute; BACKGROUND-COLOR: #ffffff; layer-background-color: #ffffff" height="200">
	  </DIV>
    </td>
  </tr>
</table>


  </center>
</div>


<font face="Arial">


<INPUT TYPE="hidden" name="course_last_date" value="<%=cours_last_datedb%>">
<INPUT TYPE="hidden" id="toDate" name="toDate" value="<%=cours_last_datedb%>">
<INPUT TYPE="hidden" name="toHour" value="00">
<INPUT TYPE="hidden" name="toMin" value="00">

<INPUT TYPE="hidden" name="classid" value="<%=request.getParameter("classid")%>">
<INPUT TYPE="hidden" name="classname" value="<%=request.getParameter("classname")%>">
<INPUT TYPE="hidden" name="coursename" value="<%=courseName%>">
</font>
</form>
<SCRIPT LANGUAGE="JavaScript">
<!--
function gettodate(){
	<%
		Date now = new Date();
		DateFormat df1 = DateFormat.getDateInstance(DateFormat.SHORT);
		String s1 = df1.format(now);
	%>
	return "<%=s1%>";
}
document.getElementById("fromDate").value=gettodate();
//-->
</SCRIPT>
<TABLE>
<TR>
	<TD width=125>&nbsp;</TD><TD ><font face="Arial" color=red>Note:</font>The assessments will be available during the above dates which were taken from the hotschools server</TD>
</TR>
</TABLE>
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

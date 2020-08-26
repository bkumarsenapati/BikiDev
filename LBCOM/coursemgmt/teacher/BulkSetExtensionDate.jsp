<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@ page errorPage = "/ErrorPage.jsp" %>

<%
	String widStr="",sidStr="",id="",dueDate="",mm="",dd="",year="",classId="",courseId="",teacherId="",schoolId="",masterTable="";
	int widLen=0,sidLen=0;
	Hashtable workIds=null,studentIds=null;
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
%>
<%
	classId=(String)session.getAttribute("classid");
	courseId=(String)session.getAttribute("courseid");
	teacherId=(String)session.getAttribute("emailid");
	schoolId=(String)session.getAttribute("schoolid");
	
	masterTable=schoolId+"_"+classId+"_"+courseId+"_workdocs";

	widStr=request.getParameter("workids");
	sidStr=request.getParameter("studentids");

	workIds=new Hashtable();
	studentIds=new Hashtable();
	
	StringTokenizer widTokens=new StringTokenizer(widStr,",");
		
	while(widTokens.hasMoreTokens())
	{
		id=widTokens.nextToken();
		workIds.put(id,id);
	}
		
	StringTokenizer sidTokens=new StringTokenizer(sidStr,",");
	while(sidTokens.hasMoreTokens())
	{
		id=sidTokens.nextToken();
		studentIds.put(id,id);
	}

	widLen = workIds.size();	
	sidLen = studentIds.size();	

	con=con1.getConnection();
	st=con.createStatement();
	
	rs=st.executeQuery("select DATE_FORMAT(last_date,'%m/%d/%Y') as last_date,DATE_FORMAT(last_date,'%Y-%m-%d') as last_datedb from coursewareinfo where course_id='"+courseId+"' and school_id='"+schoolId+"'");

	boolean b=rs.next();
	dueDate=rs.getString(1);
	rs.close();

	mm=dueDate.substring(3,5);
	dd=dueDate.substring(0,2);
	year=dueDate.substring(6,10);
	int tt=Integer.parseInt(mm);
	tt--;
	mm=""+tt;
	tt=Integer.parseInt(dd);
	dd=""+tt;
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title></title>
<link href="../../style.css" rel="stylesheet" type="text/css" />
<script>

function dateConvert()
{
	var win=window.document.duedates;
	var mon=parseInt(win.fmonth.value)+1;
	win.fromdate.value=win.fyear.value+'/'+mon+'/'+win.fdate.value;
	if(win.year.value!="")
	{
		mon=parseInt(win.month.value)+1;
		win.lastdate.value=win.year.value+'/'+mon+'/'+win.date.value;
	}
	else
		win.lastdate.value="";
}

function isValidDate(dd,mm,yy)
{
	d=dd.value;
	m=parseInt(mm.value)+1;
	y=yy.value;

	var dinm = new Array(0,31,28,31,30,31,30,31,31,30,31,30,31);
	tday=new Date();
	if(y <=1900 ||isNaN(y))
	{
		alert("Enter a valid year");
		return false;
	}
	else if(y %4==0 &&(y%100!=0 ||y%400==0))
		dinm[2]=29;
	if((m > 12 || m < 1)|| isNaN(m))
	{
		alert("Enter a valid month");
		return false;
	}
	if((d<1 || d >dinm[m])||isNaN(d))
	{
		alert("Enter a valid date");
		return false;
	}
	return true;
}

function validateDate(dd,mm,yy)
{
	var toDay;
	if(isValidDate(dd,mm,yy)==true)
	{
		var dob=new Date(yy.value,mm.value,dd.value);
		var to=new Date();
		if(navigator.appName=="Netscape")
			toDay=new Date(to.getYear()+1900,to.getMonth(),to.getDate());
		else
			toDay=new Date(to.getYear(),to.getMonth(),to.getDate());
	}
	else
		return false;
}

function validate()
{
	var win=window.document.duedates;

	if(win.fdate.disabled==false)
	{
		if(validateDate(win.fdate,win.fmonth,win.fyear)==false)
		{
			return false;
		}
		else
		{
			var dt=new Date(win.fyear.value,win.fmonth.value,win.fdate.value);
			var  d=new Date();
			d.setHours(0);
			d.setMinutes(0);
			d.setSeconds(0);
			dt.setHours(23);
			if(d>dt)
			{
				alert("Sorry! You cannot enter past dates.");
				return false;
			}
		}
	}
	if(win.date.value!="" || win.month.value!="" || win.year.value!="")
	{
		if(validateDate(win.date,win.month,win.year)==false)
			return false;
		else
		{
			var t_dt=new Date(win.year.value,win.month.value,win.date.value);
			var  d=new Date();
			d.setHours(0);
			d.setMinutes(0);
			d.setSeconds(0);
			t_dt.setHours(23);
			if(d>t_dt)
			{
				alert("Sorry! You cannot enter past dates.");
				return false;
			}
			t_dt.setHours(0);
			var course_l_date=new Date("<%=dueDate%>");
			if(course_l_date<t_dt)
			{
				alert("Submission Date should be less than or equal to the Course Completion Date(<%=dueDate%>)");
				return false;
			}
		}
	}
	var f_dt=new Date(win.fyear.value,win.fmonth.value,win.fdate.value);
	var t_dt=new Date(win.year.value,win.month.value,win.date.value);
	if(t_dt<f_dt)
	{
		alert("Submission Date must be greater than the Start Date");
		return false;
	}
	else
	{
		dateConvert();
		window.location.href="AssignManyToMany.jsp?workids=<%=workIds%>&studentids=<%=studentIds%>";
		return true;
	}
}

function addOptions()
{
	var frm=document.duedates;
	var date=new Date();
	var month=new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");

	frm.fmonth.length=13;
	frm.fdate.length=32;
	frm.fyear.length=10;
	frm.fmonth[0]=new Option("MM","");
	for(i=0;i<12;i++)
		frm.fmonth[i+1]=new Option(month[i],i);
	frm.fdate[0]=new Option("DD","");
	for(i=1;i<=31;i++)
		frm.fdate[i]=new Option(i,i);
	frm.fyear[0]=new Option("YYYY","");
	for(i=date.getFullYear(),j=1;i<date.getFullYear()+10;i++,j++)
		frm.fyear[j]=new Option(i,i);

	frm.month.length=13;
	frm.date.length=32;
	frm.year.length=10;
	frm.month[0]=new Option("MM","");
	for(i=0;i<12;i++)
		frm.month[i+1]=new Option(month[i],i);
	frm.date[0]=new Option("DD","");
	for(i=1;i<=31;i++)
		frm.date[i]=new Option(i,i);
	frm.year[0]=new Option("YYYY","");
	for(i=date.getFullYear(),j=1;i<date.getFullYear()+10;i++,j++)
		frm.year[j]=new Option(i,i);

	frm.fmonth.value=date.getMonth();
	frm.fyear.value=date.getYear();
	if(navigator.appName=="Netscape")
		frm.fyear.value=date.getYear()+1900;
	frm.fdate.value=date.getDate();
	frm.month.value="<%=mm%>";
	frm.year.value="<%=year%>";
	frm.date.value="<%=dd%>";
	return false;
}

function listAssignments()
{
	window.open("ListAssignments.jsp?workids=<%=widStr%>&tblname=<%=masterTable%>","Document","resizable=no,scrollbars=yes,width=350,height=350,toolbars=no");
}

function listStudents()
{
	window.open("ListStudents.jsp?sidstr=<%=sidStr%>","Document","resizable=no,scrollbars=yes,width=350,height=350,toolbars=no");
}

</script>
</head>

<BODY onload=" return addOptions();">

<form name='duedates' action="ExtendValidity.jsp?workids=<%=widStr%>&studentids=<%=sidStr%>" method="POST" onsubmit="return validate();" >
<input type='hidden' name=lastdate>
<input type='hidden' name=fromdate>

<p>&nbsp;</p>
<center>
<table border="0" cellpadding="0" cellspacing="0" bordercolor="#111111" width="80%" height="40">
  <tr>
    <td width="100%" height="28" bgcolor="#808080"><b>
    <font face="Verdana" size="2" color="#FFFFFF">&nbsp;Due Date Selector</font></b></td>
  </tr>
  <tr>
    <td width="100%" height="12"><font face="Verdana" size="1" color="#800000">Selecting a due 
    date and proceeding will extend the validity for all the selected assignments to all the 
    selected students.</font></td>
  </tr>
  <tr>
    <td width="100%" height="12">&nbsp;</td>
  </tr>
  <tr>
    <td width="100%" height="12">
		<p align="right">
		<b><font face="Verdana" size="2" color="#0000FF">
		<a href="#" onclick="history.go(-1); return false;">&lt;&lt;BACK</a>
		</font></b>
		</p>
	</td>
  </tr>
</table>
<br>
<table border="1" cellspacing="1" width="80%">
  <tr>
    <td width="5%">&nbsp;</td>
    <td width="25%" align="right"><font face="Verdana" size="2">No. of Assignments :</font></td>
    <td width="30%">
		<input type="text" name="T1" size="6" value="<%=widLen%>" disabled>
		<font size="1" face="Verdana"><a href="#" onclick="listAssignments(); return false;">(LIST)</a></font>
	</td>
    <td width="40%">&nbsp;</td>
  </tr>
  <tr>
    <td width="5%">&nbsp;</td>
    <td width="25%" align="right"><font face="Verdana" size="2">No. of Students :</font></td>
    <td width="30%">
		<input type="text" name="T2" size="6" value="<%=sidLen%>" disabled>
		<font size="1" face="Verdana"><a href="#" onclick="listStudents(); return false;">(LIST)</a></font>
	</td>
    <td width="40%">&nbsp;</td>
  </tr>
  <tr>
    <td width="5%">&nbsp;</td>
    <td width="25%" align="right">
		<font face="Verdana" size="2">
		<div id="sdate1" name="sdate1" style="visibility:hidden">Start Date :</font></div>
	</td>
    <td width="30%"><div id="sdate" name="sdate" style="visibility:hidden">
		<select size='1' name='fmonth'></select>
		<select size='1' name='fdate'></select>
		<select size='1' name='fyear'></select>
		</div>
	</td>
    <td width="40%">&nbsp;</td>
  </tr>
  <tr>
    <td width="5%">&nbsp;</td>
    <td width="25%" align="right">
		<font face="Verdana" size="2">Due Date :</font>
	</td>
    <td width="30%">
		<select size='1' name='month'></select>
		<select size='1' name='date'></select>
		<select size='1' name='year'></select>
	</td>
    <td width="40%">&nbsp;</td>
  </tr>
  <tr>
    <td width="5%">&nbsp;</td>
    <td width="25%">&nbsp;</td>
    <td width="30%">&nbsp;</td>
    <td width="40%">&nbsp;</td>
  </tr>
  <tr>
	<td width="100%" colspan="4" align="center">
		<input type="submit" value="PROCEED">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="reset" value="CANCEL">
	</td>
  </tr>
</table>
</center>

</form>
</body>

</html>
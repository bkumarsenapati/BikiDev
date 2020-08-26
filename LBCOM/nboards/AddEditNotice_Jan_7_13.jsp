<%@page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" scope="page" class="sqlbean.DbBean"/>
<%
	String dirName="",mode="",schoolId="",title="",fileName="",noticeId="",topicDesc="",teacherId="";
	String grade="",courseId="",viewer="",bgClr="";
	java.util.Date fdate=null,tdate=null;
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	int tdays=0,cdays=0,uType=0;
%>
<%
	mode=request.getParameter("mode");
	dirName=request.getParameter("urlval");
	schoolId=(String)session.getAttribute("schoolid");
	viewer=request.getParameter("viewer");
	
	teacherId = (String)session.getAttribute("emailid");
	grade=(String)session.getAttribute("grade");

	con=con1.getConnection();
	st=con.createStatement();
	
	if(schoolId==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}

	if(viewer.equals("admin"))
	{
		bgClr="#F0B850";
	}
	else if(viewer.equals("teacher"))
	{
		bgClr="#429EDF";
	}

	if(mode.equals("edit"))
	{
		noticeId=request.getParameter("notice");
		try
		{
			rs=st.executeQuery("select noticeid,user_type,filename,title,courseid,description,from_date,to_date,to_days(from_date) fdate,to_days(curdate()) cdate from notice_master where schoolid='"+schoolId+"' and noticeid='"+noticeId+"'");
			while(rs.next())
			{
				fileName=rs.getString("filename");
				title=rs.getString("title");
				courseId=rs.getString("courseid");
				fdate = rs.getDate("from_date");
				tdate = rs.getDate("to_date");
				uType = rs.getInt("user_type");
				topicDesc= rs.getString("description");
				tdays=rs.getInt("fdate");
				cdays=rs.getInt("cdate");
				if(topicDesc==null)
					topicDesc="";
				if(topicDesc.equals("null"))
					topicDesc="";
			}
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("FileSeesion.jsp","Operations on database ","Exception",e.getMessage());
			out.println(e);
		}
	}
%>
<html>
<head>
<title></title>
<SCRIPT LANGUAGE="JavaScript" SRC="../validationscripts.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
<!--
function dateConvert(){
	var win=window.document.fs;
	var mon=parseInt(win.fmonth.value)+1;
	win.fromdate.value=win.fyear.value+'/'+mon+'/'+win.fdate.value;
	mon=parseInt(win.month.value)+1;
	win.lastdate.value=win.year.value+'/'+mon+'/'+win.date.value;
}

function validateDate(dd,mm,yy){
	var toDay;
	if(isValidDate(dd,mm,yy)==true){
		var dob=new Date(yy.value,mm.value,dd.value);
		var to=new Date();
		if(navigator.appName=="Netscape")
			toDay=new Date(to.getYear()+1900,to.getMonth(),to.getDate());
		else
			toDay=new Date(to.getYear(),to.getMonth(),to.getDate());
		if((dob-toDay)<0){
			alert("You cannot represent past date!");
			dd.focus();
			return false;
		}
		else
		{
			return true;
		}
	}
	else
		return false;
}

function isValidDate(dd,mm,yy){
   d=dd.value;
   m=parseInt(mm.value)+1;
   y=yy.value;

   var dinm = new Array(0,31,28,31,30,31,30,31,31,30,31,30,31);
   tday=new Date();
   if(y <=1900 ||isNaN(y)){
     alert("Enter valid year");
     return false;
   }
   else
     if(y %4==0 &&(y%100!=0 ||y%400==0))
       dinm[2]=29;
   if((m > 12 || m < 1)|| isNaN(m)){
      alert("Enter valid month");
      return false;
   }
   if((d<1 || d >dinm[m])||isNaN(d)){
     alert("Enter valid Date");
     return false;
   }
   return true;
}

function checkfld(mode)
{
	var win=document.fs;
	if(trim(win.topic.value)=="")
	{
		alert("Please Enter a Title");
		win.topic.select();
		return false;
	}
	
	if(trim(win.topicdesc.value)=="" && win.filename.value=="")
	{
		alert("You didn't specify any notice");
		win.topicdesc.focus();
		return false;
	}
	if(((win.topicdesc.value).indexOf('%')!=-1)||((win.topicdesc.value).indexOf('#')!=-1)||((win.topicdesc.value).indexOf('&')!=-1) )
	{
		alert("Don't use #  & and %");
		win.topicdesc.focus();
		return false;
	}
	if((win.topicdesc.value).indexOf('\n')!=-1 )
	{
		alert("Don't press enter");
		win.topicdesc.focus();
		return false;
	}
	if(win.cid.value=="none")
	{
		alert("Please select any course");
		win.cid.focus();
		return false;
	}
	if(win.fdate.disabled==false)
		if(validateDate(win.fdate,win.fmonth,win.fyear)==false)
			return false;

	if(validateDate(win.date,win.month,win.year)==false)
			return false;
	
	var user;
	for(i=0;i<win.elements.length;i++)
		if(win.elements[i].checked)
			user=win.elements[i].value;

	dateConvert();

	win.fdate.disabled=false;
	win.fmonth.disabled=false;
	win.fyear.disabled=false;
	win.usrtype.value=user;
	replacequotes();
}

function showCourses()
{
	var win=document.fs;
	var x=document.getElementById("cid");
	win.courseid.value=x.options[x.selectedIndex].value;
}

function addOptions(){
		var frm=document.fs;
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
		frm.month.value="";
		frm.year.value="";
		frm.date.value="";
		return false;
	}
function goback(){
	document.location.href="ShowNotices.jsp?name=<%=dirName%>&viewer=<%=viewer%>&createdby=<%=viewer%>";
	return false;
}
//-->
</SCRIPT>
</head>
<body bgcolor="#FFFFFF">
<form name="fs" method="POST" enctype="multipart/form-data"  action="/LBCOM/nboards.UploadNoticeFile?dir=<%=dirName%>&mode=<%=mode%>&notice=<%=noticeId%>&creator=<%=viewer%>" onSubmit="return checkfld('<%=mode%>');">
<input type="hidden" name="fromdate">
<input type="hidden" name="lastdate">
<input type="hidden" name="usrtype">
<input type="hidden" name="courseid" value="<%=courseId%>">
<input type='image' src='images/teacher_back.jpg' onclick="return goback();">
<center>
<TABLE bgcolor="#F2F2F2">
<TR bgcolor="<%=bgClr%>">
	<TD align=center colspan='3'><b>
		<font color='white' face="Arial" size="2">Notice Details</font></b></font></TD>
</TR>

<%
	if(mode.equals("add"))
	{
%>
		<TR>
			<TD align="right">
				<font face="Arial" size="2"><b>Enter Title</b></font></TD>
			<TD align="center">
				<b>:</b></TD>
			<TD>
				<input type="text" name="topic" size="23"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return AlphaNumbersOnly(this, event)">
			</TD>
			
		</TR>

<TR>
			<TD align="right">
				<font face="Arial" size="2"><b>Classroom Announcement</b></font></TD>
			<TD align="center">
				<b>:</b></TD>

									
			<TD>
				<font face="Arial" size="2"><input type="radio" name="imp" value='1' title="Important">&nbsp;Important&nbsp;&nbsp;<input type="radio" name="imp" value="2" title="Available Up to End Date">&nbsp;Recurring</font>
			</TD>
						
		</TR>

		<TR>
			<TD align="right" valign="top">
				<font face="Arial" size="2"><b>Enter Description</b></font></TD>
			<TD align="center" valign="top">
				<b>:</b></TD>
			<TD>
				<textarea name="topicdesc" rows="5" cols="18"></textarea></TD>
		</TR>
<%
		if(viewer.equals("teacher"))
		{
			try
			{
%>
			<tr>
				<td width="40%" align="right" valign="top">
					<font face="Arial" size="2"><b>Select Course</b></td>
				<td width="5%" align="center" valign="top">
					<b><font face="Arial" size="3">:</font></b></td>
				<td width="55%" align="left" valign="top">
					<select id="cid" name="cid" onchange="return showCourses();">
					<option value="none">Select A Course</option>
<%
				//rs=st.executeQuery("select course_id,course_name from coursewareinfo where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and class_id='"+grade+"'");
				rs=st.executeQuery("select course_id,course_name from coursewareinfo where school_id='"+schoolId+"' and teacher_id='"+teacherId+"'");
	
				while(rs.next())
				{
					courseId=rs.getString("course_id");
					out.println("<option value='"+courseId+"'>"+rs.getString("course_name")+"</option>");
				}
				rs.close();
			}
			catch(Exception e)
			{
				ExceptionsFile.postException("AddEditNotice.jsp","Operations on database ","Exception",e.getMessage());
				out.println(e);
			}
%>
			</select>
			</td>
		</tr>	
<%
		}
		else
		{
%>
			<TR>
				<TD align="right">
					<font face="Arial" size="2">Open To</font></TD>
				<TD align="center"><b>:</b></TD>
				<TD>
					<input type="radio" name="usertype" value='0' checked>
					<font face="Arial" size="2">All</font>
					<input type="radio" name="usertype" value='1'>
					<font face="Arial" size="2">Teachers</font>
					<input type="radio" name="usertype" value='2'>
					<font face="Arial" size="2">Students</font></TD>
			</TR>
			<input type="hidden" id="cid" name="cid" value="all">
<%
		}	
%>
		<TR>
			<TD align="right">
				<font face="Arial" size="2"><b>Select a file to Upload</b></font></TD>
			<TD align="center">
				<b>:</b></TD>
			<TD>
				<input type="file" name="filename" size="30"></TD>
		</TR>
		<TR>
			<TD align="right">
				<font face="Arial" size="2"><b>Make Available From</b></font></TD>
			<TD align="center">
				<b>:</b></TD>
			<TD>
				<select size='1' name='fmonth'></select>
				<select size='1' name='fdate'></select>
				<select size='1' name='fyear'></select></TD>
		</TR>
		<TR>
			<TD align="right">
				<font face="Arial" size="2"><b>Make Available Up to&nbsp;</b></font></TD>
			<TD align="center">
				<b>:</b></TD>
			<TD>
				<select size='1' name='month'></select>
				<select size='1' name='date'></select>
				<select size='1' name='year'></select>
			</TD>
		</TR>
<SCRIPT LANGUAGE="JavaScript">
<!--
addOptions();
//-->
</SCRIPT>
<%
	}
	else
	{
%>
		<TR>
			<TD align="right"><font face="Arial" size="2">Enter Title</font></TD>
			<TD align="center"><b>:</b></TD>
			<TD><input type="text" name="topic" size="23" value="<%=title%>"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return AlphaNumbersOnly(this, event)" ></TD>
		</TR>

<TR>
			<TD align="right"><font face="Arial" size="2">Classroom Announcement</font></TD>
			<TD align="center"><b>:</b></TD>
			<TD>
				<font face="Arial" size="2"><input type="radio" name="imp" value='1' title="Important">&nbsp;Important&nbsp;&nbsp;<input type="radio" name="imp" value="2" title="Available Up to End Date">&nbsp;Recurring</font>
			</TD>
		</TR>

		<TR>
			<TD align="right" valign="top"><font face="Arial" size="2">Enter Description</font></TD>
			<TD align="center" valign="top"><b>:</b></TD>
			<TD><textarea name="topicdesc" rows="5" cols="18"><%=topicDesc%></textarea></TD>
		</TR>
<%
		if(viewer.equals("teacher"))
		{
%>
			<TR>
				<td width="40%" align="right" valign="top">
					<font face="Arial" size="2"><b>Select Course</b></td>
				<td width="5%" align="center" valign="top">
					<b><font face="Arial" size="3">:</font></b></td>
				<td width="55%" align="left" valign="top">
					<select id="cid" name="cid" onchange="return showCourses();">
					<option value="none">Select A Course</option>
<%
			//rs=st.executeQuery("select course_id,course_name from coursewareinfo where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and class_id='"+grade+"'");
			rs=st.executeQuery("select course_id,course_name from coursewareinfo where school_id='"+schoolId+"' and teacher_id='"+teacherId+"'");
			while(rs.next())
			{
				out.println("<option value='"+rs.getString("course_id")+"'>"+rs.getString("course_name")+"</option>");
			}
			rs.close();
%>
				</select>
				</td>
			</TR>	
<%
		}	
		else
		{
%>		
			<TR>
				<TD align="right"><font face="Arial" size="2">Open To&nbsp;</font></TD>
				<TD align="center"><b>:</b></TD>
			<TD>
<%
			if(uType==0)
			{
				out.println("<input type='radio' name='usertype' value='0' checked><font face='Arial' size='2'>All</font><input type='radio' name='usertype' value='1'><font face='Arial' size='2'>Teachers</font><input type='radio' name='usertype' value='2'><font face='Arial' size='2'>Students</font>");
			}
			else if(uType==1)
			{
				out.println("<input type='radio' name='usertype' value='0'><font face='Arial' size='2'>All</font><input type='radio' name='usertype' value='1' checked><font face='Arial' size='2'>Teachers</font><input type='radio' name='usertype' value='2'><font face='Arial' size='2'>Students</font>");
			}
			else
			{
				out.println("<input type='radio' name='usertype' value='0'><font face='Arial' size='2'>All</font><input type='radio' name='usertype' value='1'><font face='Arial' size='2'>Teachers</font><input type='radio' name='usertype' value='2' checked><font face='Arial' size='2'>Students</font>");
			}
%>
	</TD>
</TR>
			<input type="hidden" id="cid" name="cid" value="all">
<%
		}	
%>
		<TR>
			<TD align="right">
				<font face="Arial" size="2">Make Available From</font></TD>
			<TD align="center"><b>:</b></TD>
			<TD>
				<select size='1' name='fmonth'></select>
				<select size='1' name='fdate'></select>
				<select size='1' name='fyear'></select></TD>
		</TR>
		<TR>
			<TD align="right">
				<font face="Arial" size="2">Make Available Up to&nbsp;</font></TD>
			<TD align="center"><b>:</b></TD>
			<TD>
				<select size='1' name='month'></select>
				<select size='1' name='date'></select>
				<select size='1' name='year'></select></TD>
		</TR>
<%
	
	if(fileName.indexOf("null")==-1)
	{
%>
		<TR>
			<TD align="right"><font face="Arial" size="2">Uploaded File&nbsp;</font></TD>
			<TD align="center"><b>:</b></TD>
			<TD><font face="arial" size="2" color="red"><b><%=fileName.substring(fileName.indexOf("_")+1,fileName.length())%></select></TD>
		</TR>
<%
	}
%>
		<TR>
			<TD align="right"><font face="Arial" size="2">Select a file to Upload </font></TD>
			<TD align="center"><b>:</b></TD>
			<TD><input type="file" name="filename" size="30"></TD>
		</TR>

<SCRIPT LANGUAGE="JavaScript">
<!--
addOptions();
document.fs.fmonth.value="<%=fdate.getMonth()%>";
document.fs.fyear.value="<%=fdate.getYear()+1900%>";
document.fs.fdate.value="<%=fdate.getDate()%>";
document.fs.month.value="<%=tdate.getMonth()%>";
document.fs.year.value="<%=tdate.getYear()+1900%>";
document.fs.date.value="<%=tdate.getDate()%>";
document.fs.cid.value="<%=courseId%>";
//-->
</SCRIPT>
<%
	if((tdays-cdays)<0)
		out.println("<SCRIPT Language=\"JavaScript\">document.fs.fmonth.disabled=true;document.fs.fdate.disabled=true;document.fs.fyear.disabled=true;</SCRIPT>");
	}
%>

<TR>
	<TD bgcolor='<%=bgClr%>' align='center' colspan='3'>
		<input type="submit" value="Submit" name="submit"></TD>
</TR>
</TABLE>
</center>
</form>
</body>
</html>

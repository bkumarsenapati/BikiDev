<%@ page language="java" %>
<%@ page import = "java.sql.*,java.lang.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page language="java" errorPage="/ErrorPage.jsp"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:setProperty name="db" property="*" />
<%

	Connection con = null;
	Statement st = null,st1=null;
	ResultSet rs = null,rs1=null;

	String status="",status1="";
%>
<%
try
{
	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	
	if(sessid==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	String userid=(String)session.getAttribute("emailid");
	String schoolid=(String)session.getAttribute("schoolid");
	
	String sessState="",query1="",query2="";
	sessState=(String)session.getAttribute("sessionstatus");
	if(sessState==null)
	{
		session.setAttribute("originalschoolid",(String)session.getAttribute("schoolid"));
		session.setAttribute("originalemailid",(String)session.getAttribute("emailid"));
		session.setAttribute("originalclassid",(String)session.getAttribute("classid"));
	}
		query1="select T_status from form_access_group_level where form_id='F00004' and school_id='"+schoolid+"'";
		query2="select * from form_access_user_level where school_id='"+schoolid+"' and form_id='F00004' and uid='"+userid+"' and utype='T'";
		con=con1.getConnection();
	    st=con.createStatement();
		rs=st.executeQuery(query1);
			if(rs.next())
			{
				status=rs.getString("T_status");
			}
		st1=con.createStatement();
		rs1=st1.executeQuery(query2);
		if(rs1.next())
		{
			status1=rs1.getString("status");
			
		}
		if(status1==null || status1=="")
		{
			status1="000000000000000";
		}
		//System.out.println("status1..."+status1);

%>
<html>
<head>
<title>Teacher_left</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script type="text/javascript" src="/LBCOM/common/left_frame/launch.js"></script>
<script type="text/javascript" src="/LBCOM/asm/stateMonitor.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
	var sessid="<%=sessid%>";
	var schoolid="<%=(String)session.getAttribute("originalschoolid")%>";
	var teacherid="<%=(String)session.getAttribute("originalemailid")%>";
	var classid="<%=(String)session.getAttribute("classid")%>";
//-->
</SCRIPT>
</head>
<body leftmargin="0" bgcolor="#a7b7d0" topmargin="0" marginwidth="0" marginheight="0" onLoad="handler('courseware');" onUnload="closePopups();">
<div align="left" class="lDiv">
<table id="Table_01" width="168" height="402" border="0" cellpadding="0" cellspacing="0">

	<tr>
		<td height="26" width="168">
			<img src="images/Teacher_general.jpg" width="168" height="26" title=""></td>
	</tr>
	
<%
		if(status.charAt(0)=='0' && status1.charAt(0)=='0')
		{	
%>
	<tr>
		<td width="168" height="26">
			<a href="javascript:handler('profile');"  name="profile" id="profile"><img src="images/myprofile.jpg" width="168" height="26" title="My Profile" border="0"></a></td>
	</tr>
	<%}
			if(status.charAt(1)=='0' && status1.charAt(1)=='0')
		{
%>

	<tr>
		<td width="168" height="26">
			<a href="javascript:handler('calendar');" name="calendar"  id="calendar"><img src="images/organizer.jpg" width="168" height="26" title="Organizer" border="0"></a></td>
	</tr>
	<%}
			if(status.charAt(2)=='0' && status1.charAt(2)=='0')
		{
%>
	<tr>
		<td width="168" height="26">
			<a href="javascript:handler('notice');" name="notice" id="notice"><img src="images/announcement.jpg" width="168" height="26" title="Announcements" border="0"></a></td>
	</tr>
	<%}
			if(status.charAt(3)=='0' && status1.charAt(3)=='0')
		{
%>
	<tr>
		<td width="168" height="26">
			<a href="javascript:handler('personaldocs')" name="personaldocs" id="personaldocs"><img src="images/dms.jpg" width="168" height="26" title="Document Management" border="0"></a></td>
	</tr>
	<%}
			
%>
	<tr>
		<td width="168" height="26">
			<img src="images/Teacher_learningmgmt.jpg" width="168" height="26" title=""></td>
	</tr>
<%
			if(status.charAt(4)=='0' && status1.charAt(4)=='0')
		{
%>
	<tr>
		<td width="168" height="26">
			<a href="javascript:handler('courseware');" name="courseware" id="courseware"><img src="images/courseware.jpg" width="168" height="26" title="Course Management" border="0"></a></td>
	</tr>
	<%}
	if(status.charAt(5)=='0' && status1.charAt(5)=='0')
		{
%>
	<tr>
		<td width="168" height="26">
			<a href="javascript:handler('cbuilder');" name="cbuilder" id="cbuilder"><img src="images/coursewarebuilder.jpg" width="168" height="26" title="Course Developer" border="0"></a></td>
	</tr>
	<%}
			if(status.charAt(6)=='0' && status1.charAt(6)=='0')
		{
%>
	<tr>
		<td width="168" height="26">
			<a href="javascript:handler('newreports');" name="newreports" id="newreports"><img src="images/grades.jpg" width="168" height="26" title="Grades / Reports" border="0"></a></td>
	</tr>
	<%}
			if(status.charAt(7)=='0' && status1.charAt(7)=='0')
		{
%>
	<tr>
		<td width="168" height="26">
			<a href="javascript:handler('preport');" name="preport" id="preport"><img src="images/progressbook.jpg" width="168" height="26" title="Progressbook"  border="0"></a></td>
	</tr>
	<%}
		
%>
	<tr>
		<td width="168" height="26">
			<img src="images/teacher_communications.jpg" width="168" height="26" title=""></td>
	</tr>
	<%
			if(status.charAt(8)=='0' && status1.charAt(8)=='0')
		{
%>
		<tr>
		<td width="168" height="26">
			<a href="javascript:handler('chat');" name="chat" id="chat"><img src="images/chat.jpg" width="168" height="26" title="Chat" border="0"></a></td>
	</tr>
	<%
		}
			if(status.charAt(9)=='0' && status1.charAt(9)=='0')
		{
%>
	<tr>
		<td width="168" height="26">
			<a href="javascript:handler('mail');" name="mail" id="mail"><img src="images/email.jpg" width="168" height="26" title="Email" border="0"></a></td>
	</tr>
	<%}
			if(status.charAt(10)=='0' && status1.charAt(10)=='0')
		{
%>
		<tr>
		<td width="168" height="26">
			<a href="javascript:handler('bboards1');" name="bboards1" id="bboards1"><img src="images/forums.jpg" width="168" height="26" title="Discussion Forums" border="0"></a></td>
	</tr>
	<%}
			if(status.charAt(11)=='0' && status1.charAt(11)=='0')
		{
%>
	<tr>
		<td width="168" height="26">
			<a href="javascript:handler('chat1');" name="chat1" id="chat1"><img src="images/liveboard.jpg" width="168" height="26" title="Live Board"  border="0"></a></td>
	</tr>
	<%}
			if(status.charAt(12)=='0' && status1.charAt(12)=='0')
		{
%>
	<tr>
		<td width="168" height="26">
			<a href="javascript:handler('webhuddle');" name="webhuddle" id="webhuddle"><img src="images/ecalssroom.jpg" width="168" height="26" title="E-Classroom"  border="0"></a></td>
	</tr>
	<%}
			if(status.charAt(13)=='0' && status1.charAt(13)=='0')
		{
%>

	<tr>
		<td width="168" height="26">
			<a href="javascript:handler('studentview');" name="studentview" id="studentview"><img src="images/studentview.jpg" width="168" height="26" title="Student View" border="0"></a></td>
	</tr>
	<%}
			if(status.charAt(14)=='0' && status1.charAt(14)=='0')
		{
%>
	<tr>
		<td width="168" height="26">
			<a href="javascript:handler('search');" name="search"  id="search"><img src="images/usersearch.jpg" width="168" height="26" title="User Search" border="0"></a></td>
	</tr>
<%
		}
%>
		<tr>
		<td width="168" height="26">
			<a href="javascript:handler('newtemp');" name="newtemp" id="newtemp"><img src="images/forums.jpg" width="168" height="26" title="New Temp" border="0"></a></td>
	</tr>

</table></div>
<div id="ichatFrame" style="display:inline">
</div>
<SCRIPT language=JavaScript>
<!--
var current_login="Teacher";
var sview=null;
var usertype = '<%=session.getAttribute("logintype")%>';
var bl, ecw, sw;
var ecl_popupUrl;
var sessidForPHP = '<%=session.getAttribute("schoolid")%>X<%=session.getAttribute("emailid")%>X<%=session.getId()%>';


function oldPosition(){		parent.main.location.href="/LBCOM/asm/studentview.jsp?mode=student&emailid=<%=session.getAttribute("emailid")%>&usertype=<%=session.getAttribute("logintype")%>&gradeid=<%=session.getAttribute("grade")%>";
}
function newPosition(){	
	parent.main.location.href="/LBCOM/asm/studentview.jsp?mode=student&show=no";
}

var email = '<%=session.getAttribute("emailid")%>';
var schoolid = '<%=session.getAttribute("schoolid")%>';

function handler(anc){
	//setBgColor(document.getElementById(anc).parentNode);
	if(current_login!="Teacher"){
		current_login="Teacher";
		if(window.sview.closed!=true){
			
			//parent.main.location.href="/LBCOM/coursemgmt/teacher/CoursesList.jsp";
			window.sview.parent.frames['main'].location="/LBCOM/asm/studentview.jsp?mode=teacher&emailid=<%=session.getAttribute("emailid")%>&usertype=<%=session.getAttribute("logintype")%>&gradeid=<%=session.getAttribute("grade")%>";
		}else{
			oldPosition();
			alert("You have completely closed the student's view");
			parent.main.location.href="/LBCOM/coursemgmt/teacher/CoursesList.jsp";
			
		}
	}
	switch (anc){
		case 'blog':
			bl = openPopup("blog","http://sparcc.hotschools.net/~zed/hs/cAuth/pppblog/logincgi.php?schoolid="+parent.frames["left"].schoolid+"&emailid="+parent.frames["left"].email+"&withHS=true",1000,650);
			if (bl) bl.focus();
			break;
		case 'support':
			sw = openPopup("support","http://training.hotschools.net/cAuth/support/client.php?schoolid="+parent.frames["left"].schoolid+"&emailid="+parent.frames["left"].email,900,650);
//			sw = openPopup("support","http://training.hotschools.net/cAuth/ticketM/?nick="+parent.frames["left"].schoolid+"."+parent.frames["left"].email,650,500);
			if (sw) sw.focus();
			break;
		case 'studentview':
			current_login="Student";
			//parent.main.location.href="/LBCOM/coursemgmt/teacher/CoursesList.jsp";
			parent.main.location.href="about:blank";
			sview=openPopup("studentView","studentview.jsp?mode=student&show=yes",900,600);		
			break;
		case 'profile':
			parent.main.location.href="/LBCOM/teacherAdmin/modifyTeacherReg.jsp?mode=modify";
			break;
		case 'search':
			parent.main.location.href="/LBCOM/search/SearchFrame.jsp?user=teacher&userid="+email+"&schoolid="+schoolid;
			break;
		case 'organizer':
			parent.main.location.href="/LBCOM/teacherAdmin.organizer.CalAppoint?purpose=teacher&userid="+email;
			break;
		case 'calendar':
			parent.main.location.href="/LBCOM/calendar/index.jsp?type=teacher";
			break;
		case 'personaldocs':
		  //	parent.main.location.href='/cAuth/index.php?emailid=<%=session.getAttribute("emailid")%>&schoolid=<%=session.getAttribute("schoolid")%>&sessid=<%=session.getId()%>&usertype=<%=session.getAttribute("logintype")%>&gradeid=<%=session.getAttribute("grade")%>';
		parent.main.location.href="/LBCOM/DMS/index.jsp?type=teacher";
			break;
		case 'notice':
			parent.main.location.href="/LBCOM/nboards/TeacherNoticeFrame.jsp";//studentAdmin/PublicFrame.jsp?emailid="+email+"&schoolid="+schoolid;
			break;
		case 'courseware':
			parent.main.location.href="/LBCOM/coursemgmt/teacher/CoursesList.jsp";
			break;
		case 'cbuilder':
			//parent.main.location.href="/LBCOM/coursedeveloper/";
			win=window.open("/LBCOM/coursedeveloper/ValidateUser.jsp?userid=<%=session.getAttribute("emailid")%>","cbuilderwin","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
			break;

		case 'qeditor':		
			parent.main.location.href="/LBCOM/exam/QuestionEditorFrames.jsp?mode=qe";
			break;
		case 'gradebook':
			parent.main.location.href="/LBCOM/exam/QuestionEditorFrames.jsp?mode=gb";
			break;
		//case 'reports':
			//parent.main.location.href="/LBCOM/reports/";
			//break;
		case 'newreports':
			parent.main.location.href="/LBCOM/grades/index.jsp?userid="+email;
			break;
		case 'chat':
			win=window.open('http://oh.learnbeyond.net/~oh/hcl/chat/teacher_online.php?emailid=<%=session.getAttribute("emailid")%>&schoolid=<%=session.getAttribute("schoolid")%>' ,'imchatteachwin','resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no');
			win.focus();
			break;
		case 'chat1':
			parent.topframe.chatwindow=window.open('ShowCourseBoards.jsp' ,'nmwindow','status=0,resizable=yes,toolbar=no,menubar=no,titlebar=no,scrollbars=yes,width=1022,height=768');
					
			//parent.topframe.chatwindow=window.open('/LBCOM/WhiteBoard/WhiteBoard.jsp?schoolid=<%=session.getAttribute("schoolid")%>&emailid=<%=session.getAttribute("emailid")%>' ,'nmwindow','status=0,resizable=yes,toolbar=no,menubar=no,titlebar=no,scrollbars=yes,width=900,height=600');	
		//parent.main.location.href="/LBCOM/WebHuddle/teacher/ScheduledMeetings.jsp?schoolid=<%=session.getAttribute("schoolid")%>&emailid=<%=session.getAttribute("emailid")%>";
			break;
			case 'preport':
			win=window.open("https://parentaccess.access-k12.org","preportwin","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
			break;
		case 'mail':
			parent.main.location.href="/LBCOM/Commonmail/index.jsp?mode=inbox";
			break;
		//case 'bboards':
			//parent.main.location.href="/LBCOM/teacherAdmin/ShowDirTopics.jsp?schoolid="+schoolid+"&emailid="+email;
		//	break;
		case 'bboards1':
			parent.main.location.href="/LBCOM/teacherAdmin/Forums/ForumManagement.jsp?mode=findex&emailid="+email+"&schoolid="+schoolid;
			break;
		case 'backup':
			parent.main.location.href="/LBCOM/backup/Frames.jsp?mode=backup&from=teacher";
			break;
		case 'restore':
			parent.main.location.href="/LBCOM/backup/Frames.jsp?mode=restore&from=teacher";
			break;
		case 'webhuddle':
			if(parent.topframe.contineowin!=null && !parent.topframe.contineowin.closed){
				parent.topframe.contineowin.focus();
			}else{
				parent.main.location.href="/LBCOM/WebHuddle/teacher/ScheduledMeetings.jsp?schoolid=<%=session.getAttribute("schoolid")%>&emailid=<%=session.getAttribute("emailid")%>";
				
			}
			break;
		case 'contineo':
			parent.main.location.href="/LBCOM/coursemgmt/teacher/Coursebuilder.jsp?mode=cbindex";
			break;
		case 'eClassRoom':
			var url="/cAuth/eClassRoom.php?emailid=<%=session.getAttribute("emailid")%>&schoolid=<%=session.getAttribute("schoolid")%>&sessid=<%=session.getId()%>&usertype=<%=session.getAttribute("logintype")%>&gradeid=<%=session.getAttribute("grade")%>"
//			closePopups();
			ecl_popupUrl = url;
			var popupUrl = '/cAuth/launch.php?emailid=<%=session.getAttribute("emailid")%>&schoolid=<%=session.getAttribute("schoolid")%>&sessid='+sessidForPHP+'&usertype=<%=session.getAttribute("logintype")%>&gradeid=<%=session.getAttribute("grade")%>';
			if (this.name == 'left') {
				if ('<%=session.getAttribute("logintype")%>' == 'teacher') {
						ecw = openPopup('eClassRoom',url,1000,650);
				} else {
						// something for students
				}
			}
			parent.frames['main'].location.href = popupUrl;
			if (ecw) ecw.focus();
			break;

			// New Template

			case 'newtemp':
			win=window.open("http://183.82.48.154:8080/LBCOM/com/teacher/index.jsp","newtempwin","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
			break;
	}

/* (
	if(anc=='studentview')
			{
			current_login="Student";
			parent.main.location.href="about:blank";
			sview=openPopup("studentView","studentview.jsp?mode=student&show=yes",900,650);
	}else 
		// ADded by Rajesh	END PART
	if(anc=="profile")
		parent.main.location.href="/LBCOM/teacherAdmin/modifyTeacherReg.jsp?mode=modify";
	else if(anc=="search")
		parent.main.location.href="/LBCOM/search/SearchFrame.jsp?user=teacher&userid="+email+"&schoolid="+schoolid;
	else if(anc=="organizer")
		parent.main.location.href="/LBCOM/teacherAdmin.organizer.CalAppoint?purpose=teacher&userid="+email;
	else if(anc=='personaldocs')
		parent.main.location.href='/cAuth/index.php?emailid=<%=session.getAttribute("emailid")%>&schoolid=<%=session.getAttribute("schoolid")%>&sessid=<%=session.getId()%>&usertype=<%=session.getAttribute("logintype")%>&gradeid=<%=session.getAttribute("grade")%>';
	else if(anc=='notice')
		parent.main.location.href="/LBCOM/studentAdmin/PublicFrame.jsp?emailid="+email+"&schoolid="+schoolid;
	else if(anc=='courseware')
		parent.main.location.href="/LBCOM/coursemgmt/teacher/CoursesList.jsp";
	else if(anc=='qeditor')
		parent.main.location.href="/LBCOM/exam/QuestionEditorFrames.jsp?mode=qe";
	else if(anc=='gradebook')
		parent.main.location.href="/LBCOM/exam/QuestionEditorFrames.jsp?mode=gb";
	else if(anc=='reports')
		parent.main.location.href="/LBCOM/reports/";
	else if(anc=='chat')
		parent.topframe.chatwindow=window.open('ShowCourse.jsp' ,'nmwindow','status=0,resizable=no,toolbar=no,menubar=no,titlebar=no,scrollbars=yes,width=750,height=500');
	else if(anc=='mail')
		parent.main.location.href="/LBCOM/Commonmail/MailForm.jsp?schoolid="+schoolid+"&userid="+email+"&r1=teacher";
	else if(anc=='bboards')
		parent.main.location.href="/LBCOM/teacherAdmin/ShowDirTopics.jsp?schoolid="+schoolid+"&emailid="+email;
	else if(anc=='backup'){
		/*if(confirm('Are you sure. you want to take backup?')){			
			parent.main.location.href="/LBCOM/backup.TakeBackup?mode=backup&type=teacher&teacherids="+email+",&schoolid="+schoolid+"&from=teacher";
		}else {
		   return false;
		}
		 parent.main.location.href="/LBCOM/backup/Frames.jsp?mode=backup&from=teacher";
	}
	else if(anc=='restore'){
		//parent.main.location.href="/LBCOM/backup/BackupDetails.jsp?type=teacher&schoolid="+schoolid+"&from=teacher&user="+email;
		parent.main.location.href="/LBCOM/backup/Frames.jsp?mode=restore&from=teacher";
	}
	else if(anc=='contineo'){
		if(parent.topframe.contineowin!=null && !parent.topframe.contineowin.closed){
		    parent.topframe.contineowin.focus();
		}else{
			var win=window.open("/LBCOM/contienotest.jsp?type=user","Document","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
			parent.topframe.contineowin=win;
			win.focus();
		}
	}	
) */
}

function setBgColor(cell) {
	var cells = document.getElementsByTagName("td");
	for (var i = 0; i < cells.length; i++) {
	  if ( cells[i].className == 'lTCol') {
	    cells[i].style.bgColor = '#ccc';
	    cells[i].style.backgroundColor = '#ccc';
	  }
	}
	cell.style.bgColor = '#f66';
	cell.style.backgroundColor = '#f66';
}
function reDefineCells() {
	var cells = document.getElementsByTagName("td");
	var a,i;
	var n = (document.all)?0:1;
	for (i = 0; i < cells.length; i++) {

	  if ( cells[i].className == 'lTCol') {
		a=cells[i].childNodes[n].innerHTML;
		cells[i].innerHTML = "<div id='"+cells[i].childNodes[n].id+"'class='transOFF' style='padding-left:2px;' onClick=\""+cells[i].childNodes[n]+"\" onMouseOver='this.className=\"transON\"' onMouseOut='this.className=\"transOFF\"'>"+a+"&nbsp;&nbsp;</div>";
	  }
	}
}
//reDefineCells();
/*
function launch_eClassRoom(url) {
  closePopups();
  ecl_popupUrl = url;
  var popupUrl = '/cAuth/launch.php?emailid=<%=session.getAttribute("emailid")%>&schoolid=<%=session.getAttribute("schoolid")%>&sessid='+sessidForPHP+'&usertype=<%=session.getAttribute("logintype")%>&gradeid=<%=session.getAttribute("grade")%>';
  if (this.name == 'left') {
    if ('<%=session.getAttribute("logintype")%>' == 'teacher') {
                ecw = winList['eC_win'] = openPopup('eClassRoom',url,1000,650);
        } else {
                // something for students
        }
  }
  parent.frames['main'].location.href = popupUrl;
  if (ecw) ecw.focus();
  return(false);
}
*/
//-->
document. getElementById("ichatFrame"). innerHTML = "<iframe src='http://oh.learnbeyond.net/~oh/hcl/chat/teacher_online1.php?emailid=<%=session.getAttribute("emailid")%>&schoolid=<%=session.getAttribute("schoolid")%>' width='1px' height='1px'></iframe>";

</SCRIPT>

</body>
<%
	}
catch(SQLException se)
	{
	        ExceptionsFile.postException("LeftFrame.jsp","Operations on database","SQLException",se.getMessage());
			System.out.println("Error: SQL -" + se.getMessage());
	}
	catch(Exception e)
	{
	   ExceptionsFile.postException("LeftFrame.jsp","Operations on database","Exception",e.getMessage());
		System.out.println("Error:  -" + e.getMessage());
	}

	finally{
		try{
			
			
			if(st!=null)
				st.close();                //finally close the statement object
			if(st1!=null)
				st1.close();   
					
			if(con!=null && !con.isClosed())
				con.close();
			}
			catch(SQLException se){
			ExceptionsFile.postException("StudentHome.jsp","closing the statement objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}

	%>
</html>
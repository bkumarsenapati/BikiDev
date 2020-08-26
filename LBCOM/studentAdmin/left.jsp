<%@ page language="java" %>
<%@ page import = "java.sql.*,java.lang.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page language="java" errorPage="/ErrorPage.jsp"%>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page" />
<jsp:setProperty name="db" property="*" />
<%
	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	String userid=(String)session.getAttribute("emailid");
	String schoolid=(String)session.getAttribute("schoolid");
	Connection con=null;
	Statement st=null,stmt=null;
	ResultSet rs=null,rs1=null,rss=null;
	String sessState="";
	sessState=(String)session.getAttribute("sessionstatus");
	if(sessState==null)
	{
		session.setAttribute("originalschoolid",(String)session.getAttribute("schoolid"));
		session.setAttribute("originalemailid",(String)session.getAttribute("emailid"));
		session.setAttribute("originalstudentname",(String)session.getAttribute("studentname"));
		session.setAttribute("originalclassid",(String)session.getAttribute("classid"));
	}
%>
	
<html>
<head>
<title>.:: Welcome to www.hotschools.net ::. [ for quality eLearning experience ]</title>
<script type="text/javascript" src="/LBCOM/common/left_frame/launch.js"></script>
<script type="text/javascript" src="/LBCOM/studentAdmin/stateMonitor.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
	var sessid="<%=sessid%>";
	var schoolid="<%=(String)session.getAttribute("originalschoolid")%>";
	var studentid="<%=(String)session.getAttribute("originalemailid")%>";
	var classid="<%=(String)session.getAttribute("originalclassid")%>";
//-->
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<%if(userid.indexOf("_vstudent")>-1){%><!-- <%}%>
	<%String formid="F00003";%> 
	<%@ include file="/accesscontrol/accesscontrol.jsp" %> 	
<%if(userid.indexOf("_vstudent")>-1){%>--><%}%>
<%if(userid.indexOf("_vstudent")>-1){%>
	<script language="javascript" src="/LBCOM/accesscontrol/ac.js"></script>
	<SCRIPT LANGUAGE="JavaScript">
	var ac_ids="profile,organizer,notice,personaldocs,courseware,gradebook,reports,grades,chat,mail,bboards,forums,eClassRoom,search";
	var ac_status="111100011111";
</SCRIPT>
<%}%>



<link rel="stylesheet" type="text/css" href="/LBCOM/common/left_frame/left.css">
<style type="text/css">
.lMainT { border-color: #996699; }
.lTable { border-color: #E08443; }
.lTCol { border-color: #996699; }
</style>
</head>
<body bgcolor="#EBEBEB" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onUnload="closePopups();" >
<table width="130" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="168" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><img src="images/Student_general.jpg" width="168" height="26"></td>
      </tr>
	  <tr>
        <td><a href="javascript:handler('dashboard');"  name="db" id="db"><img src="images/Student_dashboard.jpg" alt="Dashboard" name="Image1" width="168" height="26" border="0"></a></td>
      </tr>
      <tr>
        <td><a href="javascript:handler('profile');"  name="profile" id="profile"><img src="images/Student_myprofile.jpg" alt="My Profile" name="Image2" width="168" height="26" border="0"></a></td>
      </tr>
      <tr>
        <td><a href="javascript:handler('organizer');" name="organizer" id="organizer"><img src="images/Student_organizer.jpg" alt="Organizer" name="Image3" width="168" height="26" border="0"></a></td>
      </tr>
      <tr>
        <td><a href="javascript:handler('notice');" name="notice" id="notice"><img src="images/Student_announcement.jpg" alt="Announcements" name="Image4" width="168" height="26" border="0"></a></td>
      </tr>
      <tr>
        <td><a href="javascript:handler('personaldocs');" name="personaldocs" id="personaldocs"><img src="images/Student_dms.jpg" alt="Document Management" name="Image5" width="168" height="26" border="0"></a></td>
      </tr>
      <tr>
        <td><img src="images/Student_learningmgmt.jpg" width="168" height="26"></td>
      </tr>
      <tr>
        <td><a href="javascript:handler('courseware');" name="courseware" id="courseware""><img src="images/Student_courseware.jpg" alt="Courseware" name="Image7" width="168" height="26" border="0"></a></td>
      </tr>
	  
      <tr>
        <td><a href="javascript:handler('reports');" name="reports" id="reports"><img src="images/Student_grades.jpg" alt="Grades / Reports" name="Image8" width="168" height="26" border="0"></a></td>
      </tr>
	   <tr>
        <td><a href="javascript:handler('preport');" name="preport" id="preport"><img src="images/progressbook.jpg" alt="Progressbook" name="Image11" width="168" height="26" border="0"></a></td>
      </tr>

	  <tr>
        <td><img src="images/Student_communications.jpg" width="168" height="26"></td>
      </tr>
	   <tr>
        <td><a href="javascript:handler('chat');" name="chat" id="chat"><img src="images/Student_imchat.jpg" alt="Chat" name="Image11" width="168" height="26" border="0"></a></td>
      </tr>
	  <tr>
        <td><a href="javascript:handler('mail');" name="mail" id="mail"><img src="images/Student_email.jpg" alt="E-Mail" name="Image11" width="168" height="26" border="0"></a></td>
      </tr>
      <tr>
        <td><a href="javascript:handler('lboard');" name="lboard" id="lboard"><img src="images/Student_liveboard.jpg" alt="Live Board" name="Image10" width="168" height="26" border="0"></a></td>
      </tr>
	  <tr>
        <td><a href="javascript:handler('bboards');" name="bboards" id="bboards"><img src="images/Student_forums.jpg" alt="Discussion Forums" name="Image12" width="168" height="26" border="0"></a></td>
      </tr>
      <tr>
        <td><a href="javascript:handler('eClassRoom');" name="eClassRoom" id="eClassRoom"><img src="images/Student_ecalssroom.jpg" alt="E-Classroom" name="Image13" width="168" height="26" border="0"></a></td>
      </tr>
      <tr>
        <td><a href="javascript:handler('tutor');" name="tutor" id="tutor"><img src="images/Student_tutorials.jpg" alt="Training Tutorials" name="Image12" width="168" height="26" border="0"></a></td>
      </tr>
	  
      <tr>
        <td height="140" bgcolor="#EBEBEB">&nbsp;</td>
      </tr>
    </table>
      </td>
  </tr>
</table>
<div id="ichatSFrame" style="display:inline">
</div>
</body>
<SCRIPT LANGUAGE="JavaScript">
/* ranjantemp
var wList = new Array ( 
parent.studenttopframe.studentChatWin,
parent.studenttopframe.stuExamHistoryWin,
parent.studenttopframe.stuAnsSheetWin,
parent.studenttopframe.studenteClassRoomWin,
parent.studenttopframe.studentUserManualwin,
parent.studenttopframe.studentExamWin,
parent.studenttopframe.studentViewMatWin,
parent.studenttopframe.studentPasswordWin,
parent.studenttopframe.studentNoticeBoardWin
);

for (var i = 0; i < wList.length; i++) {
	if (wList[i]) alert(wList.name);
}

for (var win in parent.frames['left'].winList) {
	if (winList[win].open) alert(win+'--'+winList[win].name);
}
alert(parent.main.location.href);
*/

function handler(anc){	
	if(parent.window.opener!=undefined){
		if(parent.window.opener.current_login=="Teacher"){
			parent.window.opener.current_login= "student";
			parent.window.opener.newPosition();
		}
	}

        //code block below is added by Ghanendre
        if(!(anc=='chat')){
             temp = 'other';
         }
	switch (anc){

		case 'profile':
			parent.main.location.href="RedirectSession.jsp?handler=profile";
			break
		case 'organizer':
			//parent.main.location.href="RedirectSession.jsp?handler=organizer";
			window.parent.main.location.href="../calendar/index.jsp?type=student";
			break 
		case 'personaldocs':
			/*var hrf = '/cAuth/index.php?emailid=<%= session.getAttribute("originalemailid") %>&schoolid=<%= session.getAttribute("originalschoolid") %>&sessid=<%=session.getId()%>';
			if (parent.name == 'studentView')
				hrf = hrf + '&view=virtual';
			parent.main.location.href = hrf;
			*/
			var hrf = '../DMS/index.jsp?type=\"student\"';
			parent.main.location.href = hrf;
			break
		case 'notice':
			parent.main.location.href="RedirectSession.jsp?handler=notice";
			break 
		case 'learningcentre':
			parent.main.location.href="RedirectSession.jsp?handler=learningcenter";
			break 
		case 'reflibrary':
			parent.main.location.href="RedirectSession.jsp?handler=reflibrary";
			break 
		case 'courseware':
			//window.parent.main.location="RedirectSession.jsp?handler=courseware";
			parent.main.location.href="RedirectSession.jsp?handler=courseware";
			//window.parent.frames("main"].location.href="RedirectSession.jsp?handler=courseware";
			break
		case 'gradebook':
			parent.main.location.href="RedirectSession.jsp?handler=gradebook";
			break 
		case 'reports':
			parent.main.location.href="RedirectSession.jsp?handler=reports";
			break
		//case 'grades':
			//parent.main.location.href="RedirectSession.jsp?handler=grades";
		//	break
		case 'lboard':
			//parent.studenttopframe.studentChatWin=window.open('ShowCourse.jsp' ,'nmwindow','status=0,resizable=no,toolbar=no,menubar=no,titlebar=no,scrollbars=yes,width=650,height=525');
			parent.main.location.href="RedirectSession.jsp?handler=lboard";
			break
		case 'chat1':
			//parent.main.location.href="/LBCOM/WhiteBoard/student/StudentBoards.jsp?schoolid=<%=session.getAttribute("schoolid")%>&emailid=<%=session.getAttribute("emailid")%>";
			parent.main.location.href="RedirectSession.jsp?handler=chat1";
			break
		case 'mail':
			parent.main.location.href="RedirectSession.jsp?handler=mail";
			break
		//case 'bboards':
			//parent.main.location.href="RedirectSession.jsp?handler=bboards";
			//break
		case 'bboards':
			parent.main.location.href="RedirectSession.jsp?handler=bboards";
			break
		//case 'eClassRoom':				
			//launch_eClassRoom();
		//	break

		case 'eClassRoom':				
			//win=window.open("http://192.168.1.116:8080","Document","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
				//parent.topframe.contineowin=win;
				//win.focus();
				parent.main.location.href="/LBCOM/WebHuddle/student/CurrentMeetings.jsp?schoolid=<%=session.getAttribute("schoolid")%>&emailid=<%=session.getAttribute("emailid")%>";
			break

		case 'search':
			parent.main.location.href="RedirectSession.jsp?handler=search";
			break
		case 'tutor':
			parent.studenttopframe.studentChatWin=window.open('Video_Tutorials/TrainingTutorials.html' ,'nmwindow');
			break
		case 'dashboard':
			parent.main.location.href="RedirectSession.jsp?handler=db";
			break
		case 'chat':
				win=window.open("http://oh.learnbeyond.net/~oh/hcl/chat/student_online.php?emailid=<%=session.getAttribute("originalemailid")%>&schoolid=<%=session.getAttribute("originalschoolid")%>","imchatstuwin","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
				parent.studenttopframe.studentChatWin=win;
				win.focus();
			//parent.studenttopframe.studentChatWin=window.open('http://oh.learnbeyond.net/~oh/hcl/chat/student_online.php?emailid=<%=session.getAttribute("originalemailid")%>&schoolid=<%=session.getAttribute("originalschoolid")%>' ,'chat1window');
			break
		case 'preport':
			win=window.open("https://parentaccess.access-k12.org/General/LoginPage.aspx?DistrictID=177","stupreport","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
				
				win.focus();
			
			break;
	}
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
addcontrol();
function reDefineCells() {
	var cells = document.getElementsByTagName("td");
	var a,i;
	var n = (document.all)?0:1;
	for (i = 0; i < cells.length; i++) {
	  if ( cells[i].className == 'lTCol') {
	    a = cells[i].innerHTML;
		cells[i].innerHTML = "<div class='transOFF' style='padding-left:2px' onClick=\" setBgColor(this.parentNode);"+cells[i].childNodes[n]+"\" onMouseOver='this.className=\"transON\"' onMouseOut='this.className=\"transOFF\"'>"+a+"</div>";
	
	  }
	}
}
reDefineCells();
var usertype = '<%=session.getAttribute("logintype")%>';
var ecw;
var ecl_popupUrl;
var sessidForPHP = '<%=session.getAttribute("schoolid")%>X<%=session.getAttribute("emailid")%>X<%=session.getId()%>';

function launch_eClassRoom() {
	var url='/cAuth/eClassRoom.php?emailid=<%=session.getAttribute("originalemailid")%>&schoolid=<%=session.getAttribute("originalschoolid")%>&sessid=<%=session.getId()%>&usertype=<%=session.getAttribute("logintype")%>&gradeid=<%=session.getAttribute("grade")%>';
  closePopups();
  ecl_popupUrl = url;
  var popupUrl = '/cAuth/launch.php?emailid=<%=session.getAttribute("emailid")%>&schoolid=<%=session.getAttribute("schoolid")%>&sessid='+sessidForPHP+'&usertype=<%=session.getAttribute("logintype")%>&gradeid=<%=session.getAttribute("grade")%>';
  if (this.name == 'left') {
    if('<%=session.getAttribute("logintype")%>' == 'teacher') {
                ecw = winList['eC_win'] = openPopup('eClassRoom',url,1000,650);
        } else {
                // something for students
        }
  }
  parent.frames['main'].location.href = popupUrl;
  if(ecw) ecw.focus();
}

//-->
document.getElementById("ichatSFrame").innerHTML = "<iframe src='http://oh.learnbeyond.net/~oh/hcl/chat/student_online1.php?emailid=<%=session.getAttribute("emailid")%>&schoolid=<%=session.getAttribute("schoolid")%>' width='1px' height='1px'></iframe>";
</SCRIPT>
</html>

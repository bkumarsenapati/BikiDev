<HTML>
<HEAD>
<TITLE>.:: Welcome to www.hotschools.net ::. [ for quality eLearning experience ]</TITLE>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<META content="MSHTML 6.00.2900.2627" name=GENERATOR>
<script type="text/javascript" src="/LBCOM/common/left_frame/launch.js"></script>
<link rel="stylesheet" type="text/css" href="/LBCOM/common/left_frame/left.css"></style>

<style type="text/css">
.lMainT { border-color: #429EDF; }
.lTable { border-color: #429EDF; }
.lTCol { border-color: #429EDF; }
</style>
</head>

<body leftmargin="0" bgcolor="red" topmargin="0" marginwidth="0" marginheight="0" onLoad="handler('courseware');" onUnload="closePopups();" >

<div align="left" class="lDiv">
    <table class="lMainT">
    <tbody>
        <tr class="lMTRow" style="vertical-align:top;">
            <td class="lMTCol">
            <table class="lTable" id="Table_01">
	    <tbody>
                <tr class="lTRow">
                    <td class="lTColH">
                        General</td>
                </tr>
                <tr class="lTRow">
                    <td class="lTCol">
                        <a href="javascript:handler('profile');"  name="profile" id="profile">My Profile</a></td>
                </tr>
                <!-- <tr class="lTRow">
                    <td class="lTCol">
                        <a href="javascript:handler('organizer');" name="organizer" id="organizer" >Organizer</a>
					</td>
                </tr> -->
				<tr class="lTRow">
                    <td class="lTCol">
                        <a href="javascript:handler('calendar');" name="calendar"  id="calendar">Calendar</a></td>
                </tr>
                <tr class="lTRow">
                    <td class="lTCol">
                        <a href="javascript:handler('notice');" name="notice" id="notice">Notice Board</a></td>
                </tr>
               <tr class="lTRow">
                    <td class="lTCol">
                        <a href="javascript:handler('personaldocs')" name="personaldocs" id="personaldocs">Document Management</a></td>
                </tr>
                <tr class="lTRow">
                    <td class="lTColH" name="lTColH">
                        Learning Management</td>
                </tr>
                <tr class="lTRow">
                    <td class="lTCol">
                        <a href="javascript:handler('courseware');" name="courseware" id="courseware">Course Management</a></td>
                </tr>
				<tr class="lTRow">
					<td class="lTCol">
						<a href="javascript:handler('contineo');" name="contineo" id="contineo">Content Management</a></td>
				</tr>
               <!-- <tr class="lTRow">
                    <td class="lTCol" style="display:none">
                        <a href="javascript:handler('gradebook');" name="gradebook" id="gradebook">GradeBook</a></td>
                </tr>
		-->
                <!-- <tr class="lTRow">
                    <td class="lTCol">
                        <a href="javascript:handler('reports');" name="reports" id="reports">Grades/Reports</a></td>
                </tr> -->
				<tr class="lTRow">
                    <td class="lTCol">
                        <a href="javascript:handler('newreports');" name="newreports" id="newreports">Grades/Reports</a></td>
                </tr>
                <tr class="lTRow">
                    <td class="lTColH" name="lTColH">Communication</td>
                </tr>
               <tr class="lTRow">
                    <td class="lTCol">
                       
							  <a href="javascript:handler('chat');" name="chat" id="chat">Chat</a>
					</td>
                </tr>
				
                <tr class="lTRow">
                    <td class="lTCol">
                        <a href="javascript:handler('mail');" name="mail" id="mail">Email</a></td>
                </tr>
                <!-- <tr class="lTRow">
                    <td class="lTCol">
                        <a href="javascript:handler('bboards');" name="bboards" id="bboards">Forums</a></td>
                </tr> -->
				<tr class="lTRow">
                    <td class="lTCol">
                        <a href="javascript:handler('bboards1');" name="bboards1" id="bboards1">Forums</a></td>
                </tr>
				<tr class="lTRow">
                    <td class="lTCol">
                        <a href="javascript:handler('chat1');" name="chat1" id="chat1">Live Board</a></td>
                </tr>
				<tr class="lTRow">
					<td class="lTCol">
						<a href="javascript:handler('webhuddle');" name="webhuddle" id="webhuddle">eClassroom</a></td>
				</tr>
                <!-- <tr class="lTRow">
                    <td class="lTCol">
						<a href="javascript:handler('eClassRoom');return(false);" name="eClassRoom" id="eClassRoom">eClassroom</a>
                    </td>
                </tr> -->
				<tr class="lTRow">
			<td class="lTCol">
				<a href="javascript:handler('studentview');" name="studentview" id="studentview">Student View</a></td>
			</tr>
			
                <tr class="lTRow">
                    <td class="lTCol">
                        <a href="javascript:handler('search');" name="search"  id="search">User Search</a></td>
                </tr>
				



				
		
		<tr class="lTRow">
			<td class="lTCol">
				<a href="javascript:handler('support');" name="support" id="support">Support</a></td>
		</tr> 
		<!-- <tr class="lTRow">
			<td class="lTCol">
				<a href="javascript:handler('blog');" name="blog" id="blog">Blog</a></td>
		</tr> -->
		
		
		  </tbody>
            </table>
            </td>
        </tr>
    </tbody>
    </table>
	</div>
	<div id='divcontent'><FONT face=Verdana size='2' color='#191919'><P align=center><STRONG>1st 
      <a href="santhosh">Quarter</a> (Grading Period)</STRONG></P></div>


<SCRIPT language=JavaScript>
<!--
var current_login="Teacher";
var sview=null;
var usertype = '<%=session.getAttribute("logintype")%>';
var bl, ecw, sw;
var ecl_popupUrl;
var sessidForPHP = '<%=session.getAttribute("schoolid")%>X<%=session.getAttribute("emailid")%>X<%=session.getId()%>';


function oldPosition(){		parent.main.location.href="/LBCOM/asm/studentview.jsp?mode=teacher&emailid=<%=session.getAttribute("emailid")%>&usertype=<%=session.getAttribute("logintype")%>&gradeid=<%=session.getAttribute("grade")%>";
}
function newPosition(){	
	parent.main.location.href="/LBCOM/asm/studentview.jsp?mode=student&show=no";
}

var email = '<%=session.getAttribute("emailid")%>';
var schoolid = '<%=session.getAttribute("schoolid")%>';

function handler(anc){
	setBgColor(document.getElementById(anc).parentNode);
	if(current_login!="Teacher"){
		current_login="Teacher";
		if(window.sview.closed!=true){
			//parent.main.location.href
			window.sview.parent.frames['main'].location="/LBCOM/asm/studentview.jsp?mode=teacher&emailid=<%=session.getAttribute("emailid")%>&usertype=<%=session.getAttribute("logintype")%>&gradeid=<%=session.getAttribute("grade")%>";
		}else{
			oldPosition();
			//alert("You have completely closed the student's view");
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
			parent.main.location.href="/LBCOM/DMS/index.jsp?type=teacher";
			break;
		case 'notice':
			parent.main.location.href="/LBCOM/nboards/TeacherNoticeFrame.jsp";//studentAdmin/PublicFrame.jsp?emailid="+email+"&schoolid="+schoolid;
			break;
		case 'courseware':
			parent.main.location.href="/LBCOM/coursemgmt/teacher/CoursesList.jsp";
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
			parent.main.location.href="/LBCOM/chat/LiveUsers.jsp?userid="+email;
			//parent.main.location.href="http://220.227.250.172/chat/samplea.php";
			break;
		case 'chat1':
			parent.topframe.chatwindow=window.open('ShowCourseBoards.jsp' ,'nmwindow','status=0,resizable=yes,toolbar=no,menubar=no,titlebar=no,scrollbars=yes,width=1022,height=768');
			
			
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
// Santhosh added here for chat

function winprint()
{
	alert("Hi");
	var w = 650;
	var h = 450;
	var l = (window.screen.availWidth - w)/2;
	var t = (window.screen.availHeight - h)/2;
	var sOption='toolbar=no,location=no,directories=no,menubar=no,scrollbars=yes,width=' + w + ',height=' + h + ',left=' + l + ',top=' + t;
	var sDivText =window.document.getElementById('divcontent').innerHTML;
	var objWindow = window.open('','Print',sOption);
	sDivText=sDivText.replace(/&lt;/g,'<');
	sDivText=sDivText.replace(/&gt;/g,'>');
	objWindow.document.write(sDivText);
	objWindow.document.close();
	//objWindow.print();
	//objWindow.close();
}
// Upto here
reDefineCells();

//-->
</SCRIPT>

</body>
</html>

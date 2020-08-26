<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar, java.text.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
String studentId="",schoolId="",teacherName="";
String query1="",query2="",status="",status1="",teacherId="";
String logoName="";
Connection con=null;
Statement st=null,st1=null;
ResultSet rs=null,rs1=null;
boolean flag=false;
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
	
	schoolId = (String)session.getAttribute("schoolid");
	studentId = (String)session.getAttribute("emailid");
	teacherId=request.getParameter("teacherid");
	session.setAttribute("originalteacherid",teacherId);
	if(teacherId==null)
	{
		teacherId="vstudent";
	}

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<META content="text/html; charset=UTF-8" http-equiv=content-type>
<LINK rel="shortcut icon" href="favicon.ico"><LINK rel=icon type=image/x-icon href="img/favicon.ico">
<LINK rel="shortcut icon" type=image/x-icon href="img/favicon.ico">
<!-- chat -->
<!-- Style Includes --><LINK id=jquery_ui_theme_loader 
rel=stylesheet type=text/css href="css/jquery-ui.css">
<!-- <LINK 
rel=stylesheet type=text/css 
href="http://fstoke.me/jquery/window/js/jquery/window/css/jquery.window.css">
<LINK 
rel=stylesheet type=text/css 
href="http://fstoke.me/jquery/window/js/jquery/codeview/css/jquery.codeview.css">
<LINK 
rel=stylesheet type=text/css 
href="http://fstoke.me/jquery/window/js/jquery/share/css/jquery.share.css">
<LINK 
rel=stylesheet type=text/css href="http://fstoke.me/jquery/window/index.css">
 -->
<!-- Upto here -->

<title>::  Learn Beyond ::</title>
<link href="/LBCOM/com/styles/studentcss.css" rel="stylesheet" type="text/css" />
<link href="/LBCOM/com/styles/form.css" rel="stylesheet" type="text/css" />

<!-- for chat -->
<link href="/LBCOM/studentAdmin/css/jquery.window.css" rel="stylesheet" type="text/css" />
<!-- upto here -->

<link rel="stylesheet" type="text/css" href="/LBCOM/com/styles/jquery.noty.css"/>
  <link rel="stylesheet" type="text/css" href="/LBCOM/com/styles/noty_theme_default.css"/>
  <link rel="stylesheet" type="text/css" href="/LBCOM/com/styles/noty_theme_twitter.css"/>
  <link rel="stylesheet" type="text/css" href="/LBCOM/com/styles/noty_theme_mitgux.css"/>
  <link rel="stylesheet" type="text/css" href="/LBCOM/com/styles/noty_theme_facebook.css"/>
  <link rel="stylesheet" type="text/css" href="/LBCOM/com/styles/noty_theme_growl.css"/>

<!-- Calender -->
<style>
			.cal_calendar {font-size:10pt;font-family:verdana;padding:0px;margin:0px;border:none; border-collapse:collapse;}
			.cal_header {background-color:#E4E4E4;padding:0px;margin:0px;border:none; border-collapse:collapse;}
			.cal_cell {padding:2px;margin:1px;border:0px groove;text-align:center;width:5ex}
			.cal_labelcell {padding:2px;margin:1px;border:0px groove;text-align:center;}
			.cal_oddweek {background-color:#E4E4E4;padding:0px;margin:0px;border:none; border-collapse:collapse;}
			.cal_evenweek {background-color:#E4E4E4;padding:0px;margin:0px;border:none; border-collapse:collapse;}

			.cal_day {width:5ex;text-align:center;padding:0px;margin:0px;border:none; border-collapse:collapse;cursor:hand;}
			.cal_today {color: #996600;font-size:10pt;font-weight:bolder;width:5ex;padding:0px;margin:0px;border:none; border-collapse:collapse;}
			.cal_disabled {color:#999999;width:5ex;padding:0px;margin:0px;border:none; border-collapse:collapse;}
			.cal_common {color:black;width:5ex;padding:0px;margin:0px;border:none; border-collapse:collapse;}
			.cal_holiday {color:red;width:5ex;padding:0px;margin:0px;border:none; border-collapse:collapse;}
			.cal_event {background-color:#7AA9F0;color:white;width:5ex;padding:0px;margin:0px;border:none; border-collapse:collapse;}
</style>
		<script type="text/javascript" src="/LBCOM/com/teacher/calendar/JS/calendar.js"></script>
		
	<script type="text/javascript" src="/LBCOM/com/teacher/calendar/JS/ajax.js"></script> 
	<!-- for getting shared events-->
	<script type="text/javascript" src="/LBCOM/com/teacher/calendar/JS/sharedevents.js"></script> 


	<script type="text/javascript" src="/LBCOM/com/teacher/calendar/calendar/epoch_classes.js"></script>
	<script type="text/javascript" src="/LBCOM/com/teacher/calendar/calendar/epoch_classes1.js"></script>
	<link rel="stylesheet" type="text/css" href="/LBCOM/com/teacher/calendar/calendar/epoch_styles.css" /> 
	<!-- Calendar upto here -->

<!-- For Course Material -->
<script type="text/javascript" src="/LBCOM/coursemgmt/student/js/jquery.min.js"></script>
<script type="text/javascript" src="/LBCOM/coursemgmt/student/js/jquery/jquery-ui-1.8.20.custom.min.js"></script>
<script type="text/javascript" src="/LBCOM/coursemgmt/student/js/jquery/window/jquery.window.min.js"></script>
<script type="text/javascript" src="/LBCOM/coursemgmt/student/js/custom.js"></script>

<link href="/LBCOM/coursemgmt/student/lbstyles/lbcss.css" rel="stylesheet" type="text/css" />
<link href="/LBCOM/coursemgmt/student/lbstyles/common.css" rel="stylesheet" type="text/css" />
<link href="coursestyle.css" rel="stylesheet" type="text/css" />
<link type="text/css" href="lbstyles/jquery.window.css" rel="stylesheet" />



<SCRIPT LANGUAGE="JavaScript">

function logout(){
	 window.location.href= "/LBCOM/common/Logout.jsp";
}
function DoActionChat(sId,tId)
{
	window.open("http://oh.learnbeyond.net/~oh/hcl/chat/student_online.php?emailid="+tId+"&schoolid="+sId+"","newtempwin","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
}
function DoActionLiveBoard(sId,tId)
{
	$("#nav_main li").removeClass('selected');showLoading('grid');$("#live_board").addClass('selected');grid_content.load("/LBCOM/WhiteBoard/student/StudentBoards.jsp?schoolid="+sId+"&emailid="+tId+"", hideLoading);
	
}
function tutorials()
{
	window.open('Video_Tutorials/TrainingTutorials.html' ,'nmwindow');
}
function listCourses(sId,tId)
{
	//window.location.reload();
	
	$("#nav_main li").removeClass('selected');showLoading('grid');$("#organizer_main").addClass('selected');grid_content.load("/LBCOM/coursemgmt/student/CourseHome.jsp", hideLoading);

}
function DoActionReport(sId,tId)
{
	window.open("https://parentaccess.access-k12.org/General/LoginPage.aspx?DistrictID=177","stupreport","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
}
</SCRIPT>
<script type="text/javascript">
	var sessid="<%=sessid%>";
	var schoolid="<%=(String)session.getAttribute("schoolid")%>";
	var studentid="<%=(String)session.getAttribute("emailid")%>";
	var classid="<%=(String)session.getAttribute("classid")%>";
	var start_cal;
	function tt() {
		
		
	start_cal = new Epoch('start_cal','flat',document.getElementById('cal'),false);
	start_cal_next = new Epoch1('start_cal1','flat',document.getElementById('cal_next'),false);
	var dt="";
		if(start_cal.selectedDates[0]!=null)
		dt=start_cal.selectedDates[0].dateFormat();
		else if(start_cal_next.selectedDates[0]!=null)
			{
				
				dt=start_cal_next.selectedDates[0].dateFormat();
			}
		else
		{
			today=new Date();
			dt=today.dateFormat();
		}
		
		addevent(dt);
	
	}
	//this function is used when we back with add event
	function tt(type,dt)
	{
		
		start_cal = new Epoch('start_cal','flat',document.getElementById('cal'),false);
		start_cal_next = new Epoch1('start_cal1','flat',document.getElementById('cal_next'),false);
		if(type=="day")
		{
			
			addevent(dt);
		}
		else if(type=="weak")
		{
			getWeak(dt);
		}
		else if(type=="month")
		{
			getMonth(dt);
		}
		else if(type=="allEvents")
		{
			getAllEvents();
		}
		else{
			var date="";
			if(start_cal.selectedDates[0]!=null)
			{
				dt=start_cal.selectedDates[0].dateFormat();
			}
			else if(start_cal_next.selectedDates[0]!=null)
			{
				
				dt=start_cal_next.selectedDates[0].dateFormat();
			}
			else
			{
				today=new Date();
				date=today.dateFormat();
			}
			addevent(date);
		}
	}

	function createevent()
	{
		
		var dt="";
		
		if(start_cal.selectedDates[0]!=null)
		dt=start_cal.selectedDates[0].dateFormat();
		else if(start_cal_next.selectedDates[0]!=null)
		dt=start_cal_next.selectedDates[0].dateFormat();
		else {
				var today=new Date();
				dt=today.dateFormat();
		}
		
		var c_page=document.getElementById("type").value;
				
		window.location.href='/LBCOM/com/teacher/calendar/JSP/addEventForm.jsp?sel_date='+dt+'&source='+c_page;
		
	}
//this function is back from Edit page
	function edit_page(uid,dt)
	{
		
		
		start_cal = new Epoch('start_cal','flat',document.getElementById('cal'),false);
		start_cal_next = new Epoch1('start_cal1','flat',document.getElementById('cal_next'),false);
		getEventDetails(uid,"day",dt);
	}

function hide(x)
{	
	//document.getElementById(x).style.display='none';
}

function createWindowWithRemotingUrl()
	{
		$.window({
			title: "Chat",
			//url: "http://demo.learnbeyond.com/~lbeyond/chat/teacher_online.php?emailid=<%=studentId%>&schoolid=<%=schoolId%>"
			url: "http://oh.learnbeyond.net/~oh/hcl/chat/student_online.php?emailid=student1&schoolid=lbeyond"
			});

	}
function exitSView(sId,tId)
{
	
	
	 window.location.href="/LBCOM/com/teacher/index.jsp?schoolid="+sId+"&mode=teacher&session=oldtonew&teacherid="+tId+"";	//window.open("/LBCOM/asm/studentview.jsp?mode=student&show=yes","sviewwin","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
}
	</script>

<!-- <script type="text/javascript" src="/LBCOM/common/left_frame/launch.js"></script> -->
<script type="text/javascript" src="/LBCOM/studentAdmin/stateMonitor.js"></script>
</head>
<body onload="tt();">

<!-- <body onload="tt();" oncontextmenu='return false;'> -->
<%
		query1="select S_status from form_access_group_level where form_id='F00003' and school_id='"+schoolId+"'";
		query2="select * from form_access_user_level where school_id='"+schoolId+"' and form_id='F00003' and uid='"+studentId+"' and utype='S'";
		con=con1.getConnection();
	    st=con.createStatement();
		rs=st.executeQuery(query1);
			if(rs.next())
			{
				status=rs.getString("S_status");
			}
			rs.close();
			st.close();
		if(status==null || status=="")
		{
			status1="000000000000";
		}
		st1=con.createStatement();
		rs1=st1.executeQuery(query2);
		if(rs1.next())
		{
			status1=rs1.getString("status");
			
		}
		rs1.close();
		st1.close();
		if(status1==null || status1=="")
		{
			status1="000000000000";
		}
		
		st=con.createStatement();
		rs=st.executeQuery("select * from cobrand_logo where school_id='"+schoolId+"'");
		 if(rs.next())
		{
			logoName=rs.getString("logo_name");
			flag=true;
			
		}
		if(flag==false)
		{
			logoName="facility_logo.JPG";

		}		
		rs.close();
		st.close();
		
%>
 <iframe name="usage" width="0" height="0"></iframe>
<div id="frames">	   
			<iframe name="studenttopframe" marginwidth="0" marginheight="0" scrolling="no" target="_self" height="0"></iframe>
			<iframe name="left" scrolling="no" marginwidth="0" marginheight="0" height="0"></iframe>
			<iframe name="main" scrolling="auto" height="0"></iframe>
	</div>
<div id="loading"><img src="/LBCOM/com/images/loading.gif" alt="Loading..." /></div>
<div id="wrapper" align="center">
  <div class="container" >
     <div class="header1"></div>
    <!--Header Info - Start -  -->
    <div class="header">
      <div class="logo"><img src="/LBCOM/com/images/logo.png" alt="logo" width="277" height="69" /></div>
	  <div class="logo" style="margin-top:10px; margin-left:462px;"><img src="../images/hsn/<%=logoName%>" width="219" height="50" border="0" title="<%=schoolId%>"/></div>
      <div class="global"><a href="#"  onClick="tutorials();"><img src="/LBCOM/studentAdmin/images/helpmanaual.png" alt="help" width="64" height="69"  border="0"/></a><div id="HCLInitiate" style="position:absolute; z-index:1; top: 40%; left:40%; visibility: hidden;"><a href="javascript:initiate_accept()"><img src="//www.hotschools.net/~mahoning/hcl/inc/skins/default/images/lh/initiate.gif" border="0"></a><br><!-- <a href="javascript:initiate_decline()"><img src="//www.hotschools.net/~mahoning/hcl/inc/skins/default/images/lh/initiate_close.gif" border="0"></a> --></div>
<!-- <script type="text/javascript" language="javascript" src="//www.hotschools.net/~mahoning/hcl/lh/live.php"></script> --></div>
 </div>

    <div class="header2"></div>
    <!--Header Info - End -  -->
	<%
		if(!teacherId.equals("vstudent"))
		{
		%><p align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">Hello&nbsp;<%=teacherId%>,&nbsp;currently in Student View.<a href="#"  onClick="exitSView('<%=schoolId%>','<%= teacherId%>');"> Click here to go back to teacher view.</a></font></p>
		<div class="clear"></div>
<%
		}
		%>

    
    <div class="content">
      <!--Main Menu Items - Start -  -->
      <div class="nav">
        <ul id="nav_main">
          <li id="courses_main" class="main_nav"><a href="#"  onClick="listCourses('<%=schoolId%>','<%= studentId%>');" >LIST OF COURSES</a></li>
     <%
		  
		  if(status.charAt(1)=='0' && status1.charAt(1)=='0')
		{
%>
		  <li id="calendar_main" class="main_nav">ORGANIZER</li>
<%}
			
			if(status.charAt(2)=='0' && status1.charAt(2)=='0')
			{
%>
				<li id="notice_main" class="main_nav">NOTICE BOARDS</li>
<%
			}

			if(status.charAt(3)=='0' && status1.charAt(3)=='0')
			{
%>		
			<li id="privatedocs_main" class="main_nav">PRIVATE DOCS</li>
<%		}
%>

          <!-- <li id="course_main" class="main_nav">COURSE MANAGEMENT</li> -->
<%         if(status.charAt(5)=='0' && status1.charAt(5)=='0')
				{
%>		
					<li id="grade_main" class="main_nav">GRADE BOOK</li>
<%			}

		if(status.charAt(8)=='0' && status1.charAt(8)=='0')
		{
%>
			<li id="dis_forum" class="main_nav">FORUMS</li>
<%
		}

		if(status.charAt(10)=='0' && status1.charAt(10)=='0')
		{
%>		
			<li id="live_board" class="main_nav"><a href="#"  onClick="DoActionLiveBoard('<%=schoolId%>','<%= studentId%>');" >LIVE BOARD</a></li>
<%	}
		if(status.charAt(9)=='0' && status1.charAt(9)=='0')
		{
%>
		  <li id="e_class" class="main_nav">E-CLASSROOM</li>

<%}
			if(status.charAt(6)=='0' && status1.charAt(6)=='0')
			{
%>
				<li id="chat" class="main_nav"><a href="#"  onClick="DoActionChat('<%=schoolId%>','<%=studentId%>');">CHAT</a></li>
<%		}
%>
			<li id="organizer_main" class="main_nav">DASHBOARD</li>
		
        </ul>
      </div>
      <!--Main Menu Items - End -  -->
	  
      <!--Logged Info - Start -  -->
      <div class="loginfo">Logged in as <span class="dtext" onclick="right_content_load('profile_but');"><%=studentId%></span> | <a href="javascript://" onclick="return logout();"><span class="dtext">Logout</span></a> </div>
      <div class="nav1"></div>
      <div class="nav3">&nbsp;</div>
      <div class="nav2"></div>
      <!--Logged Info - End -  -->
      <div class="formArea">
        <div class="formArea01">
          <!-- Chat Area Start -->
          <div id="Cform" >
            <div style="width:640px; text-align:right;">
              <div class="Ctext" >CHAT BOX</div>
              <a href="javascript:animatedcollapse.hide('Cform')"><img border="0" src="/LBCOM/com/images/deleteIcon.png" alt="del" style="padding:5px;" /></a></div>
            <div class="clear"></div>
            <div style=" width:640px; height:600px; padding:5px;" id="cform_content"></div>
          </div>
          <!-- Chat Area End -->
          <div class="formdetails" id="grid_content"></div>
        </div>
        <!-- FormArea 2 Starts here - This Area Loads the Secondary menu and Form items -->
        <div class="formArea02" id="right_bar">
          <!-- <div id="Sform" >
            <div style="width:245px; text-align:right;">
              <div class="Stext" id="sform_title" >&nbsp;</div>
              <a href="javascript:animatedcollapse.hide('Sform')"><img border="0" src="/LBCOM/com/images/deleteIcon.png" alt="del" style="padding:5px;" /></a></div>
            <div class="clear"></div>
            <div style=" height:350px; padding:5px; overflow-y:scroll;" id="sform_content"></div>
          </div> -->
          <!-- Dynamic Buttons Starts here - The button for each module loads here -->
          <div id="dynamicbutton" style="display:none1;">
		  <%
		  if(status.charAt(1)=='0' && status1.charAt(1)=='0')
		{
%>
		   <script>

			var refreshId = setInterval(function()
			{
				$('#dynamicbutton').toggle().load('StudentEvents.jsp').toggle();
			}, 100000);
			</script>
                <jsp:include page="StudentEvents.jsp" flush="true"/>
<%
		}
%>

            
            <!-- <div class="Sbuttons" id="event_but">ADD EVENT</div>
            <div class="Sbuttons" id="address_but">ADDRESS BOOK</div> -->
          </div>
          <!-- Dynamic Buttons  Ends here - The button for each module loads here -->
          <%
		if(status.charAt(0)=='0' && status1.charAt(0)=='0')
		{	
%>
		  <div class="Sbuttons" id="profile_but">PROFILE</div>
<%	}
%>
          <!-- <div class="Sbuttons" id="chat_but">CHAT</div> -->
          <%
		if(status.charAt(7)=='0' && status1.charAt(7)=='0')
		{
%>		
				<script>

					var refreshId = setInterval(function()
					{
						$('#email_but').toggle().load('EmailAlerts.jsp').toggle();
					}, 100000);

				</script> 
			<div class="Sbuttons" id="email_but">EMAIL</div>
<%
		}
	if(status.charAt(11)=='0' && status1.charAt(11)=='0')
		{
%>
			<div class="Sbuttons" id="progress_but"><a href="#"  onClick="DoActionReport('<%=schoolId%>','<%=studentId%>');">PROGRESSBOOK</a></div>
       
		<%
		}	

%>
 </div>
        <!-- FormArea 2 Ends here - This Area Loads the Secondary menu and Form items -->
      </div>
    </div>
  </div>
  <div class="footer">
    <div class="fcrnr001"></div>
    <div class="fbg"></div>
    <div class="fcrnr002"></div>
    <div class="fDetails">Learnbeyond © 2012   |  Privacy policy  |  Terms & Conditions Powered by Learnbeyond</div>
  </div>
</div>
<div id="ichatSFrame" style="display:inline">
<script type="text/javascript" src="/LBCOM/com/js/jquery.min.js"></script>
<script type="text/javascript" src="/LBCOM/com/js/animatedcollapse.js"></script>
<script type="text/javascript" src="/LBCOM/com/js/student_content_load.js"></script>
 <script type="text/javascript" src="/LBCOM/com/js/jquery.form.js"></script>



<script src="/LBCOM/com/js/jquery-1.7.2.min.js"></script>
<!-- <script type="text/javascript" src="/LBCOM/com/js/jquery.noty.js"></script> -->


<%
		  
}
	  catch(Exception e){
		ExceptionsFile.postException("Student Index.jsp","operations on database","Exception",e.getMessage());	 
		System.out.println("Error:  -" + e.getMessage());

	}

	finally{
		try{
			
				if(st1!=null)
				st1.close();                //finally close the statement object
			if(st!=null)
				st.close();		
			if(con!=null)
				con.close();
		}catch(SQLException se){
			ExceptionsFile.postException("Student Index.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println(se.getMessage());
		}
	}
	%>
	<div class="container" id="emailalert"></div>

	
<SCRIPT type="text/javascript">
		try {
		var pageTracker = _gat._getTracker("UA-4293992-5");
		pageTracker._trackPageview();
		} catch(err) {}</SCRIPT>
<!-- upto here -->
<script>
document.getElementById("ichatSFrame").innerHTML = "<iframe src='http://oh.learnbeyond.net/~oh/hcl/chat/student_online1.php?emailid=<%=session.getAttribute("emailid")%>&schoolid=<%=session.getAttribute("schoolid")%>' width='1px' height='1px'></iframe>";
</script>
</body>
</html>

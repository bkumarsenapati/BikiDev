<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar, java.text.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
String teacherId="",schoolId="",teacherName="",logoName="",grade="",className="";
String sessState="",query1="",query2="",status="",status1="";
boolean flag=false;
Connection con=null;
Statement st=null,st1=null;
ResultSet rs=null,rs1=null;
Hashtable classNames=null;
Hashtable gradeTags=null;
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
	sessState=(String)session.getAttribute("sessionstatus");
	if(sessState==null)
	{
		System.out.println("**************sessionstatus...IF");
		session.setAttribute("originalschoolid",(String)session.getAttribute("schoolid"));
		session.setAttribute("originalemailid",(String)session.getAttribute("emailid"));
		session.setAttribute("originalclassid",(String)session.getAttribute("classid"));
	}
	System.out.println("*************sessionstatus...ELSE");
	schoolId = (String)session.getAttribute("schoolid");
	teacherId = (String)session.getAttribute("emailid");
	if(teacherId.equals("C000_vstudent"))
	{
		teacherId=(String)session.getAttribute("originalteacherid");
		session.setAttribute("emailid",teacherId);
		
	}

	teacherName = (String)session.getAttribute("firstname");

	grade=request.getParameter("classid");
	className=request.getParameter("classname");
		
	   
	if (grade==null)
	{
		grade=(String)session.getAttribute("classid");
	}
	
	classNames=new Hashtable();
	gradeTags=new Hashtable();


	query1="select T_status from form_access_group_level where form_id='F00004' and school_id='"+schoolId+"'";
	query2="select * from form_access_user_level where school_id='"+schoolId+"' and form_id='F00004' and uid='"+teacherId+"' and utype='T'";
		con=con1.getConnection();
	    st=con.createStatement();
		rs=st.executeQuery(query1);
			if(rs.next())
			{
				status=rs.getString("T_status");
			}
			rs.close();
			st.close();
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
			status1="000000000000000";
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


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="Sat, 01 Dec 2001 00:00:00 GMT">
<title>::  Learnbeyond ::</title>
<link href="../styles/teachcss.css" rel="stylesheet" type="text/css" />
<link href="../styles/form.css" rel="stylesheet" type="text/css" />
<!-- Calender -->
<style>
			.cal_calendar {font-size:10pt;font-family:verdana;padding:0px;margin:0px;border:none; border-collapse:collapse;}
			.cal_header {background-color:#CAD9FA;padding:0px;margin:0px;border:none; border-collapse:collapse;}
			.cal_cell {padding:2px;margin:1px;border:0px groove;text-align:center;width:5ex}
			.cal_labelcell {padding:2px;margin:1px;border:0px groove;text-align:center;}
			.cal_oddweek {background-color:#CAD9FA;padding:0px;margin:0px;border:none; border-collapse:collapse;}
			.cal_evenweek {background-color:#CAD9FA;padding:0px;margin:0px;border:none; border-collapse:collapse;}

			.cal_day {width:5ex;text-align:center;padding:0px;margin:0px;border:none; border-collapse:collapse;cursor:hand;}
			.cal_today {color: #996600;font-size:10pt;font-weight:bolder;width:5ex;padding:0px;margin:0px;border:none; border-collapse:collapse;}
			.cal_disabled {color:#999999;width:5ex;padding:0px;margin:0px;border:none; border-collapse:collapse;}
			.cal_common {color:black;width:5ex;padding:0px;margin:0px;border:none; border-collapse:collapse;}
			.cal_holiday {color:red;width:5ex;padding:0px;margin:0px;border:none; border-collapse:collapse;}
			.cal_event {background-color:#7AA9F0;color:white;width:5ex;padding:0px;margin:0px;border:none; border-collapse:collapse;}
</style>
		<script type="text/javascript" src="/LBCOM/com/teacher/calendar/JS/calendar.js"></script>
<script type="text/javascript" src="/LBCOM/common/left_frame/launch.js"></script>		
 <script type="text/javascript" src="/LBCOM/com/teacher/calendar/JS/ajax.js"></script>
	<!-- for getting shared events-->
	<script type="text/javascript" src="/LBCOM/com/teacher/calendar/JS/sharedevents.js"></script>


<script type="text/javascript" src="/LBCOM/com/teacher/calendar/calendar/epoch_classes.js"></script>
	<script type="text/javascript" src="/LBCOM/com/teacher/calendar/calendar/epoch_classes1.js"></script>
	<link rel="stylesheet" type="text/css" href="/LBCOM/com/teacher/calendar/calendar/epoch_styles.css" />
	<!-- Calendar upto here -->
<style>
a {
	color:#3189c5;
	text-decoration:underline;
}

a:hover {
	text-decoration:none;
	color:#000;
}
</style>
<script type="text/javascript">
            
            $(document).ready(function() {
               
                $('#chat').click(function(e) {
                    
                    e.preventDefault();
                                        
                    $.ajax({
                        url: "ChatStatus.jsp",
                        type: "post",
                        data: "teacherid=<%=teacherId%>&schoolid=<%=schoolId%>",
                        cache: false,
                        success: function(data) {
                          
                                    
                                  $("#savee").val("save");  
                            
                            $("#message").html(data).slideDown('slow');
                        }
                    });
                });
            });
        </script>
<script>

var refreshId = setInterval(function()
{
	$('#dynamicbutton').toggle().load('Events.jsp').toggle();
}, 10000);
</script>
<SCRIPT LANGUAGE="JavaScript">
var lbcmscb=null;
function logout()
{
	
	if(lbcmscb!=null && !lbcmscb.closed)
	{
		lbcmscb.close();
	}
	window.location.href= "/LBCOM/common/Logout.jsp";
}
function DoActionChat(sId,tId)
{
	
	//$("#nav_main li").removeClass('selected');showLoading('grid');$("#organizer_main").addClass('selected');grid_content.load("http://demo.learnbeyond.com/~lbeyond/chat/teacher_online.php?emailid=bnayini&schoolid=lbeyond", hideLoading);
	window.open("http://oh.learnbeyond.net/~oh/hcl/chat/teacher_online.php?emailid="+tId+"&schoolid="+sId+"","newtempwin","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
}
function DoActionCMS(sId,tId)
{
	window.open("/LBCOM/coursedeveloper/ValidateUser.jsp?userid="+tId+"&schoolid="+sId+"","cbuilderwin","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
}
function DoActionLBCMS(sId,tId)
{var win;
	win=window.open("/LBCOM/lbcms/ValidateUser.jsp?userid="+tId+"&schoolid="+sId+"","lbcmsbuilderwin","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
	lbcmscb=win;
}
function usermanual(){
	usermanualwindow=window.open("/LBCOM/manuals/educator_UG/","UserManual","resizable=yes,scrollbars,toolbars=no");
}
function DoActionPRGSBOOK(sId,tId)
{
	window.open("https://parentaccess.access-k12.org","preportwin","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
}
function DoActionSView(sId,tId)
{
	
	
	 window.location.href="/LBCOM/asm/studentview.jsp?mode=student&show=yes&teacherid="+tId+"";	//window.open("/LBCOM/asm/studentview.jsp?mode=student&show=yes","sviewwin","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
}
</SCRIPT>
<script type="text/javascript">
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
		//alert(c_page);
		
		window.location.href='/LBCOM/com/teacher/calendar/JSP/addEventForm.jsp?sel_date='+dt+'&source='+c_page;
		
	}
//this function is back from Edit page
	function edit_page(uid,dt)
	{
		
		
		start_cal = new Epoch('start_cal','flat',document.getElementById('cal'),false);
		start_cal_next = new Epoch1('start_cal1','flat',document.getElementById('cal_next'),false);
		getEventDetails(uid,"day",dt);
	}

	</script>
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
<body>
<form name="courselist">
 <iframe name="usage" width="0" height="0"></iframe>
<div id="loading"><img src="../images/loading.gif" alt="Loading..." /></div>
<div id="wrapper" align="center">
  <div class="container" >
    <!--Header Info - Start -  -->
    <div class="header1"></div>
     <div class="header">
      <div class="logo"><img src="/LBCOM/com/images/logo.png" alt="logo" width="277" height="69" /></div>
	  <div class="logo" style="margin-top:10px; margin-left:462px;"><img src="/LBCOM/images/hsn/<%=logoName%>" width="219" height="59" border="0" title="<%=schoolId%>"/></div>
      <div class="global"><a href="#"  onClick="tutorials();"><img src="/LBCOM/com/images/helpmanaual.png" alt="help" width="64" height="69"  border="0"/></a><!-- <img src="/LBCOM/com/images/livehelp.png" alt="live" width="64" height="69" />  -->
	  
	  
	  <!-- <div id="HCLInitiate" style="position:absolute; z-index:1; top: 40%; left:40%; visibility: hidden;"><a href="javascript:initiate_accept()"><img src="//demo.learnbeyond.com/~lbeyond/hcl/inc/skins/default/images/lh/initiate.gif" border="0"></a><br><a href="javascript:initiate_decline()"><img src="//demo.learnbeyond.com/~lbeyond/hcl/inc/skins/default/images/lh/initiate_close.gif" border="0"></a></div>

<script type="text/javascript" language="javascript" src="//demo.learnbeyond.com/~lbeyond/hcl/lh/live.php"></script>  -->
</div>
 </div>
     <div class="header2"></div>
    <!--Header Info - End -  -->
    <div class="clear"></div>
    <div class="content">
	<!--Main Menu Items - Start -  -->
      <div class="nav">
        <ul id="nav_main">
          <li id="organizer_main" class="main_nav">COURSES</li>
          <%
			if(status.charAt(1)=='0' && status1.charAt(1)=='0')
		{
%>

		  <li id="calendar_main" class="main_nav">ORGANIZER</li>
<%
		}
			if(status.charAt(2)=='0' && status1.charAt(2)=='0')
		{
%>
		  <li id="notice_main" class="main_nav">NOTICE BOARD</li>
<%	}
			if(status.charAt(3)=='0' && status1.charAt(3)=='0')
		{
%>
          <li id="privatedocs_main" class="main_nav">PRIVATE DOCS</li>
<!--           <li id="course_main" class="main_nav">COURSE MANAGEMENT</li> -->
<%	}
			if(status.charAt(6)=='0' && status1.charAt(6)=='0')
		{
%>
		  <li id="grade_main" class="main_nav">GRADE BOOK</li>
		  <li id="dis_forum" class="main_nav">FORUMS</li>
		  <li id="live_board" class="main_nav">LIVE BOARD</li>
		  <li id="e_class" class="main_nav">E-CLASSROOM</li>
		  <%}
			if(status.charAt(8)=='0' && status1.charAt(8)=='0')
		{
%>
		  <li id="chat" class="main_nav"><a href="#"  onClick="DoActionChat('<%=schoolId%>','<%= teacherId%>');" >CHAT</a><div id="chatstatus"><a><input id="savee" type="image" value="save"  src="images/chat_off.png"/></a></div></li>
		  	<%}
	
			
%>
        </ul>
      </div>
      <!--Main Menu Items - End -  -->
	  
      <!--Logged Info - Start -  -->
      <div class="loginfo">Logged in as <span class="dtext" onclick="right_content_load('profile_but');"><%=teacherName%></span> | <a href="javascript://" onclick="return logout();"><span class="dtext">Logout</span></a> </div>
       <div class="nav1"></div>
      <div class="nav3">&nbsp;</div>
      <div class="nav2"></div>
      <!--Logged Info - End -  -->
      <div class="formArea">
        <div class="formArea01">
          
          <div class="formdetails" id="grid_content"></div>
        </div>
        <!-- FormArea 2 Starts here - This Area Loads the Secondary menu and Form items -->
        <div class="formArea02" id="right_bar">
        <!--   <div id="Sform" >
            <div style="width:245px; text-align:right;">
              <div class="Stext" id="sform_title" >&nbsp;</div>
              <a href="javascript:animatedcollapse.hide('Sform')"><img border="0" src="../images/deleteIcon.png" alt="del" style="padding:5px;" /></a></div>
            <div class="clear"></div>
            <div style=" height:350px; padding:5px; overflow-y:scroll;" id="sform_content"></div>
          </div> -->
          <!-- Dynamic Buttons Starts here - The button for each module loads here -->
		  <div id="dynamicbutton" style="display:none1;">
         <jsp:include page="Events.jsp" flush="true"/>


		  </div>
          <!-- Dynamic Buttons  Ends here - The button for each module loads here -->
<%
		if(status.charAt(0)=='0' && status1.charAt(0)=='0')
		{	
%>
		 <!--  <div class="Sbuttons" id="profile_but">PROFILE</div> -->
<%
		}
		if(status.charAt(9)=='0' && status1.charAt(9)=='0')
		{
%>
			<script>

			var refreshId = setInterval(function()
			{
				$('#email_but').toggle().load('TeachEmailAlerts.jsp').toggle();
			}, 1000);

			</script> 
		  <div class="Sbuttons" id="email_but">EMAIL</div>
<%
		}
		if(status.charAt(5)=='0' && status1.charAt(5)=='0')
		{
%>
		  <div class="Sbuttons" id="cb_bulder"><a href="#"  onClick="DoActionCMS('<%=schoolId%>','<%= teacherId%>');" >COURSE BUILDER</a></div>

		  <div class="Sbuttons" id="lbcms_bulder"><a href="#"  onClick="DoActionLBCMS('<%=schoolId%>','<%= teacherId%>');" >LBCMS</a></div>
<%	}
	if(status.charAt(7)=='0' && status1.charAt(7)=='0')
		{
%>
	<div class="Sbuttons" id="sview"><a href="#"  onClick="DoActionSView('<%=schoolId%>','<%= teacherId%>');">STUDENT VIEW</a></div>
<%}
		if(status.charAt(7)=='0' && status1.charAt(7)=='0')
	{
%>

	<div class="Sbuttons" id="pdgs_book"><a href="#"  onClick="DoActionPRGSBOOK('<%=schoolId%>','<%= teacherId%>');" >PROGRESSBOOK</div>
	
	<%}
	
%>


		  <!-- Chat Area Start -->
          <!-- <div class="Sbuttons" id="chat_but" >
            <div style="width:640px; text-align:right;">
              <div class="Ctext" >CHAT BOX</div>
              <a href="javascript:animatedcollapse.hide('Cform')"><img border="0" src="../images/deleteIcon.png" alt="del" style="padding:5px;" /></a></div>
            <div class="clear"></div>
            <div style=" width:640px; height:600px; padding:5px;" id="cform_content"></div>
          </div> -->
          <!-- Chat Area End -->
        </div>
        <!-- FormArea 2 Ends here - This Area Loads the Secondary menu and Form items -->
		
      </div>
    </div>
	
  </div>
<!--  <div class="chatbox" id="chat"> <iframe src="http://demo.learnbeyond.com/~lbeyond/chat/teacher_online.php?emailid=bnayini&schoolid=lbeyond" width="100%" height="100px" frameborder="0"></iframe></div> -->
  <div class="footer">
    <div class="fcrnr001"></div>
    <div class="fbg"></div>
    <div class="fcrnr002"></div>
    <div class="fDetails">Learnbeyond © 2012   |  Privacy policy  |  Terms & Conditions Powered by - Learnbeyond</div>
  </div>
</div>
<div id="ichatFrame" style="display:inline">
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/animatedcollapse.js"></script>
<script type="text/javascript" src="../js/content_load.js"></script>
<script type="text/javascript" src="../js/jquery.form.js"></script>
<%
		  
}
	  catch(Exception e){
		ExceptionsFile.postException("Teacher Index.jsp","operations on database","Exception",e.getMessage());	 
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
			ExceptionsFile.postException("Teacher Index.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println(se.getMessage());
		}
	}
	%>
	<script>
document. getElementById("ichatFrame"). innerHTML = "<iframe src='http://oh.learnbeyond.net/~oh/hcl/chat/teacher_online1.php?emailid=<%=session.getAttribute("emailid")%>&schoolid=<%=session.getAttribute("schoolid")%>' width='1px' height='1px'></iframe>";
</script>
</form>
</body>
</html>

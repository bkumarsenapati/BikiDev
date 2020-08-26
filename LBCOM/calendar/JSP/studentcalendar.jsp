<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/TR/xhtml1/strict">
	<head>
		<meta http-equiv="Content-Type" content="text/xhtml; charset=utf-8"/>
		<script type="text/javascript" src="../JS/calendar.js"></script>
		
	<script type="text/javascript" src="../JS/studentView.js"></script> 
	<!-- for getting shared events-->
	<script type="text/javascript" src="../JS/sharedevents_st.js"></script> 


	<script type="text/javascript" src="../calendar/epoch_classes.js"></script>
	<script type="text/javascript" src="../calendar/epoch_classes1.js"></script>
	<link rel="stylesheet" type="text/css" href="../calendar/epoch_styles.css" /> 
	
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
		
		window.location.href='addEventForm.jsp?sel_date='+dt+'&source='+c_page;
		
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
	document.getElementById(x).style.display='none';
}

	</script>
	</head>
	<%
	if(request.getParameter("type")!=null)
	{
		
		if(request.getParameter("type").equals("editpage"))
		{
			
			%>
			<Body onload="edit_page('<%=request.getParameter("uid")%>','<%=request.getParameter("sdate")%>')">
			<%
		}else{
	%>
	<Body onload="tt('<%=request.getParameter("type")%>','<%=request.getParameter("dt")%>')">
	<%
	}
	}else{
	%>
	<Body onload="tt();hide('cal');hide('cal_next');">
	<%}%>
	<form method="" name="ff" action="#">
	<table border="0" cellpadding="0" cellspacing="0" valign="top" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" height="100%" >
	<tr>
	<td width="100%" valign="top" align="left" height="20%">
	<table border="0" width="60%">
	<tr>
	<td width="12%" valign="top" align="center" height="20%">
	<a href="#" onclick="return createevent()" style="font-family: Arial;text-decoration:none;">
	<img src="../images/cal_compose.png" width="32" height="32" border="0" alt="Add Event">
	</a>
	</td><td width="3%">&nbsp;&nbsp;</td>
	<td width="12%" valign="top" align="center" height="20%">
	<a href="#" onclick="addevent();" style="font-family: Arial;text-decoration:none;">
	<img src="../images/cal_day.png" width="32" height="32" border="0" alt="Day view">
	</a>
	</td><td width="3%">&nbsp;&nbsp;</td>
	<td width="12%" valign="top" align="center" height="20%">
	<a href="#" onclick="getWeak('null');" style="font-family: Arial;text-decoration:none;">
	<img src="../images/cal_week.png" width="32" height="32" border="0" alt="Weak view">
	</a>
	</td><td width="3%">&nbsp;&nbsp;</td>
	<td width="12%" valign="top" align="center" height="20%">
	<a href="#" onclick="getMonth('null');" style="font-family: Arial;text-decoration:none;">
	<img src="../images/cal_month.png" width="32" height="32" border="0" alt="Month view">
	</a>
	</td>
	<td width="3%">&nbsp;&nbsp;</td>
	<td width="12%" valign="top" align="center" height="20%">
	<a href="#" onclick="getAllEvents();" style="font-family: Arial;text-decoration:none;">
	<img src="../images/cal_group.png" width="32" height="32" border="0" alt="All events">
	</a>
	</td>
	<td width="3%">&nbsp;&nbsp;</td>
	<td width="12%" valign="top" align="center" height="20%">
	<a href="#" onclick="getSharedEvents();" style="font-family: Arial;text-decoration:none;">
	<img src="../images/cal_group.png" width="32" height="32" border="0" alt="All events">
	</a>
	</td>
	<td width="3%">&nbsp;&nbsp;</td>
	<td width="12%" valign="top" align="center" height="20%">
	<div width="12%" id="refresh"></div>
	</td>

	</tr>
	<tr>
	<td width="12%" valign="top" align="center" height="20%">
	<a href="#" onclick="return createevent()" style="font-family: Arial;text-decoration:none;font-size:8pt;">
	New Event
	</a>
	</td><td width="3%">&nbsp;&nbsp;</td>
	<td width="12%" valign="top" align="center" height="20%">
	<a href="#" onclick="addevent();" style="font-family: Arial;text-decoration:none; font-size:8pt;">
	Day View
	</a>
	</td><td width="3%">&nbsp;&nbsp;</td>
	<td width="12%" valign="top" align="center" height="20%">
	<a href="#" onclick="getWeak('null');" style="font-family: Arial;text-decoration:none;font-size:8pt;">
	Week View
	</a>
	</td><td width="3%">&nbsp;&nbsp;</td>
	<td width="12%" valign="top" align="center" height="20%">
	<a href="#" onclick="getMonth('null');" style="font-family: Arial;text-decoration:none;font-size:8pt;">
	Month View
	</a>
	</td><td width="3%">&nbsp;&nbsp;</td>
	<td width="12%" valign="top" align="center" height="20%">
	<a href="#" onclick="getAllEvents();" style="font-family: Arial;text-decoration:none;font-size:8pt;">
	All Events
	</a>
	</td>
	</td><td width="3%">&nbsp;&nbsp;</td>
	<td width="12%" valign="top" align="center" height="20%">
	<a href="#" onclick="getSharedEvents();" style="font-family: Arial;text-decoration:none;font-size:8pt;">
	Shared Events
	</a>
	</td><td width="3%">&nbsp;&nbsp;</td>
	<td width="12%" valign="top" align="center" height="20%">
	<div width="12%" id="rtext"></div>
		</td>

	</tr>
	</table>
	</td>
	</tr>
	  <!-- <tr>
            <td width="100%" valign="top" height="80%">
        <table border="1" cellpadding="0" cellspacing="0" valign="top"   width="100%" id="AutoNumber1" height="100%">
          <tr>
            <td width="16%" valign="top">
           <table border="0" cellpadding="0" cellspacing="0" valign="top" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber2">
              <tr>
                <td width="100%" height="50%" valign="top">
				<div width="100%" id="cal">
				</div>
		&nbsp;</td>
              </tr>
			  <tr>
                <td width="100%" height="50%" valign="top">
				<div width="100%" id="cal_next">
				</div>
		&nbsp;</td>
              </tr> -->
            </table>
            </td>
            <td width="74%" valign="top" height="100%">
            <!-- <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="70%" id="AutoNumber3" height="10">
              <tr>
                <td align="center"><a href="#" onclick="addevent();">Day</a></td>
                <td align="center"> <a href="#" onclick="getWeak('null');">Weak</a></td>
                <td align="center"> <a href="#" onclick="getMonth('null');">Month</a></td>
                <td align="center"><a href="#" onclick="getAllEvents();">Event</a></td>
              </tr>
            </table> -->
            <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" height="90%" id="AutoNumber4" bgcolor="#9db38a">
              <tr>
                <td width="100%" height="20%" bgcolor="#9db38a">
					<table width="100%" >
					<tr><td align="left"><div id="back">&nbsp;</div> </td>
						<td align="right"><div id="weak"></div> </td>
						<td align="right"><div id="date"></div></td>
					</tr>
					</table>
				</td>
              </tr>
              
			  <tr>
                <td width="100%" height="65%" ><div id="data" height="100%"></div></td>
              </tr>
            </table>
            </td>
          </tr>		  
        </table>
        </td></tr>
		</table>
		<div width="100%" id="cal">
				</div>
				<div width="100%" id="cal_next">&nbsp;
				</div>
		<div id="type"></div>
		</form>
	</body>
</html>
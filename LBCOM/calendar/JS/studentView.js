var v="";
var tp=""
var result="";
var Viewtype="";
var result_share="";
var http = getHTTPObject();
function getHTTPObject() {
	var xmlhttp;
	if (window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	
		return xmlhttp;
}

//this is for display the event details
function getEventHandler_result() {
	
	if (http.readyState == 4) {
		
	if (http.status==200){
		
		var message=http.responseXML.getElementsByTagName("root");
		
			result="<center><table width=\"90%\">";
			
			
			for(i=0; i<message.length;i++)
			{
				v=message[i].getElementsByTagName('data');
				
				for(j=0;j<v.length;j++)
				{
					var sdate=v[j].getElementsByTagName('start_date')[0].firstChild.nodeValue;
					var uid=v[j].getElementsByTagName('id')[0].firstChild.nodeValue;
					var stime=v[j].getElementsByTagName('start_time')[0].firstChild.nodeValue;
					var etime=v[j].getElementsByTagName('end_time')[0].firstChild.nodeValue;

					var edate=v[j].getElementsByTagName('end_date')[0].firstChild.nodeValue;
					var day_name=v[j].getElementsByTagName('day')[0].firstChild.nodeValue;
					var loc=v[j].getElementsByTagName('location')[0].firstChild.nodeValue;
					var users=v[j].getElementsByTagName('users')[0].firstChild.nodeValue;
					var title=v[j].getElementsByTagName('title')[0].firstChild.nodeValue;
					var desp=v[j].getElementsByTagName('desp')[0].firstChild.nodeValue;
					var day=sdate.substring(sdate.lastIndexOf("-")+1);
					
					if(users=='null' )
						users="";
					result+="<tr><td align=\"left\" width=\"29%\" height=\"31\">Event on</td><td width=\"1%\" height=\"31\" colspan=\"2\"><p align=\"right\">:</td>";
					if(title=='null')
						result+="<td align=\"left\" width=\"82%\" height=\"31\"> </td></tr>";
					else
					result+="<td align=\"left\" width=\"82%\" height=\"31\"><font face=\"Arial\" style=\"font-size: 12px;\">"+title+"</td></tr>";

					if(stime=='null')
						stime="";
					if(sdate=="null")
						sdate="";
					result+="<tr><td align=\"left\" width=\"16%\" height=\"50\" rowspan=\"2\" valign=\"top\">Dates </td><td align=\"left\" width=\"2%\" height=\"50\" rowspan=\"2\" colspan=\"2\" valign=\"top\"><p align=\"right\">:</td><td align=\"left\" width=\"82%\" height=\"13\">";
					
					result+="<font face=\"Arial\" style=\"font-size: 12px;\">Start date &amp; Time&nbsp; :"+change_dt_format_norm(sdate)+"&nbsp;"+stime+"</font></td></tr>";

					if(etime=='null')
						etime="";
					if(edate=='null')
						edate="";

						result+="<tr><td align=\"left\" width=\"82%\" height=\"37\"><font face=\"Arial\" style=\"font-size: 12px;\">End date &amp; Time&nbsp; :"+change_dt_format_norm(edate)+"&nbsp"+etime+"</font></td></tr>";
					

					if(loc=='null')
					loc="";
					result+="<tr><td align=\"left\" width=\"16%\" height=\"19\">Location</td><td width=\"2%\" height=\"19\" colspan=\"2\"><p align=\"right\">:</td> <td align=\"left\" width=\"82%\" height=\"19\"><font face=\"Arial\" style=\"font-size: 12px;\">"+loc+"</font></td></tr>";

					if(desp=='null')
						desp="";
						result+="<tr><td align=\"left\" width=\"16%\" height=\"19\">Description</td>      <td width=\"2%\" height=\"19\" colspan=\"2\"><p align=\"right\">:</td>";
					result+="<td align=\"left\" width=\"82%\" height=\"38\" ><font face=\"Arial\" style=\"font-size: 12px;\">"+desp+"</font></td></tr>";

					if(users=='null')
						result+="";
					if(Viewtype!="shared")
					{
						result+="<tr><td align=\"left\" width=\"16%\" height=\"19\">Shared to</td>      <td width=\"2%\" height=\"19\" colspan=\"2\"><p align=\"right\">:</td>";
					result+="<td align=\"left\" width=\"82%\" height=\"38\" ><font face=\"Arial\" style=\"font-size: 12px;\">"+users+"</font></td></tr>";
					}
					result+="<tr><td align=\"left\" width=\"16%\" height=\"19\">&nbsp;</td><td align=\"left\" width=\"2%\" height=\"19\" colspan=\"2\">&nbsp;</td></tr>";
					if(Viewtype!="shared")
					{
					result+="<tr><td width=\"100%\" height=\"19\" colspan=\"4\" align=\"center\"><a href=\"#\" onclick=\"redirect('EditEvent.jsp?uid="+uid+"')\"><font face=\"Arial\" style=\"font-size: 12px;\">Edit</font></a></td></tr>";
					}
				}

			}
			result+="</table></center>";
		var v=result;
		
		document.getElementById("data").innerHTML=v;
		
	}
	}
}

function addEventHandler() {
	
	if (http.readyState == 4) {
	if (http.status==200){
	
		var message=http.responseXML.getElementsByTagName("root");
	var sdate="";
			result="<table width=100%>";
			result+="<tr><td width=\"10%\" bgcolor=\"#546878\" align=\"center\"> <td width=\"90%\" bgcolor=\"#546878\">";
			result+="<table width=\"100%\"><tr><td width=\"20%\" align=\"left\"><font color=\"#FFFFFF\" face=\"Arial\" style=\"font-size: 12px;\"><b>Starting at</b></font></td>    <td width=\"20%\"  align=\"left\"><font face=\"Arial\" color=\"#FFFFFF\" style=\"font-size: 12px;\"><b>Ending at</b></font></td>    <td width=\"20%\" align=\"left\"><font color=\"#FFFFFF\" face=\"Arial\" style=\"font-size: 12px;\"><b>Title</b></font></td>    <td   width=\"20%\" align=\"left\"><font color=\"#FFFFFF\" face=\"Arial\" style=\"font-size: 12px;\"><b>Created by</b></font></td><td width=\"20%\"   align=\"left\"><font color=\"#FFFFFF\" face=\"Arial\" style=\"font-size: 12px;\"><b>Shared to</b></font></td></tr></table></td></tr>";
			result_share=result;
			var count=0;
			for(i=0; i<message.length;i++)
			{
				
				
				
					v=message[i].getElementsByTagName('data');
				var day_name=message[i].getElementsByTagName('day')[0].firstChild.nodeValue;
				var  mnt=message[i].getElementsByTagName('month')[0].firstChild.nodeValue;
					
				var month_name="";getMonth_name(parseInt()-1);

				var yr=message[i].getElementsByTagName('year')[0].firstChild.nodeValue;
				var day=message[i].getElementsByTagName('dt')[0].firstChild.nodeValue;

				var type="day";
				
					//top_date=message[i].getElementsByTagName('tdate')[0].firstChild.nodeValue;
				if(day=='null')
				{
					type="allEvents";
					day="";
				}
				if(mnt=='null')
				{
					
					day_name="";
				}
				else{
					
					month_name=getMonth_name(parseInt(mnt)-1);
				}
				if(month_name=='null')
				{
					month="";
				}
				if(yr=='null')
					yr="";
				if(mnt=='null')
				{
				result+="<tr><td  width=\"10%\" height=\"50\" align=\"center\" valign=\"top\"></td><td width=\"90%\" height=\"50\"><table width=\"100%\">";
				}
				else{
					result+="<tr><td bgcolor=\"#CCCCCC\" width=\"10%\" height=\"50\" align=\"center\" valign=\"top\"><font face=\"Arial\" style=\"font-size: 12px;\" color=\"white\" style=\"bold\">"+month_name+" "+day+"' "+yr.substring(2)+"<br\>"+day_name+"</td><td width=\"90%\" height=\"50\"><table width=\"100%\">";
				}
				var test=v.length;
				for(j=0;j<v.length;j++)
				{
					count++;
					sdate=v[j].getElementsByTagName('start_date')[0].firstChild.nodeValue;
					var uid=v[j].getElementsByTagName('id')[0].firstChild.nodeValue;
					
					var stime=v[j].getElementsByTagName('start_time')[0].firstChild.nodeValue;
					if(stime=='Time')
						stime="";
					var etime=v[j].getElementsByTagName('end_time')[0].firstChild.nodeValue;
					
					var edate=v[j].getElementsByTagName('end_date')[0].firstChild.nodeValue;
					if(etime=='Time' || edate=="")
						etime="";
					var owner=v[j].getElementsByTagName('owner')[0].firstChild.nodeValue;

					var users=v[j].getElementsByTagName('users')[0].firstChild.nodeValue;
					var desp=v[j].getElementsByTagName('title')[0].firstChild.nodeValue;
					var allEvent_date="";
					
					if(day=="")
					{
						
						allEvent_date=sdate;
					}
					if(users=='null' )
						users="";
					if(stime=='null')
						result+="<tr><td width=\"20%\" height=\"30\"> </td>";
					else
					result+="<tr><td width=\"20%\" height=\"30\"  align=\"left\"><font face=\"Arial\" style=\"font-size: 12px;\">"+change_dt_format_norm(allEvent_date)+" "+stime+"</td>";

					if(etime=='null')
						result+="<td width=\"20%\" height=\"30\" > </td>";
					else
					result+="<td width=\"20%\" height=\"30\" align=\"left\" ><font face=\"Arial\" style=\"font-size: 12px;\">"+change_dt_format_norm(edate)+"  "+etime+"</td>";
					
					if(desp=='null')
						result+="<td width=\"20%\" height=\"30\" ><a href=\"#\" onclick=\"del('"+uid+"','"+type+"','"+sdate+"')\" ><img src=\"../../images/idelete.gif\" width=\"16\" height=\"16\" border=\"0\" alt=\"Delete\"></a></td>";
					else
					result+="<td width=\"20%\" height=\"30\" align=\"left\" ><a href=\"#\" onclick=\"del('"+uid+"','"+type+"','"+sdate+"')\" ><img src=\"../../images/idelete.gif\" width=\"16\" height=\"16\" border=\"0\" alt=\"Delete\"></a><font face=\"Arial\" style=\"font-size: 12px;\"><a href=\"#\" onclick=\"getEventDetails('"+uid+"','"+type+"','"+sdate+"')\"  style=\"text-decoration:none\">"+desp+"</a></td>";

					if(owner=='null')
						result+="<td  width=\"3%\" height=\"30\"> </td>";
					else
					result+="<td width=\"20%\" height=\"30\"  align=\"left\"><font face=\"Arial\" style=\"font-size: 12px;\">"+owner+"</td>";

					if(users=='null')
						result+="<td width=\"20%\" height=\"30\" > </td>";
					else if(users.length>20)
							users=users.substring(0,20)+"...";

					result+="<td width=\"20%\" height=\"30\" align=\"left\" ><font face=\"Arial\" style=\"font-size: 12px;\">"+users+"</td></tr>";
						/*var increment=0;
						var total_lnth=users.length;
						var users1="";
						while(total_lnth!=0)
						{
							if(total_lnth/20==0)
							{
								users1=users.substring(increment,(increment+20))+"<br>";
								increment+=20;
								total_lnth-=20;
							}
							else
							{
								users1=users.substring(increment,(total_lnth));
							}
						}
						users=users1;
						*/
					
					
					
					if(test>1)
					{
						
						result+="<tr><td colspan=\"5\" width=\"100%\"><hr width=\"100%\"></td></tr>";
						test--;
					}
				}
				if(count<=0)
					result+="<tr><td colspan=\"5\" align=\"center\"><font face=\"Arial\" style=\"font-size: 12px;\">No events are available!</font></td></tr></table></td></tr><tr><td colspan=\"5\"><hr width=\"100%\"></td></tr>";
				else
				result+="</table></td></tr><tr><td colspan=\"5\"><hr width=\"100%\"></td></tr>";
				

			}
			if(count<=0 && type=="allEvents")
			{		result_share+="<tr><td colspan=\"5\" valign=\"top\" align=\"center\"> <font face=\"Arial\" style=\"font-size: 12px;\">No events are available!</font></td></tr> <tr><td colspan=\"5\" valign=\"top\" align=\"center\"><hr width=\"100%\"> </td></tr>";
					result=result_share;
			}
			result+="</table>";
			
		var v=result;
		//
		//document.getElementById("date").innerHTML=sdate;
		document.getElementById("data").innerHTML=v;
	}
	}
}

//this is for all event start

//All event End

// this is method is for getting the calendar for Weak
function addEventHandler_WEAK() {
	
	if (http.readyState == 4) {
	if (http.status==200){
	
		var message=http.responseXML.getElementsByTagName("root");
	
			result="<table width=100%>";
			result+="<tr><td width=\"10%\" bgcolor=\"#546878\" align=\"center\"> <td width=\"90%\" bgcolor=\"#546878\">";
			result+="<table width=\"100%\"><tr><td width=\"20%\"><font color=\"#FFFFFF\" face=\"Arial\" style=\"font-size: 12px;\"><b>Starting at</b></font></td>    <td width=\"20%\"  align=\"left\"><font face=\"Arial\" color=\"#FFFFFF\" style=\"font-size: 12px;\"><b>Ending at</b></font></td>    <td width=\"20%\" align=\"left\"><font color=\"#FFFFFF\" face=\"Arial\" style=\"font-size: 12px;\"><b>Title</b></font></td>    <td   width=\"20%\" align=\"left\"><font color=\"#FFFFFF\" face=\"Arial\" style=\"font-size: 12px;\"><b>Created by</b></font></td><td width=\"20%\"   align=\"left\"><font color=\"#FFFFFF\" face=\"Arial\" style=\"font-size: 12px;\"><b>Shared to</b></font></td></tr></table></td></tr>";
			
			for(i=0; i<message.length;i++)
			{
				
				var sub=message[i].getElementsByTagName('subroot');
				for(k=0; k<sub.length;k++)
				{
					v=sub[k].getElementsByTagName('data');

					var month_name=getMonth_name(parseInt(message[i].getElementsByTagName('month')[0].firstChild.nodeValue)-1);


				var yr=message[i].getElementsByTagName('year')[0].firstChild.nodeValue;

				var day_name=sub[k].getElementsByTagName('day')[0].firstChild.nodeValue;
				var day=sub[k].getElementsByTagName('dt')[0].firstChild.nodeValue;
				var current_date=new Date();
				if(day==current_date.getDate())
					{
					result+="<tr><td bgcolor=\"#CCCCCC\" width=\"10%\" height=\"50\" align=\"center\" valign=\"top\"><font face=\"Arial\" style=\"font-size: 12px;\" color=\"white\" style=\"bold\">"+month_name+" "+day+"' "+yr.substring(2)+"<br\>"+day_name+"</td><td width=\"90%\" height=\"50\"><table width=\"100%\">";
					}
					else{
						result+="<tr><td bgcolor=\"white\" width=\"10%\" height=\"50\" align=\"center\" valign=\"top\"><font face=\"Arial\" style=\"font-size: 12px;\" color=\"black\" style=\"bold\">"+month_name+" "+day+"' "+yr.substring(2)+"<br\>"+day_name+"</td><td width=\"90%\" height=\"50\"><table width=\"100%\">";
					}
				var test=v.length;
				for(j=0;j<v.length;j++)
				{
					var uid=v[j].getElementsByTagName('id')[0].firstChild.nodeValue;
					var sdate=v[j].getElementsByTagName('start_date')[0].firstChild.nodeValue;

					var edate=v[j].getElementsByTagName('end_date')[0].firstChild.nodeValue;
					var stime=v[j].getElementsByTagName('start_time')[0].firstChild.nodeValue;
					if(stime=='Time')
						stime="";
					var etime=v[j].getElementsByTagName('end_time')[0].firstChild.nodeValue;
					if(etime=='Time' || edate=="")
						etime="";

					var owner=v[j].getElementsByTagName('owner')[0].firstChild.nodeValue;
					var users=v[j].getElementsByTagName('users')[0].firstChild.nodeValue;
					var desp=v[j].getElementsByTagName('title')[0].firstChild.nodeValue;
					
					
					
					if(stime=='null')
						result+="<tr><td width=\"20%\" height=\"30\"> </td>";
					else
					result+="<tr><td width=\"20%\" height=\"30\"  align=\"left\"><font face=\"Arial\" style=\"font-size: 12px;\">"+stime+"</td>";

					if(etime=='null')
						result+="<td width=\"20%\" height=\"30\" > </td>";
					else
					result+="<td width=\"20%\" height=\"30\" align=\"left\" ><font face=\"Arial\" style=\"font-size: 12px;\">"+edate+" "+etime+"</font></td>";

					if(desp=='null')
						desp="";
						
					result+="<td width=\"20%\" height=\"30\" align=\"left\" ><a href=\"#\" onclick=\"del('"+uid+"','weak','"+sdate+"')\" ><img src=\"../../images/idelete.gif\" width=\"16\" height=\"16\" border=\"0\" alt=\"Delete\"></a><font face=\"Arial\" style=\"font-size: 12px;\"><a href=\"#\" onclick=\"getEventDetails('"+uid+"','weak','"+sdate+"')\"  style=\"text-decoration:none\">"+desp+"</a> </td>";

					if(owner=='null')
						owner="";

					result+="<td width=\"20%\" height=\"30\"  align=\"left\"><font face=\"Arial\" style=\"font-size: 12px;\">"+owner+"</td>";

					if(users=='null')
						result+="<td width=\"20%\" height=\"30\" > &nbsp;</td>";
					else if(users.length>20)
							users=users.substring(0,20)+"...";

					result+="<td width=\"20%\" height=\"30\" align=\"left\" ><font face=\"Arial\" style=\"font-size: 12px;\">"+users+"</td></tr>";
					if(test>1)
					{
						
						result+="<tr><td colspan=\"5\" width=\"100%\"><hr width=\"100%\"></td></tr>";
						test--;
					}
				}
				result+="</table></td></tr><tr><td colspan=\"2\"><hr width=\"100%\"></td></tr>";
				}

			}
			result+="</table>";
		var v=result;
		
		document.getElementById("data").innerHTML=v;
		
	}
	}
}
//this is method is for getting the calendar for Month
function addEventHandler_month() {
	
	if (http.readyState == 4) {
	if (http.status==200){
	
		var message=http.responseXML.getElementsByTagName("root");
	
			result="<table width=100%>";
			result+="<tr><td width=\"10%\" bgcolor=\"#546878\" align=\"center\"> <td width=\"90%\" bgcolor=\"#546878\">";
			result+="<table width=\"100%\"><tr><td width=\"20%\"><font color=\"#FFFFFF\" face=\"Arial\" style=\"font-size: 12px;\"><b>Starting at</b></font></td>    <td width=\"20%\"  align=\"left\"><font face=\"Arial\" color=\"#FFFFFF\" style=\"font-size: 12px;\"><b>Ending at</b></font></td>    <td width=\"20%\" align=\"left\"><font color=\"#FFFFFF\" face=\"Arial\" style=\"font-size: 12px;\"><b>Title</b></font></td>    <td   width=\"20%\" align=\"left\"><font color=\"#FFFFFF\" face=\"Arial\" style=\"font-size: 12px;\"><b>Created by</b></font></td><td width=\"20%\"   align=\"left\"><font color=\"#FFFFFF\" face=\"Arial\" style=\"font-size: 12px;\"><b>Shared to</b></font></td></tr></table></td></tr>";
			
			for(i=0; i<message.length;i++)
			{
				
				var sub=message[i].getElementsByTagName('subroot');
				for(k=0; k<sub.length;k++)
				{
					v=sub[k].getElementsByTagName('data');

					var month_name=getMonth_name(parseInt(message[i].getElementsByTagName('month')[0].firstChild.nodeValue)-1);

				var yr=message[i].getElementsByTagName('year')[0].firstChild.nodeValue;
			
				var day_name=sub[k].getElementsByTagName('day')[0].firstChild.nodeValue;
				var day=sub[k].getElementsByTagName('dt')[0].firstChild.nodeValue;
				var current_date=new Date();
				if(day==current_date.getDate())
					{
				result+="<tr><td bgcolor=\"#CCCCCC\" width=\"10%\" height=\"50\" align=\"center\" valign=\"top\"><font face=\"Arial\" style=\"font-size: 12px;\" color=\"white\" style=\"bold\">"+month_name+" "+day+"' "+yr.substring(2)+"<br\>"+day_name+"</td><td width=\"90%\" height=\"50\"><table width=\"100%\">";
					}
					else{
						result+="<tr><td bgcolor=\"white\" width=\"10%\" height=\"50\" align=\"center\" valign=\"top\"><font face=\"Arial\" style=\"font-size: 12px;\" color=\"black\" style=\"bold\">"+month_name+" "+day+"' "+yr.substring(2)+"<br\>"+day_name+"</td><td width=\"90%\" height=\"50\"><table width=\"100%\">";

					}
				var test=v.length;
				for(j=0;j<v.length;j++)
				{
					var uid=v[j].getElementsByTagName('id')[0].firstChild.nodeValue;
					var sdate=v[j].getElementsByTagName('start_date')[0].firstChild.nodeValue;
					var stime=v[j].getElementsByTagName('start_time')[0].firstChild.nodeValue;
					if(stime=='Time')
						stime="";
					var etime=v[j].getElementsByTagName('end_time')[0].firstChild.nodeValue;
					if(etime=='Time')
						etime="";
					
					var owner=v[j].getElementsByTagName('owner')[0].firstChild.nodeValue;
					var users=v[j].getElementsByTagName('users')[0].firstChild.nodeValue;
					var desp=v[j].getElementsByTagName('title')[0].firstChild.nodeValue;
					
					
					
					if(stime=='null')
						result+="<tr><td width=\"20%\" height=\"30\"> </td>";
					else
					result+="<tr><td width=\"20%\" height=\"30\"  align=\"left\"><font face=\"Arial\" style=\"font-size: 12px;\">"+stime+"</td>";
					
					if(users=='null' )
						users="";

					if(etime=='null')
						result+="<td width=\"20%\" height=\"30\" > </td>";
					else
					result+="<td width=\"20%\" height=\"30\" align=\"left\" ><font face=\"Arial\" style=\"font-size: 12px;\">"+etime+"</td>";

					if(desp=='null')
						desp="";
						
					result+="<td width=\"20%\" height=\"30\" align=\"left\" ><a href=\"#\" onclick=\"del('"+uid+"','month','"+sdate+"')\" ><img src=\"../../images/idelete.gif\" width=\"16\" height=\"16\" border=\"0\" alt=\"Delete\"></a><font face=\"Arial\" style=\"font-size: 12px;\"><a href=\"#\" onclick=\"getEventDetails('"+uid+"','month','"+sdate+"')\"  style=\"text-decoration:none\">"+desp+"</a></font></td>";

					if(owner=='null')
						owner="";

					result+="<td width=\"20%\" height=\"30\"  align=\"left\"><font face=\"Arial\" style=\"font-size: 12px;\">"+owner+"</td>";

					if(users=='null')
						result+="<td width=\"20%\" height=\"30\" >&nbsp; </td>";
					else if(users.length>20)
							users=users.substring(0,20)+"...";


					result+="<td width=\"20%\" height=\"30\" align=\"left\" ><font face=\"Arial\" style=\"font-size: 12px;\">"+users+"</td></tr>";
					if(test>1)
					{
						
						result+="<tr><td colspan=\"5\" width=\"100%\"><hr width=\"100%\"></td></tr>";
						test--;
					}
				}
				result+="</table></td></tr><tr><td colspan=\"2\"><hr width=\"100%\"></td></tr>";
				}

			}
			result+="</table>";
		var v=result;
		
		document.getElementById("data").innerHTML=v;
		
	}
	}
}
// this is method is for getting the calendar for day
function addevent(ddt) {
	
	var dt="";
	tp="day";
	document.getElementById("type").value="";
	document.getElementById("back").innerHTML="&nbsp;";
	document.getElementById("type").value=tp;
	document.getElementById("date").innerHTML="&nbsp;";
	document.getElementById("weak").innerHTML="&nbsp;";
	
		if(ddt!=null)
		{	
			dt=ddt;
		}
		else{
			
		if(start_cal.selectedDates[0]!=null)
		dt=start_cal.selectedDates[0].dateFormat();
		else
			{
				var cdate=new Date();
				dt=cdate.dateFormat();
			}
		}
		//document.getElementById("refresh").innerHTML="<a href=\"#\" onclick=\"addevent('"+dt+"')\"><img src=\"../images/cal_refresh.png\" width=\"32\" height=\"32\" border=\"0\" alt=\"Refresh\"></a>";

//		document.getElementById("rtext").innerHTML="<a href=\"#\" onclick=\"addevent('"+dt+"')\" style=\"font-family: Arial;text-decoration:none;font-size:8pt;\">Refresh</a>";

		
		document.getElementById("date").innerHTML="<a href=\"#\" onclick=\"previous('"+dt+"')\"><img src=\"../images/back_small.png\" width=\"16\" height=\"16\" border=\"0\" alt=\"Previous\"></a><font face=\"Arial\" style=\"font-size: 12px;\">&nbsp;&nbsp;"+change_dt_format_normal(dt)+"&nbsp;&nbsp;</font><a href=\"#\" onclick=\"next('"+dt+"')\"><img src=\"../images/forward_small.png\" width=\"16\" height=\"16\" border=\"0\" alt=\"Next\"></a>";
	
	http.open("GET", "getDay.jsp?sel_date="+dt, true);	
	http.onreadystatechange = addEventHandler;
	http.send(null);
}


function getWeak(ddt)
	{
		tp="weak";
		document.getElementById("type").value=tp;
		document.getElementById("date").innerHTML="&nbsp;";
		var dt="";
		if(ddt=='null')
		{
		if(start_cal.selectedDates[0]!=null)
		dt=start_cal.selectedDates[0].dateFormat();
		else
		{
			today=new Date();
			dt=today.dateFormat();
		}
		}
		else
		{
			dt=ddt;
		}
		
//		document.getElementById("refresh").innerHTML="<a href=\"#\" onclick=\"getWeak('"+dt+"')\"><img src=\"../images/cal_refresh.png\" width=\"32\" height=\"32\" border=\"0\" alt=\"Refresh\" ></a>";

//		document.getElementById("rtext").innerHTML="<a href=\"#\" onclick=\"getWeak('"+dt+"')\" style=\"font-family: Arial;text-decoration:none;font-size:8pt;\">Refresh</a>";
		var my_day=new Date(dt);
		var day_name=new Array(7);
		day_name[0]="Sunday"
		day_name[1]="Monday"
		day_name[2]="Tuesday"
		day_name[3]="Wednesday"
		day_name[4]="Thursday"
		day_name[5]="Friday"
		day_name[6]="Saturday"

		var day=day_name[my_day.getDay()]; 
		var no=my_day.getDay();

		
		
		
		var start_day=my_day.getDate()-no;
		
		var end_date=start_day+6;
		my_day.setDate(start_day);

		dt=my_day.dateFormat();
		var edt=new Date(dt);

		var emonth=edt.getMonth()+1;
		var eyear=edt.getFullYear();

		
		var vv=daysInMonth(emonth,eyear);
	
	
	if(end_date>vv)
	{
		end_date=end_date-vv;
		emonth=emonth+1;
		if(emonth>=12)
		{
			emonth=01;
			eyear=eyear+1;

		}
		emonth=(emonth<10?'0'+emonth:emonth);
		
		end_date=(end_date<10?'0'+end_date:end_date);
		
	}
	else
	{
		if(start_day<0)
		{
		
			emonth=emonth+1;
			
		}
		emonth=(emonth<10?'0'+emonth:emonth);
		
		end_date=(end_date<10?'0'+end_date:end_date);
	
	}
	
	var final_end_date=emonth+"/"+(end_date)+"/"+eyear;
			
		
		
		
		document.getElementById("back").innerHTML="&nbsp;";
		document.getElementById("date").innerHTML="&nbsp;";
		document.getElementById("weak").innerHTML="<a href=\"#\" onclick=\"previous_weak('"+dt+"')\"><img src=\"../images/back_small.png\" width=\"16\" height=\"16\" border=\"0\" alt=\"Previous\"></a> <font face=\"Arial\" style=\"font-size: 12px;\">"+change_dt_format_normal(dt)+" to "+change_dt_format_normal(final_end_date)+" </font> <a href=\"#\" onclick=\"next_weak('"+final_end_date+"')\"><img src=\"../images/forward_small.png\" width=\"16\" height=\"16\" border=\"0\" alt=\"Next\"></a>";
		http.open("GET", "getWeak.jsp?sel_date="+dt, true);	
		http.onreadystatechange = addEventHandler_WEAK;
		http.send(null);
//		window.location.href='./getWeak.jsp?sel_date='+dt;
		
	}

	function getMonth(ddt)
	{	
		tp="month";
		document.getElementById("type").value=tp;
		var dt="";
		if(ddt=='null')
		{
		if(start_cal.selectedDates[0]!=null)
		dt=start_cal.selectedDates[0].dateFormat();
		else
		{
			today=new Date();
			dt=today.dateFormat();
		}
		}
		else
		{
			dt=ddt;
		}
//		document.getElementById("refresh").innerHTML="<a href=\"#\" onclick=\"getMonth('"+dt+"')\"><img src=\"../images/cal_refresh.png\" width=\"32\" height=\"32\" border=\"0\" alt=\"Refresh\"></a>";

//		document.getElementById("rtext").innerHTML="<a href=\"#\" onclick=\"getMonth('"+dt+"')\" style=\"font-family: Arial;text-decoration:none;font-size:8pt;\" style=\"font-family: Arial;text-decoration:none;font-size:8pt;\">Refresh</a>";
		//document.getElementById("refresh").innerHTML="<a href=\"#\" onclick=\"addevent('"+dt+"')\">Refresh</a>";
		document.getElementById("date").innerHTML="&nbsp;";
		document.getElementById("weak").innerHTML="&nbsp;";
		document.getElementById("back").innerHTML="&nbsp;";
		http.open("GET", "getMonth.jsp?sel_date="+dt, true);	
		http.onreadystatechange = addEventHandler_month;
		http.send(null);
//		window.location.href='./getWeak.jsp?sel_date='+dt;
		
	}
	function getAllEvents()
	{
		
		tp="allEvents";
		document.getElementById("back").innerHTML="&nbsp;";
		document.getElementById("type").value=tp;
//		document.getElementById("refresh").innerHTML="&nbsp;";
		document.getElementById("date").innerHTML="&nbsp;";
	document.getElementById("weak").innerHTML="&nbsp;";
//	document.getElementById("refresh").innerHTML="<a href=\"#\" onclick=\"getAllEvents()\"><img src=\"../images/cal_refresh.png\" width=\"32\" height=\"32\" border=\"0\" alt=\"Refresh\"></a>";
//	document.getElementById("rtext").innerHTML="<a href=\"#\" onclick=\"getAllEvents()\" style=\"font-family: Arial;text-decoration:none;font-size:8pt;\">Refresh</a>";
	//
		http.open("GET", "allEvents.jsp", true);	
		http.onreadystatechange = addEventHandler;
		http.send(null);
//		window.location.href='./getWeak.jsp?sel_date='+dt;
		
	}

function getEventDetails(id,type,ddt)
{
	Viewtype=type;
	var year=ddt.substring(0,ddt.indexOf("-"));
	var mnt=ddt.substring(ddt.indexOf("-")+1,ddt.lastIndexOf("-"));
	var dt=mnt+"/"+ddt.substring(ddt.lastIndexOf("-")+1)+"/"+year;

	
	document.getElementById("date").innerHTML="&nbsp;";
	document.getElementById("weak").innerHTML="&nbsp;";
	var items="";
	items="<center><table border=\"0\" cellspacing=\"0\" width=\"90%\" id=\"AutoNumber3\" bgcolor=\"#429EDF\" style=\"border-collapse: collapse\" bordercolor=\"#111111\" cellpadding=\"0\" ><tr><td width=\"50%\" align=\"left\" height=\"28\"><font face=\"Arial\" style=\"font-size: 12px;\"><b>&nbsp;<font color=\"#FFFFFF\" face=\"Arial\" style=\"font-size: 12px;\" >Event Details </font></b></font></td><td width=\"50%\" height=\"24\" align=\"right\">";
	if(type=="day")
	{
		items+="<a href=\"#\" onclick=\"addevent('"+dt+"')\">";
	}
	else if(type=="weak")
	{
		
		items="<a href=\"#\" onclick=\"getWeak('"+dt+"')\">";
	}
	else if(type=="month")
	{
		items+="<a href=\"#\" onclick=\"getMonth('"+dt+"')\">";
	}
	else if(type=="shared")
	{
		items+="<a href=\"#\" onclick=\"getSharedEvents()\">";
	}
	else if(type=="allEvents")
	{
		items+="<a href=\"#\" onclick=\"getAllEvents()\">";
	}
	items+="<IMG SRC=\"../../images/back.gif\" WIDTH=\"70\" HEIGHT=\"25\" BORDER=\"0\" ALT=\"&lt;&lt;&nbsp;Back\"></a>&nbsp;</td></tr></table></center>";
	document.getElementById("back").innerHTML=items;
	http.open("GET", "getEventDetails.jsp?id="+id, true);	
	http.onreadystatechange = getEventHandler_result;
	http.send(null);
}

function next(dt)
{
	var modify_date=new Date(dt);
	var day=modify_date.getDate();//dt.substring(dt.indexOf('/')+1,dt.lastIndexOf('/'));
	var mnt=modify_date.getMonth()+1;//dt.substring(0,dt.indexOf('/'));
	var vv=daysInMonth(mnt,modify_date.getFullYear());
	var year=modify_date.getFullYear();//dt.substring(dt.lastIndexOf("/")+1);
	day=day+1;
	if(day>vv)
	{
		day=01;
		mnt=modify_date.getMonth()+2;
		if(mnt>=12)
		{
			mnt=01;
			year=modify_date.getFullYear()+1;

		}
		mnt=(mnt<10?'0'+mnt:mnt);
		
		day=(day<10?'0'+day:day);
		addevent(mnt+"/"+(day)+"/"+year);
	}
	else
	{
		mnt=(mnt<10?'0'+mnt:mnt);
		
		day=(day<10?'0'+day:day);
	addevent(mnt+"/"+(day)+"/"+year);
	}

}
function daysInMonth(Month, Year)
 {
	 return new Date(Year, Month, 0).getDate();
     //return 32 - new Date(Year, Month, 32).getDate();
 }
 function previous(dt)
 {
	 var modify_date=new Date(dt);
	var day=modify_date.getDate();//dt.substring(dt.indexOf('/')+1,dt.lastIndexOf('/'));
	var mnt=modify_date.getMonth()+1;//dt.substring(0,dt.indexOf('/'));
	var vv=daysInMonth((mnt-1),modify_date.getFullYear());
	var year=modify_date.getFullYear();//dt.substring(dt.lastIndexOf("/")+1);
	day=day-1;
	if(day<1)
	{

		
		day=vv;
		mnt=modify_date.getMonth();
		if(mnt<0)
		{
			mnt=12;
			year=modify_date.getFullYear()-1;

		}
		mnt=(mnt<10?'0'+mnt:mnt);
		
		day=(day<10?'0'+day:day);
		addevent(mnt+"/"+(day)+"/"+year);
	}
	else
	{
		mnt=(mnt<10?'0'+mnt:mnt);
		
		day=(day<10?'0'+day:day);
	addevent(mnt+"/"+(day)+"/"+year);
	}
 }

   function next_weak(dt) 
   {
	   var modify_date=new Date(dt);
	   var day=modify_date.getDate();
	var mnt=modify_date.getMonth()+1;
	//var vv=daysInMonth((mnt-1),modify_date.getFullYear());
	var year=modify_date.getFullYear();

	getWeak(mnt+"/"+(day+1)+"/"+year);
   }
function previous_weak(dt)
{
   var modify_date=new Date(dt);
   var day=modify_date.getDate();
   var mnt=modify_date.getMonth()+1;
	
	var year=modify_date.getFullYear();

	getWeak(mnt+"/"+(day-1)+"/"+year);
}
function getMonth_name(mnt1)
{
var mnt=parseInt(mnt1);
var month=new Array(12);
month[0]="Jan";
month[1]="Feb";
month[2]="Mar";
month[3]="Apr";
month[4]="May";
month[5]="Jun";
month[6]="Jul";
month[7]="Aug";
month[8]="Sep";
month[9]="Oct";
month[10]="Nov";
month[11]="Dec";

return (month[mnt]);
}
//this function is for delete the event from the event table
function del(uid,type,dt)
{
	var c=confirm("Sure are you want to delete the event");
	if(c)
	{
		http.open("GET", "DeleteEvent.jsp?eid="+uid+"&type="+type+"&dt="+dt, true);	
		http.onreadystatechange = delEventHandlerResponse;
		http.send(null);
	}
	else{
		return false;
	}
	//window.location.href=";
}

function delEventHandlerResponse()
{
	if (http.readyState == 4) {
	if (http.status==200){
		
			var v=http.responseXML.getElementsByTagName("root");
			for(i=0; i<v.length;i++)
			{
				var satus=v[i].getElementsByTagName('status')[0].firstChild.nodeValue;
				var type=v[i].getElementsByTagName('type')[0].firstChild.nodeValue;
				var dt=v[i].getElementsByTagName('date')[0].firstChild.nodeValue;
				var date=change_dt_format(dt);
				
		if(type=="day")
		{
				addevent(date);
		}
		if(type=="event")
		{
				getAllEvents();
		}
		if(type=="weak")
		{
				getWeak(date);
		}
		if(type=="month")
		{
				getMonth(date);
		}
	 }
	 }
	}
}
//change the date format from yyyy-mm-dd to mm/dd/yyyy
function change_dt_format(dt)
{
	var year=dt.substring(0,dt.indexOf("-"));
	var month=dt.substring(dt.indexOf("-")+1,dt.lastIndexOf("-"));
	var day=dt.substring(dt.lastIndexOf("-")+1);
	return (month+"/"+day+"/"+year);

}

//change the date format from mm/dd/yyyy  to dd/mm/yyyy
function change_dt_format_normal(dt)
{
	var year=dt.substring(dt.lastIndexOf("/")+1);
	var day=dt.substring(dt.indexOf("/")+1,dt.lastIndexOf("/"));
	var month=dt.substring(0,dt.indexOf("/"));
	return (day+"-"+month+"-"+year);

}
//change the date format from yyyy-mm-dd to dd/mm/yyyy
function change_dt_format_norm(dt)
{
	if(dt=="")
	{
		
		return dt;
	}
	else{
			var year=dt.substring(0,dt.indexOf("-"));
			var month=dt.substring(dt.indexOf("-")+1,dt.lastIndexOf("-"));
			var day=dt.substring(dt.lastIndexOf("-")+1);
			return (day+"-"+month+"-"+year);
		}

}
function redirect(url)
{
	
	window.location.href=""+url;
}
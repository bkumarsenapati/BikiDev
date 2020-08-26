
var sharedhttp = getHTTPObject();
function getHTTPObject() {
	var xmlhttp_shared;
	if (window.XMLHttpRequest) {
		xmlhttp_shared = new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		xmlhttp_shared = new ActiveXObject("Microsoft.XMLHTTP");
	}
	
		return xmlhttp_shared;
}
function addEventHandler_shared() {
	
	if (sharedhttp.readyState == 4) {
	if (sharedhttp.status==200){
	
		var message=sharedhttp.responseXML.getElementsByTagName("root");
	var sdate="";
			result="<center><table width=100%>";
			result+="<tr><td width=\"90%\" bgcolor=\"#546878\" >";
			result+="<table width=\"100%\"><tr><td width=\"20%\" align=\"left\" ><font color=\"#FFFFFF\" face=\"Arial\" style=\"font-size: 12px;\"><b>Starting at</b></font></td>    <td width=\"20%\"  align=\"left\"><font color=\"#FFFFFF\" face=\"Arial\" style=\"font-size: 12px;\"><b>Ending at</b></font></td>    <td width=\"20%\"  align=\"left\"><font color=\"#FFFFFF\" face=\"Arial\" style=\"font-size: 12px;\"><b>Title</b></font></td>    <td   width=\"20%\" align=\"left\"><font color=\"#FFFFFF\" face=\"Arial\" style=\"font-size: 12px;\"><b>Created by</b></font></td></tr></table></td></tr>";
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
					type="event";
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
				
				var test=v.length;
				for(j=0;j<v.length;j++)
				{
					count++;
					sdate=v[j].getElementsByTagName('start_date')[0].firstChild.nodeValue;
					var uid=v[j].getElementsByTagName('id')[0].firstChild.nodeValue;
					
					var stime=v[j].getElementsByTagName('start_time')[0].firstChild.nodeValue;
					if(stime=='Time')
						stime="No time";
					var etime=v[j].getElementsByTagName('end_time')[0].firstChild.nodeValue;
					
					var edate=v[j].getElementsByTagName('end_date')[0].firstChild.nodeValue;
					if(etime=='Time' || edate=="")
						etime="<i>No time</i>";
					var owner=v[j].getElementsByTagName('owner')[0].firstChild.nodeValue;

					var users=v[j].getElementsByTagName('users')[0].firstChild.nodeValue;
					var desp=v[j].getElementsByTagName('title')[0].firstChild.nodeValue;
					var allEvent_date="";
					
					if(day=="")
					{
						
						allEvent_date=sdate;
					}
					
					result+="<table width=\"100%\"><tr><td width=\"20%\" height=\"30\"  align=\"left\"><font face=\"Arial\" style=\"font-size: 12px;\">"+change_dt_format_norm(allEvent_date)+" <i>"+stime+"</i></td>";

					result+="<td width=\"20%\" height=\"30\" align=\"left\" ><font face=\"Arial\" style=\"font-size: 12px;\">"+change_dt_format_norm(edate)+"  <i>"+etime+"</i></td>";
					
					/*if(desp=='null')
						result+="<td width=\"20%\" height=\"30\" > <a href=\"#\" onclick=\"del('"+uid+"','"+type+"','"+sdate+"')\">delete</a></td>";
						*/
					//else
						result+="<td width=\"20%\" height=\"30\" align=\"left\" ><font face=\"Arial\" style=\"font-size: 12px;\"><a href=\"#\" onclick=\"getEventDetails('"+uid+"','shared','"+sdate+"')\"  style=\"text-decoration:none\">"+desp+"</a></td>";
					/*result+="<td width=\"20%\" height=\"30\" align=\"left\" ><font face=\"Arial\" size=\"3\"><a href=\"#\" onclick=\"getEventDetails('"+uid+"','day','"+sdate+"')\"  style=\"text-decoration:none\">"+desp+"</a><br><a href=\"#\" onclick=\"del('"+uid+"','"+type+"','"+sdate+"')\" >delete</a></td>";*/

					result+="<td width=\"20%\" height=\"30\"  align=\"left\"><font face=\"Arial\" style=\"font-size: 12px;\">"+owner+"</td></tr>";

			
					if(test>1)
					{
						
						result+="<tr><td colspan=\"4\" width=\"100%\"><hr width=\"100%\"></td></tr>";
						test--;
					}
				}
				result+="</table></td></tr>";
				

			}
			
			if(count<=0)
				result+="<tr><td colspan=\"4\" align=\"center\"> <font face=\"Arial\" style=\"font-size: 12px;\">No shared events are available!</font></td></tr><tr><td colspan=\"4\" width=\"100%\"><hr width=\"100%\"></td></tr>";
			result+="</table> </center>";

		var v=result;
		//
		//document.getElementById("date").innerHTML=sdate;
		document.getElementById("data").innerHTML=v;
	}
	}
}

function getSharedEvents()
	{
		
		tp="sharedEvents";
		document.getElementById("back").innerHTML="&nbsp;";
		document.getElementById("type").value=tp;
		//document.getElementById("refresh").innerHTML="&nbsp;";
		document.getElementById("date").innerHTML="&nbsp;";
	document.getElementById("weak").innerHTML="&nbsp;";
	//document.getElementById("refresh").innerHTML="<a href=\"#\" onclick=\"getAllEvents()\"><img src=\"../images/cal_refresh.png\" width=\"32\" height=\"32\" border=\"0\" alt=\"Refresh\"></a>";
	//document.getElementById("rtext").innerHTML="<a href=\"#\" onclick=\"getAllEvents()\" style=\"font-family: Arial;text-decoration:none;font-size:8pt;\">Refresh</a>";
	//
		sharedhttp.open("GET", "getSharedEvents.jsp", true);	
		sharedhttp.onreadystatechange = addEventHandler_shared;
		sharedhttp.send(null);
	}
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>New Page 1</title>
<script type="text/javascript" src="../calendar/epoch_classes.js"></script>
<!-- <script type="text/javascript" src="../JS/time.js"></script> -->
<script type="text/javascript" src="../JS/ajax.js"></script> 
<link rel="stylesheet" type="text/css" href="../calendar/epoch_styles.css" /> 
<script type="text/javascript">
	var start_cal, end_cal;
window.onload = function () {
	start_cal = new Epoch('start_cal','popup',document.getElementById('sdate'),false);
	end_cal = new Epoch('dp_cal','popup',document.getElementById('edate'),false);
	//start_cal.toggle();
	var flag=false;
	for (var i=0; i < document.form.sharing.length; i++)
   {
   if (document.form.sharing[i].checked)
      {
	   if(document.form.sharing[i].value=="public")
		flag=true;
      }
   }
   
	if(!flag){
	document.getElementById("invite_user").style.visibility = 'hidden';
	document.getElementById("invite_user1").style.visibility = 'hidden';
	}

}
	function validateForm()
{
	var title=document.form.title.value;
	//
	var sdate=document.form.sdate.value;
	var edate=document.form.edate.value;
	
	if(title==null||title=="")
		{
		  alert("Please enter title!");
		  document.getElementById("title").focus();
		  return false;
		}
	
	else if(sdate==null||sdate=="")
		{
		  alert("Please enter Start date!");
		  document.getElementById("sdate").focus();
		  return false;
		}
	
	else
	{
			//for current date 
			var cr_date = new Date();
			
			var sdt = new Date(sdate);
			var edt = new Date(edate);
					
		if(edate==null || edate=="")
		{
			
			document.form.edate.value=document.form.sdate.value;
		}

		if(edate!=null || edate!="")
		{
			

			if(sdt.getFullYear()>edt.getFullYear() )
			{
				alert("End Date Should not Less then Start date!");
				document.getElementById("edate").focus();
				return false;
			}
			else {
				if(sdt.getFullYear()==edt.getFullYear() && sdt.getMonth()>edt.getMonth())
					{
					alert("End Date Should not Less then Start date!");
					document.getElementById("edate").focus();
					return false;
					}
				else {
					
						if(sdt.getMonth()==edt.getMonth() && sdt.getDate()>edt.getDate())
						{
							alert("End Date Should not Less then Start date!");
							document.getElementById("edate").focus();
							return false;
						}
						else
						{
							
							return true;
						}
					}
					
			}
		}
		
			
			


	}
}
function getHTTPObject1() {
	var xmlhttp;
	if (window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	} return xmlhttp;
}

var http1=getHTTPObject1();

function check_title()
{
	var title=document.form.title.value;
	http1.open("POST", "./validtitle.jsp?title="+title, true);	
	http1.onreadystatechange = test;
	http1.send(null);
}

function test()
{
	if (http1.readyState == 4) {
	if (http1.status==200){
		
			var v=http1.responseXML.getElementsByTagName("root")[0].firstChild.nodeValue;
			if(v=="fail")
		{
				
			document.getElementById("valid").innerHTML="<font color=red style=\"font-size: 12px;\">Already event is created with this title. So please select another name!</font>";	
			document.getElementById("title").focus();
			return false;
		}
		else 
		{	
			return true;
		}
		  }
		}
}

function setdivvisibility(show) {
if(show)
showvar="visible";
else
showvar="hidden";
document.getElementById("invite_user").style.visibility = showvar;
document.getElementById("invite_user1").style.visibility = showvar;
}
</script>
</head>

<body>
<%
String getdate="";
String clr="";
String b_title="",b_sdate="",b_stime="",b_edate="",b_etime="",b_loc="",b_desc="",pub="",prv="";
int s_hour=0,s_min=0,e_hour=0,e_min=0;
String data[]={};
String users="";
String uType=(String)session.getAttribute("utype");

if(uType=="student")
{
	clr="#546878";
}
else
clr="#429EDF";

String input_type=request.getParameter("source");

java.util.Date dt=null;
if(request.getParameter("sel_date")!=null)
{
	
	
	if(!(request.getParameter("sel_date").equals("")))
	{		
	getdate=request.getParameter("sel_date");
	 dt= new java.util.Date(getdate);
	}
	else dt=new java.util.Date();
}

if(request.getParameter("u_List")!=null)
	{
		users=request.getParameter("u_List");
		data=request.getParameter("backup").split(",");
			
		
		for(int i=0;i<data.length; i++)
		{
			
			if(data[i].indexOf("TI:")!=-1)
			{
				b_title=data[i].substring(data[i].indexOf("TI:")+3);
			}
			if(data[i].indexOf("SD:")!=-1)
			{
				getdate=data[i].substring(data[i].indexOf("SD:")+3);
				
			}
			if(data[i].indexOf("ST:")!=-1)
			{
				b_stime=data[i].substring(data[i].indexOf("ST:")+3);
				s_hour=Integer.parseInt(b_stime.substring(0,2));
				s_min=Integer.parseInt(b_stime.substring(3,5));
								
				
				if(s_hour>12)
					s_hour=s_hour%12;
			}
			if(data[i].indexOf("ED:")!=-1)
			{
				b_edate=data[i].substring(data[i].indexOf("ED:")+3);
			}
			if(data[i].indexOf("ET:")!=-1)
			{
				b_etime=data[i].substring(data[i].indexOf("ET:")+3);

				e_hour=Integer.parseInt(b_etime.substring(0,2));
				e_min=Integer.parseInt(b_etime.substring(3,5));

				if(e_hour>12)
					e_hour=e_hour%12;

				
				
			}
			if(data[i].indexOf("LO:")!=-1)
			{
				b_loc=data[i].substring(data[i].indexOf("LO:")+3);
			}
			if(data[i].indexOf("SH:")!=-1)
			{
				if(data[i].substring(data[i].indexOf("SH:")+3).equals("public"))
				{
					pub="checked";
				}
				else if(data[i].substring(data[i].indexOf("SH:")+3).equals("private"))
				{
					prv="checked";
				}
			}
			if(data[i].indexOf("DES:")!=-1)
			{

				b_desc=data[i].substring(data[i].indexOf("DES:")+4);
			}


		
		}
	}
	

%>
<form method="POST" name="form" action="../../save.saveEvent" onsubmit="return validateForm();">
<center>
  <table border="0" cellpadding="10" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
  <tr>
      <td width="100%"><font face="Arial" style="font-size: 12px;">

  <table border="0" cellspacing="0" width="70%" id="AutoNumber3" bgcolor="<%=clr%>" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" >
  <tr>
    <!-- <td width="50%" height="20" valign="bottom"><font face="Arial" style="font-size: 12px;" ><b>&nbsp;<font color="#FFFFFF" style="font-size: 12px;" face="arial"><a href="" onclick="validateForm1()"><input type="submit" src="../../images/button.save.gif" value="Sava"  name="save"></a>  </font></b></font></td> -->

	<td width="50%" height="20" align="right" colspan=3>
	<a href="#" onclick="backToSource('<%=input_type%>')"><IMG SRC="../images/back.png" WIDTH="22" HEIGHT="22" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a>&nbsp;
	</td>
  </tr>
  </table>
  </td>
  </tr>
    <!-- <tr>
      <td width="100%"><font face="Arial">
      <input type="reset" value="Cancel" name="Back" ></font></td>
    </tr> -->
    <tr>
      <td width="100%">
      <!-- <div align="center"> -->
        
        <table border="0" cellpadding="0" cellspacing="6" style="border-collapse: collapse" bordercolor="#111111" width="587" id="AutoNumber2" height="20%">
          <tr>
            <td width="100%" height="100%">
            <table width="100%">
			<tr><td align="left">
            <font face="Arial" style="font-size: 12px;">Title </font></td><td align="right">
            :</td></tr></table>
			</td>
            <td width="100%" height="100%"><font face="Arial" style="font-size: 12px;">
            <input type="text" name="title" id="title" size="61" value="<%=b_title%>" onBlur="check_title();"> <br><div id="valid"></div> </font></td>
          </tr>
          <tr>
            <td width="149" height="23">
            <table width="100%">
			<tr><td align="left">
            <font face="Arial" style="font-size: 12px;">Date and Time</font></td><td align="right">
            :</td></tr></table>
			</td>
            <td width="437" height="23">
            <input type="text" name="sdate" id="sdate" size="20" value = "<%=getdate%>"  onclick="start_cal.toggle();"> Time:
			<font face="Arial"><select name="stime" id="stime" Style="font-size : 10px">
			<option>Time</option>
			<%
			String chkd="";
			for(int i=1;i<=23; i++)
			{
				for(int j=0;j<60;)
				{
					
					String temp="";
					if(j==0)
						temp="00";
					else temp=""+j;
					
					if(i==s_hour && j==s_min)
						chkd="selected=\"selected\"";
					else chkd="";
					if(i>=12)
					{
						int hours=(i%12);
						String hours2="";
						if(hours<10)
						{
							hours2="0"+hours;
						}
						else
						{
							hours2=Integer.toString(hours);
						}
						if(i==12)
						{
							hours2="12";							
						}
				%>
				<option value="<%=(hours2)%>:<%=temp%> PM" <%=chkd%>><%=(hours2)%>:<%=temp%> PM 
				<%
					}
				else
					{
					
						String test_i="";
					if(i<10)
						test_i="0"+i;
					else
						test_i=Integer.toString(i);
					
				%>
				<option value="<%=test_i%>:<%=temp%> AM" <%=chkd%>><%=test_i%>:<%=temp%> AM 
				<%
					}
					j=j+30;
				}
			}
			%>
			</select>
			
            to</font></td>
          </tr>
          <tr>
            <td width="149" height="23">&nbsp;</td>
            <td width="437" height="23">
            <input type="text" name="edate" id="edate" size="20" value = "<%=b_edate%>"  onclick="end_cal.toggle();"> Time:
			<font face="Arial" size="1"><select name="etime" id="etime" Style="font-size : 10px">
			<option>Time</option>
			<%
			chkd="";
			for(int i=1;i<24; i++)
			{
				for(int j=0;j<60;)
				{
					
					String temp="";
					if(j==0)
						temp="00";
					else temp=""+j;

					if(i==e_hour && j==e_min)
						chkd="selected=\"selected\"";
					else chkd="";
					if(i>=12)
					{
						int hours1=(i%12);
						String hours2="";
						if(hours1<10)
						{
							hours2="0"+hours1;
						}
						else
						{
							hours2=Integer.toString(hours1);
						}
						if(i==12)
						{
							hours2="12";							
						}
						
						
				%>
				<option value="<%=(hours2)%>:<%=temp%> PM" <%=chkd%>><%=(hours2)%>:<%=temp%> PM 
				<%
					}
				else
					{
						String test_i="";
						if(i<10)
						{
							test_i="0"+i;
						}
						else
							test_i=Integer.toString(i);

				%>
				<option value="<%=test_i%>:<%=temp%> AM" <%=chkd%>><%=test_i%>:<%=temp%> AM 
				<%
					}
					j=j+30;
				}
			}
			%>
			
			</select></font></td>
          </tr>
          <tr>
            <td width="149" align="center" height="22">
				<table width="100%">
				<tr>
					<td align="left">
					<font face="Arial" style="font-size: 12px;">Location </font></td>
					<td align="right">:</td>
				</tr>
				</table>
			</td>
            <td width="437" height="22"><font face="Arial" style="font-size: 12px;">
            <input type="text" name="locetion" id="locetion" value="<%=b_loc%>" size="61"></font></td>
          </tr>
          <tr>
            <td width="149" align="center" height="19">
            <table width="100%">
			<tr><td align="left">
            <font face="Arial" style="font-size: 12px;">Description </font></td><td align="right">
            :</td></tr></table></td>
            <td width="100%" rowspan="2" height="100%"><font face="Arial" style="font-size: 12px;">
            <textarea rows="3" name="desc" id="desc"  cols="48"><%=b_desc%></textarea></font></td>
          </tr>
          <tr>
            <td width="149" height="19">&nbsp;</td>
          </tr>
          <tr>
            <td width="149" height="20">
			<table width="100%">
			<tr><td align="left">
            <font face="Arial" style="font-size: 12px;">Permissions </font></td><td align="right">
            :</td></tr></table></td>
            <td width="437" valign="top" height="19">
            <!-- <p style="margin-top: 0; margin-bottom: 0"> --><font face="Arial" style="font-size: 12px;">
            <input type="radio" value="private" onclick="setdivvisibility(false)" name="sharing" id="sharing" <%=prv%>>Private</font><!-- </p> -->
            <!-- <p style="margin-top: 0; margin-bottom: 0"> --><font face="Arial" style="font-size: 12px;">
            <input type="radio" value="public" onclick="setdivvisibility(true)" name="sharing" id="sharing" <%=pub%>>Public</font></td>
          </tr>
		  
          <tr>
            <td width="149" height="19" valign="top">
            <table width="100%">
			<tr><td align="left">
            <font face="Arial" style="font-size: 12px;"><div id="invite_user">Invitation </div></font></td><td align="right">
            </td></tr></table></td>
            <td width="100%" height="100%">
			<div id="invite_user1">
            <p style="margin-top: 0; margin-bottom: 0"><font face="Arial" style="font-size: 12px;">
            <a href="#" onclick="getUsers()"; style="text-decoration: none">Invite users</a></font></p>
            <p style="margin-top: 0; margin-bottom: 0"><font face="Arial" style="font-size: 12px;">
            <textarea rows="3" name="users" id="users" cols="48"><%=users%></textarea></font>
			</div>
			</td>
          </tr>
	  
          </table>
      </td>
    </tr>
      <tr>
      <td width="100%" align="center"><font face="Arial">
      <input type="submit" value="Save" name="save1"><input type="reset" value="Reset" name="cancel1"></font></td>
    </tr> 
  </table>
  </center>
</form>
<script type="text/Javascript">
function backToSource(type)
{
	if("<%=uType%>"=='teacher')
	document.location.href="calendar.jsp?type=<%=input_type%>&dt=<%=getdate%>";
	else if("<%=uType%>"=='student')
	{
		document.location.href="studentcalendar.jsp?type=<%=input_type%>&dt=<%=getdate%>";
	}
}
function getUsers()
{
	var orgs="";
	if((document.form.title.value).length>0)
	{
		orgs+="TI:"+document.form.title.value;
	}
	 if((document.form.sdate.value).length>0)
	{
		orgs+=",SD:"+document.form.sdate.value;
	}
	
	
	if((document.form.stime.value).length>0)
	{
		orgs+=",ST:"+document.form.stime.value;
	}
	//end date and time
	if((document.form.edate.value).length>0)
	{
		orgs+=",ED:"+document.form.edate.value;
	}
	
	//Permission
	for( i = 0; i < document.form.sharing.length; i++ )
			{
			if( document.form.sharing[i].checked == true )
			orgs+=",SH:"+ document.form.sharing[i].value;
			}

	//location
	if((document.form.locetion.value).length>0)
	{
		orgs+=",LO:"+document.form.locetion.value;
	}

	//Description

	if((document.form.desc.value).length>0)
	{
		
		orgs+=",DES:"+document.form.desc.value;
	}
	if((document.form.etime.value).length>0)
	{

		orgs+=",ET:"+document.form.etime.value;
	}
	
	document.location.href="shareFile.jsp?orgs="+orgs+"&dt=<%=getdate%>&mode=add&type=<%=input_type%>";
}
</script>
</body>

</html>
<%@ page import="sqlbean.DbBean,bean.Validate,coursemgmt.ExceptionsFile"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Edit Event</title>
<!-- TinyMCE -->
<script type="text/javascript" src="../../tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">
	tinyMCE.init({

	// General options
		mode : "textareas",
		theme : "advanced",
		plugins : "pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,wordcount,advlist,autosave",

		// Theme options
		theme_advanced_buttons1 : "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
		theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
		theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
		theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak,restoredraft",
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : true,

		// Example content CSS (should be your site CSS)
		content_css : "css/content.css",

		// Drop lists for link/image/media/template dialogs
		template_external_list_url : "lists/template_list.js",
		external_link_list_url : "lists/link_list.js",
		external_image_list_url : "lists/image_list.js",
		media_external_list_url : "lists/media_list.js",

		// Style formats
		style_formats : [
			{title : 'Bold text', inline : 'b'},
			{title : 'Red text', inline : 'span', styles : {color : '#ff0000'}},
			{title : 'Red header', block : 'h1', styles : {color : '#ff0000'}},
			{title : 'Example 1', inline : 'span', classes : 'example1'},
			{title : 'Example 2', inline : 'span', classes : 'example2'},
			{title : 'Table styles'},
			{title : 'Table row 1', selector : 'tr', classes : 'tablerow1'}
		],

		// Replace values for the template plugin
		template_replace_values : {
			username : "Some User",
			staffid : "991234"
		}
	});
</script>
<!-- /TinyMCE -->
<script type="text/javascript" src="../calendar/epoch_classes.js"></script>
<script type="text/javascript" src="../JS/time.js"></script>
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
	
	var sdate=document.form.sdate.value;
	var edate=document.form.edate.value;
	
	if(title==null||title=="")
		{
		  alert("Please enter title");
		  document.getElementById("title").focus();
		  return false;
		}
	
	else if(sdate==null||sdate=="")
		{
		  alert("Please enter Start date");
		  document.getElementById("sdate").focus();
		  return false;
		}
	
	else
	{
			//for current date 
			var cr_date = new Date();
			
			var sdt = new Date(sdate);//.toDDMMYYYYString();
			var edt = new Date(edate);//.toDDMMYYYYString();
					
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
function setdivvisibility(show) {
if(show)
showvar="visible";
else
showvar="hidden";
document.getElementById("invite_user").style.visibility = showvar;
document.getElementById("invite_user1").style.visibility = showvar;
}
</script>
<%!
Connection con=null;
Statement st=null;
ResultSet rs=null;
private DbBean bean=null;
String b_title="",b_sdate="",b_stime="",b_edate="",b_etime="",b_loc="",b_desc="",pub="",prv="";
int s_hour=0,s_min=0,e_hour=0,e_min=0;
String data[]={};
String users="";
%>
</head>

<body>
<%
String getdate="";
java.util.Date dt=null;

int id=Integer.parseInt(request.getParameter("uid"));


String query="select * from event where id="+id;
try{
	bean=new DbBean();
	con=bean.getConnection();

	st=con.createStatement();
	rs=st.executeQuery(query);
%>
<form method="POST" name="form" action="../../save.saveEvent" onsubmit="return validateForm();">
 
 <table border="0" cellspacing="0" width="70%" id="AutoNumber3" bgcolor="#429EDF" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" >
  <tr>
    <td width="50%" height="28"><font face="Arial" style="font-size: 12px;"><b>&nbsp;<font color="#FFFFFF" style="font-size: 12px;"><input type="submit" value="Update" name="save1">  </font></b></font></td>
	<td width="50%" height="24" align="right">
	<a href="#" onclick="back_to_view()"><IMG SRC="../images/back.png" WIDTH="22" HEIGHT="22" BORDER="0" ALT="Back"></a>&nbsp;
	</td>
  </tr>
</table>
<center>
 <table border="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
  <input type="hidden" name="mode" value="edit">
  <input type="hidden" name="id" value="<%=id%>">
  <%
	String title="",sdate="",edate="",stime="",etime="",desp="",loc="",permission="",pri="",pub="";
	if(rs.next())
	{
		if(!(rs.getString("title").equals("null")))
			title=rs.getString("title");
		if(!(rs.getString("sdate").equals("null")))
		{
			sdate=rs.getString("sdate");
			int year=Integer.parseInt(sdate.substring(0,sdate.indexOf("-")));
			int month=Integer.parseInt(sdate.substring(sdate.indexOf("-")+1,sdate.lastIndexOf("-")));
			int day=Integer.parseInt(sdate.substring(sdate.lastIndexOf("-")+1));
			sdate=month+"/"+day+"/"+year;
		}
		if(!(rs.getString("edate").equals("null")))
		{
			edate=rs.getString("edate");
			int year=Integer.parseInt(edate.substring(0,edate.indexOf("-")));
			int month=Integer.parseInt(edate.substring(edate.indexOf("-")+1,edate.lastIndexOf("-")));
			int day=Integer.parseInt(edate.substring(edate.lastIndexOf("-")+1));
			edate=month+"/"+day+"/"+year;
		}
		if(!(rs.getString("stime").equals("null")))
			stime=rs.getString("stime");
		if(!(rs.getString("etime").equals("null")))
			etime=rs.getString("etime");
		if(!(rs.getString("locetion").equals("null")))
			loc=rs.getString("locetion");
		if(!(rs.getString("desp").equals("null")))
			desp=rs.getString("desp");

		if(!(rs.getString("sharing").equals("null")))
			permission=rs.getString("sharing");
		if(!(rs.getString("users").equals("null")))
			users=rs.getString("users");
		
		if(permission.equals("public"))
		{
			pub="checked";
		}
		if(permission.equals("private"))
		{
			pri="checked";
		}
		if(request.getParameter("u_List")!=null)
		users=users+request.getParameter("u_List");
		
		%><%
		if(rs.getString("stime")!=null && !(rs.getString("stime").equals("Time")))
		{
			String time_s=rs.getString("stime");
			//s_hour=Integer.parseInt(time_s.substring(0,2));
			//s_min=Integer.parseInt(time_s.substring(3,5));
			s_hour=Integer.parseInt(time_s.substring(0,time_s.indexOf(":")));
			s_min=Integer.parseInt(time_s.substring(time_s.indexOf(":")+1,time_s.indexOf(":")+3));
			if(s_hour>12)
			s_hour=s_hour%12;
		}
%><%
		if(rs.getString("etime")!=null && !(rs.getString("etime").equals("Time")))
		{
			String time_e=rs.getString("etime");
			
			
			e_hour=Integer.parseInt(time_e.substring(0,time_e.indexOf(":")));
			//e_hour=Integer.parseInt(time_e.substring(0,time_e.indexOf(":")));
			
			//e_min=Integer.parseInt(time_e.substring(3,5));
			e_min=Integer.parseInt(time_e.substring(time_e.indexOf(":")+1,time_e.indexOf(":")+3));
			//System.out.println("Hours before :"+b_stime.substring(3,5));
			if(e_hour>12)
			e_hour=e_hour%12;
		}
	%>
    <!-- <tr>
      <td width="100%"><font face="Arial">
      <input type="submit" value="Update" name="save"><input type="reset" value="Back" name="Back"></font></td>
    </tr> -->
    <tr>
      <td width="100%">
      <!-- <div align="left"> -->
       
        <table border="0" cellpadding="0" cellspacing="10" style="border-collapse: collapse" bordercolor="#111111" width="587" id="AutoNumber2" height="20%">
          <tr>
            <td width="100%" height="100%">
            <table width="100%">
			<tr><td align="left">
            <font face="Arial" style="font-size: 12px;">Title </font></td><td align="right">
            :</td></tr></table>
			</td>
            <td width="100%" height="100%"><font face="Arial" style="font-size: 12px;">
            <input type="text" name="title" id="title" value="<%=title%>" readonly size="61"></font></td>
          </tr>
          <tr>
            <td width="149" height="23">
            <table width="100%">
			<tr><td align="left">
            <font face="Arial" style="font-size: 12px;">Date and Time</font></td><td align="right">
            :</td></tr></table>
			</td>
            <td width="437" height="23">
            <input type="text" name="sdate" id="sdate" value="<%=sdate%>" size="20"   onclick="start_cal.toggle();"> Time:
			<font face="Arial" size=1><select name="stime" id="stime" Style="font-size : 10px">
			<option>Time</option>
			<%
			String chkd="";
			for(int i=1;i<24; i++)
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
					
					if(i>12)
					{
						
				%>
				<option value="<%=i%>:<%=temp%> PM" <%=chkd%>><%=(i%12)%>:<%=temp%> PM 
				<%
					}
				else
					{
				%>
				<option value="<%=i%>:<%=temp%> AM" <%=chkd%>><%=i%>:<%=temp%> AM 
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
            <input type="text" name="edate" id="edate" size="20" value = "<%=edate%>"  onclick="end_cal.toggle();"> Time:
			<select name="etime" id="etime" Style="font-size : 10px" >
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
					if(i>12)
					{
						
				%>
				<option value="<%=i%>:<%=temp%> PM" <%=chkd%>><%=(i%12)%>:<%=temp%> PM 
				<%
					}
				else
					{
				%>
				<option value="<%=i%>:<%=temp%> AM" <%=chkd%>><%=i%>:<%=temp%> AM 
				<%
					}
					j=j+30;
				}
			}
			%>
			
			</select></td>
          </tr>
          <tr>
            <td width="149" align="center" height="22">
            <p align="right"><font face="Arial" style="font-size: 12px;">
            Location&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :&nbsp;</font></td>
            <td width="437" height="22"><font face="Arial" style="font-size: 12px;">
            <input type="text" name="locetion" id="locetion" value="<%=loc%>" size="61"></font></td>
          </tr>
          <tr>
            <td width="149" align="center" height="19">
            <table width="100%">
			<tr><td align="left">
            <font face="Arial" style="font-size: 12px;">Description </font></td><td align="right">
            :</td></tr></table>
			</td>
            <td width="100%" rowspan="2" height="100%"><font face="Arial" style="font-size: 12px;">
            <textarea rows="3" name="desc" id="desc" cols="48"><%=desp%></textarea></font></td>
          </tr>
          <tr>
            <td width="149" height="19">&nbsp;</td>
          </tr>
           <tr>
            <td width="149" height="20">
            <table width="100%">
			<tr><td align="left">
            <font face="Arial" style="font-size: 12px;">Event type </font></td><td align="right">
            :</td></tr></table>
			</td>
            <td width="437" valign="top" height="19">
            <!-- <p style="margin-top: 0; margin-bottom: 0"> --><font face="Arial" style="font-size: 12px;">
            <input type="radio" value="private" onclick="setdivvisibility(false)" name="sharing" id="sharing" <%=pri%>>Private</font><!-- </p> -->
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
            <a href="#" onclick="getUsers()" style="text-decoration: none">Invite users</a></font></p>
            <p style="margin-top: 0; margin-bottom: 0"><font face="Arial" style="font-size: 12px;">
            <textarea rows="3" name="users" id="users" cols="48"><%=users%></textarea></font>
			</div>
			</td>
          </tr>
          </table>
        
      </div>
      </td>
    </tr>
	<%}%>
  </table>
  </center>
</form>
<script type="text/Javascript">
function getUsers()
{
	
	document.location.href="shareFile1.jsp?uid=<%=id%>";
}
	function back_to_view()
	{
		
		document.location.href="calendar.jsp?type=editpage&uid=<%=id%>&sdate=<%=sdate%>";
	}
</script>
<%}catch(Exception exp)
{
				exp.printStackTrace();
			}
			finally{
		try{
			
			if(rs!=null)
				rs.close();
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
		}catch(Exception e)
		{
			e.printStackTrace();
			//System.out.println("error is "+e);
			ExceptionsFile.postException("EditEvent.jsp","Database exception","Exception",e.getMessage());	
		}
	}

				%>
				
</body>

</html>
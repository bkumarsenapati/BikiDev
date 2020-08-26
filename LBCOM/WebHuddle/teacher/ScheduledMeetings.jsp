<%@ page import = "java.sql.*,java.sql.Statement" language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<!-- <jsp:useBean id="db" class="sqlbean.DbBean" scope="page"/> -->
<jsp:useBean id="con1" class="sqlbean.WHDbBean" scope="page" />

<%
	//final  String dbURL    = "jdbc:mysql://64.72.92.78:9306/webhuddle?user=root&password=whizkids";
	//final  String dbDriver = "com.mysql.jdbc.Driver";  
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null;
	int i=0,j=0;
	String userId="",schoolId="",emailId="",pwd="";
	int custId=0,maxCount=0,mid=0;
%>
<%	
	String sessid=(String)session.getAttribute("sessid");
	if (sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	
	try{
		
		userId=(String)session.getAttribute("emailid");
		schoolId=(String)session.getAttribute("schoolid");
		//emailId=userId+"@hotschools.net";
		emailId=userId+"@"+schoolId;
		//Class.forName(dbDriver );
		//con = DriverManager .getConnection( dbURL );
		con=con1.getConnection();
		session=request.getSession();
	
	
		//con=db.getConnection();
		
		
		st2 = con.createStatement();
		st3 = con.createStatement();
		st4= con.createStatement();
		rs3=st4.executeQuery("select password from lmscustomers where emailid='"+emailId+"'");
		if(rs3.next())
		{
			pwd=rs3.getString("password");
			
		}
		rs3.close();
		rs2=st2.executeQuery("select customer_id from customers where email='"+emailId+"'");
		if(rs2.next())
		{
			custId=rs2.getInt("customer_id");
		}
		rs2.close();		
		
		st = con.createStatement() ;
		//rs=st.executeQuery("select distinct wm.meeting_id,wm.meeting_name,wm.meeting_description,wm.meeting_key,wm.scheduled_start,wm.meeting_Start,wm.meeting_End,wc.first_name,wc.last_name,wc.city,wc.email from webhuddle.meetings as wm inner join webhuddle.customers as wc on wm.customer_id_fk=wc.customer_id and wc.email='"+emailId+"' where wm.meeting_Start>=curdate() and wm.meeting_End IS NULL");

		rs=st.executeQuery("select distinct wm.meeting_id,wm.meeting_name,wm.meeting_description,wm.meeting_key,wm.scheduled_start,wm.meeting_Start,wm.meeting_End,wc.first_name,wc.last_name,wc.city,wc.email from webhuddle.meetings as wm inner join webhuddle.customers as wc on wm.customer_id_fk=wc.customer_id where wm.meeting_Start>=curdate() and wm.meeting_End IS NULL");
		
		}catch(Exception e){
		try{
		
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			//ExceptionsFile.postException("QuestionImport.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			
		}
		e.printStackTrace();
	}
	
	
%>

<html>
<head>

<title>Import Utility</title>
 <!-- <base href="https://192.168.1.116:8446/logonpage123.jsp"> -->
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<SCRIPT LANGUAGE="JavaScript">
function popup(url){
	window.open(url,"AVW","width=800,height=400,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no,copyhistory=no");
	//window.refresh();
}
function popup1(url){
	
	window.location.href=url;
	//window.open(url,"AVW","width=800,height=400,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no,copyhistory=no");
	//window.refresh();
}
function showRecordings(rec)
{
	
	//document.logonForm.action=rec;
	//document.logonForm.submit();
	window.open(rec,"AVW","width=800,height=400,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no,copyhistory=no");
	
}
function showParticipants(mid,mname)
{
	window.open("ParticipantsList.jsp?mid="+mid+"&mname="+mname,"Document","resizable=no,scrollbars=yes,width=550,height=400,toolbars=no");
}

function startMeeting(ip)
{
	document.logonForm.action=ip;
	
	document.logonForm.submit();
	var t=setTimeout("refresh()",10000);
}
function refresh()
{
	window.location.href=window.location.href
}
function timedRefresh(timeoutPeriod)
{
	setTimeout("location.reload(true);",timeoutPeriod);
}

</SCRIPT>
</head>
 <DIV id="loading"  style='WIDTH:100%;height:100%; POSITION: absolute; TEXT-ALIGN: center;border: 3px solid;z-index:1;visibility:hidden'><IMG src="/LBCOM/common/images/loading.gif" border=0></DIV>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
<BR>
<table border="1" width="100%" align="center" cellspacing="2" bordercolordark="#333333" bordercolorlight="#333333" bordercolor="#333333" cellpadding="2">
    <tr>
        <td height="34" bgcolor="#CCCCCC" background="../icons/bg.jpg">
            <p align="center"><a href="#" onclick="javascript:document.logonForm.submit(); return false;" target=_new><span style="font-size:10pt;">
				<font face="Arial"><b>Schedule Virtual Classroom</b></a></font></span></p>
        </td>
        <td height="34" bgcolor="#CCCCCC" background="../icons/bg.jpg">
            <p align="center"><span style="font-size:10pt;"><a href="#" onclick="showRecordings('https://www.learnbeyond.net:8443/recordings.do');return false;" ><font face="Arial"><b>Classroom Archives</b></a></font></span></p>
        </td>
    </tr>
</table>
<br>
	  <table border="1" width="100%" align="center" cellspacing="2" bordercolordark="#333333" bordercolorlight="#333333" bordercolor="#333333" cellpadding="2" height="80">
    <tr>
        <td width="668" height="34" bgcolor="#E8E8E8" colspan="4"><font face="Arial"><span style="font-size:11pt;"><b><img src="../icons/chalk_board.png" width="24" height="24" border="0" align="absmiddle">Current Virtual Classroom(s)</b></span></font></td>
    </tr>
  <tr>
        <td height="34" bgcolor="#CCCCCC" width="127" background="../icons/bg.jpg">
            <p><span style="font-size:10pt;"><font face="Arial"><b>&nbsp;<img src="../icons/computer.png" width="18" height="18" border="0" align="absmiddle"> Classroom(s)</b></font></span></p>
        </td>
        <td width="330" height="34" bgcolor="#CCCCCC" background="../icons/bg.jpg">
            <p><span style="font-size:10pt;"><font face="Arial"><b>&nbsp;<img src="../icons/window_edit.png" width="18" height="18" border="0" align="absmiddle"> Description</b></font></span></p>
        </td>
        <td width="87" height="34" bgcolor="#CCCCCC" background="../icons/bg.jpg">
            <p align="center"><font face="Arial"><span style="font-size:11pt;"><b><img src="../icons/clock.png" width="18" height="18" border="0" align="absmiddle"></b></span></font><span style="font-size:10pt;"><font face="Arial"><b> Time</b></font></span></p>
        </td>
        <td width="100" height="34" bgcolor="#CCCCCC" background="../icons/bg.jpg">
            <p align="center"><font face="Arial"><span style="font-size:11pt;"><b><img src="../icons/she_user.png" width="18" height="18" border="0" align="absmiddle"></b></span></font><span style="font-size:10pt;"><font face="Arial"><b> Created By</b></font></span></p>
        </td>
    </tr>
<%		
		while(rs.next())
		{
			
			i++;
			
%>
   <tr>
        <td width="127" height="34" bgcolor="#F0ECE1">
			<a href="#" onclick="if(confirm('Are you sure you want to join this meeting')){popup('https://www.learnbeyond.net:8443/j.do?key=<%=rs.getString("meeting_key")%>&mID=<%=rs.getString("meeting_id")%>&displayName=<%=userId%>&emailID=<%=emailId%>');}else{ return false;}"><font face="Arial" size="2" color="green"><%=rs.getString("meeting_name")%></font></a></td>
        <td width="330" height="34" bgcolor="#F0ECE1"><%=rs.getString("meeting_description")%></td>
		        
		<td width="87" height="34" bgcolor="#F0ECE1"><font face="Arial" size="2">&nbsp;<%=rs.getString("meeting_Start")%></font></td>
        <td width="100" height="34" bgcolor="#F0ECE1">
			<font face="Arial" size="2">&nbsp; <%=rs.getString("first_name")%> <%=rs.getString("last_name")%></font>
		</td>
    </tr>
<%
		}
		if(i==0)
		{
%>
			<tr>
			<td colspan="4" width="100%" height="34" bgcolor="#F0ECE1" align="center">No meetings are running.</td>
			</tr>
			
<%		}
%>
 </table>
<br>
<table border="1" width="100%" align="center" cellspacing="2" bordercolordark="#333333" bordercolorlight="#333333" bordercolor="#333333" cellpadding="2" height="80">
    <tr>
        <td width="689" height="34" bgcolor="#E8E8E8" colspan="6"><font face="Arial"><span style="font-size:11pt;"><b><img src="../icons/chalk_board.png" width="24" height="24" border="0" align="absmiddle">Scheduled Virtual Classroom(s)</b></span></font></td>
    </tr>
    <tr>
        <td height="34" bgcolor="#CCCCCC" width="130" background="../icons/bg.jpg">
            <p><span style="font-size:10pt;"><font face="Arial"><b>&nbsp;<img src="../icons/computer.png" width="18" height="18" border="0" align="absmiddle"> Classroom(s)</b></font></span></p>
        </td>
        <td width="168" height="34" bgcolor="#CCCCCC" background="../icons/bg.jpg">
            <p><span style="font-size:10pt;"><font face="Arial"><b>&nbsp;<img src="../icons/window_edit.png" width="18" height="18" border="0" align="absmiddle"> Description</b></font></span></p>
        </td>
        <td width="67" height="34" bgcolor="#CCCCCC" background="../icons/bg.jpg">
            <p align="center"><span style="font-size:10pt;"><font face="Arial"><b><img src="../icons/community_users.png" width="18" height="18" border="0" align="absmiddle"></b></font></span><span style="font-size:10pt;"><font face="Arial"><b> Add</b></font></span></p>
        </td>
        <td width="113" height="34" bgcolor="#CCCCCC" background="../icons/bg.jpg">
            <p align="center"><span style="font-size:10pt;"><font face="Arial"><b><img src="../icons/community_users.png" width="18" height="18" border="0" align="absmiddle"></b></font></span><span style="font-size:10pt;"><font face="Arial"><b> Participants</b></font></span></p>
        </td>
        <td width="71" height="34" bgcolor="#CCCCCC" background="../icons/bg.jpg">
            <p align="center"><font face="Arial"><span style="font-size:11pt;"><b><img src="../icons/clock.png" width="18" height="18" border="0" align="absmiddle"></b></span></font><span style="font-size:10pt;"><font face="Arial"><b> Time</b></font></span></p>
        </td>
        <td width="100" height="34" bgcolor="#CCCCCC" background="../icons/bg.jpg">
            <p align="center"><font face="Arial"><span style="font-size:11pt;"><b><img src="../icons/she_user.png" width="18" height="18" border="0" align="absmiddle"></b></span></font><span style="font-size:10pt;"><font face="Arial"><b> Created By</b></font></span></p>
        </td>
    </tr>
     <tr>
	<%
		st1 = con.createStatement() ;
		rs1=st1.executeQuery("select distinct wm.meeting_id,wm.meeting_name,wm.meeting_description,wm.meeting_key,wm.scheduled_start,wm.meeting_Start,wm.meeting_End,wc.first_name,wc.last_name,wc.city,wc.email from webhuddle.meetings as wm inner join webhuddle.customers as wc on wm.customer_id_fk=wc.customer_id and wc.email='"+emailId+"' where (wm.scheduled_start>=curdate() or wm.scheduled_start<=curdate()) and wm.meeting_Start IS NULL");

		while(rs1.next())
		{
			j++;
			mid=rs1.getInt("meeting_id");
		
			rs3=st3.executeQuery("select count(invitation_id) from invitations where meeting_id_fk="+mid+"");
			if(rs3.next())
			{
				maxCount=rs3.getInt(1);
			}
			else
			{
				maxCount=0;
			}
			rs3.close();
			
%>
  <tr>
        
		
		<%
			if(maxCount>0)
			{
%>
				<td width="130" height="34" bgcolor="#F0ECE1">
					<a href="#" onclick="if(confirm('Are you sure you want to start this meeting')){startMeeting('https://www.learnbeyond.net:8443/openmeeting.do?meetingID=<%=rs1.getInt("meeting_id")%>');}else{ return false;}"><font color="Green" face="Arial" size="2"> <%=rs1.getString("meeting_name")%></font>

					<!-- <a href="#" onclick="if(confirm('Are you sure you want to add participants to this meeting')){popup1('http://192.168.1.8:8080/LBCOM/WebHuddle/teacher/MeetingPermissions.jsp?mid=<%=rs1.getInt("meeting_id")%>&emailID=<%=userId%>@<%=schoolId%>');}else{ return false;}"><font color="Green" face="Arial" size="2"> <%=rs1.getString("meeting_name")%></font> -->
				</td>
				<td width="168" height="34" bgcolor="#F0ECE1"><%=rs1.getString("meeting_description")%></td>
				<td width="67" height="34" bgcolor="#F0ECE1" align="center">
					<a href="#" onclick="if(confirm('Are you sure you want to add participants to this meeting')){popup1('http://oh.learnbeyond.net:8080/LBCOM/WebHuddle/teacher/MeetingPermissions.jsp?mid=<%=rs1.getInt("meeting_id")%>&emailID=<%=userId%>@<%=schoolId%>');}else{ return false;}"><font color="Green" face="Arial" size="2">Add</font>
				</td>
				<td width="113" height="34" bgcolor="#F0ECE1" align="center">
					<a href="#" onclick="showParticipants('<%=rs1.getInt("meeting_id")%>','<%=rs1.getString("meeting_name")%>');return false;">
					<font color="Green" face="Arial" size="2"> <%=maxCount%></font>
				</td>
				
<%			}
			else
			{
%>				<td width="130" height="34" bgcolor="#F0ECE1">
					<font color="red" face="Arial" size="2"> <%=rs1.getString("meeting_name")%>
				</td>
				<td width="168" height="34" bgcolor="#F0ECE1"><%=rs1.getString("meeting_description")%></td>
				<td width="67" height="34" bgcolor="#F0ECE1" align="center">
					<a href="#" onclick="if(confirm('Are you sure you want to add participants to this meeting')){popup1('http://oh.learnbeyond.net:8080/LBCOM/WebHuddle/teacher/MeetingPermissions.jsp?mid=<%=rs1.getInt("meeting_id")%>&emailID=<%=userId%>@<%=schoolId%>');}else{ return false;}"><font color="red" face="Arial" size="2">Add</font>
				</td>
				<td width="113" height="34" bgcolor="#F0ECE1" align="center">
					<a href="#" onclick="showParticipants('<%=rs1.getInt("meeting_id")%>','<%=rs1.getString("meeting_name")%>');return false;">
					<font color="red" face="Arial" size="2"> <%=maxCount%></font>
				</td>
<%			}
%>
		
		
		
		<td width="71" height="34" bgcolor="#F0ECE1">
			<font face="Arial" size="2">Time:&nbsp;<%=rs1.getString("scheduled_start")%></font></td>
        <td width="100" height="34" bgcolor="#F0ECE1">
			<font face="Arial" size="2">&nbsp; <%=rs1.getString("first_name")%> <%=rs1.getString("last_name")%></font></td></font></td>
      </tr>
<%
		}
		if(j==0)
		{
%>
			<tr>
			<td colspan="6" width="100%" height="34" bgcolor="#F0ECE1" align="center">No meetings are scheduled.</td>
			</tr>
			</tr>
</table>
<br>
<p>&nbsp;</p>
<%		}
%>



<%
	try{
	if(con!=null && !con.isClosed())
		con.close() ;
}catch(Exception e ){}
%>

<form name= "logonForm" action="https://www.learnbeyond.net:8443/logon.do" method='post' target='_new'>
<input type='hidden' name='username' value='<%=emailId%>'/>
<input type='hidden' name='password' value='<%=pwd%>'/>
</body>
</form>
</html>
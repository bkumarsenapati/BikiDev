<%@ page import = "java.sql.*,java.sql.Statement" language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.WHDbBean" scope="page" />

<%
	
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rs2=null;
	int i=0,j=0;
	String userId="",schoolId="",emailId="";
	int custId=0;
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
		emailId=userId+"@"+schoolId;
		con=con1.getConnection();
		session=request.getSession();
			
		st = con.createStatement() ;
		//rs=st.executeQuery("select distinct wm.meeting_id,wm.meeting_name,wm.meeting_description,wm.meeting_key,wm.scheduled_start,wm.meeting_Start,wm.meeting_End,wc.first_name,wc.last_name,wc.city,wc.email from webhuddle.meetings as wm inner join webhuddle.customers as wc on wm.customer_id_fk=wc.customer_id where wm.meeting_Start>=curdate() and wm.meeting_End IS NULL");
		
		rs=st.executeQuery("select distinct wm.meeting_id,wm.meeting_name,wm.meeting_description,wm.meeting_key,wm.scheduled_start,wm.meeting_Start,wm.meeting_End,wc.first_name,wc.last_name,wc.city,wc.email from webhuddle.meetings as wm,webhuddle.customers as wc,webhuddle.invitations as wi where wi.email='"+emailId+"' and wm.meeting_id=wi.meeting_id_fk and wm.customer_id_fk=wc.customer_id and wm.meeting_Start>=curdate() and wm.meeting_End IS NULL");
		
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
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<SCRIPT LANGUAGE="JavaScript">
function popup(url)
{
	window.open(url,"AVW","width=800,height=400,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no,copyhistory=no");
}
</SCRIPT>
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
<form name= "wh" method="post" enctype="multipart/form-data">

<table border="1" width="700" align="center" cellspacing="2" bordercolordark="#333333" bordercolorlight="#333333" bordercolor="#333333" cellpadding="2" height="80">
    <tr>
        <td width="668" height="34" bgcolor="#E8E8E8" colspan="4"><font face="Arial"><span style="font-size:11pt;"><b><img src="/LBCOM/WebHuddle/icons/chalk_board.png" width="24" height="24" border="0" align="absmiddle">Current Virtual Classroom(s)</b></span></font></td>
    </tr>
    <tr>
        <td height="34" bgcolor="#CCCCCC" width="127" background="/LBCOM/WebHuddle/icons/bg.jpg">
            <p><span style="font-size:10pt;"><font face="Arial"><b>&nbsp;<img src="/LBCOM/WebHuddle/icons/computer.png" width="18" height="18" border="0" align="absmiddle"> Classroom(s)</b></font></span></p>
        </td>
        <td width="330" height="34" bgcolor="#CCCCCC" background="/LBCOM/WebHuddle/icons/bg.jpg">
            <p><span style="font-size:10pt;"><font face="Arial"><b>&nbsp;<img src="/LBCOM/WebHuddle/icons/window_edit.png" width="18" height="18" border="0" align="absmiddle"> Description</b></font></span></p>
        </td>
        <td width="87" height="34" bgcolor="#CCCCCC" background="/LBCOM/WebHuddle/icons/bg.jpg">
            <p align="center"><font face="Arial"><span style="font-size:11pt;"><b><img src="/LBCOM/WebHuddle/icons/clock.png" width="18" height="18" border="0" align="absmiddle"></b></span></font><span style="font-size:10pt;"><font face="Arial"><b> Time</b></font></span></p>
        </td>
        <td width="100" height="34" bgcolor="#CCCCCC" background="/LBCOM/WebHuddle/icons/bg.jpg">
            <p align="center"><font face="Arial"><span style="font-size:11pt;"><b><img src="/LBCOM/WebHuddle/icons/she_user.png" width="18" height="18" border="0" align="absmiddle"></b></span></font><span style="font-size:10pt;"><font face="Arial"><b> Created By</b></font></span></p>
        </td>
    </tr>

<%		
		while(rs.next())
		{
			
			i++;
			
%>
 <tr>
        <td width="127" height="34" bgcolor="#F0ECE1">
		
			<a href="#" onclick="if(confirm('Are you sure you want to join this meeting')){popup('https://www.learnbeyond.net:8443/j.do?key=<%=rs.getString("meeting_key")%>&mID=<%=rs.getString("meeting_id")%>&displayName=<%=userId%>&emailID=<%=userId%>@<%=schoolId%>');}else{ return false;}"><font face="Arial" size="2" color="green"><%=rs.getString("meeting_name")%></font></a></td>
        
		<td width="330" height="34" bgcolor="#F0ECE1"><%=rs.getString("meeting_description")%></td>
		
        
		<td width="87" height="34" bgcolor="#F0ECE1">
			<font face="Arial" size="2">&nbsp;<%=rs.getString("meeting_Start")%></font></td>
        <td width="100" height="34" bgcolor="#F0ECE1">
			<font face="Arial" size="2">&nbsp; <%=rs.getString("first_name")%> <%=rs.getString("last_name")%></font></td>
      </tr>
<%
		}
		if(i==0)
		{
%>
			<tr>
			<td colspan=4 width="100%" height="34" bgcolor="#F0ECE1" align="center">No meetings are running.</td>
			</tr>
			</table>
<%		}
%>
 <br>
<table border="1" width="701" align="center" cellspacing="2" bordercolordark="#333333" bordercolorlight="#333333" bordercolor="#333333" cellpadding="2" height="80">
    <tr>
        <td width="689" height="34" bgcolor="#E8E8E8" colspan="6"><font face="Arial"><span style="font-size:11pt;"><b><img src="/LBCOM/WebHuddle/icons/chalk_board.png" width="24" height="24" border="0" align="absmiddle">Scheduled Virtual Classroom(s)</b></span></font></td>
    </tr>
    <tr>
        <td height="34" bgcolor="#CCCCCC" width="130" background="/LBCOM/WebHuddle/icons/bg.jpg">
            <p><span style="font-size:10pt;"><font face="Arial"><b>&nbsp;<img src="/LBCOM/WebHuddle/icons/computer.png" width="18" height="18" border="0" align="absmiddle"> Classroom(s)</b></font></span></p>
        </td>
        <td width="168" height="34" bgcolor="#CCCCCC" background="/LBCOM/WebHuddle/icons/bg.jpg">
            <p><span style="font-size:10pt;"><font face="Arial"><b>&nbsp;<img src="/LBCOM/WebHuddle/icons/window_edit.png" width="18" height="18" border="0" align="absmiddle"> Description</b></font></span></p>
        </td>
        <td width="71" height="34" bgcolor="#CCCCCC" background="/LBCOM/WebHuddle/icons/bg.jpg">
            <p align="center"><font face="Arial"><span style="font-size:11pt;"><b><img src="/LBCOM/WebHuddle/icons/clock.png" width="18" height="18" border="0" align="absmiddle"></b></span></font><span style="font-size:10pt;"><font face="Arial"><b> Time</b></font></span></p>
        </td>
        <td width="100" height="34" bgcolor="#CCCCCC" background="/LBCOM/WebHuddle/icons/bg.jpg">
            <p align="center"><font face="Arial"><span style="font-size:11pt;"><b><img src="/LBCOM/WebHuddle/icons/she_user.png" width="18" height="18" border="0" align="absmiddle"></b></span></font><span style="font-size:10pt;"><font face="Arial"><b> Created By</b></font></span></p>
        </td>
    </tr>
    <tr>
	<%
		st1 = con.createStatement() ;
		//rs1=st1.executeQuery("select distinct wm.meeting_id,wm.meeting_name,wm.meeting_description,wm.meeting_key,wm.scheduled_start,wm.meeting_Start,wm.meeting_End,wc.first_name,wc.last_name,wc.city,wc.email from webhuddle.meetings as wm inner join webhuddle.customers as wc on wm.customer_id_fk=wc.customer_id where (wm.scheduled_start>=curdate() or wm.scheduled_start<=curdate()) and wm.meeting_Start IS NULL");

		rs1=st1.executeQuery("select distinct wm.meeting_id,wm.meeting_name,wm.meeting_description,wm.meeting_key,wm.scheduled_start,wm.meeting_Start,wm.meeting_End,wc.first_name,wc.last_name,wc.city,wc.email from webhuddle.meetings as wm,webhuddle.customers as wc,webhuddle.invitations as wi where wi.email='"+emailId+"' and wm.meeting_id=wi.meeting_id_fk and wm.customer_id_fk=wc.customer_id and (wm.scheduled_start>=curdate() or wm.scheduled_start<=curdate()) and wm.meeting_Start IS NULL");

		while(rs1.next())
		{
			j++;
			
%>
  <tr>
        
        <td width="130" height="34" bgcolor="#F0ECE1">
			<font color="red" face="Arial" size="2"> <%=rs1.getString("meeting_name")%></td>
		<td width="168" height="34" bgcolor="#F0ECE1"> <%=rs1.getString("meeting_description")%></td>
		
		<td width="71" height="34" bgcolor="#F0ECE1">
			<font face="Arial" size="2">&nbsp;<%=rs1.getString("scheduled_start")%></font></td>
        <td width="100" height="34" bgcolor="#F0ECE1">
			<font face="Arial" size="2">&nbsp; <%=rs1.getString("first_name")%> <%=rs1.getString("last_name")%></font></td></font></td>
      </tr>
<%
		}
		if(j==0)
		{
%>
			<tr>
			<td colspan=4 width="100%" height="34" bgcolor="#F0ECE1" align="center">No meetings are scheduled.</td>
			</tr>
			</table>
<%		}
%>



<%
	try{
	if(con!=null && !con.isClosed())
		con.close() ;
}catch(Exception e ){}
%>
</form>
</body>
</html>
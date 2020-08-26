<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader ("Expires", -1);
%>
<html>
<head>

<title>Student Boards</title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<SCRIPT LANGUAGE="JavaScript">
function popup(url){
	window.open(url,"Document","width=800,height=400,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no,copyhistory=no");
	//window.refresh();
}
</SCRIPT>
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" topmargin="0" leftmargin="0">


<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	int i=0,j=0;
	String userId="",schoolId="",emailId="",webinarId="";

%>
<%	
	
	try
	{
		
		//userId=(String)session.getAttribute("emailid");
		//schoolId=(String)session.getAttribute("schoolid");
		//emailId=userId+"@"+schoolId;
		
		schoolId=request.getParameter("facilityid");
		emailId=request.getParameter("userid");
		webinarId=request.getParameter("wid");
		System.out.println("%%%%%% schoolId..."+schoolId+"emailId...."+emailId+"webinarId..."+webinarId);
		if(emailId==null||webinarId==null||schoolId==null)
		{
			out.println("<html><script> window.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		

		con=con1.getConnection();
		st = con.createStatement() ;
		

		//rs=st.executeQuery("select distinct bi.teacher_id,bi.course_id,bi.att_url,bi.meeting_id,bi.start_date,bi.end_date from bbb_master as bi inner join coursewareinfo_det as cd on bi.course_id=cd.course_id where cd.student_id='"+userId+"' and bi.school_id='"+schoolId+"' and cd.school_id='"+schoolId+"' and bi.start_date<=curdate() and bi.end_date IS NULL and status!=1");
		
		System.out.println("select bm.teacher_id,em.webinar_name,bm.att_url,bm.webinar_id from bbb_master bm inner join eclassmaster em on bm.webinar_id=em.webinar_id and bm.school_id=em.school_id where bm.school_id='"+schoolId+"' and bm.webinar_id='"+webinarId+"' and bm.start_date<=curdate()");

		rs=st.executeQuery("select bm.teacher_id,em.webinar_name,bm.att_url,bm.webinar_id from bbb_master bm inner join eclassmaster em on bm.webinar_id=em.webinar_id and bm.school_id=em.school_id where bm.school_id='"+schoolId+"' and bm.webinar_id='"+webinarId+"' and bm.start_date<=curdate() and bm.end_date is null");

		
%>


<form name= "wh" method="post" enctype="multipart/form-data">

<table  border="1" style="border:2px outset #eb473b; margin-top:-18px;" width="100%" align="left" cellspacing="2" bordercolordark="#9db38a" bordercolorlight="#9db38a" bordercolor="#9db38a" >
    <tr>
        <td width="100%" bgcolor="#9db38a" colspan="4"><font face="Arial" color="#FFFFFF"><span style="font-size:11pt;"><b><img src="../WhiteBoard/icons/chalk_board.png" width="24" height="24" border="0" align="absmiddle">&nbsp;Boards</b></span></font></td>
    </tr>
    <tr>
        <td bgcolor="#ffea9d" width="60%" >
            <p><span style="font-size:10pt;"><font face="Arial"><b>&nbsp;<img src="../WhiteBoard/icons/computer.png" width="18"  border="0" align="absmiddle">&nbsp;Boards in session</b></font></span></p>
        </td>
        <!-- <td width="220" height="34" bgcolor="#CCCCCC" background="../icons/bg.jpg">
            <p align="center"><font face="Arial"><span style="font-size:11pt;"><b><img src="../icons/clock.png" width="18" height="18" border="0" align="absmiddle"></b></span></font><span style="font-size:10pt;"><font face="Arial"><b> Time</b></font></span></p>
        </td> -->
        <td width="40%"  bgcolor="#ffea9d" >
            <p align="center"><font face="Arial"><span style="font-size:11pt;"><b><img src="../WhiteBoard/icons/she_user.png" width="18" height="18" border="0" align="absmiddle"></b></span></font><span style="font-size:10pt;"><font face="Arial"><b> Created By</b></font></span></p>
        </td>
    </tr>

<%		
		if(rs.next())
		{
			
			i++;
			String std_id="&username="+emailId;

			//String attdURL=rs.getString("att_url");			
			//attdURL=attdURL.replaceAll("invite","enter");
			
			rs.getString("webinar_id");
			String attdURL=rs.getString("att_url");			
			attdURL=attdURL.replaceAll("invite","enter");
			
			
%>
 <tr>
            
        <td width="40%" bgcolor="#ffea9d">
			<font face="Arial" size="2">&nbsp; <%=rs.getString("webinar_id")%>  : <%=rs.getString("webinar_name")%></font></td>
			 <td width="60%"  bgcolor="#ffea9d">&nbsp;
			<a href="#" onClick="if(confirm('Are you sure you want to join this board')){popup('<%=attdURL%><%=std_id%>');}else{ return false;}"><font face="Arial" size="2" color="green"><%=rs.getString("webinar_name")%></font></a>
		</td>     
        <td width="40%" bgcolor="#ffea9d">
			<font face="Arial" size="2">&nbsp; <%=rs.getString("teacher_id")%></font></td>
      </tr>
		
<%
		}
		if(i==0)
		{
%>
			<tr>
			<td colspan=4 width="100%" bgcolor="#F0ECE1" align="center">No boards are running.</td>
			</tr>
			
<%		}
	
%>
 <br></table>
		<input type="hidden" name="schoolid" value="<%=schoolId%>">
		<input type="hidden" name="emailid" value="<%=emailId%>">

<%
	}
	catch(Exception e)
	{
		System.out.println("Exception in StudentBoardsDB.jsp is..."+e.getMessage());
		ExceptionsFile.postException("StudentBoardsDB.jsp","displaying","Exception",e.getMessage());
	}
	finally
	{
		try
		{
		
			if(con!=null && !con.isClosed())
				con.close();
			
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("StudentBoardsDB.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			
		}
		
	}
	
	
%>
</form>
</body>
</html>
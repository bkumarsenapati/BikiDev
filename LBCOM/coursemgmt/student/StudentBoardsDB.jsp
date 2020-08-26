<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

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
	String userId="",schoolId="",emailId="";

%>
<%	
	String sessid=(String)session.getAttribute("sessid");
	if (sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	
	try
	{
		
		userId=(String)session.getAttribute("emailid");
		schoolId=(String)session.getAttribute("schoolid");
		emailId=userId+"@"+schoolId;
		con=con1.getConnection();
		st = con.createStatement() ;
		
		//rs=st.executeQuery("select distinct bi.course_name,bi.course_id,bi.user_id,bi.board_start,bi.board_end from boardinitiator as bi inner join coursewareinfo_det as cd on bi.course_id=cd.course_id where cd.student_id='"+userId+"' and bi.school_id='"+schoolId+"' and bi.course_id=cd.course_id and bi.board_start<=curdate() and bi.board_end IS NULL and user_type!='student'");
		
		rs=st.executeQuery("select distinct bi.course_name,bi.course_id,bi.user_id,bi.board_start,bi.board_end from boardinitiator as bi inner join coursewareinfo_det as cd on bi.course_id=cd.course_id where cd.student_id='"+userId+"' and bi.school_id='"+schoolId+"' and cd.school_id='"+schoolId+"' and bi.board_start<=curdate() and bi.board_end IS NULL and user_type!='student'");
		
%>


<form name= "wh" method="post" enctype="multipart/form-data">

<table border="1" width="100%" align="left" cellspacing="2" bordercolordark="#9db38a" bordercolorlight="#9db38a" bordercolor="#9db38a" cellpadding="2" style="margin-top:-20px;">
    <tr>
        <td width="100%" bgcolor="#9db38a" colspan="4"><font face="Arial" color="#FFFFFF"><span style="font-size:11pt;"><b><img src="../WhiteBoard/icons/chalk_board.png" width="24" height="24" border="0" align="absmiddle">&nbsp;Boards</b></span></font></td>
    </tr>
    <tr>
        <td bgcolor="#CCCCCC" width="60%" background="../WhiteBoard/icons/bg.jpg">
            <p><span style="font-size:10pt;"><font face="Arial"><b>&nbsp;<img src="../WhiteBoard/icons/computer.png" width="18"  border="0" align="absmiddle">&nbsp;Boards in session</b></font></span></p>
        </td>
        <!-- <td width="220" height="34" bgcolor="#CCCCCC" background="../icons/bg.jpg">
            <p align="center"><font face="Arial"><span style="font-size:11pt;"><b><img src="../icons/clock.png" width="18" height="18" border="0" align="absmiddle"></b></span></font><span style="font-size:10pt;"><font face="Arial"><b> Time</b></font></span></p>
        </td> -->
        <td width="40%"  bgcolor="#CCCCCC" background="../WhiteBoard/icons/bg.jpg">
            <p align="center"><font face="Arial"><span style="font-size:11pt;"><b><img src="../WhiteBoard/icons/she_user.png" width="18" height="18" border="0" align="absmiddle"></b></span></font><span style="font-size:10pt;"><font face="Arial"><b> Created By</b></font></span></p>
        </td>
    </tr>

<%		
		while(rs.next())
		{
			
			i++;
			
%>
 <tr>
        <td width="60%"  bgcolor="#F0ECE1">&nbsp;
			<a href="#" onClick="if(confirm('Are you sure you want to join this board')){popup('/LBCOM/WhiteBoard/WhiteBoard.jsp?courseid=<%=rs.getString("course_id")%>');}else{ return false;}"><font face="Arial" size="2" color="green"><%=rs.getString("course_name")%></font></a>
		</td>     
		<!-- <td width="220" height="34" bgcolor="#F0ECE1">
			<font face="Arial" size="2">&nbsp;<%=rs.getString("board_start")%></font>
		</td> -->
        <td width="40%" bgcolor="#F0ECE1">
			<font face="Arial" size="2">&nbsp; <%=rs.getString("user_id")%></font></td>
      </tr>
		
<%
		}
		if(i==0)
		{
%>
			<tr>
			<td colspan=4 width="100%" bgcolor="#F0ECE1" align="left">No boards are running.</td>
			</tr>
			
<%		}
	
%>
 <br></table>
		<input type="hidden" name="schoolid" value="<%=schoolId%>">
		<input type="hidden" name="emailid" value="<%=userId%>">

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
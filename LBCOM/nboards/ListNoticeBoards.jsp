<%@page language="java" import = "java.sql.*,java.lang.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
Connection con=null;
Statement st=null,st1=null,st2=null,st3=null;
ResultSet rs=null,rs1=null,rs2=null,rs3=null;
String studentId="",teacherId="",schoolId="",dirName="",viewer="",tName="",bgClr="",nbMsg="",tId="";
boolean flag=false;
%>
<%
	String sessid=(String)session.getAttribute("sessid");

	if(sessid==null)
	{
		out.println("<html><script>top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}

	viewer=request.getParameter("viewer");
	schoolId=request.getParameter("schoolid");

	if(viewer.equals("teacher"))
	{
		bgClr="#429EDF";
		nbMsg="My Notice Boards";
	}
	else if(viewer.equals("student"))
	{
		bgClr="#546878";
		nbMsg="Teacher Notice Boards";
	}

	try
	{
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();

		// This is for all users
		rs=st.executeQuery("select * from notice_boards where schoolid='"+schoolId+"' and teacherid='admin'");

		if(viewer.equals("teacher"))
		{
			teacherId=request.getParameter("emailid");
			rs1=st1.executeQuery("select * from notice_boards where schoolid='"+schoolId+"' and teacherid='"+teacherId+"'");
		}
		else if(viewer.equals("student"))
		{
			studentId=request.getParameter("emailid");
			//rs1=st1.executeQuery("select nboard_name from notice_boards where schoolid='"+schoolId+"' and teacherid!='admin'");
			rs1=st1.executeQuery("select * from notice_boards where schoolid='"+schoolId+"' and teacherid!='admin'");

		}
%>
<html>
<head>
<title></title>
<style>
<!--
a{text-decoration:none}
//-->
</style>
<SCRIPT LANGUAGE="JavaScript">
<!--
function generalNotices(dir)
{
	parent.two.location.href="/LBCOM/nboards/ShowNotices.jsp?name="+dir+"&viewer=<%=viewer%>&createdby=admin";
	return false;
}
function teacherNotices(dir)
{
	parent.two.location.href="/LBCOM/nboards/ShowNotices.jsp?name="+dir+"&viewer=<%=viewer%>&createdby=teacher";
	return false;
}
function createNotice()
{
	parent.two.location.href="/LBCOM/nboards/CreateNoticeBoard.jsp?mode=add&creator=<%=viewer%>";
	return false;
}
function ListNBoards()
{
	parent.two.location.href="/LBCOM/nboards/NoticeBoards.jsp?creator=<%=viewer%>";
	return false;
}
function TeacherRefresh()
{
	parent.one.location.href="/LBCOM/nboards/ListNoticeBoards.jsp?emailid=<%=teacherId%>&schoolid=<%=schoolId%>&viewer=teacher";
	return false;
}
function AdminRefresh()
{
	parent.one.location.href="/LBCOM/nboards/ListNoticeBoards.jsp?schoolid=<%=schoolId%>&viewer=admin";
	return false;
}
//-->
</SCRIPT>
</head>
<body leftmargin="0" rightmargin="0">
<center>
<TABLE width="95%" border="0" cellspacing="0" cellpadding="0">
<%
	if(rs.next())
	{
		flag=true;
%>
<%
		if(!viewer.equals("admin"))
		{
%>
		<TR bgcolor="<%=bgClr%>">
			<TD colspan='4' align="left" height="24" bgcolor="#9db38a">
				<font face='arial' size='2' color="white"><b>&nbsp;Announcements</b></TD>
		</TR>
		<TR>
			<TD colspan="4" width="100%"><hr></TD>
		</TR>
<%
		}	
%>
<%
		rs.beforeFirst();
	}
%>
		<TR>
			<TD colspan="4">
				<font face='arial' size='2'><b>School Admin Notice Boards</b></TD>
		</TR>
<%
	if(viewer.equals("admin"))
	{
%>
		<TR>
			<TD colspan='4' align="right"><font face='arial' size='2'><b>
				<a href="javascript://" onClick="return AdminRefresh();"><u>Refresh</u></a>&nbsp;&nbsp;
				<a href="javascript://" onClick="return ListNBoards();"><u>List</u></a>
			</TD>
		</TR>
<%
	}	
%>
		<TR>
			<TD colspan="4" width="100%"><hr></TD>
		</TR>
<tr><td>
<div style="border:0px solid green; padding-left:10px; height:170px; width:95%; overflow:auto;">
<table>
<%
	while(rs.next())
	{
		dirName=rs.getString("nboard_name");
		flag=true;
%>
		<TR>
			<TD colspan="4" width="100%">
				<a href="javascript://" onClick="return generalNotices('<%=dirName%>');">
				<font face="arial" size="2"><b><%=dirName%></a>
			</TD>
		</TR>
<%
	}
%>
</table>
</div>
</td></tr>
<%
	if(viewer.equals("teacher") || viewer.equals("student"))
	{
%>	
		<TR>
			<TD colspan="4" width="100%"><hr></TD>
		</TR>
		<TR>
			<TD colspan="4"><font face='arial' size='2'><b><%=nbMsg%></b></TD>
		</TR>
<%
	}	
%>
<%
	if(viewer.equals("teacher"))
	{
%>
		<TR>
			<TD colspan='4' align="right"><font face='arial' size='2'><b>
				<a href="javascript://" onClick="return TeacherRefresh();"><u>Refresh</u></a>&nbsp;&nbsp;
				<a href="javascript://" onClick="return ListNBoards();"><u>List</u></a>
			</TD>
		</TR>
<%
	}	
%>
<%
	if(viewer.equals("teacher") || viewer.equals("student"))
	{
%>	
		<TR>
			<TD colspan="4" width="100%"><hr></TD>
		</TR>
<%
	}	
%>
<tr><td>
<div style="border:0px solid green; padding-left:10px; height:170px; width:95%; overflow:auto;">
<table>
<%
		if(viewer.equals("teacher"))
		{
			while(rs1.next())
			{
				dirName=rs1.getString("nboard_name");
				flag=true;
%>
		<TR>
			<TD colspan="4" width="100%">
				<a href="javascript://" onClick="return teacherNotices('<%=dirName%>');">
				<font face="arial" size="2"><b><%=dirName%></a>
			</TD>
		</TR>
<%
			}
		}
		else if(viewer.equals("student"))
		{
			while(rs1.next())
			{
			//	rs2=st2.executeQuery("select dirname,courseid,teacherid from notice_master where schoolid='"+schoolId+"' and teacherid!='admin' and courseid IN (select course_id from coursewareinfo_det where school_id='"+schoolId+"' and student_id='"+studentId+"')");

			//	while(rs2.next())
			//	{
			//		tId=rs2.getString("teacherid");
			//		rs3=st3.executeQuery("select firstname,lastname from teachprofile where schoolid='"+schoolId+"' and username='"+tId+"'");
			//		if(rs3.next())
			//		{
			//			tName=rs3.getString("firstname")+" "+rs3.getString("lastname");
			//		}
			//		rs3.close();
					tName=rs1.getString("teacherid");
					dirName=rs1.getString("nboard_name");
					flag=true;
%>
		<TR>
			<TD colspan="2" width="100%">
				<a href="javascript://" onClick="return teacherNotices('<%=dirName%>');">
				<font face="arial" size="2"><b><%=dirName%></b></font></a>
			</TD>
			<TD colspan="2" width="100%">
				<font face="arial" size="2"><b>&nbsp;&nbsp;&nbsp;&nbsp;<%=tName%></b></font>
			</TD>
		</TR>
<%
				//}
			}
		}
%>
</table>
</div>
</td></tr>
<%
	if(flag==false)
		out.println("<tr><td colspan='2' align='center'><font face='Arial' size='2'>No Departments Available</td></tr>");
}
catch(Exception e)
{
	ExceptionsFile.postException("ListNoticeBoards.jsp","operations on database","Exception",e.getMessage());
	out.println(e);
}
finally
{
	try
	{
		if(st!=null)
			st.close();
		if(st1!=null)
			st1.close();
		if(con!=null)
			con.close();
			
	}
	catch(SQLException se)
	{
		ExceptionsFile.postException("ListNoticeBoards.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		System.out.println(se.getMessage());
	}
}
%>
</TABLE>
</body>
</html>

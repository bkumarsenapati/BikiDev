<%@page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<html>
<head>

<title><%=application.getInitParameter("title")%></title>

<script>
//var logopath = "<%= session.getAttribute("logopath")%>";
</script>
<%
Connection con=null;
Statement st=null,st1=null,st2=null;
ResultSet rs=null,rs1=null,rs2=null;
String nbName="",nbId="",viewer="",query1="",nbFile="";
String userId="",userType="",schoolId="";
int i=0;
userId=(String) session.getAttribute("Login_user");
schoolId =(String)session.getAttribute("Login_school");

%>
<%
	try
	{
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();

		rs=st.executeQuery("select * from notice_boards where schoolid='"+schoolId+"'");
		while(rs.next())
		{
			i=0;
			nbName=rs.getString("nboard_name");
			viewer=rs.getString("teacherid");

			if(viewer.equals("admin"))
			{
				query1="select distinct * from notice_master where dirname='"+nbName+"' and schoolid='"+schoolId+"' and user_type!=1 and imp='2' and to_date>=curdate() order by from_date";
			}
			else
				query1="select distinct * from notice_master where dirname='"+nbName+"' and schoolid='"+schoolId+"' and courseid IN (select course_id from coursewareinfo_det where school_id='"+schoolId+"' and student_id='"+userId+"') and user_type!=1 and imp='2' and to_date>=curdate() order by from_date";

			rs1=st1.executeQuery(query1);
			while(rs1.next())
			{
				i=0;
				nbId=rs1.getString("noticeid");
				nbFile=rs1.getString("filename");
				
				i=st2.executeUpdate("delete from student_notice_boards where schoolid='"+schoolId+"' and noticeid='"+nbId+"' and studentid='"+userId+"'");
				
			}
		}
		
	}
	catch(Exception e)
{
	ExceptionsFile.postException("StudentAdmin.jsp","operations on database","Exception",e.getMessage());
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
		if(st2!=null)
			st2.close();
		if(con!=null)
			con.close();
			
	}
	catch(SQLException se)
	{
		ExceptionsFile.postException("StudentAdmin.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		System.out.println(se.getMessage());
	}
}
%>
</head>
<!-- <frameset rows="90,*,0" border="0" frameborder="0" framespacing="0">
	<frame src="/LBCOM/studentAdmin/top.html?schoolid=<%=schoolId%>&userid=<%=userId%>" name="studenttopframe" marginwidth="0" marginheight="0" scrolling="no" target="_self">
	<frameset cols="168,0,*"name="userloginfr">
		<frame src='/LBCOM/studentAdmin/left.jsp' name="left" scrolling="no" marginwidth="0" marginheight="0">
		<frame name="refreshframe" target="main" scrolling="no" noresize border="0">
		
		<frame src='' name="main" scrolling="auto" >
	</frameset> -->
	<!-- <frameset rows="90,*,0" border="0" frameborder="0" framespacing="0">
	<frame src="/LBCOM/studentAdmin/top.jsp?schoolid=<%=schoolId%>&userid=<%=userId%>" name="studenttopframe" marginwidth="0" marginheight="0" scrolling="no" target="_self">
	<frameset cols="168,0,*"name="userloginfr">
		<frame src='/LBCOM/studentAdmin/left.jsp' name="left" scrolling="no" marginwidth="0" marginheight="0">
		<frame name="refreshframe" target="main" scrolling="no" noresize border="0">
		<frame src='/LBCOM/studentAdmin/StudentHome.jsp' name="main" scrolling="auto" > 
		<frame src='' name="mainn" scrolling="auto" >
	</frameset>
	<frame src="/LBCOM/bottom.jsp" id="bottom" name="bottom" marginwidth="0" marginheight="0" scrolling="no" target="_self">
	<noframes>
    <body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
    <p>To view this page correctly, you need a Web browser that supports frames.</p>
	<A HREF="/LBCOM/common/Logout.jsp">Logout</A> 
    </body>
    </noframes>
</frameset> -->


<%
response.sendRedirect("/LBCOM/studentAdmin/index.jsp");
%>

<!-- <frameset cols="1%,*">
  <frame src='/LBCOM/studentAdmin/left.jsp' name="left" scrolling="no" marginwidth="0" marginheight="0">
  <frame src="/LBCOM/studentAdmin/index.jsp"  name="main" scrolling="auto"  />
  </frameset> -->
</html>

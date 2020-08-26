<%@page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	private String check4Opostrophe(String str)
	{
		str=str.replaceAll("\'","\\\\\'");
		str=str.replaceAll("\"","\\&quot;");
		return(str);
	}
%>
<%
Connection con=null;
Statement st=null,st1=null,st2=null;
ResultSet rs=null,rs1=null,rs2=null;
String schoolId="",studentId="",nbName="",nbId="",viewer="",query1="",nbFile="",tempdesc="";
int i=0;
%>

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Welcome to Student!</title>
<SCRIPT LANGUAGE="JavaScript" src="/LBCOM/common/Validations.js"></SCRIPT>
</head>
<!-- <DIV id=loading  style='WIDTH:100%; height:90%; POSITION: absolute; TEXT-ALIGN: center;border: 0px solid;z-index:1;background-color : white;'><IMG src="/LBCOM/common/images/loading.gif" border=0>
</DIV> -->
<body topmargin="20" leftmargin="20">
<!-- <body topmargin="20" leftmargin="20"> -->
<form name="stadnb"   method="post" enctype="multipart/form-data">

<%	
	try
	{
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		//schoolId="eschool";
		//studentId="student1";
		int j=0;
		studentId=(String) session.getAttribute("Login_user");
		schoolId =(String)session.getAttribute("Login_school");
		
		// This is for all users
		rs=st.executeQuery("select * from notice_boards where schoolid='"+schoolId+"'");

		while(rs.next())
		{
			i=0;
			nbName=rs.getString("nboard_name");
			viewer=rs.getString("teacherid");

			if(viewer.equals("admin"))
			{
				query1="select distinct * from notice_master where dirname='"+nbName+"' and schoolid='"+schoolId+"' and user_type!=1 and imp='1' order by from_date";
			}
			else
				query1="select distinct * from notice_master where dirname='"+nbName+"' and schoolid='"+schoolId+"' and courseid IN (select course_id from coursewareinfo_det where school_id='"+schoolId+"' and student_id='"+studentId+"') and user_type!=1 and imp='1' order by from_date";

			
			int note=1;
			rs1=st1.executeQuery(query1);
			while(rs1.next())
			{
				i=0;
				nbId=rs1.getString("noticeid");
				nbFile=rs1.getString("filename");
%>
				<SCRIPT LANGUAGE="JavaScript">
<%
				tempdesc=rs1.getString("description");
				tempdesc="'"+check4Opostrophe(tempdesc)+"'";
%>
				 var note<%=note%>=<%=tempdesc%>;
				</SCRIPT>
<%
				rs2=st2.executeQuery("select * from student_notice_boards where schoolid='"+schoolId+"' and noticeid='"+nbId+"' and studentid='"+studentId+"'");
				if(rs2.next())
				{
					
					//
				}
				else
				{
					
					i++;
					if(nbFile.indexOf("null")==-1)
					{

						response.sendRedirect("NBPopFrame.jsp?nbid="+nbId+"&dir="+nbName+"&file="+nbFile+"&msg="+tempdesc);

					}
					else
					{
					response.sendRedirect("NBTop1.jsp?nbid="+nbId+"&msg="+tempdesc);
					}
				}
			}
			j+=i;
			
			
		}
		if(j==0)
		{
			response.sendRedirect("/LBCOM/studentAdmin/StudentAdmin.jsp");
		}
		
%>		
				
</form>
<%
}
catch(Exception e)
{
	ExceptionsFile.postException("StudentHomeNB.jsp","operations on database","Exception",e.getMessage());
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
		ExceptionsFile.postException("StudentHomeNB.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		System.out.println(se.getMessage());
	}
}
%>
</body>
</html>
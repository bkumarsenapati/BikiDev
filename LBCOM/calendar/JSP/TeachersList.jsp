<%@ page language="java" import="java.sql.*,java.io.*,java.util.StringTokenizer,java.util.Hashtable,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ include file="/common/checksession.jsp" %> 
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
String schoolId="",teacherId="",studentId="",classId="",sess="",mode="",selectedIds="",id="",courseId="";
String meetingId="",cId="";
String query1="",query2="";
Connection con=null;
ResultSet rs=null,rs1=null;
Statement st=null,st1=null;
boolean flag=false;
File folder=null;
%>
<%
response.setContentType("text/xml");
response.setHeader("Cache-Control","no-cache");
try
{
	teacherId=(String)session.getAttribute("emailid");
	schoolId=(String)session.getAttribute("schoolid");
	classId="C000";
	courseId=request.getParameter("courseid");
	String utype=session.getAttribute("utype").toString();
	String query="";
	mode="mod";
	con=con1.getConnection();
	st=con.createStatement();
	
	if(!courseId.equals("teachers"))		// Start of IF
	{
		rs=st.executeQuery("select emailid,fname,lname from studentprofile s inner join coursewareinfo_det  c on s.emailid=c.student_id and s.schoolid=c.school_id where c.course_id='"+courseId+"'  and s.grade='"+classId+"' and s.schoolid='"+schoolId+"' and s.username!='"+classId+"_vstudent' and s.status=1 "+query+" order by s.emailid");
		
	}
	else{
			if(utype.equals("teacher"))
		{
			rs=st.executeQuery("select email,firstname,lastname from teachprofile where schoolid='"+schoolId+"' and username!='"+teacherId+"' order by username");
		}
		else{

			rs=st.executeQuery("select distinct t.email,t.firstname,t.lastname from teachprofile t, coursewareinfo c ,coursewareinfo_det d  where c.course_id=d.course_id and c.school_id=d.school_id and d.student_id='"+teacherId+"' and c.status=1 and c.school_id='"+schoolId+"' and t.username=c.teacher_id");

		}
	}
	out.print("<root>");
		while(rs.next())
		{
			studentId=rs.getString(1);
			

			String block="";
			out.print("<data>");
			if(studentId.equals(classId+"_vstudent")) block="onclick='this.checked=true' checked ";
			if(mode.equals("mod"))
			{
				
				out.print("<check_data>");
				out.print(studentId);
				out.print("</check_data>");

				out.print("<ck>");
				out.print(block+"_test");
				out.print("</ck>");
			}
			else
			{
				out.print("<check_data>");
				out.print(studentId);
				out.print("</check_data>");

				out.print("<ck>");
				out.print(block);
				out.print("</ck>");
			}
			out.print("<id>");
				out.print(studentId);
				out.print("</id>");

				out.print("<name>");
				out.print(rs.getString(2)+" "+rs.getString(3));
				out.print("</name>");
				
				out.print("</data>");
		}	
		out.print("</root>");
}
	catch(Exception e)
	{
		ExceptionsFile.postException("TeachersList.jsp","Operations on database and reading parameters","Exception",e.getMessage());
		
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(Exception e)
		{  
			ExceptionsFile.postException("TeachersList.jsp","closing connections","Exception",e.getMessage());
			System.out.println("Error : Finallly  - "+e.getMessage()); 
		}
	}
%>
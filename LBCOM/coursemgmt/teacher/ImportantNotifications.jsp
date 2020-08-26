<%@page language="java" import="java.util.Vector,java.util.Hashtable,java.util.Enumeration,java.sql.*,java.util.Date,java.util.Calendar,java.lang.Math"%>
<jsp:useBean id="dbBean" class="sqlbean.DbBean" scope="page"/>
<%!
	final static private byte COURSENOTIFICATIONDAYS=7;
	
%>
<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;

	String schoolId="",teacherId="",studentId="",classId="",courseId="",className="",courseName="",studentName="";

	Hashtable courses=null;
	Hashtable teacherIds=null;
	Hashtable lastDates=null;
	Hashtable noOfDays=null;
	java.util.Date currDate=null,lastDate=null;


%>

<%
	try
	{
		session=request.getSession();
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
		}
		schoolId=(String)session.getAttribute("schoolid");
		studentId=(String)session.getAttribute("emailid");
		studentName=(String)session.getAttribute("studentname");
		classId=(String)session.getAttribute("classid");
		className=(String)session.getAttribute("classname");
		courseId=(String)session.getAttribute("courseid");


		con=dbBean.getConnection();
		st=con.createStatement();
		courses=new Hashtable();
		teacherIds=new Hashtable();
		lastDates=new Hashtable();
		noOfDays=new Hashtable();
	    rs=st.executeQuery("select c.course_name,c.teacher_id,c.course_id,c.last_date,curdate() as todate,datediff(curdate(),c.last_date) as diff from coursewareinfo c inner join coursewareinfo_det d on c.school_id=d.school_id and c.course_id=d.course_id where c.school_id='"+schoolId+"' and d.school_id='"+schoolId+"' and c.class_id='"+classId+"' and d.student_id='"+studentId+"' and c.status=1 and curdate()<c.last_date ");
		while(rs.next()){
			courses.put(rs.getString("course_id"),rs.getString("course_name"));
			teacherIds.put(rs.getString("course_id"),rs.getString("teacher_id"));
			lastDates.put(rs.getString("course_id"),(java.util.Date)rs.getDate("last_date"));
			noOfDays.put(rs.getString("course_id"),rs.getString("diff"));
			currDate=null;
			currDate=(java.util.Date)rs.getDate("todate");
		}
	      		
	}catch(Exception e){
		System.out.println("Exception in ImportantNotifications.jsp is "+e);
	}finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("ImportantNotifications.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>

<BODY>
<form name='notifications' method='post'>
<table>
        
<%
	Enumeration coursesEnum=courses.keys();
//	int noOfDays=0;
	
	while(coursesEnum.hasMoreElements()){
		courseId=(String)coursesEnum.nextElement();
		
		lastDate=(java.util.Date)lastDates.get(courseId);	
		
		if(lastDate!=null && currDate.compareTo(lastDate)<=0){
			out.println("<tr>");
			if(Math.abs(Integer.parseInt((String)noOfDays.get(courseId)))>COURSENOTIFICATIONDAYS)
				out.println("<td>CourseName :"+(String)courses.get(courseId)+"</td>");
			else
				out.println("<td>CourseName :"+(String)courses.get(courseId)+"&nbsp;"+(String)noOfDays.get(courseId)+"</td>");
		
		}

//		st.executeQuery("select
		out.println("</tr>");
	}	
%>
</table>
</form>
</BODY>
</HTML>

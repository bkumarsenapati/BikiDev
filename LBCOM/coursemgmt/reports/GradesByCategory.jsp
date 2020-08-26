<%@ page import="java.sql.*,java.util.*,java.text.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;

	Hashtable courses=null,typeTable=null,categoryTable=null,percentages=null,totalPointsTbl=null;

	DecimalFormat df=null;

	String studentId="",classId="",courseId="",courseName="",schoolId="",category="",catDesc="",bgColor="",className="";

	float wtg=0.0f,weightedPoints=0.0f,marks=0.0f,totalMarks=0.0f,totalPoints=0.0f;

%>
<%
	try
	{
		try
		{
			session=request.getSession();
			String sessid=(String)session.getAttribute("sessid");
			if(sessid==null)
			{
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
		
			schoolId=(String)session.getAttribute("schoolid");
			studentId=(String)session.getAttribute("emailid");
			className=(String)session.getAttribute("classname");
			classId=(String)session.getAttribute("classid");
			//courseId=request.getParameter("courseid");
			//courseName=request.getParameter("coursename");
			con=con1.getConnection();
			st=con.createStatement();
			courses=new Hashtable();
			typeTable=new Hashtable();
			categoryTable=new Hashtable();
			percentages=new Hashtable();
			totalPointsTbl=new Hashtable();
			df=new DecimalFormat();
			df.setMaximumFractionDigits(2);
			wtg=0;
			marks=0;
			totalMarks=0;
			weightedPoints=0;
			bgColor="";
	
			rs=st.executeQuery("select c.course_name,c.course_id from coursewareinfo c left join coursewareinfo_det d on c.course_id=d.course_id and c.school_id=d.school_id where d.student_id='"+studentId+"' and c.status=1 and d.school_id='"+schoolId+"'");
			while(rs.next())
			{
				courses.put(rs.getString("course_id"),rs.getString("course_name"));
			}
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("GradesByCategory.jsp","Operations on database","Exception",e.getMessage());
			System.out.println("Error in GradesByCourse is "+e);
		}
%>
<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title></title>
</head>
<body topmargin="3" leftmargin="3">

	<table border="0" width="100%" cellspacing="1">
		<tr>
			<td width="100%" valign="middle" align="left" height="25" bgcolor="#E8ECF4"><b>
				<font face="Verdana" size="2" color="#800080">Grade Book</font></b></td>
		</tr>
	</table>
	<br>
	<center>
	<table border="0" cellspacing="1" bordercolor="#111111" width="850">
		<tr>
			<td width="150" bgcolor="#C1BDAA" height="25"><b>
				<font face="Verdana" size="2" color="black">Class</font></b></td>
			<td width="700" bgcolor="#D7D0C4" height="25"><b>
				<font face="Verdana" size="2" color="#800080"><%=className%></font></b></td>
		</tr>
		<tr>
			<td width="150" bgcolor="#C1BDAA" height="25"><b>
				<font face="Verdana" size="2" color="black">Student Name</font></b></td>
			<td width="700" bgcolor="#D7D0C4" height="25"><b>
				<font face="Verdana" size="2" color="#800080"><%=studentId%></font></b></td>
		</tr>
	</table>
<br>
	<table border="0" cellpadding="0" cellspacing="1" width="850">
		<tr>
			<td width="300" height="28" bgcolor="#CECFCE" align="left"><b>
				<font face="Verdana" size="2" color="#003063">Course Name</font></b></td>
				<font size="2">
			<td width="125" height="28" bgcolor="#CECFCE" align="center">
				<font face="Verdana" size="2" color="#003063"><b>Assignments</b></font></td>
			<td width="125" height="28" bgcolor="#CECFCE" align="center">
				<font face="Verdana" size="2" color="#003063"><b>Assessments</b></font></td>
			<td width="150" height="28" bgcolor="#CECFCE" align="center">
				<font face="Verdana" size="2" color="#003063"><b>Maximum Points (attempted)</b></font></td>
			<td width="150" height="28" bgcolor="#CECFCE" align="center"><b>
				<font face="Verdana" size="2" color="#003063">Secured Points</font></b></td>
			<!--<td width="27%" height="28" bgcolor="#CECFCE" align="center">
				<font color="#003063"><b>Grade</b></font></td>-->
		</tr>
<%
	 if(courses.size()<=0){

		out.println("<tr><td colspan='5' width='100%' height='28' align='center'><font color=''><b>No course is created</b></font></td></tr>");
		return;
	}
	Enumeration courseNames=courses.keys();
    
	int j=0;
    while(courseNames.hasMoreElements())
	{
		marks=0;
		totalMarks=0;
		totalPoints=0;
		if (j%2==0)
			bgColor="";
		else
			bgColor="#F7F3F7";
		j++;
		courseId=(String)courseNames.nextElement();
		courseName=(String)courses.get(courseId);
%>
		<tr>
			<td width='300' height='25' bgcolor='<%=bgColor%>'><b>
				<font face="Verdana" size="2">
				<a href='GradesByClass.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>'><%=courseName%></b>
			</td>
<%
		rs.close();

		rs=st.executeQuery("select sum(c.total_marks) totalmarks,sum(c.marks_secured) marks from category_item_master m left join "+schoolId+"_cescores c on m.item_id=c.category_id and m.course_id=c.course_id  and m.school_id=c.school_id  where m.school_id='"+schoolId+"' and m.course_id='"+courseId+"' and m.category_type='AS' and m.grading_system !=0 and c.user_id='"+studentId+"' and c.status!=3 and c.status!=0");
		while(rs.next())
		{
			marks=rs.getFloat("marks");
			totalMarks+=marks;
			totalPoints+=rs.getFloat("totalmarks");
%>
		    <td width='125' height='25' bgcolor='<%=bgColor%>' align='center'>
				<%=df.format(Double.valueOf(String.valueOf(marks)))%></td>
<%
		}
		rs.close();
		marks=0;
		//totalMarks=0;
		
		rs=st.executeQuery("select sum(c.total_marks) totalmarks,sum(c.marks_secured) marks from category_item_master m inner join "+schoolId+"_cescores c,exam_tbl e on m.item_id=c.category_id and m.course_id=c.course_id  and m.school_id=c.school_id and e.exam_id=c.work_id and e.school_id=c.school_id and e.status=1  where m.school_id='"+schoolId+"' and m.course_id='"+courseId+"' and m.category_type='EX' and m.grading_system !=0 and c.user_id='"+studentId+"' and c.status!=3 and c.status!=0");
			
		while(rs.next())
		{
			marks=rs.getFloat("marks");
			totalMarks+=marks;
			totalPoints+=rs.getFloat("totalmarks");
%>
			<td width='125' height='25' bgcolor='<%=bgColor%>' align='center'>
				<%=df.format(Double.valueOf(String.valueOf(marks)))%></td>
<%					
		}
%>
			<td width='150' height='25' bgcolor='<%=bgColor%>' align='center'>
				<%=df.format(Double.valueOf(String.valueOf(totalPoints)))%></td>
			<td width='150' height='25' bgcolor='<%=bgColor%>' align='center'>
				<%=df.format(Double.valueOf(String.valueOf(totalMarks)))%></td>

<%			
			//fg=new FindGrade();
			//centMarks=fg.convertToCent(weightedPoints,totalWeightage);
			//out.println("<td width='27%' height='25' align='center'><font color='#800080'><b></b></font></td>");
%>
		</tr>
<%
	}
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("GradesByCategoryjsp","Performaing operation on database","SQLException",e.getMessage());
		System.out.println("Error in GradesByCategory is "+e);
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
		catch(SQLException se)
		{
			ExceptionsFile.postException("GradesByCategory.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}
%>

	</table>
</body>
</html>

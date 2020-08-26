<%@ page import="java.sql.*,java.util.*,exam.FindGrade,java.text.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	FindGrade fg=null;
	Hashtable students=null,categoryTable=null,percentages=null,totalPointsTbl=null,typeTable=null;
	DecimalFormat df=null;
	String studentId="",classId="",courseId="",courseName="",schoolId="",category="",catDesc="",type="",bgColor="";
	float wtg=0.0f,weightedPoints=0.0f,pointsPossible=0.0f,marks=0.0f,totalMarks=0.0f,totalPoints=0.0f,totalWeightage=0.0f,centMarks=0.0f;
	int j=0;
	String grade="",className="";
%>
<%
	try{
	    session=request.getSession();
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		schoolId=(String)session.getAttribute("schoolid");
		classId= request.getParameter("classid");
		courseId=request.getParameter("courseid");
		courseName=request.getParameter("coursename");
		className=request.getParameter("classname");
		con=con1.getConnection();
		st=con.createStatement();
		
		//fg=new FindGrade();
		students=new Hashtable();
		typeTable=new Hashtable();
		percentages=new Hashtable();
		categoryTable=new Hashtable();
		//totalPointsTbl=new Hashtable();
		df=new DecimalFormat();
		df.setMaximumFractionDigits(2);
		
		j=0;
		wtg=0;
		marks=0;
		bgColor="";
		totalMarks=0;
		pointsPossible=0;
		weightedPoints=0;

		rs=st.executeQuery("select * from category_item_master where course_id='"+courseId+"' and category_type!='CM' and category_type!='CO' and grading_system!=0 and school_id='"+schoolId+"' order by category_type");
		while(rs.next()){

			categoryTable.put(rs.getString("item_id"),rs.getString("item_des"));
			typeTable.put(rs.getString("item_id"),rs.getString("category_type"));
			percentages.put(rs.getString("item_id"),rs.getString("weightage"));
		}
		rs.close();
		
		if(categoryTable.size()<=0)
		{
%>
			<table border='1' cellspacing='1' bordercolor='#111111' width='100%'>
				<tr>
					<td width='20%' bgcolor='#ADBACE' height='25'><b>
						<font face='Verdana' size='2' color='#800000'>ClassName&nbsp;:&nbsp;<%=className%></font></b></td>
					<!-- <td width='20%' bgcolor='#CAD2DF' height='25'><b>
						<font face='Verdana' size='2' color='#800000'>Course Name:&nbsp;<%=courseName%></font></b></td> -->
					<td width='20%' bgcolor='#ADBACE' height='25'><b>
						<font face='Verdana' size='2' color='#800000'><a href='#' onclick='javascript:history.go(-1); return false;'>Back</a></font></b></td>
				</tr>
				<tr>
					<td colspan='2' width='100%' bgcolor='#F7F3F7' height='25'><b>
						<font face='Verdana' size='2'>There are no categories in this course.</font></b></td>
				</tr>
			</table>

<%
			return;
        }
		
		//rs=st.executeQuery("select * from coursewareinfo_det where course_id='"+courseId+"'");
		rs=st.executeQuery("select * from coursewareinfo_det where school_id='"+schoolId+"' and course_id='"+courseId+"'");
		while(rs.next()){
			students.put(rs.getString("student_id"),rs.getString("student_id"));
		}
		students.remove(classId+"_vstudent"); //Added by Rajesh To remove Virtuastudent from report
		if(students.size()<=0){

			out.println("<table border='1' cellspacing='1' style='border-collapse: collapse; font-family: Verdana; font-size: 10pt' bordercolor='#111111' width='100%'>");
			out.println("<tr>");
			out.println("<td width='12%' bgcolor='#ADBACE' height='25'><font color='#800000'><b>Class</b></font></td>");
			out.println("<td width='100%' bgcolor='#CAD2DF' height='25' bordercolordark='#ADBACE'><b>"+className+"</b></td>");
			out.println("</tr>");
			out.println("<tr><td width='12%' bgcolor='#ADBACE' height='25'><b><font color='#800000'>Course Name</font></b></td>");
			out.println("<td width='100%' bgcolor='#CAD2DF' height='25' bordercolordark='#ADBACE'><b>"+courseName+"</b></td>");
			out.println("</tr><tr >");
			out.println("<td width='100%' colspan='2' bgcolor='#F7F3F7' height='25' align='center'><b><font face='Verdana' size='2'>There are no students in this course to show</font></b></td>");
			out.println("</tr></table>");	

			return;
       }
}catch(SQLException s){
		ExceptionsFile.postException("GradesByCourse.jsp","at display","SQLException",s.getMessage());
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
				
		}catch(SQLException se){
			ExceptionsFile.postException("GradesByCourse.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}catch(Exception e){
		ExceptionsFile.postException("GradesByCourse.jsp","operations on database","Exception",e.getMessage());
		System.out.println("Error in GradesByCourse is "+e);
	}

%>
<html>
<head>
<!--<link REL="stylesheet" TYPE="text/css" href="teacherGradeBook.css"/>-->
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Penns Grove - Carneys Point Regional School District</title>
</head>

<body topmargin="0" leftmargin="3">

 <table border="0" width="100%" cellspacing="1">
      <tr>
        <td width="80%" valign="middle" align="left" bgcolor="#E8ECF4"><b>
			<font face="Verdana" size="2" color="#800080">Grade Book </font>
			<font face="arial" size="2" color="#800080">&gt;&gt; </font>
			<font face="Verdana" size="2" color="#800080">Courses</font></a>
			<font face="arial" size="2" color="#800080">&gt;&gt;</font>
			<font face="Verdana" size="2" color="#800080"><%=courseName%></font></b></td>
		  <td width="20%" bgcolor="#E8ECF4" align="right">
		  <font face="Verdana" size="2" color="#800080">
		  <a href='SSViewOfGrades.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&classid=<%=classId%>&classname=<%=className%>'>Spread Sheet View</td>
      </tr>
    </table>


<table border="0" cellspacing="1" width='<%=(categoryTable.size()*100)+750 %>'>
  <tr>
    <td width="12%" bgcolor="#ADBACE" height="25">
		<font face="Verdana" size="2" color="#800000"><b>Class</b></font></td>
    <td width="188%" bgcolor="#CAD2DF" height="25" bordercolordark="#ADBACE">
		<font face="Verdana" size="2" color="#800000"><b><%=className%></b></font></td>
  </tr>
  <tr>
    <td width="12%" bgcolor="#ADBACE" height="25"><b>
		<font face="Verdana" size="2" color="#800000">Course Name</font></b></td>
    <td width="188%" bgcolor="#CAD2DF" height="25" bordercolordark="#ADBACE">
		<font face="Verdana" size="2" color="#800000"><b><%=courseName%></b></font></td>
  </tr>
  </table>


<table border="0" cellpadding="0" cellspacing="1" width='<%=(categoryTable.size()*100)+750 %>'>
  <tr>
     <td width="200" height="20" bgcolor="#CECFCE" align="center">
		<font face='Verdana' size='2' color="#003063"><b>Student Name</font></b></td>

  <% 
    try
	{ 
		 Statement stmt=con.createStatement();
		 ResultSet rst=null;
		 Enumeration categories=categoryTable.keys();
		 catDesc="";
		while(categories.hasMoreElements())
		{
			category=(String)categories.nextElement();
			type=(String)typeTable.get(category);
			catDesc=(String)categoryTable.get(category);
			wtg=Float.parseFloat((String)percentages.get(category));
%>
			<td width='100' bgcolor='#CECFCE' align='center'><b>
				<font face='Verdana' size='2' color='#003063'>
				<a href='Frames.jsp?coursename=<%=courseName%>&classid=<%=classId%>&courseid=<%=courseId%>&categoryid=<%=category%>&wtg=<%=wtg%>&categorytype=<%=type%>&desc=<%=catDesc%>&classname=<%=className%>'>
				<font color='#003063'><%=catDesc%></a></font></b></td>
<%
		}
%>
		<td width="130" height='20' bgcolor='#CECFCE' align='center'><b>
			<font face='Verdana' size='2' color='#003063'>Maximum Points (attempted)</font></b></td>
		<td width="130" height='20' bgcolor='#CECFCE' align='center'><b>
			<font face='Verdana' size='2' color='#003063'>Secured Points</font></b></td>
		<!-- <td width='150' height=''28' bgcolor='#CECFCE' align='center'><b>
			<font face='Verdana' size='2' color='#003063'>Calculated Weightage</font></b></td> -->
		<!-- <td width='150' height=''28' bgcolor='#CECFCE' align='center'><b>
			<font face='Verdana' size='2' color='#003063'>Weighted Percentage</font></b></td> -->
		<!-- <td width='150' height=''28' bgcolor='#CECFCE' align='center'><b>
			<font face='Verdana' size='2' color='#003063'>Grade</font></b></td> -->
	</tr>
<%
		//Enumeration studentsNames;
		boolean gradeFlag=false;
		boolean worksFlag=false;
		//studentsNames=students.keys();
		SortedSet studentsNames = new TreeSet(students.keySet());     // added by ghanendra
		bgColor="";
		Iterator itr = studentsNames.iterator();                      // added by ghanendra
		//while(studentsNames.hasMoreElements())
		while(itr.hasNext())
		{
			gradeFlag=false;
			worksFlag=false;
			wtg=0;
			totalMarks=0;
			weightedPoints=0;
			totalWeightage=0;
			pointsPossible=0;
			if(j%2==0)
				bgColor="";
			else
				bgColor="#F7F3F7";
			j++;
			//studentId=(String)studentsNames.nextElement();
			studentId=(String)itr.next();                               // added by ghanendra
%>			 
	<tr>
		<td  height='28' bgcolor='<%=bgColor%>' align='left'><b>
			<font face='Verdana' size='2'>
			<a href='GradesByStudent.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&classid=<%=classId%>&studentid=<%=studentId%>&type=all&mode=T&classname=<%=className%>'><%=studentId%></a></font></b></td>
<%
			categories=categoryTable.keys();
			while(categories.hasMoreElements())
			{
				category=(String)categories.nextElement();
				wtg=Float.parseFloat((String)percentages.get(category));
				rs.close();
				
				if (typeTable.get(category).toString().equals("EX"))
					rs=st.executeQuery("select sum(marks_secured) marks,sum(total_marks) total_marks from "+schoolId+"_cescores cs inner join exam_tbl as et on cs.work_id=et.exam_id and et.course_id='"+courseId+"' and et.school_id='"+schoolId+"' and et.status=1 where cs.course_id='"+courseId+"' and cs.user_id='"+studentId+"' and category_id='"+category+"' and cs.status!=3 and cs.status!=0 and cs.school_id='"+schoolId+"'");

				else
				rs=st.executeQuery("select sum(marks_secured) marks, sum(total_marks) total_marks from "+schoolId+"_cescores where user_id='"+studentId+"' and course_id='"+courseId+"' and category_id='"+category+"' and status!=3 and status!=0 and  school_id='"+schoolId+"'");


				if(rs.next())
				{
					marks=rs.getFloat("marks");
					totalPoints=rs.getFloat("total_marks");
					if(marks==0)
					{
						rst=stmt.executeQuery("select * from "+schoolId+"_cescores where user_id='"+studentId+"' and course_id='"+courseId+"' and category_id='"+category+"' and status > 0 and school_id='"+schoolId+"'");
						if(rst.next())
							gradeFlag=true;
%>
				<td height='28' bgcolor='<%=bgColor%>' align='center'>-</td>
<%
					}
					else
					{
						gradeFlag=true;
%>
				<td height='28' align='center' bgcolor='<%=bgColor%>'>
					<%=df.format(Double.valueOf(String.valueOf(marks)))%></td>
<%
					}
					totalMarks+=marks;
					pointsPossible+=totalPoints;
					
					if(rs.getString("total_marks")==null)
					{
						weightedPoints+=0;
						totalWeightage+=0;
					}
					else
					{
						worksFlag=true;
						weightedPoints+=(marks*wtg)/totalPoints;
						totalWeightage+=wtg;
					}
				}
		     }
			  
			 fg=new FindGrade();
			 centMarks=fg.convertToCent(weightedPoints,totalWeightage);
			 grade=fg.getGrade(schoolId,classId,courseId,centMarks);
%>
			  <td width='125' height='20' bgcolor='<%=bgColor%>' align='center'>
				<%=df.format(Double.valueOf(String.valueOf(pointsPossible)))%></td>	

			  <td  width='125' height='20' bgcolor='<%=bgColor%>' align='center'>
				<%=df.format(Double.valueOf(String.valueOf(totalMarks)))%></td>
			 
			  <!-- <td  height=''28' bgcolor='<%=bgColor%>' align='center'>
				<%=df.format(Double.valueOf(String.valueOf(totalWeightage)))%></td> -->
			  <!-- <td  height=''28' bgcolor='<%=bgColor%>' align='center'>
				<%=df.format(Double.valueOf(String.valueOf(weightedPoints)))%></td> -->
<%			  
			//	if(worksFlag)
			//	{
			//		if(gradeFlag)
			//		{
%>
				<!-- <td  height=''28' bgcolor='<%=bgColor%>' align='center'><%=grade%></td> -->
<%
			//		}
			//		else
			//		{
%>
				<!-- <td  height=''28' bgcolor='<%=bgColor%>' align='center'>Not Attempted.</td> -->
<%
			//		}
			//	}
			//	else
			//	{
%>
				<!-- <td height=''28' bgcolor='<%=bgColor%>' align='center'></td> -->
<%
			//	}
%>	

		</tr>
<%
		}
%>
<!--
		 <tr>
			<td height='25' bgcolor='#E1E1E1'><b>
				<font color='#800080' face='Verdana' size='2'>Weightage</font></b></td>
<%
		 categories=categoryTable.keys();
		 totalPoints=0;
			while(categories.hasMoreElements())
			{
				category=(String)categories.nextElement();
				wtg=Float.parseFloat((String)percentages.get(category));
				totalPoints+=wtg;
%>
		<td height=''28' bgcolor='#E1E1E1' align='center' >
			<font color='#800080' face='Verdana' size='2'><%=df.format(Double.valueOf(String.valueOf(wtg)))%>%</td>
<%
			}
%>
		<td height=''28' bgcolor='#E1E1E1'>
			<font face='Verdana' size='2' color='#800080'>&nbsp;</td>
		<td height='28' bgcolor='#E1E1E1'>
			<font face='Verdana' size='2' color='#800080'>&nbsp;</td>
		<td height='28' bgcolor='#E1E1E1' align='center'>
			<font face='Verdana' size='2' color='#800080'><%=df.format(Double.valueOf(String.valueOf(totalPoints)))%></td>
		<td height='28' bgcolor='#E1E1E1'>
			<font face='Verdana' size='2' color='#800080'>&nbsp;</td>
		<td  height='28' bgcolor='#E1E1E1'>
			<font face='Verdana' size='2' color='#800080'></td>
	</tr>
-->
</table>

<%
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("GradesByCourse.jsp","at display","Exception",e.getMessage());
		System.out.println("Error in GradesByCourse.jsp at display is "+e);
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
			ExceptionsFile.postException("GradesByCourse.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
  }
%>

</body>
</html>
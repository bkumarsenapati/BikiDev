<%@ page import="java.sql.*,java.util.*,exam.FindGrade,java.text.*,java.text.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@ page errorPage="/ErrorPage.jsp" %>
<%!
	public void output(JspWriter out ,String cId, String cName,String txt) 
	{
		try
		{
			out.println("<table border='1' cellspacing='1' style='border-collapse: collapse; font-family: Verdana; font-size: 10pt' bordercolor='#111111' width='100%'>");
            out.println("<tr>");
			out.println("<td width='20%' bgcolor='#C1BDAA' height='25'><b><font face='Verdana' size='2' color='#800000'>ClassName:&nbsp;"+cId+"</font></b></td>");
	        out.println("<td width='20%' bgcolor='#D7D0C4' height='25'><b><font face='Verdana' size='2' color='#800000'>Course Name:&nbsp;"+cName+"</font></b></td>");
			out.println("<td width='20%' bgcolor='#C1BDAA' height='25'><b><font face='Verdana' size='2' color='#800000'><a href='#' onclick='javascript:history.go(-1); return false;'>Back</a> </font></b></td>");
			out.println("</tr><tr>");
			out.println("<td colspan='2' width='100%' bgcolor='#F7F3F7' height='25'><b><font face='Verdana' size='2'>"+txt+"</font></b></td>");
			out.println("</tr></table>");
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("SSViewOfGrades.jsp","operations on database","Exception",e.getMessage());
			System.out.println("Error in SSViewOfGrades at output is "+e);
		}
  }
%>
<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	FindGrade fg=null;
	Hashtable students=null,percentages=null,typeTable=null,works=null,worksType=null,totalMarksTbl=null,secMarksTbl=null,weightageTbl=null;
	DecimalFormat df=null;
	Enumeration workids=null,studentids=null,enum=null;
	String studentId="",classId="",courseId="",courseName="",schoolId="",category="",catDesc="",type="",bgColor="",txt="",workdocsTbl="";
	String workId="";
	float wtg=0.0f,pointsPossible=0.0f,marks=0.0f,totalMarks=0.0f,securedMarks=0.0f,totalWeightage=0.0f,centMarks=0.0f,marksSec=0.0f;
	int status=0,j=0;
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

		works=new Hashtable();
		students=new Hashtable();
		worksType=new Hashtable();
		
		secMarksTbl=new Hashtable();
		percentages=new Hashtable();
		weightageTbl=new Hashtable();
		totalMarksTbl=new Hashtable();		

		workdocsTbl=schoolId+"_"+classId+"_"+courseId+"_workdocs";		

		df=new DecimalFormat();
		df.setMaximumFractionDigits(2);
		
		j=0;
		wtg=0;
		marks=0;
		grade="";
		bgColor="";
		totalMarks=0;
		pointsPossible=0;
		
		rs=st.executeQuery("select * from category_item_master where course_id='"+courseId+"' and category_type!='CM' and category_type!='CO' and grading_system!=0 and school_id='"+schoolId+"' order by category_type,item_id");
		
		while(rs.next()){
			
			percentages.put(rs.getString("item_id"),rs.getString("weightage"));	
		}
		rs.close();
		
		if(percentages.size()<=0){
			txt="There are no categories";
			output(out,courseName,courseName,txt);
			return;
        }
		rs.close();
		//rs=st.executeQuery("select * from coursewareinfo_det where course_id='"+courseId+"'");
		rs=st.executeQuery("select * from coursewareinfo_det where school_id='"+schoolId+"' and course_id='"+courseId+"'");
		while(rs.next()){
			students.put(rs.getString("student_id"),rs.getString("student_id"));
		}
			students.remove(classId+"_vstudent");
		if(students.size()<=0){
			txt="There are no studnets ";
			output(out,courseName,courseName,txt);
			return;
       }
	     
	   rs.close();
	   rs=st.executeQuery("select * from exam_tbl where school_id='"+schoolId+"' and course_id='"+courseId+"' and status=1 and exam_type!= all(select item_id from category_item_master where grading_system=0 and course_id='"+courseId+"' and school_id='"+schoolId+"')");
	   while(rs.next()){
			works.put(rs.getString("exam_id"),rs.getString("exam_name"));
			worksType.put(rs.getString("exam_id"),rs.getString("exam_type"));
	   }
	   rs.close();
	   rs=st.executeQuery("select * from "+workdocsTbl+" where status=1 and category_id!= all(select item_id from category_item_master where grading_system=0 and course_id='"+courseId+"' and school_id='"+schoolId+"')");
	   while(rs.next()){
			works.put(rs.getString("work_id"),rs.getString("doc_name"));
			worksType.put(rs.getString("work_id"),rs.getString("category_id"));
	   }
	   if(works.size()<=0){
		   txt="There are no works";
		   output(out,className,courseName,txt);
	  
		  return;
 }
}catch(SQLException s){
	ExceptionsFile.postException("SSViewOfGrades.jsp","at display","SQLException",s.getMessage());
	try{
		if(st!=null)
			st.close();
		if(con!=null && !con.isClosed())
			con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("SSViewOfGrades.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
		
}catch(Exception e){
	ExceptionsFile.postException("SSViewOfGrades.jsp","at display","Exception",e.getMessage());
	System.out.println("Error in SSViewOfGrades is "+e);
}
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">

</head>

<body topmargin="1" leftmargin="3">

<table border="0" width="<%=(works.size()*100)+ 450 %>" cellspacing="1">
	<tr>
		<td width="80%" valign="middle" align="left" bgcolor="#E8ECF4"><b>
			<font face="Verdana" size="2" color="#800080">Grade Book</font>
			<font face="Arial" size="2" color="#800080">&gt;&gt;</font>
			<font face="Verdana" size="2" color="#800080">Courses</font>
	        <font face="Arial" size="2" color="#800080">&gt;&gt;&nbsp;</font>
			<font face="Verdana" size="2" color="#800080">
			<a target='_self' href="GradesByCourse.jsp?classid=<%=classId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&classname=<%=className%>"><%= courseName%></a></font>
			<font face="Arial" size="2" color="#800080">&gt;&gt;</font>
			<font face="Verdana" size="2" color="#800080" align="right">Spread Sheet View </b></td>
      </tr>
</table>

<table border="0" cellspacing="1" width="<%=(works.size()*100)+450%>">
  <tr>
    <td width="150" bgcolor="#C1BDAA" height="25">
		<font face="Verdana" size="2" color="#800000"><b>Course Name</b></font></td>
    <td bgcolor="#D7D0C4" height="25">
		<font face="Verdana" size="2" color="#800000"><b><%=courseName%></b></font></td>
  </tr>
</table>

<table border="0" cellpadding="1" cellspacing="1" width="<%=(works.size()*100)+ 450 %>">
	<tr>
		<td width='189' bgcolor='#CECFCE' align='center'>
			<font face="Verdana" size="2" color='#003063'><b>Student Name</b></font></td>

<%
	try
	{
		workids=works.keys();
		while(workids.hasMoreElements())
		{
			workId=(String)workids.nextElement();
%>
		<td width='118' height='28' bgcolor='#CECFCE' align='center'>
			<font face="Verdana" size="2" color='#003063'><b><%=(String)works.get(workId)%></b></font></td>
<%	
		}
%>

		<td width='125' height='28' bgcolor='#CECFCE' align='center'>
			<font face="Verdana" size="2" color='#003063'><b>Total Points</b></font></td>
		<!-- <td width='113' height='28' bgcolor='#CECFCE' align='center'>
			<font color='#003063'><b>Weighted Percentage</b></font></td> -->
		<!-- <td width='88' height='28' bgcolor='#CECFCE' align='center'>
			<font color='#003063'><b>Grade</b></font></td> -->
	</tr>

<%	
    studentids=students.keys();
	boolean gradeFlag=false;
	boolean worksFlag=false;
	
	while(studentids.hasMoreElements())
	{
		j=0;
		securedMarks=0;
		pointsPossible=0;
		totalWeightage=0;
		grade="";
		if(!secMarksTbl.isEmpty()){
			secMarksTbl.clear();
		}
		if(!totalMarksTbl.isEmpty()){
			totalMarksTbl.clear();
		}
		
		studentId=(String)studentids.nextElement();
		
		workids=works.keys();
%>
	<tr>
		<td width='189' height='25'>
			<font face="Verdana" size="2" color='black'><%=studentId%></font></td>
<%
		gradeFlag=false;
		worksFlag=false;
		while(workids.hasMoreElements())
		{
			wtg=0;
			marksSec=0;
		    if(j%2==0)
				bgColor="";
			else
				bgColor="#F7F3F7";
			j++;
			
			workId=(String)workids.nextElement();
			category=(String)worksType.get(workId);
			
			if((String)percentages.get(category)==null)
				wtg=0;
			else
				wtg=Float.parseFloat((String)percentages.get(category));
			
			if((String)secMarksTbl.get(category)==null)
				marks=0;
			else
				marks=Float.parseFloat((String)secMarksTbl.get(category));

			if((String)totalMarksTbl.get(category)==null)
				totalMarks=0;
			else
				totalMarks=Float.parseFloat((String)totalMarksTbl.get(category));

			//rs.close();
			
			rs=st.executeQuery("select * from "+schoolId+"_cescores where course_id='"+courseId+"' and user_id='"+studentId+"' and work_id='"+workId+"' and  school_id='"+schoolId+"'");
			
			if(rs.next())
			{
				worksFlag=true;	
				status=rs.getInt("status");
				marksSec=rs.getFloat("marks_secured");
				marks+=marksSec;
				totalMarks+=rs.getFloat("total_marks");
				totalWeightage+=wtg;
			
				if(status==0)
				{
%>
					
		<td width='118' height='25' align='center' bgcolor='<%=bgColor%>'>-</td>
<%
				}
				else if(status==1)
				{
					gradeFlag=true;
%>
		<td width='118' height='25' align='center' bgcolor='<%=bgColor%>'>
			<font face="Verdana" size="2" color='#003063'><%=df.format(Double.valueOf(String.valueOf(marksSec)))%>*</font></td>
<%
				}
				else if(status==2)
				{
					gradeFlag=true;
%>
		<td width='118' height='25' align='center' bgcolor='<%=bgColor%>'>
			<font face="Verdana" size="2" color='#003063'><%=df.format(Double.valueOf(String.valueOf(marksSec)))%></font></td>
<%					
				}
				weightageTbl.put(category,String.valueOf(wtg));

			}
			else
			{
				marks+=0;
				totalMarks+=0;
%>
		<td width='118' height='25' align='center' bgcolor='<%=bgColor%>'>$</td>
<%				
			}
			
			totalMarksTbl.put(category,String.valueOf(totalMarks));
			secMarksTbl.put(category,String.valueOf(marks));			
		}
		
		enum=percentages.keys();
		marks=0;
		totalMarks=0;
		securedMarks=0;
		pointsPossible=0;
		totalWeightage=0;
		wtg=0;
		
		while(enum.hasMoreElements())
		{
			category=(String)enum.nextElement();
			
			if((String)secMarksTbl.get(category)==null)
				marks=0;
			else
				marks=Float.parseFloat((String)secMarksTbl.get(category));

			if((String)totalMarksTbl.get(category)==null)
			{
				totalMarks=1;
			}
			else if(((String)totalMarksTbl.get(category)).equals("0.0"))
			{
				totalMarks=1;
			}
			else
			{
				totalMarks=Float.parseFloat((String)totalMarksTbl.get(category));
			}
			
			securedMarks+=marks;
			pointsPossible+=totalMarks;
			
			if((String)weightageTbl.get(category)==null)
			{
				wtg+=0;
			}
			else
			{
				wtg+=Float.parseFloat((String)weightageTbl.get(category));
				totalWeightage+=(marks*(Float.parseFloat((String)weightageTbl.get(category))))/totalMarks;
			}
		}
		fg=new FindGrade();
		centMarks=fg.convertToCent(totalWeightage,wtg);
		grade=fg.getGrade(schoolId,classId,courseId,centMarks);
%>
		<td width='125' height='25' align='center'><b>
			<font face="Verdana" size="2" color='#003063'><%=df.format(Double.valueOf(String.valueOf(securedMarks)))%></font></b></td>
		<!-- <td width='113' height='25' align='center'><%=df.format(Double.valueOf(String.valueOf(totalWeightage)))%></td> -->
<%		 
		if(worksFlag)
		{
			if(gradeFlag)
			{
%>
		<!-- <td width='88' height='25' align='center'><b><%=grade%></b></td> -->
<%
			}
			else
			{
%>
		<!-- <td width='88' height='25' align='center'><b>Not Taken</b></td> -->
<%
			}
		}
		else
		{
%>
		<td width='88' height='25' align='center'><b></b></td>
<%
		}
%>
	</tr>
<%
	}
%>
	</tr>
</table>
<br>
<table width='700'>
	<tr>
		<td width='123' height='25' bgcolor='#FFFFFF' align='left'>
			<font face="verdana" size="2" color='#800080'><b>@ : </b>Completed</font>
		</td>
		<td width='151' height='25' bgcolor='#FFFFFF' align='left'>
			<font face="verdana" size="2" color='#800080'><b> - : </b>No Information</font></td>
		<td width='131' height='25' bgcolor='#FFFFFF' align='left'>
			<font face="verdana" size="2" color='#800080'><b> * : </b>In Progress</font></td>
		<td width='140' height='25' bgcolor='#FFFFFF' align='left'>
			<font face="verdana" size="2" color='#800080'><b># : </b>Not Submitted</font></td>
		<td width='137' height='25' bgcolor='#FFFFFF' align='left'>
			<font face="verdana" size="2" color='#800080'><b>$ : </b>Not Assigned</font></td>
	</tr>
</table>

<%
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("SSViewOfGrades.jsp","at display","Exception",e.getMessage());
		System.out.println(e.getMessage());
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
			ExceptionsFile.postException("SSViewOfGrades.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
   }	
%>

</body>
</html>

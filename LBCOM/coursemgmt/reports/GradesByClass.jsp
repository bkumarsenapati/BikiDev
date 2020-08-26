<%@ page import="java.sql.*,java.util.*,java.text.*,coursemgmt.ExceptionsFile,exam.FindGrade"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;

	Hashtable courses=null,categoryTable=null,percentages=null,totalMarksTbl=null,weightedTbl=null,typeTable=null;
	Enumeration courseNames=null;        //,categories=null;  changed by ghanendra

	DecimalFormat df=null;
	FindGrade fg=null;

	String studentId="",classId="",courseId="",courseName="",schoolId="",category="",catDesc="",type="",bgColor="",className="",grade="";

	float wtg=0.0f,weightedPoints=0.0f,marks=0.0f,totalMarks=0.0f,totalPoints=0.0f,possibleTotal=0.0f,totalWeightage=0.0f,weight=0.0f,centMarks=0.0f;

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
		classId= (String)session.getAttribute("classid");
		className= (String)session.getAttribute("classname");
		studentId=(String)session.getAttribute("emailid");
		courseId=request.getParameter("courseid");
		courseName=request.getParameter("coursename");
		con=con1.getConnection();
		st=con.createStatement();

		
		categoryTable=new Hashtable();
		percentages=new Hashtable();
		totalMarksTbl=new Hashtable();
		weightedTbl=new Hashtable();
		typeTable=new Hashtable();
		
		df=new DecimalFormat();
		df.setMaximumFractionDigits(2);

		wtg=0;
		marks=0;
		catDesc="";
		totalMarks=0;
		weightedPoints=0;
		grade="";
		
			rs=st.executeQuery("select * from category_item_master where course_id='"+courseId+"' and category_type!='CM' and category_type!='CO' and grading_system!=0 and school_id='"+schoolId+"' order by category_type");
		    while(rs.next()){
			  categoryTable.put(rs.getString("item_id"),rs.getString("item_des"));
			  percentages.put(rs.getString("item_id"),rs.getString("weightage"));
			  typeTable.put(rs.getString("item_id"),rs.getString("category_type"));
		   }
		if(categoryTable.size()<=0)
		{
%>
		<table border='1' cellspacing='1' bordercolor='#111111' width='800'>
			<tr>
				<td width='100%' bgcolor='#C1BDAA' height='25'><b>
					<font face='Verdana' size='2' color='#800000'>Class Name:&nbsp;<%=className%></font></b></td>
			</tr>
			<tr>
				<td width='100%' bgcolor='#C1BDAA' height='25'><b>
					<font face='Verdana' size='2' color='#800000'>Student Name:&nbsp;<%=studentId%></font></b></td></tr><tr>
				<td width='100%' bgcolor='#F7F3F7' height='25'><b>
					<font face='Verdana' size='2'>There are no categories in this course.</font></b></td>
			</tr>
		</table>
<%
			return;
        }

	}
	catch(SQLException s)
	{
		ExceptionsFile.postException("GradesByClass.jsp","at display","SQLException",s.getMessage());
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
				
		}catch(SQLException se){
			ExceptionsFile.postException("GradesByClass.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}catch(Exception e){
		ExceptionsFile.postException("GradesByClass.jsp","Operations on database and hashtables","Exception",e.getMessage());
		System.out.println("Error in GradesByClass is "+e);
	}
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Penns Grove - Carneys Point Regional School District</title>
</head>

<body topmargin="3" leftmargin="3">
	<table border="0" width="100%" cellspacing="1">
	  <tr>
        <td width="100%" valign="middle" align="left" bgcolor="#E8ECF4"><b>
			<font face="Verdana" size="2" color="#800080">Grade Book</font>
			<font face="Arial" size="2">&gt;&gt;</font>
			<font size="2" color="#800080" face="Verdana"><a href='GradesByCategory.jsp'>Courses</a></font>
			<font face="Arial" size="2">&gt;&gt;</font></b>
			<font face="Verdana" size="2" color="#800080"><b><%=courseName%></b></td>
      </tr>
  </table>
  <br>
<center>  
  <table border="0" cellspacing="1" bordercolor="#111111" width="700">
	<tr>
		<td width="150" bgcolor="#C1BDAA" height="25"><b><font face='Verdana' size='2'>Class</font></b></td>
		<td width="550" bgcolor="#D7D0C4" height="25"><b><font face='Verdana' size='2'><%=className%></font></b></td>	
	</tr>
	<tr>
		<td width="150" bgcolor="#C1BDAA" height="25"><b><font face='Verdana' size='2'>Student Name</font></b></td>
		<td width="550" bgcolor="#D7D0C4" height="25"><b><font face='Verdana' size='2'><%=studentId%></font></b></td>
	</tr>
  </table>
<br>

<%
	try
	{
		int j=0;
		totalMarks=0;
		wtg=0;
		totalWeightage=0;
		weightedPoints=0;
		//categories=categoryTable.keys();
                SortedSet categories = new TreeSet(categoryTable.keySet());  
%>
			<table border='0' cellpadding='2' cellspacing='2' bordercolor='#111111' width='700' height="113">
				<tr>
					<td width='350' height='28' bgcolor='#CECFCE' align='left'>
						<font face='Verdana' size='2' color='#003063'><u><b>
						<a href="GradesByStudent.jsp?classid=<%=classId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&studentid=<%=studentId%>&type=all&mode=S&classname=<%=className%>">
						Category</a></b></u></font></td>
							  
					<td width='175' height='28' bgcolor='#CECFCE' align='center'><b>
						<font face='Verdana' size='2' color='#003063'>Maximum Points (attempted) </font></b></td>
					
					<td width='175' height='28' bgcolor='#CECFCE' align='center'><b>
						<font face='Verdana' size='2' color='#003063'>Secured Points</font></b></td>
				  
					<!-- <td width='150' height='28' bgcolor='#CECFCE' align='center'><b>
						<font face='Verdana' size='2' color='#003063'>weighted Points</font></b></td> -->
					
					<!-- <td width='150' height='28' bgcolor='#CECFCE' align='center'><b>
						<font face='Verdana' size='2' color='#003063'>Weightage</font></b></td> -->
				</tr>
<%				  
				  boolean gradeFlag=false;
				  boolean worksFlag=false;
				  Statement stmt=con.createStatement();
		   		  ResultSet rst=null;
				  Iterator itr = categories.iterator();    // added by ghanendra
				//while(categories.hasMoreElements())
				while(itr.hasNext())
				{
					if (j%2==0)
						bgColor="";
					else
						bgColor="#F7F3F7";
					j++;
					//category=(String)categories.nextElement();
					category = (String)itr.next();           // added by ghanendra
					catDesc =(String)categoryTable.get(category);
					wtg=Float.parseFloat((String)percentages.get(category));
					type=(String)typeTable.get(category);
					marks=0;
					totalPoints=0;
%>
				<tr>
					<td height='28'  bgcolor='<%=bgColor%>' align='left' width="350">
						<a href='GradesByStudent.jsp?classid=<%=classId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&studentid=<%=studentId%>&type=<%=category%>&mode=S'><b>
						<font face='Verdana' size='2'><%=catDesc%></font></b>
					</td>
<%
					rs.close();

					if(type.equals("EX"))
						rs=st.executeQuery("select sum(marks_secured) marks,sum(total_marks) total_marks from "+schoolId+"_cescores cs inner join exam_tbl as et on cs.work_id=et.exam_id and et.course_id='"+courseId+"' and et.school_id='"+schoolId+"' and et.status=1 where cs.course_id='"+courseId+"' and cs.user_id='"+studentId+"' and category_id='"+category+"' and cs.status!=3 and cs.status!=0 and cs.school_id='"+schoolId+"'");

						else
					rs=st.executeQuery("select sum(marks_secured) marks, sum(total_marks) total_marks from "+schoolId+"_cescores where user_id='"+studentId+"' and course_id='"+courseId+"' and category_id='"+category+"' and status!=3 and status!=0 and  school_id='"+schoolId+"'");


				if(rs.next())
				{
					marks=rs.getFloat("marks");
						
					if (marks==0)
					{
						rst=stmt.executeQuery("select * from "+schoolId+"_cescores where user_id='"+studentId+"' and course_id='"+courseId+"' and category_id='"+category+"' and status > 0 and school_id='"+schoolId+"'");
						if(rst.next())
						{
							gradeFlag=true;
						}
					}
					else if(marks>0)
					{
						gradeFlag=true;
					}
						
					totalPoints=rs.getFloat("total_marks");
					possibleTotal=possibleTotal+totalPoints;
					totalMarks+=marks;		
%>
					<td bgcolor='<%=bgColor%>' align='center' width="175" height="28"><%=df.format(Double.valueOf(String.valueOf(totalPoints)))%></td>

					<td bgcolor='<%=bgColor%>' align='center' width="175" height="28"><%=df.format(Double.valueOf(String.valueOf(marks)))%></td>

<%
	if(rs.getString("total_marks")==null)
	{
		weight=0;
		weightedPoints+=0;
		totalWeightage+=0;
	}
	else
	{
		worksFlag=true;
		weight=(marks*wtg)/totalPoints;
		weightedPoints+=weight;
		totalWeightage+=wtg;
	}
%>
					<!-- <td bgcolor='<%=bgColor%>' align='center'><%=df.format(Double.valueOf(String.valueOf(weight)))%></td> -->

					<!-- <td align='center' bgcolor='<%=bgColor%>'><b><font face='Verdana' size='2'><%=wtg%>%</font></b></td> -->
<%

			}
		}
%>				  
				</tr>
				<tr>	
					<td colspan='1' width='350' bgcolor='#E1E1E1' align='left' height="31"><b>
						<font color='#800080' face='Verdana' size='2'>Total</font></b></td>

					<td bgcolor='#E1E1E1' align='center' width="175" height="31"><b>
						<font color='#800080' face='Verdana' size='2'> <%=df.format(Double.valueOf(String.valueOf(possibleTotal)))%></font></b></td>

					<td bgcolor='#E1E1E1' align='center' width="175" height="31">
						<font color='#800080' face='Verdana' size='2'><b> <%=df.format(Double.valueOf(String.valueOf(totalMarks)))%></b></font></td>

					<!-- <td bgcolor='#E1E1E1' align='center'><b>
					<font color='#800080' face='Verdana' size='2'><%=df.format(Double.valueOf(String.valueOf(weightedPoints)))%></font></b></td> -->

					<!-- <td bgcolor='#E1E1E1'>&nbsp;</td> -->
				</tr>
<%					
					fg=new FindGrade();
					centMarks=fg.convertToCent(weightedPoints,totalWeightage);
					grade=fg.getGrade(schoolId,classId,courseId,centMarks);
				  
				  //out.println("<tr><td colspan='5' align='center' bgcolor='#E1E1E1'><font color='#800080' face='Verdana' size='2'><b>Grade = "+grade+"</b></td></tr>");
					if(worksFlag)
					{
						if(gradeFlag)
						{
%>
				<!-- <tr>
					<td colspan='5' align='center' bgcolor='#E1E1E1'>
						<font color='#800080' face='Verdana' size='2'><b>Grade = '<%=grade%>'</b>
					</td>
				</tr> -->
<%
						}
						else
						{
%>
				<tr>
					<td colspan='5' align='center' bgcolor='#E1E1E1' height="26">
						<font color='#800080' face='Verdana' size='2'><b>Not Attempted.</b></td>
				</tr>
<%
						}
				  }
%>
		</table>
<%
		}
		catch(Exception e){
			ExceptionsFile.postException("GradesByClass.jsp","at displaying","Exception",e.getMessage());
			
		}finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("GradesByClass.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("in GradesByClass.jsp"+se.getMessage());
		}
   }
%>
</center>
</body>
</html>
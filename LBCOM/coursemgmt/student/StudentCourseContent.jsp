
<!--
	/**
	 *Displays the contents in the courseware and also the no.of new items for each content.
     *Also provides the link to go the inbox of each content
	 */
-->




<%@ page import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile" autoFlush="true"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null,rs1=null;
	
	String SELFTEST="",selfTests="",catCO="",newCourseOutlines="",queryString1="";
	String courseName="",categoryId="",courseId="",classId="",workId="",schoolId="",studentId="",queryString="";
    String newMaterials="",newAssignments="",newExams="",examId="",examType="",createDate="",tableName="";  
	     //no.of new items for each category

	int newAssItems=0,newMatItems=0,newExamItems=0,newCatItems=0;
	String cid="";                                                 // added by ghanendra for usage report

%>
<%
	try {
		session=request.getSession();
		String sessid=(String)session.getAttribute("sessid");
			
		if(sessid==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
		}
		studentId=(String)session.getAttribute("emailid");
		schoolId=(String)session.getAttribute("schoolid");
		classId=(String)session.getAttribute("classid");

		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();

		courseName=request.getParameter("coursename");
		courseId=request.getParameter("courseid");
		cid = schoolId + "/" + courseId;             // added by Ghanendra
		
		queryString="";
		queryString1="";
		newAssItems=0;
		newExamItems=0;
		newMatItems=0;
		
		session.putValue("courseid",courseId);



		  /*
					*select the work_ids of  workAssignments(PW/HW/ASS)
					*Then find new workAssignments from the selected work_ids
					*Add them to the variable newAssItems
					*find the new Results from the selected work_ids and add them to the newResults var
				    */ 	
				  rs=st.executeQuery("select count(distinct(w.work_id)) from "+schoolId+"_"+classId+"_"+courseId+"_workdocs as w inner join  "+schoolId+"_"+classId+"_"+courseId+"_dropbox as d on w.work_id=d.work_id and d.status=0 and d.student_id='"+studentId+"' where (w.from_date<=curdate() and w.to_date>=curdate()) or ( w.to_date='0000-00-00' and w.from_date<=curdate()) ");
				  if(rs.next()) {					
					   newAssItems+=rs.getInt(1);
				  } 
				   
				   rs.close();			

				  
				   
				   			   
				   /*
				    *select the work_ids of courseMaterials(CO/CM/RB/MI)
					*Then find the new CourseMaterials and add them to the variable newNatItems
					*/

				  rs=st.executeQuery("select item_id from category_item_master where course_id='"+courseId+"' and category_type='CO' and school_id='"+schoolId+"'");
				  while(rs.next()){
					  if(queryString.equals(""))
							queryString="category_id='"+rs.getString("item_id")+"'";
					  else
						  queryString+=" or category_id='"+rs.getString("item_id")+"'";
				  }
				  
                  rs.close();	
				  rs=st.executeQuery("select item_id from category_item_master where course_id='"+courseId+"' and category_type='CM' and school_id='"+schoolId+"'");
				  while(rs.next()){
					  if(queryString1.equals(""))
							queryString1="category_id='"+rs.getString("item_id")+"'";
					  else
						  queryString1+=" or category_id='"+rs.getString("item_id")+"'";
				  }	
   			      
				  rs.close();
				  newCatItems=0;
				rs=st.executeQuery("select count(distinct(c.work_id)) from course_docs as c inner join course_docs_dropbox as d on c.work_id=d.work_id and c.school_id=d.school_id where c.course_Id='"+courseId+"' and c.school_id='"+schoolId+"' and d.school_id='"+schoolId+"' and d.status=0 and d.student_id='"+studentId+"' and ("+queryString+")");
       			 
				  if(rs.next()){
					  newCatItems+=rs.getInt(1);
				  }
				rs.close();
				rs=st.executeQuery("select count(distinct(c.work_id)) from course_docs as c inner join course_docs_dropbox as d on c.work_id=d.work_id and c.school_id=d.school_id where c.course_Id='"+courseId+"' and c.school_id='"+schoolId+"' and d.school_id='"+schoolId+"' and d.status=0 and d.student_id='"+studentId+"' and ("+queryString1+")");
				newMatItems=0;
				if(rs.next()){
					newMatItems+=rs.getInt(1);   
				}
				rs.close();
				newExamItems=0;
				rs=st.executeQuery("select count(distinct(e.exam_id)) from exam_tbl as e inner join "+schoolId+"_"+studentId+" as s on e.exam_id=s.exam_id where e.course_id='"+courseId+"' and e.school_id='"+schoolId+"' and e.status='1' and s.exam_status='0' and (e.to_date='0000-00-00' or (e.to_date>curdate())or (e.to_date=curdate() and e.to_time<=curtime()))");
				if(rs.next()) {
					newExamItems+=rs.getInt(1);
				}
				
		
		if(newExamItems==0)
			newExams="";
		else
			newExams="("+newExamItems+")";
		if(newMatItems==0)
			newMaterials="";
		else
			newMaterials="("+newMatItems+")";
		if(newAssItems==0)
			newAssignments="";
    	else
			newAssignments="("+newAssItems+")";
		if(newCatItems==0)
			newCourseOutlines="";
		else
			newCourseOutlines="("+newCatItems+")";
		
	
   }
   catch(Exception e){
	   ExceptionsFile.postException("StudentCourseContent.jsp","Operations on database and reading parameters","Exception",e.getMessage());
		System.out.println("Error:  -" + e.getMessage());
   }finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("StudentCourseContent.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
		

   }
 

%>

<html>
<head>
<title></title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0"><meta name="author" content="hotschools.net">

<script language="JavaScript">
<!--
       function setMatVar(course_id)
       {
          parent.frames['left'].studycid = course_id;
          parent.frames['left'].temp = 'study';
       } 
       
       function setAsgnVar(course_id)
       {
          parent.frames['left'].asgncid = course_id;
          parent.frames['left'].temp = 'assignment';
       }
       
       function setAsmtVar(course_id)
       {
          parent.frames['left'].asmtcid = course_id;
          parent.frames['left'].temp = 'assessment';
       }   
 	
       function setVar()
       {
          parent.frames['left'].temp = 'other';
       }   
 	    
//-->	   
</script>


</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" topmargin="3" leftmargin="5">

<!--For providing the link to the courses-->
<table border="0" width="100%" cellspacing="1">
    <tr>
      <td width="100%" valign="middle" align="left" bgcolor="#FBF4EC"><font color="#800000" face="Arial" size="2"><b><a href="CourseHome.jsp">Courses</a> <font size=1>&nbsp;>>&nbsp;</font><%=courseName%></b></font></td>
    </tr>
  </table>

<font face=arial size=2><b>

<p>&nbsp;</p>

<hr color="#E87418" width="600">
<table align="center" border="0" cellpadding="0" cellspacing="0" width="600">
    <tr>
        <td width="600">

        </td>
    </tr>
    <tr>
        <td width="600">
<TABLE borderColor="#E87418" width="600" border="0" cellpadding="0" cellspacing="0" bordercolordark="#E87418" bordercolorlight="#E87418" align="center">

<TBODY align="center">


<TBODY >   

<!--To display the course contents,no.of new items and to provide link for each content in a tabular format  -->
<TR>
	 <TD width="62"><p>
     <a href="AssignmentFrames.jsp?type=CO&coursename=<%=courseName%>" onclick="javascript: setVar();"><img src="../images/courseoutline.gif" width="60" height="67" border="0"></a></p>
	 </TD>
	 <TD width="334"><FONT face=Arial size=2>
	 <a href="AssignmentFrames.jsp?type=CO&coursename=<%=courseName%>" onclick="javascript: setVar();">Course Info</a><%=newCourseOutlines%></FONT></TD>
	 <TD width="63"><p>
	 <a href="AssignmentFrames.jsp?type=CM&coursename=<%=courseName%>" onclick="javascript: setMatVar('<%=cid%>');"><img src="../images/courseoutline.gif" width="60" height="67" border="0"></a></p>
     </TD>
	 <TD width="283"><FONT face=arial size=2>
	 <a href="AssignmentFrames.jsp?type=CM&coursename=<%=courseName%>" onclick="javascript: setMatVar('<%=cid%>');">Course Material</a><%=newMaterials%></FONT></TD>
</TR>
<TR>
	<TD width="62"><p>
    <a href="AssignmentFrames.jsp?type=AS&coursename=<%=courseName%>"  onclick="javascript: setAsgnVar('<%=cid%>');"><img src="../images/assignment.gif" width="60" height="62" border="0"></a></p></TD>
	<TD width="334"><FONT face=arial size=2>
	<a href="AssignmentFrames.jsp?type=AS&coursename=<%=courseName%>"  onclick="javascript: setAsgnVar('<%=cid%>');">Assignments </a><%=newAssignments%></FONT></TD>

	<TD width="63"><p><font face=arial size=2><b>
	<a href="AssignmentFrames.jsp?type=EX&coursename=<%=courseName%>" onclick="javascript: setAsmtVar('<%=cid%>');"><img border="0" src="../images/quiz.gif" width="60" height="63" lowsrc="quiz.gif"></a></p></b></font>
	</TD><font face=arial size=2><b>
	<TD width="283"><font face=arial size=2>
    <a href="AssignmentFrames.jsp?type=EX&coursename=<%=courseName%>" onclick="javascript: setAsmtVar('<%=cid%>');">Assessments</a><%=newExams%> </font></TD>

</TR>
<TR>
	<TD width="62"><p>
    <a href="WeblinksList.jsp?coursename=<%=courseName%>&totrecords=&start=0" onclick="javascript: setVar();"><img src="../images/stu_weblinks.gif" width="60" height="62" border="0" TITLE="Weblinks"></a></p></TD>
	<TD width="334"><FONT face=arial size=2>
	<a href="WeblinksList.jsp?coursename=<%=courseName%>&totrecords=&start=0" onclick="javascript: setVar();">Weblinks</a></FONT></TD>
</tr>

<TD width="62">

</TD>

</TBODY></TABLE></b></font></td>
    </tr>
</table>
<hr color="#E87418" width="600" >
<p>&nbsp;</p>
</body>
</html>

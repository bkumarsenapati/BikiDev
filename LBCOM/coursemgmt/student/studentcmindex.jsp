<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" autoFlush="true"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%

Connection con=null;
Statement st=null,st1=null;
ResultSet  rs=null,rs1=null;


Vector courseNames=null,schoolNames=null,courseIds=null,teachers=null;		     				//stores the coursenames alloted to the student
//Vector assWorkIds,matWorkIds,courseIds;

int inboxItems=0;					//total no.of new items in the studnet inbox
int newAssItems=0,totalAssItems=0;				//total no.of new AS+HW+PW
int newMatItems=0;				//total no.of new CO+CM+RB+MI
int newResults=0;					//total no of new Results
int len=0,i=0;
int newExams=0,totalExams=0;
int newMidExams=0;
int newFinals=0;
boolean flag=false;					//false if there are no courses for the student

String courseName="",classId="",studentName="",studentId="",schoolId="",courseId="",workId="",examId="",createDate="",examType="";
String tableName="",teacherId="",crossRegisterFlag="";
String newSchoolId="";
String cid="";                           // added by ghanendra for usage report
%>
<%
try
{
	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}

	String sessionStatus=(String)session.getAttribute("sessionstatus");
	if(sessionStatus==null)
	{
		schoolId=(String)session.getAttribute("schoolid");
		studentId=(String)session.getAttribute("emailid");
		studentName=(String)session.getAttribute("studentname");
		classId=(String)session.getAttribute("classid");
	}
	else
	{
		schoolId=(String)session.getAttribute("originalschoolid");
		studentId=(String)session.getAttribute("originalemailid");
		studentName=(String)session.getAttribute("originalstudentname");
		classId=(String)session.getAttribute("originalclassid");
	}
	
	con=con1.getConnection();
	st=con.createStatement();
	st1=con.createStatement();
	
	rs=st.executeQuery("select crossregister_flag from studentprofile where username='"+studentId+"' and schoolid='"+schoolId+"'");
	if(rs.next())
	{
		crossRegisterFlag=rs.getString("crossregister_flag");
	}
	rs.close();
	
	if(crossRegisterFlag.equals("1"))
	{
		rs=st.executeQuery("select schoolid from studentprofile where username='"+schoolId+"_"+studentId+"'");
		schoolNames=new Vector();
		while(rs.next())
		{
			schoolNames.add(rs.getString("schoolid"));
		}
		rs.close();
	}
	//// This is for teacher to view his own courses when he try to view virtual student courses
	String sview_string="";
	if(crossRegisterFlag.equals("3"))
	{
		String lu=(String)session.getAttribute("Login_user");
		if(!lu.equals(""+studentId+""))
			sview_string="and c.teacher_id='"+lu+"'";
		
	}
	/// end  and check for sview_string
	rs=st.executeQuery("select c.course_name,c.course_id,c.teacher_id from coursewareinfo c inner join coursewareinfo_det d  on c.course_id=d.course_id and c.school_id=d.school_id where d.student_id='"+studentId+"' and c.status=1 and c.school_id='"+schoolId+"' and class_id='"+classId+"'"+sview_string);
	
	courseNames=new Vector();
	courseIds=new Vector();
	teachers=new Vector();

	while (rs.next()) 
	{		
		courseNames.add(rs.getString("course_name"));
		courseIds.add(rs.getString("course_id"));
		teachers.add(rs.getString("teacher_id"));
	}
	rs.close();
%>

<html>
<head>
<title></title>

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
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" topmargin="0" leftmargin="5">

<table border="0" width="100%" height="135" cellspacing="0" align="center" cellpadding="0">
	<tr>
		<td width="988" height="46" valign="top">
			<b><font face="Arial" size="4">Welcome <%=studentName%>&nbsp;!</font></b>
		</td>
	</tr>
	<tr>
		<td width="100%" valign=top >
		
	<table border="0" width="100%" cellspacing="1" bordercolordark="#FFFFFF">
		<tr>
			<td width="824" height="32" colspan="7">
				<img src="../images/slistofcourses.gif" width="151" height="28" border="0">
			</td>
		</tr>
		<tr>
			<td  height="18" width="3%" bgcolor="#E08040" align="center" width="24">
			&nbsp;&nbsp;
			</td>
			<td width="38%" height="18" bgcolor="#E08040" align="center">
				<font face="Arial" color="#FFFFFF" size="2"><b>Course Name</b></font>
			</td>
			<td height="18" width="3%" bgcolor="#E08040" align="center">
				<font face="Arial" color="#FFFFFF" size="2"><b></b></font>
			</td>	
			<td width="8%" height="18" bgcolor="#E08040" align="center">
				<font face="Arial" color="#FFFFFF" size="2"><b>Teacher </b></font>
			</td>
			<!-- <td width="96" height="18" bgcolor="#E08040" align="center">
				<font face="Arial" color="#FFFFFF" size="2"><b>Inbox</b></font>
			</td> -->
			<td width="10%" height="18" bgcolor="#E08040" align="center">
				<b><font face="Arial" color="#FFFFFF" size="2">Assignments</font></b>
			</td>
			<td width="11%" height="18" bgcolor="#E08040" align="center">
				<font face="Arial" color="#FFFFFF" size="2"><b>Assessments</b></font>
			</td>
			<!-- Commented by Rajesh
			<td width="23%" height="18" bgcolor="#E08040" align="center">
				<font face="Arial" color="#FFFFFF" size="2"><b>Materials</b></font>
			</td> -->
					
			<td width="7%" height="15" bgcolor="#E08040" align="center">           
				<font face="Arial" color="#FFFFFF" size="2"><b>Results</b></font>
			</td>
		</tr>
<%
	for(int j=0;j<courseNames.size();j++)		    // for each course	
	{
		courseName=(String)courseNames.get(j);
		courseId=(String)courseIds.get(j);
		teacherId=(String)teachers.get(j);
		cid = schoolId + "/" + courseId;              // added by ghanendra
		inboxItems=0;
		newAssItems=0;
		newResults=0;
		totalAssItems=0;
		totalExams=0;
/*
		*select the work_ids of  workAssignments(PW/HW/ASS)
		*Then find new workAssignments from the selected work_ids
		*Add them to the variable newAssItems
		*find the new Results from the selected work_ids and add them to the newResults var
*/ 		
		rs=st.executeQuery("select count(distinct(work_id)) as cnt,status from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where student_id='"+studentId+"' and submit_count<=1 and (start_date<=curdate() and end_date>=curdate()) or (end_date='0000-00-00' and start_date<=curdate()) group by status");
		int sts=0,cnt=0;
		
		while(rs.next()) 
		{
			sts=rs.getInt("status");
			cnt=rs.getInt("cnt");
			if(sts==4)
				newResults+=cnt;
			if(sts==0)
				newAssItems=newAssItems+1; 
			totalAssItems+=cnt;
		}
		rs.close();					   
		inboxItems=newAssItems+newResults;	//new items in the inbox				   
/*
	    *select the work_ids of courseMaterials(CO/CM/RB/MI)
		*Then find the new CourseMaterials and add them to the variable newNatItems
*/
		rs=st.executeQuery("select count(distinct(c.work_id)) from course_docs as c inner join course_docs_dropbox as d on c.work_id=d.work_id and c.school_id=d.school_id where c.course_Id='"+courseId+"' and c.school_id='"+schoolId+"' and d.school_id='"+schoolId+"' and d.status=0 and d.student_id='"+studentId+"'");
		newMatItems=0;		
		if(rs.next()) 
		{
			newMatItems+=rs.getInt(1);   
		}					
		inboxItems+=newMatItems;	        //new items in Inbox				
		rs.close();
		rs=st.executeQuery("select exam_status as status,count(e.exam_id) as cnt from exam_tbl as e inner join "+schoolId+"_"+studentId+" as s on e.exam_id=s.exam_id where e.course_id='"+courseId+"' and e.school_id='"+schoolId+"' and e.status='1' and (e.to_date='0000-00-00' or (e.to_date>curdate()) or (e.to_date=curdate() and e.to_time<=curtime())) group by exam_status");		
		sts=0;cnt=0;
		newExams=0;
		while(rs.next()){
			sts=rs.getInt("status");
			cnt=rs.getInt("cnt");
			if(sts==0)
				newExams=cnt; 
			totalExams+=cnt;
		}
		rs.close();	
		inboxItems+=newExams;
%>
<!--To display the course name, new items in a tabular format   -->

	<tr>
		<td height="20" width="3%" bgcolor="#E7E7E7" align="center" width="24">
			<!-- AssignmentFrames.jsp?type=CO&coursename=SPC  -->
			<a href="ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=schoolId%>&studentid=<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=newtoold&page_type=CO" onclick="javascript: setVar();">
			<img border="0" src="../images/courseinfo.gif" width="20" height="22" Title="Course Info"></a>
		</td>
        <td width="38%" height="20" bgcolor="#E7E7E7" align="left">
           <a href="ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=schoolId%>&studentid=<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=newtoold&page_type=CM" Title="Course Material"  onclick="javascript: setMatVar('<%=cid%>');"> 
		   <font face="Arial" size="2" ><%=courseName%></font></a>
        </td>
		<td width="3%" height="20" bgcolor="#E7E7E7" align="center">
            <a href="ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=schoolId%>&studentid=<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=newtoold&page_type=WL" TITLE="Resourses"  onclick="javascript: setVar();"><img border="0" src="../images/stu_weblinks.gif" width="20" height="22" Title="Weblinks"></a>
        </td>
		<td width="8%" height="20" bgcolor="#E7E7E7" align="left">
			<font face="Arial" size="2"><%=teacherId%></font>
        </td>
		<!--  
		<td width="96" height="20" bgcolor="#E7E7E7" align="center">
            <font face="Arial" size="2" color="red"><b><%=inboxItems%></b></font>
        </td>
		-->
        <td width="10%" height="20" bgcolor="#E7E7E7" align="center">
			<a href="ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=schoolId%>&studentid=<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=newtoold&page_type=AS" TITLE="Assignments" onclick="javascript: setAsgnVar('<%=cid%>');"><font face="Arial" size="2"><%=newAssItems%>/<%=totalAssItems%></font></a>
        </td>
        <td width="11%" height="20" bgcolor="#E7E7E7" align="center">
            <a href="ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=schoolId%>&studentid=<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=newtoold&page_type=EX" TITLE="Assessments" onclick="javascript: setAsmtVar('<%=cid%>');"><font face="Arial" size="2"><%=newExams%>/<%=totalExams%></font></a>
        </td>
		<!-- Commented by Rajesh
        <td width="23%" height="20" bgcolor="#E7E7E7" align="center">
            <font face="Arial" size="2"><%=newMatItems%></font>
        </td> 
		-->		
		<td width="7%" height="25" bgcolor="#E7E7E7" align="center">
            <font face="Arial" color="green"><b><%=newResults%></b></font>
        </td>
    </tr>
<% 
		flag=true;
	}
%>
<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->
<%
	if(crossRegisterFlag.equals("1"))
	{
		for(int k=0;k<schoolNames.size();k++)
		{
			newSchoolId=(String)schoolNames.get(k);
%>
<%
			rs=st.executeQuery("select c.course_name,c.course_id,c.teacher_id from coursewareinfo c inner join coursewareinfo_det d  on c.course_id=d.course_id and c.school_id=d.school_id where d.student_id='"+schoolId+"_"+studentId+"' and c.status=1 and c.school_id='"+newSchoolId+"' and class_id='"+classId+"'");
			
			courseNames=new Vector();
			courseIds=new Vector();
			teachers=new Vector();

			while (rs.next()) 
			{		
				courseNames.add(rs.getString("course_name"));
				courseIds.add(rs.getString("course_id"));
				teachers.add(rs.getString("teacher_id"));
			}
			rs.close();
%>
<%
			for(int j=0;j<courseNames.size();j++)		    // for each course	
			{
				courseName=(String)courseNames.get(j);
				courseId=(String)courseIds.get(j);
				teacherId=(String)teachers.get(j);
				cid = newSchoolId + "/" + courseId;        // added by ghanendra
				inboxItems=0;
				newAssItems=0;
				newResults=0;
				totalAssItems=0;
				totalExams=0;
				rs=st.executeQuery("select count(distinct(work_id)) as cnt,status from  "+newSchoolId+"_"+classId+"_"+courseId+"_dropbox where student_id='"+studentId+"' and (start_date<=curdate() and end_date>=curdate()) or ( end_date='0000-00-00' and start_date<=curdate()) group by status");
				int sts=0,cnt=0;
				
				while(rs.next()) 
				{
					sts=rs.getInt("status");
					cnt=rs.getInt("cnt");
					if(sts==4)
						newResults+=cnt;
					if(sts==0)
						newAssItems=cnt; 
					totalAssItems+=cnt;
				}
				rs.close();
				inboxItems=newAssItems+newResults;	//new items in the inbox
						   
				rs=st.executeQuery("select count(distinct(c.work_id)) from course_docs as c inner join course_docs_dropbox as d on c.work_id=d.work_id and c.school_id=d.school_id where c.course_Id='"+courseId+"' and c.school_id='"+newSchoolId+"' and d.school_id='"+newSchoolId+"' and d.status=0 and d.student_id='"+schoolId+"_"+studentId+"'");

				newMatItems=0;
				
				if(rs.next()) 
				{
					newMatItems+=rs.getInt(1);   
				}
							
				inboxItems+=newMatItems;	        //new items in Inbox					
				rs.close();
				rs=st.executeQuery("select exam_status as status,count(e.exam_id) as cnt from exam_tbl as e inner join "+newSchoolId+"_"+schoolId+"_"+studentId+" as s on e.exam_id=s.exam_id where e.course_id='"+courseId+"' and e.school_id='"+newSchoolId+"' and e.status='1' and (e.to_date='0000-00-00' or (e.to_date>curdate()) or (e.to_date=curdate() and e.to_time<=curtime())) group by exam_status");		
				sts=0;cnt=0;
				newExams=0;
				while(rs.next()){
					sts=rs.getInt("status");
					cnt=rs.getInt("cnt");
					if(sts==0)
						newExams=cnt; 
					totalExams+=cnt;
				}
				rs.close();	
				inboxItems+=newExams;
%>
		<!--To display the course name, new items in a tabular format   -->

			<tr>
				<td height="20" width="3%" bgcolor="#E7E7E7" align="center" width="24">
				<a href="ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=newSchoolId%>&studentid=<%=schoolId%>_<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=oldtonew&page_type=CO"  onclick="javascript: setVar();"><img border="0" src="../images/courseinfo.gif" width="17" height="20" Title="Course Info"></a>
				</td>

				<td width="38%" height="20" bgcolor="#E7E7E7" align="left">
				   <a Title="Course Material" href="ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=newSchoolId%>&studentid=<%=schoolId%>_<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=oldtonew&page_type=CM" onclick="javascript: setMatVar('<%=cid%>');"> 
				   <font face="Arial" size="2" ><%=courseName%></font></a>
				</td>
				<td height="20" width="3%" bgcolor="#E7E7E7" align="center">
					<a href="ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=newSchoolId%>&studentid=<%=schoolId%>_<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=oldtonew&page_type=WL" TITLE="Weblinks"  onclick="javascript: setVar();"><img border="0" src="../images/stu_weblinks.gif" width="17" height="20" ></a>
				</td>
				<td width="8%" height="20" bgcolor="#E7E7E7" align="left">
					<font face="Arial" size="2"><%=teacherId%></font>
				</td>
				<!-- <td width="96" height="20" bgcolor="#E7E7E7" align="center">
					<font face="Arial" size="2" color="red"><b><%=inboxItems%></b></font>
				</td> -->
				<td width="10%" height="20" bgcolor="#E7E7E7" align="center">
					<a href="ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=newSchoolId%>&studentid=<%=schoolId%>_<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=oldtonew&page_type=AS" TITLE="Assignments" onclick="javascript: setAsgnVar('<%=cid%>');"><font face="Arial" size="2"><%=newAssItems%>/<%=totalAssItems%></font></a>
				</td>
				<td width="11%" height="20" bgcolor="#E7E7E7" align="center">
					<a href="ChangeSessionValues.jsp?coursename=<%=courseName%>&courseid=<%=courseId%>&schoolid=<%=newSchoolId%>&studentid=<%=schoolId%>_<%=studentId%>&studentname=<%=studentName%>&classid=<%=classId%>&mode=oldtonew&page_type=EX" TITLE="Assessments" onclick="javascript: setAsmtVar('<%=cid%>');"><font face="Arial" size="2"><%=newExams%>/<%=totalExams%></font></a>
				</td>
				<!-- Commented by Rajesh
				<td width="23%" height="20" bgcolor="#E7E7E7" align="center">
					<font face="Arial" size="2"><%=newMatItems%></font>
				</td> -->
				
				<td width="7%" height="25" bgcolor="#E7E7E7" align="center">
					<font face="Arial" color="green"><b><%=newResults%></b></font>
				</td>
			</tr>
<% 
				flag=true;
			}
%>
<%
		}
	}
%>
<!--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->
<%
	if(!flag)		//if there are no courses alloted to the student
	{
%>
	<tr>
		<td width="100%" colspan="9" height="21" align="center" bgcolor="#E7E7E7">
			<font face="Arial" color="#000000" size="2">Presently there are no Courses available.</font>
		</td>
	</tr>			
<%
		}	
	}	
	catch(SQLException se)
	{
		ExceptionsFile.postException("studentcmindex.jsp","Operations on database","SQLException",se.getMessage());
		System.out.println("Error in studentcindex.jso : SQL in studentcmindex.jsp......." + se.getMessage());
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("studentcmindex.jsp","Operations on database","Exception",e.getMessage());
		System.out.println("Error in studentcmindex.jsp:  -" + e.getMessage());

	}

	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("studentcmindex.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("SQL Error in studentcmindex.jsp"+se.getMessage());
		}
	}
%>
		</table>
	</td>
  </tr>
</table>

</body>
</html>
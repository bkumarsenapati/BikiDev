<%@ page language="java" import="coursemgmt.StudentWorksBean,java.io.PrintWriter,java.util.Hashtable,java.util.Enumeration"%>
<%!
	private void tableFormat(JspWriter out,String msg){
		try{
			out.println("<table border='0' width='100%' id='table1'>");
			out.println("<tr>");
			out.println("<td colspan='2' bgcolor='#B3E0FB'><b><font face='arial' size='2' color='#CC0000'></font>Alert : "+msg+"</b></font></td>");
		}catch(Exception e){
			System.out.println("Exception in TableFormat() of StudentWorks.jsp is "+e);
		}
	}
%>
<%
	
	StudentWorksBean studentWorkBean=(StudentWorksBean)request.getAttribute("studentsworks");
	if(studentWorkBean!=null)
	{}
	else
	{}
	Enumeration enum=null;
	String courseName="";
	String courseId="";
	String workName="";
	String workId="";
	int i=0;
	

	Hashtable dueDates=(Hashtable)studentWorkBean.getDueDates();
	Hashtable courses=(Hashtable)studentWorkBean.getCourses();
	Hashtable worksNames=null;
	boolean flag=false;
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
<body>
<form name='studentswork' method='post'>

<%
try{
	if(studentWorkBean.getDueDateCourses()!=null && ((Hashtable)studentWorkBean.getDueDateCourses()).size()>0){

	/*	out.println("<table border='0' width='100%' id='table1'>");
		out.println("<tr>");
		out.println("<td colspan='2' bgcolor='#B3E0FB'><b><font face='arial' size='2' color='#CC0000'></font>Alert : Course DeadLines</b></font></td>");*/
		tableFormat(out,"CourseDeadLines");
		out.println("</tr>");
		Hashtable dueDateCourses=(Hashtable)studentWorkBean.getDueDateCourses();
		enum=dueDateCourses.keys();
		while(enum.hasMoreElements()){
			flag=true;
			courseId=(String)enum.nextElement();
			courseName=(String)dueDateCourses.get((String)courseId);
			if(i%2==0){
			out.println("<tr>");
			out.println("<td width='50%'>"+courseName+"&nbsp;("+dueDates.get(courseId)+")</td>");
			}else{
				out.println("<td width='50%'>"+courseName+"&nbsp;("+dueDates.get(courseId)+")</td>");
				out.println("</tr>");
			}
			
		}	%>
	
	</table>
	<%}
	%>
<!--	<table border="0" width="100%" id="table2">
		<tr>
			<td colspan="2" bgcolor="#B3E0FB"><b>Alert : Course Latest</b></td>
		</tr>-->
	<%
	if((studentWorkBean.getLatestCourseOutlines()!=null && ((Hashtable)studentWorkBean.getLatestCourseOutlines()).size()>0) || (studentWorkBean.getLatestCourseMaterials()!=null && ((Hashtable)studentWorkBean.getLatestCourseMaterials()).size()>0) || 
	(studentWorkBean.getLatestAssignments()!=null && ((Hashtable)studentWorkBean.getLatestAssignments()).size()>0) ||
	(studentWorkBean.getLatestAssessments()!=null && ((Hashtable)studentWorkBean.getLatestAssessments()).size()>0)){
		tableFormat(out,"CourseLatest");
	}
	if(studentWorkBean.getLatestCourseOutlines()!=null && ((Hashtable)studentWorkBean.getLatestCourseOutlines()).size()>0){

		Hashtable courseOutlines=(Hashtable)studentWorkBean.getLatestCourseOutlines();
		worksNames=(Hashtable)studentWorkBean.getCoursesOutlines();
		
		
		enum=courseOutlines.keys();
		out.println("<tr>");
		out.println("<td colspan='2' bgcolor='#E8E8DB'><b>Course Outline</b></td>");
		out.println("</tr>");
		while(enum.hasMoreElements()){
			flag=true;
			workId=(String)enum.nextElement();
			workName=(String)courseOutlines.get(workId);
			courseId=(String)worksNames.get(workId);
			courseName=(String)courses.get(courseId);
			out.println("<tr>");
			out.println("<td width='50%' bgcolor='#E8E8DB'><a href='/LBCOM/coursemgmt/student/AssignmentFrames.jsp?type=CO&coursename="+courseName+"&courseid="+courseId+"'>"+workName+"</a></td>");
			out.println("<td width='50%' bgcolor='#E8E8DB'>"+courseName+"</td>");
			out.println("</tr>");
		  }
	}

	if(studentWorkBean.getLatestCourseMaterials()!=null && ((Hashtable)studentWorkBean.getLatestCourseMaterials()).size()>0){
		Hashtable courseMaterials=(Hashtable)studentWorkBean.getLatestCourseMaterials();
		worksNames=(Hashtable)studentWorkBean.getCoursesMaterial();
		
		

		enum=courseMaterials.keys();
		out.println("<tr>");
		out.println("<td colspan='2' bgcolor='#E1E1FF'><b>Course Materials</b></td>");
		out.println("</tr>");
		while(enum.hasMoreElements()){
			flag=true;
			workId=(String)enum.nextElement();
			
			workName=(String)courseMaterials.get(workId);
			courseId=(String)worksNames.get(workId);
			courseName=(String)courses.get(courseId);
			out.println("<tr>");
			out.println("<td width='50%' bgcolor='#E1E1FF'><a href='/LBCOM/coursemgmt/student/AssignmentFrames.jsp?type=CM&coursename="+courseName+"&courseid="+courseId+"'>"+workName+"</a></td>");
			out.println("<td width='50%' bgcolor='#E1E1FF'>"+courseName+"</td>");
			out.println("</tr>");
		}
	}
	
	if(studentWorkBean.getLatestAssignments()!=null && ((Hashtable)studentWorkBean.getLatestAssignments()).size()>0){
		Hashtable assignments=(Hashtable)studentWorkBean.getLatestAssignments();
		
		
		worksNames=(Hashtable)studentWorkBean.getAssignmentsNames();
		
		enum=assignments.keys();
		out.println("<tr>");
		out.println("<td colspan='2' bgcolor='#FFEEDD'><b>Assignments</b></td>");
		out.println("</tr>");
		while(enum.hasMoreElements()){
			flag=true;
			workId=(String)enum.nextElement();
			
			workName=(String)worksNames.get(workId);
			courseId=(String)assignments.get(workId);
			courseName=(String)courses.get(courseId);
			out.println("<tr>");
			out.println("<td width='50%' bgcolor='#FFEEDD'><a href='/LBCOM/coursemgmt/student/AssignmentFrames.jsp?type=AS&coursename="+courseName+"&courseid="+courseId+"'>"+workName+"</a></td>");
			out.println("<td width='50%' bgcolor='#FFEEDD'>"+courseName+"</td>");
			out.println("</tr>");
		  }
	}
	if(studentWorkBean.getLatestAssessments()!=null && ((Hashtable)studentWorkBean.getLatestAssessments()).size()>0){
		Hashtable assessments=(Hashtable)studentWorkBean.getLatestAssessments();
		
		
		worksNames=(Hashtable)studentWorkBean.getAssessmentsNames();
		
		enum=assessments.keys();
		out.println("<tr>");
		out.println("<td colspan='2' bgcolor='#D0DFDF' ><b>Assessments</b></td>");
		out.println("</tr>");
		while(enum.hasMoreElements()){
			flag=true;
			workId=(String)enum.nextElement();
			
			workName=(String)worksNames.get(workId);
			courseId=(String)assessments.get(workId);
			courseName=(String)courses.get(courseId);
			out.println("<tr>");
			out.println("<td width='50%' bgcolor='#D0DFDF'><a href='/LBCOM/coursemgmt/student/AssignmentFrames.jsp?type=EX&coursename="+courseName+"&courseid="+courseId+"'>"+workName+"</a></td>");
			out.println("<td width='50%' bgcolor='#D0DFDF'>"+courseName+"</td>");
			out.println("</tr>");
		  }
	}


%>
		
<!--<table border="0" width="100%" id="table3">
		<tr>
			<td colspan="2" bgcolor="#B3E0FB"><b>Alert :Deadlines</b></td>
		</tr>-->
<%
	if((studentWorkBean.getDueDateAssignments()!=null && ((Hashtable)studentWorkBean.getDueDateAssignments()).size()>0) ||
	   (studentWorkBean.getDueDateAssessments()!=null && ((Hashtable)studentWorkBean.getDueDateAssessments()).size()>0)){
		tableFormat(out,"DeadLines");
	}
	if(studentWorkBean.getDueDateAssignments()!=null && ((Hashtable)studentWorkBean.getDueDateAssignments()).size()>0){
		Hashtable assignments=(Hashtable)studentWorkBean.getDueDateAssignments();
		
		
		worksNames=(Hashtable)studentWorkBean.getAssignmentsNames();
		
		enum=assignments.keys();
		out.println("<tr>");
		out.println("<td colspan='2' bgcolor='#E8E8DB' ><b>Assignments</b></td>");
		out.println("</tr>");
		while(enum.hasMoreElements()){
			flag=true;
			workId=(String)enum.nextElement();
			
			workName=(String)worksNames.get(workId);
			courseId=(String)assignments.get(workId);
			courseName=(String)courses.get(courseId);
			out.println("<tr>");
			out.println("<td width='50%' bgcolor='#E8E8DB'><a href='/LBCOM/coursemgmt/student/AssignmentFrames.jsp?type=AS&coursename="+courseName+"&courseid="+courseId+"'>"+workName+"</a>&nbsp;&nbsp;"+dueDates.get(workId)+"</td>");
			out.println("<td width='50%' bgcolor='#E8E8DB'>"+courseName+"</td>");
			out.println("</tr>");
		  }
	}
	if(studentWorkBean.getDueDateAssessments()!=null && ((Hashtable)studentWorkBean.getDueDateAssessments()).size()>0){
		Hashtable assessments=(Hashtable)studentWorkBean.getDueDateAssessments();
		
		
		worksNames=(Hashtable)studentWorkBean.getAssessmentsNames();
		
		enum=assessments.keys();
		out.println("<tr>");
		out.println("<td colspan='2' bgcolor='#D0DFDF' ><b>Assessments</b></td>");
		out.println("</tr>");
		while(enum.hasMoreElements()){
			flag=true;
			workId=(String)enum.nextElement();
			
			workName=(String)worksNames.get(workId);
			courseId=(String)assessments.get(workId);
			courseName=(String)courses.get(courseId);
			out.println("<tr>");
			out.println("<td width='50%' bgcolor='#D0DFDF'><a href='/LBCOM/coursemgmt/student/AssignmentFrames.jsp?type=EX&coursename="+courseName+"&courseid="+courseId+"'>"+workName+"</a>&nbsp;&nbsp;"+dueDates.get(workId)+"</td>");
			out.println("<td width='50%' bgcolor='#D0DFDF'>"+courseName+"</td>");
			out.println("</tr>");
		  }
	}
%>
<!--<table border="0" width="100%" id="table4">
		<tr>
			<td colspan="2" bgcolor="#B3E0FB"><b>Alert :Upcoming</b></td>
		</tr>-->
	<%
	if((studentWorkBean.getUpcomingAssignments()!=null && ((Hashtable)studentWorkBean.getUpcomingAssignments()).size()>0) ||
		(studentWorkBean.getUpcomingAssessments()!=null && ((Hashtable)studentWorkBean.getUpcomingAssessments()).size()>0)){
		tableFormat(out,"Upcoming");
	}

	if(studentWorkBean.getUpcomingAssignments()!=null && ((Hashtable)studentWorkBean.getUpcomingAssignments()).size()>0){
		/*out.println("<table border='0' width='100%' id='table1'>");
		out.println("<tr>");
		out.println("<td colspan='2' bgcolor='#B3E0FB'><b><font face='arial' size='2' color='#CC0000'></font>Alert : Upcoming</b></font></td>");*/
		Hashtable assignments=(Hashtable)studentWorkBean.getUpcomingAssignments();
		

		
		worksNames=(Hashtable)studentWorkBean.getAssignmentsNames();
		
		enum=assignments.keys();
		out.println("<tr>");
		out.println("<td colspan='2' bgcolor='#E8E8DB' ><b>Assignments</b></td>");
		out.println("</tr>");
		while(enum.hasMoreElements()){
			flag=true;
			workId=(String)enum.nextElement();
			
			workName=(String)worksNames.get(workId);
			courseId=(String)assignments.get(workId);
			courseName=(String)courses.get(courseId);
			out.println("<tr>");
			out.println("<td width='50%' bgcolor='#E8E8DB'><a href='/LBCOM/coursemgmt/student/AssignmentFrames.jsp?type=AS&coursename="+courseName+"&courseid="+courseId+"'>"+workName+"</a></td>");
			out.println("<td width='50%' bgcolor='#E8E8DB'>"+courseName+"</td>");
			out.println("</tr>");
		  }
	}
	if(studentWorkBean.getUpcomingAssessments()!=null && ((Hashtable)studentWorkBean.getUpcomingAssessments()).size()>0){
		Hashtable assessments=(Hashtable)studentWorkBean.getUpcomingAssessments();
		
		
		worksNames=(Hashtable)studentWorkBean.getAssessmentsNames();
		
		enum=assessments.keys();
		out.println("<tr>");
		out.println("<td colspan='2' bgcolor='#D0DFDF' ><b>Assessments</b></td>");
		out.println("</tr>");
		while(enum.hasMoreElements()){
			flag=true;
			workId=(String)enum.nextElement();
			
			workName=(String)worksNames.get(workId);
			courseId=(String)assessments.get(workId);
			courseName=(String)courses.get(courseId);
			out.println("<tr>");
			out.println("<td width='50%' bgcolor='#D0DFDF'><a href='/LBCOM/coursemgmt/student/AssignmentFrames.jsp?type=EX&coursename="+courseName+"&courseid="+courseId+"'>"+workName+"</a></td>");
			out.println("<td width='50%' bgcolor='#D0DFDF'>"+courseName+"</td>");
			out.println("</tr>");
		  }
	}

	if(flag==false){
		/*out.println("<table border='0' width='100%' id='table1'>");
		out.println("<tr>");
		out.println("<td colspan='2' bgcolor='#B3E0FB'><b><font face='arial' size='2' color='#CC0000'></font>There is no Updates </b></font></td>");*/
		//tableFormat(out,"There is no Updates ");
		response.sendRedirect("/LBCOM/coursemgmt/student/studentcmindex.jsp");
	}
}catch(Exception e){
	System.out.println("Error in StudentWorks.jsp is "+e);
}

  %>
</form>


</BODY>
</HTML>

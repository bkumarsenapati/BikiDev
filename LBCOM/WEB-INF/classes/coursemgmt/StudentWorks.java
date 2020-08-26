package coursemgmt;
import java.io.PrintWriter;
import java.io.IOException;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Date;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletRequest;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import coursemgmt.StudentWorksBean;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;

public class StudentWorks extends HttpServlet
{
	final static private int COURSENOTIFICATIONDAYS=7;

	public void doGet(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException{
		doPost(req,res);
	}


	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{

		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		HttpSession session=request.getSession();
		Connection con=null;
		Statement st=null;
		try{

			String sessid=(String)session.getAttribute("sessid");
			if(sessid==null){
					out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
					return;
			}
			String schoolId="",teacherId="",studentId="",classId="",courseId="",courseName="",studentName="";

			schoolId=(String)session.getAttribute("schoolid");
			studentId=(String)session.getAttribute("emailid");
			studentName=(String)session.getAttribute("studentname");
			classId=(String)session.getAttribute("classid");
			courseId=(String)session.getAttribute("courseid");

			
			ResultSet rs=null;

			Hashtable courses=null;
			Hashtable dates=null;
			
			DbBean db=null;
			StudentWorksBean studentworksBean=null;

			db=new DbBean();
			con=db.getConnection();
			st=con.createStatement();
			
			studentworksBean=new StudentWorksBean(); 
			courses=new Hashtable();
			dates=new Hashtable();
		
			courses=getAllCourses(st,rs,schoolId,studentId);

			studentworksBean.setCourses(courses);
			getDueDateCourses(st,rs,studentworksBean,schoolId,studentId,classId,dates);
			getLatestCourseMaterials(st,rs,studentworksBean,courses,schoolId,studentId,classId,"CM");
			getLatestCourseMaterials(st,rs,studentworksBean,courses,schoolId,studentId,classId,"CO");
			getAssignments(st,rs,studentworksBean,courses,schoolId,studentId,classId,dates);
			getAssessments(con,st,rs,studentworksBean,courses,schoolId,studentId,dates);
			
			studentworksBean.setDueDates(dates);
			
			
			request.setAttribute("studentsworks",studentworksBean);
			
			try{

				if(st!=null){
				  st.close();
				}
				if (con!=null && !con.isClosed()){
				   con.close();
				}
			}catch(SQLException se){
				ExceptionsFile.postException("StudentWorks.java","closing the connection objects","SQLException",se.getMessage());
				
			}
			RequestDispatcher rd=request.getRequestDispatcher("/coursemgmt/student/StudentWorks.jsp");
			if(rd!=null){
				
			}else{
				
			}
			
			rd.forward(request,response);

		}catch(Exception e){
			System.out.println("Exception in doPost() of StudentWorks.java is "+e);
		}finally{
			try{

				if(st!=null){
				  st.close();
				}
				if (con!=null && !con.isClosed()){
				   con.close();
				}
			}catch(SQLException se){
				ExceptionsFile.postException("StudentWorks.java","closing the connection objects","SQLException",se.getMessage());
				
			}
		}


	}

	private Hashtable getAllCourses(Statement st,ResultSet rs,String schoolId,String studentId){
		Hashtable courses=new Hashtable();
		try{
			
			rs=st.executeQuery("select c.course_id,course_name from coursewareinfo c inner join coursewareinfo_det d on c.course_id=d.course_id and c.school_id=d.school_id where c.school_id='"+schoolId+"' and d.school_id='"+schoolId+"' and student_id='"+studentId+"' and c.status=1");
			while(rs.next()){
				
				courses.put(rs.getString("course_id"),rs.getString("course_name"));
			}
		}catch(Exception e){
			System.out.println("Exception in getAllCourses() of StudentWorks.java is "+e);
		}
		return courses;
	}
	private void getDueDateCourses(Statement st,ResultSet rs,StudentWorksBean studentWorks,String schoolId,String studentId,String classId,Hashtable dates){
		Hashtable dueDateCourses=null;
		Hashtable dueDates=null;
		try{
			String courseId="";
			Date lastDate=null;
			Date currDate=null;
			dueDateCourses=new Hashtable();
			dueDates=new Hashtable();
			rs=st.executeQuery("select c.course_name,c.teacher_id,c.course_id,c.last_date,curdate() as todate,datediff(curdate(),c.last_date) as diff from coursewareinfo c inner join coursewareinfo_det d on c.school_id=d.school_id and c.course_id=d.course_id where c.school_id='"+schoolId+"' and d.school_id='"+schoolId+"' and c.class_id='"+classId+"' and d.student_id='"+studentId+"' and c.status=1 and curdate()<c.last_date ");
			double daysDiff=0;
			while(rs.next()){
				courseId=rs.getString("course_id");
				lastDate=rs.getDate("last_date");
				daysDiff=rs.getDouble("diff");
				currDate=rs.getDate("todate");


				if(lastDate!=null && currDate.compareTo(lastDate)<=0){

					if(Math.abs(daysDiff)>COURSENOTIFICATIONDAYS){

						//System.out.println("difference is greater than 7 days");
					}else{

						dueDateCourses.put(rs.getString("course_id"),rs.getString("course_name"));
						dueDates.put(rs.getString("course_id"),rs.getString("last_date"));
						dates.put(rs.getString("course_id"),rs.getString("last_date"));

					}
		
				}
				studentWorks.setDueDateCourses(dueDateCourses);
				//studentWorks.setdueDates(dueDates);
			}
		}catch(Exception e){
			dueDateCourses=null;
			dueDates=null;
		}
	}
	
	private void getLatestCourseMaterials(Statement st,ResultSet rs,StudentWorksBean studentWorks,Hashtable courses,String schoolId,String studentId,String classId,String type){
		Hashtable materials=null;
		Hashtable materialsCourses=null;
		Enumeration enumm=null;
		try{
			String query="";
			String courseId="";
			
			materials=new Hashtable();
			materialsCourses=new Hashtable();
			enumm=courses.keys();
			while(enumm.hasMoreElements()){
				query="";
				courseId=(String)enumm.nextElement();
				query=getQueryString(st,rs,schoolId,courseId,type);

				rs=st.executeQuery("select * from course_docs c inner join course_docs_dropbox d on c.school_id=d.school_id and c.work_id=d.work_id where c.school_id='"+schoolId+"' and d.school_id='"+schoolId+"' and c.section_id='"+classId+"' and c.course_id='"+courseId+"' and d.student_id='"+studentId+"' and d.status=0 "+query);
				while(rs.next()){

						materials.put(rs.getString("work_id"),rs.getString("doc_name"));
						materialsCourses.put(rs.getString("work_id"),courseId);
				}
			}

			if(type.equals("CM")){
				studentWorks.setLatestCourseMaterials(materials);
				studentWorks.setCoursesMaterials(materialsCourses);
			}else if (type.equals("CO"))
			{
				studentWorks.setLatestCourseOutlines(materials);
				studentWorks.setCoursesOutlines(materialsCourses);
			}
		}catch(Exception e){
				System.out.println("Exception in StudentWorks at getLatestCourseMaterials is "+e);
		}finally{
			materials=null;
			materialsCourses=null;
			enumm=null;
		}
	}
	
	private void getAssignments(Statement st,ResultSet rs,StudentWorksBean studentWorks,Hashtable courses,String schoolId,String studentId,String classId,Hashtable dates){
		Enumeration enumm=null;
		Hashtable assignments=null;
		Hashtable assignmentsCourses=null;
		Hashtable upcomingAssignmentsCourses=null;
		Hashtable dueDateAssignmentsCourses=null;
		Hashtable results=null;
		try{
			String table="";
			String courseId="";
			double noOfDays=0;
			assignments=new Hashtable();
			assignmentsCourses=new Hashtable();
			upcomingAssignmentsCourses=new Hashtable();
			dueDateAssignmentsCourses=new Hashtable();
			results=new Hashtable();

			enumm=courses.keys();
			while(enumm.hasMoreElements()){
				courseId=(String)enumm.nextElement();
				table=schoolId+"_"+classId+"_"+courseId;
				rs=st.executeQuery("select *,d.status as dropbox_status,curdate() as curdate ,datediff(curdate(),to_date) as diff from "+table+"_workdocs w inner join "+table+"_dropbox d on w.work_id=w.work_id where d.student_id='"+studentId+"' and (d.status=0 or d.status=4) and (w.to_date>=curdate() or  w.to_date='0000-00-00' ) and w.status=1");
				while(rs.next()){
					    
					    noOfDays=Math.abs(rs.getDouble("diff"));
						/**
							From date is greater the current date i.e, these assignments are coming up later
						*/
						
						if(rs.getInt("dropbox_status")==0){
							if(rs.getDate("from_date").compareTo(rs.getDate("curdate"))>0){
								upcomingAssignmentsCourses.put(rs.getString("work_id"),courseId);
								assignments.put(rs.getString("work_id"),rs.getString("doc_name"));

							}else {  

								assignments.put(rs.getString("work_id"),rs.getString("doc_name"));
								assignmentsCourses.put(rs.getString("work_id"),courseId);
							}

							/**
								Todate is set(not null) and Todate is with in COURSENOTICATIONDAYS
							*/
							if(rs.getDate("to_date")!=null && noOfDays<=COURSENOTIFICATIONDAYS){

								dueDateAssignmentsCourses.put(rs.getString("work_id"),courseId);
								dates.put(rs.getString("work_id"),rs.getString("to_date"));
								assignments.put(rs.getString("work_id"),rs.getString("doc_name"));
							}
						}else if(rs.getInt("dropbox_status")==4){
							assignments.put(rs.getString("work_id"),rs.getString("doc_name"));
							results.put(rs.getString("work_id"),courseId);

						}
						
				}

			}
			studentWorks.setLatestAssignments(assignmentsCourses);
			studentWorks.setUpcomingAssignments(upcomingAssignmentsCourses);
			studentWorks.setDueDateAssignments(dueDateAssignmentsCourses);
			studentWorks.setAssignmentResults(results);
			studentWorks.setAssignmentsNames(assignments);

		}catch(Exception e){
				
				System.out.println("Exception in StudentWorks at getAssignments() is "+e);
		}finally{
			assignments=null;
			dueDateAssignmentsCourses=null;
			assignmentsCourses=null;
			upcomingAssignmentsCourses=null;
			enumm=null;
		}

	}

	
	private void getAssessments(Connection con,Statement st,ResultSet rs,StudentWorksBean studentWorks,Hashtable courses,String schoolId,String studentId,Hashtable dates){
		Statement st1=null;
		ResultSet rs1=null;
		Enumeration enumm=null;
		Hashtable assessments=null;
		Hashtable assessmentsCourses=null;
		Hashtable upcomingAssessmentsCourses=null;
		Hashtable dueDateAssessmentsCourses=null;
		try{
			String table="";
			String courseId="";
			double noOfDays=0;
			st1=con.createStatement();
			assessments=new Hashtable();
			assessmentsCourses=new Hashtable();
			upcomingAssessmentsCourses=new Hashtable();
			dueDateAssessmentsCourses=new Hashtable();

			enumm=courses.keys();

			while(enumm.hasMoreElements()){
				courseId=(String)enumm.nextElement();
			
				rs=st.executeQuery("select *,curdate() as curdate, datediff(curdate(),to_date) as diff from exam_tbl where school_id='"+schoolId+"' and course_id='"+courseId+"' and status=1 and (to_date>=curdate() or to_date='0000-00-00')");

				while(rs.next()){
					table=schoolId+"_"+rs.getString("exam_id")+"_"+rs.getString("create_date").replace('-','_');

					 noOfDays=Math.abs(rs.getDouble("diff"));
					rs1=st1.executeQuery("select * from "+table+" where student_id='"+studentId+"' and status=0");
					while(rs1.next()){
						if(rs.getDate("from_date").compareTo(rs.getDate("curdate"))>0){
							upcomingAssessmentsCourses.put(rs.getString("exam_id"),courseId);
							assessments.put(rs.getString("exam_id"),rs.getString("exam_name"));

						}else {  

							assessments.put(rs.getString("exam_id"),rs.getString("exam_name"));
							assessmentsCourses.put(rs.getString("exam_id"),courseId);
						}

						/**
							Todate is set(not null) and Todate is with in COURSENOTICATIONDAYS
						*/
						if(rs.getDate("to_date")!=null && noOfDays<=COURSENOTIFICATIONDAYS){

							dueDateAssessmentsCourses.put(rs.getString("exam_id"),courseId);
							dates.put(rs.getString("exam_id"),rs.getString("to_date"));
							assessments.put(rs.getString("exam_id"),rs.getString("exam_name"));
						}
						 
					}
				}
			}
			studentWorks.setLatestAssessments(assessmentsCourses);
			studentWorks.setUpcomingAssessments(upcomingAssessmentsCourses);
			studentWorks.setDueDateAssessments(dueDateAssessmentsCourses);
			studentWorks.setAssessmentsNames(assessments);


		}catch(Exception e){
				System.out.println("Exception in StudentWorks at getLatestAssessments() is "+e);
		}finally{
			try{
				if(rs1!=null)
					rs1.close();
				if(st!=null)
					st1.close();
			
			assessments=null;
			assessmentsCourses=null;
			}catch(Exception e){
				System.out.println("Exception while closing statments in getLatestAssessments is "+e);
			}
		}

	}

	synchronized private String getQueryString(Statement st,ResultSet rs,String schoolId,String courseId,String type){
		String query="";
		try{
	
			rs=st.executeQuery("select * from category_item_master where category_type='"+type+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");
			if(rs.next()){
				query=" and (category_id='"+rs.getString("item_id")+"'";
				while(rs.next()){
					query+=" or category_id='"+rs.getString("item_id")+"'";
				}
				query=query+")";
			}
			
		}catch(Exception e){
				System.out.println("Exception in StudentWorks at getQueryString() is "+e);
		}
		return query;
	}

}

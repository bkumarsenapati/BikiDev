package exam;

import sqlbean.DbBean;
import java.io.*;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Connection;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import coursemgmt.ExceptionsFile;

public class  DistributeExam extends HttpServlet
{
		
	
	protected void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		Statement st1=null;
		ResultSet rs1=null;
		HttpSession session=null;
		try{
			response.setContentType("text/html");
			PrintWriter out=response.getWriter();
			
			session=request.getSession(false);
			//String sessid=(String)session.getAttribute("sessid");
			if(session==null) {
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
		    }

			ExamPaper examPaper=null;
	    	CalTotalMarks calc=null;
			Hashtable hsSelIds=null,qIdsQtypes=null,unSelIds=null;
			String examId=null,stdlist=null,examType=null,uncheckedIds=null,courseId=null,classId=null,id=null,quesList=null,dbString=null,createDate=null,studentId=null,schoolId=null;

			float examTotal=0.0f;
			boolean flg=false;
			int maxAttempts=0;

			schoolId  =(String)session.getAttribute("schoolid");
			courseId  =(String)session.getAttribute("courseid");
			classId   =(String)session.getAttribute("classid");
			
			DbBean db=new DbBean();	
			con=db.getConnection();
			st=con.createStatement();
			st.clearBatch();
			st1=con.createStatement();
			calc=new CalTotalMarks();

			examId   = request.getParameter("examid"); //exam id
			stdlist  = request.getParameter("strStudentList"); //Available Student list
			examType  =request.getParameter("examtype");	//exam type	
			uncheckedIds=request.getParameter("unchecked"); 
			createDate=request.getParameter("createdate");
			
			hsSelIds=(Hashtable)session.getAttribute("seltIds");
			unSelIds=new Hashtable();
			
			flg=false; //this is used for generating query string
			
			examTotal=calc.calculateTmp(examId,schoolId);
			
			qIdsQtypes=new Hashtable();
			String submitStu="";
		
		    st.executeUpdate("update exam_tbl_tmp set group_status=0,status=5 where exam_id='"+examId+"' and group_status=2 and course_id='"+courseId+"' and school_id='"+schoolId+"'");

			st.executeUpdate("delete from "+schoolId+"_"+examId+"_"+createDate+"_tmp");
			st.executeUpdate("delete from cescores_tmp where school_id='"+schoolId+"' and work_id='"+examId+"' and course_id='"+courseId+"'");
			st.executeUpdate("delete from student_inst_tmp where school_id='"+schoolId+"' and exam_id='"+examId+"'");

			

			// Submitted students resultset
		/*	rs=st.executeQuery("select * from "+schoolId+"_"+examId+"_"+createDate+"_tmp where status>=1");
			while(rs.next()) {
				submitStu+=rs.getString("student_id")+",";

			} */

			rs=st.executeQuery("select mul_attempts from exam_tbl_tmp where school_id='"+schoolId+"' and exam_id='"+examId+"'");
			if(rs.next()) {
				maxAttempts=rs.getInt("mul_attempts");
			}

			rs.close();


			if(hsSelIds.size()>0){
				StringTokenizer idTkns=new StringTokenizer(uncheckedIds,",");
				while(idTkns.hasMoreTokens()){
					   id=idTkns.nextToken();
   					   unSelIds.put(id,id);                 //put the student ids in the hashtable for whom this assessment is unchecked
					   if(hsSelIds.containsKey(id))
							 hsSelIds.remove(id);
				}
			}
			StringTokenizer stk=new StringTokenizer(stdlist,",");
			while(stk.hasMoreTokens()){
				id=stk.nextToken();
				hsSelIds.put(id,id);
			}
			if(hsSelIds.size()==0 && stdlist.length()==0){
				out.println("You have to select at least one student <a href='#' onclick=\"window.location.href='/LBCOM/coursemgmt/teacher/AssStudentsList.jsp?cat=edit&workid="+examId+"&start=0&totrecords=&examtype="+examType+"'\">Back</a>");
				return;
			}
		
		 //remove the studentIds from the unselected list and selected list those who are already attempted.

		/*	stk=new StringTokenizer(submitStu,",");
			while(stk.hasMoreTokens()){
				id=stk.nextToken();
				if(hsSelIds.containsKey(id))
					hsSelIds.remove(id);
				if(unSelIds.containsKey(id))
					unSelIds.remove(id);            
			}
*/

			/**
				delete this exam records from the schoolId_studentId for the assessment is unchecked
			*/
			Enumeration stdKeys=unSelIds.keys();
			String tableName="";
			while(stdKeys.hasMoreElements()){			
				studentId=(String)unSelIds.get(stdKeys.nextElement());
				
				//tableName=schoolId+"_"+studentId;
				//dbString="delete from "+tableName+" where exam_id='"+examId+"';";
				//st.addBatch(dbString);

				dbString="delete from student_inst_tmp where school_id='"+schoolId+"' and student_id='"+studentId+"' and exam_id='"+examId+"'";
				st.addBatch(dbString);

				dbString="delete from cescores_tmp where school_id='"+schoolId+"' and work_id='"+examId+"' and user_id='"+studentId+"'";
				st.addBatch(dbString);

			}
			st.executeBatch();

					
//Storing Student Ids in hashtable hsSelIds
		
			rs=st.executeQuery("select * from "+schoolId+"_"+examId+"_versions_tbl_tmp");
			if (rs.next())
			{
				rs.first();
			}
			int verNo;
			
			stdKeys=hsSelIds.keys();
			tableName="";
			while(stdKeys.hasMoreElements()){
				quesList=rs.getString("ques_list");
				verNo=rs.getInt("ver_no");
				if(!stdKeys.hasMoreElements())
					break;
				studentId=(String)hsSelIds.get(stdKeys.nextElement());
				dbString="insert into "+schoolId+"_"+examId+"_"+createDate+"_tmp (exam_id,student_id,ques_list,count,status,version,password) values('"+
				examId+"','"+studentId+"','"+quesList+"',0,0,"+verNo+",'');";
				st.addBatch(dbString);

				/**
				     This code is newly written to add a new table for each student and insert the details fo the exam in the table
				**/
				
			/*	tableName=schoolId+"_"+studentId;
				dbString="delete from "+tableName+" where exam_id='"+examId+"'";	
				st.addBatch(dbString);*/

				

				dbString="insert into student_inst_tmp (school_id,student_id,exam_id,exam_status,count,version,exam_password,max_attempts) values('"+schoolId+"','"+studentId+"','"+examId+"',0,0,"+verNo+",'',"+maxAttempts+");";
				st.addBatch(dbString);
				

				// End of New Code  


				st.addBatch("insert into cescores_tmp(school_id,user_id,course_id,category_id,work_id,submit_date,marks_secured,total_marks,status,report_status) values('"+schoolId+"','"+studentId+"','"+courseId+"','"+examType+"','"+examId+"','0000-00-00',0,"+examTotal+",0,0)");



				rs.next();
				if(rs.isAfterLast()) 
					rs.first();
			}//end while
			st.executeBatch();


			out.println("<script>parent.parent.location.href=\"/LBCOM/exam/ExamsListTmp.jsp?examtype="+examType+"\";"+"</script>");
				
			}catch(NullPointerException np){
				ExceptionsFile.postException("DistributeExam.java","service","NullPointerException",np.getMessage());
				System.out.println("NullPointerException : "+np.getMessage());
			}catch(Exception e){
				ExceptionsFile.postException("DistributeExam.java","service","Exception",e.getMessage());
				System.out.println("Exception  : "+e.getMessage());
			}finally{
				 try{
					 if(st!=null)
						 st.close();
                     if (con!=null && !con.isClosed()){
                         con.close();
                     }
					 if(session!=null)
						 session.setAttribute("seltIds",null);
				
               }catch(SQLException se){
				        ExceptionsFile.postException("DistributeExam.java","closing connections","SQLException",se.getMessage());
						System.out.println("SQLException : "+se.getMessage());
               }


			}
			
	}//end service

}//end class

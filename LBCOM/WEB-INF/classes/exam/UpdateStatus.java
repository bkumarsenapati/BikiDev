package exam;
import java.io.*;
import java.sql.*;
import sqlbean.DbBean;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;

public class UpdateStatus extends HttpServlet
{
	
	
	public void doGet(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException {
			doPost(req,res);
	}

	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException {
		DbBean con1=null;
		Connection con=null;
		Statement st=null;
		PrintWriter out=null;
		ResultSet rs=null;
		HttpSession session=null;
		CalTotalMarks calc=null;		
		String examId=null;
		String teacherId=null;
		String examType=null;
		String mode=null,courseId=null,examInsTable=null,schoolId=null,dbString="";
		String sortBy,sortType,start,totRecords;
		float examTotal=0.0f;   
		try{	
			res.setContentType("text/html");
			out=res.getWriter();
			session=req.getSession(false);
			if (session==null) {
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			int i=0;
			con1=new DbBean();
			con=con1.getConnection();
			st=con.createStatement();
			calc=new CalTotalMarks();
			mode=req.getParameter("mode");
			examId=req.getParameter("examid");
			examType=req.getParameter("examtype");
			examInsTable=req.getParameter("instable");
			schoolId=(String)session.getAttribute("schoolid");
			courseId=(String)session.getAttribute("courseid");			

			sortBy=req.getParameter("sortby");
			sortType=req.getParameter("sorttype");
			start=req.getParameter("start");
			totRecords=req.getParameter("totrecords");


			if (mode.equals("AV")) {  // make availabe to students

				examTotal=calc.calculate(examId,schoolId);
				
				st.clearBatch();

				dbString="update exam_tbl set status=1 where exam_id='"+examId+"' and school_id='"+schoolId+"'";
				st.addBatch(dbString);				

				dbString="insert into "+schoolId+"_activities (SELECT exam_id,exam_name,'EX' as exam_type,'QZ' as exam_sub_type,course_id,from_date,to_date FROM exam_tbl where exam_id='"+examId+"' and school_id='"+schoolId+"')";
				st.addBatch(dbString);				

				dbString="delete from "+schoolId+"_cescores where work_id='"+examId+"' and status=0 and course_id='"+courseId+"' and school_id='"+schoolId+"'";
				st.addBatch(dbString);

				rs=st.executeQuery("select * from "+examInsTable);
				while(rs.next()){
					st.addBatch("insert into "+schoolId+"_cescores(school_id,user_id,course_id,category_id,work_id,submit_date,marks_secured,total_marks,status,report_status) values('"+schoolId+"','"+rs.getString("student_id")+"','"+courseId+"','"+examType+"','"+examId+"','0000-00-00',0,"+examTotal+",0,1)");
				}
				st.executeBatch();

			}else if(mode.equals("UA")){ // make unavailabe to students
			
				st.clearBatch();

				dbString="update exam_tbl set status=0 where exam_id='"+examId+"' and school_id='"+schoolId+"'";
				st.addBatch(dbString);
				dbString="delete from "+schoolId+"_cescores where work_id='"+examId+"' and status=0 and course_id='"+courseId+"' and school_id='"+schoolId+"'";
				st.addBatch(dbString);
				dbString="delete from "+schoolId+"_activities where activity_id='"+examId+"'";
				st.addBatch(dbString);
				st.executeBatch();				

			}		   
			
			out.println("<script>");
			out.println("parent.bottompanel.location.href='/LBCOM/exam/ExamsList.jsp?examtype="+examType+"&sortby="+sortBy+"&sorttype="+sortType+"&totrecords="+totRecords+"&start="+start+"';");
			out.println("</script>");
		}
		catch(Exception e) {
			ExceptionsFile.postException("UpdateSataus.java","doPost","Exception",e.getMessage());
			System.out.println(e.getMessage());
		}finally{
				 try{
					 if(st!=null)
						 st.close();
                     if (con!=null && !con.isClosed()){
                        con.close();
                     }
               }catch(SQLException se){
				        ExceptionsFile.postException("UpdateStatus.java","closing connections","SQLException",se.getMessage());
                        
               }


		}
	}

}

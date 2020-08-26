package exam;
import sqlbean.DbBean;
import java.sql.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;

public class ExamEvaluate extends HttpServlet {
   
   
    
	public void init(ServletConfig conf) {
		try{	
		    
		}catch(Exception e){
			ExceptionsFile.postException("ExamEvaluate.java","init","Exception",e.getMessage());
		}
	}
	public void doGet(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		doPost(req,res);

	}
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		DbBean con1=null;
		try
		{	
			HttpSession session=null;
			PrintWriter out=null;
			res.setContentType("text/html");
			out=res.getWriter();
			session=req.getSession(false);
			//String sessid=(String)session.getAttribute("sessid");
			if(session==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			int i=0,status=0,totRecords=0,count=0,markScheme=0;
			float marks=0.0f,marksSecured=0.0f;
			String studentId=null,examId=null,maxMarks=null,examName=null,examType=null,stuTableName=null,schoolId=null;
			con1=new DbBean();
		    con=con1.getConnection();
			st=con.createStatement();
			schoolId=(String)session.getAttribute("schoolid");
			studentId=req.getParameter("studentid");;
			examId=req.getParameter("examid");
			marksSecured=Float.parseFloat(req.getParameter("markssecured"));
			marks=Float.parseFloat(req.getParameter("marks"));
			maxMarks=req.getParameter("maxmarks");
			examName=req.getParameter("examname");
			examType=req.getParameter("examtype");
			totRecords=Integer.parseInt(req.getParameter("totrecords"));
			stuTableName=req.getParameter("tablename");
			status=Integer.parseInt(req.getParameter("status"));
			count=Integer.parseInt(req.getParameter("count"));
			markScheme=Integer.parseInt(req.getParameter("scheme"));
			marks=marksSecured+marks;
			
			if (status<2) {
				i=st.executeUpdate("update "+stuTableName+" set status='2',marks_secured="+marks+" where exam_id='"+examId+"' and student_id='"+studentId+"' and count="+count);
			}
			if (markScheme==0){
				rs=st.executeQuery("select max(marks_secured) marks from "+stuTableName+" where exam_id='"+examId+"' and student_id='"+studentId+"' and status='2'");
			}else if(markScheme==1){
				rs=st.executeQuery("select marks_secured marks from "+stuTableName+" where exam_id='"+examId+"' and student_id='"+studentId+"'and status='2' order by count desc");
			}else{
				rs=st.executeQuery("select avg(marks_secured) marks from "+stuTableName+" where exam_id='"+examId+"' and student_id='"+studentId+"'  and status='2'");
			}
			if(rs.next()) {
				marksSecured=rs.getFloat("marks");				
			}
			rs=st.executeQuery("select count(*) as cnt from "+stuTableName+" where exam_id='"+examId+"' and student_id='"+studentId+"'  and status='1'");
			char new_status='2';    // Completed
			if(rs.next()) {
				if(rs.getInt("cnt")>0)
					new_status='1';   // Partially evaluated
			}
			i=st.executeUpdate("update "+schoolId+"_cescores set marks_secured="+marksSecured+",status='"+new_status+"' where work_id='"+examId+"' and user_id='"+studentId+"' and category_id='"+examType+"' and school_id='"+schoolId+"'");
			if(i!=0)
			{
				out.println("<script>");
			out.println("parent.location.href='/LBCOM/exam/examTakenStu.jsp?examname="+examName+"&tablename="+stuTableName+"&examid="+examId+"&examtype="+examType+"&totrecords="+totRecords+"&start=0&scheme="+markScheme+"';");
				out.println("</script>");
			}
			else
				out.println("The marks are not Assigned");

	   }
	   catch(Exception e)
	   {
		   ExceptionsFile.postException("ExamEvaluate.java","doPost","Exception",e.getMessage());
		   System.out.println("Exception in ExamEvaluate.java"+e);
	}finally{
				 try{
					 if(st!=null)
						 st.close();
                     if (con!=null){
                        con.close();
                     }
               }catch(SQLException se){
				        ExceptionsFile.postException("ExamEvaluate.java","closing connections","SQLException",se.getMessage());
               }


			}	  

	}
}

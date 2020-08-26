package exam;
import sqlbean.DbBean;
import java.sql.*;
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;

public class EvaluateSubmission extends HttpServlet 
{
	public void init(ServletConfig conf) 
	{
		try
		{
		
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("EvaluateSubmission.java","init","Exception",e.getMessage());
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
			if(session==null)
			{
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			int i=0,status=0,count=0,markScheme=0;
			int j=0;
			float marks=0.0f,marksSecured=0.0f,totalMarks=0.0f;
			String studentId=null,examId=null,examName=null,examType=null,stuTblName=null,schoolId=null,attempt=null;
			String courseId=null;
			String ansStr="",qList="",qStr="";
			String mode=null;
			String evalStatus="";
			StringTokenizer quesStr;
			boolean fbFlag=false;

			con1=new DbBean();
		    con=con1.getConnection();
			st=con.createStatement();
			
			schoolId=(String)session.getAttribute("schoolid");
			courseId=(String)session.getAttribute("courseid");

			studentId=req.getParameter("studentid");
			examId=req.getParameter("examid"); 

			marksSecured=Float.parseFloat(req.getParameter("markssecured"));
			totalMarks=Float.parseFloat(req.getParameter("totalmarks"));
			marks=Float.parseFloat(req.getParameter("marks")); // Value in the readonly text field of EvaluateSubmission.jsp

			mode=req.getParameter("mode");
			System.out.println("Here");
			ansStr=req.getParameter("ansstr");
			System.out.println("ansStr..."+ansStr);
			examName=req.getParameter("examname");
			examType=req.getParameter("examtype");
			
			stuTblName=(String)session.getAttribute("stuTblName");

			status=Integer.parseInt(req.getParameter("status"));
			attempt=req.getParameter("count");
			count=Integer.parseInt(attempt);
			markScheme=Integer.parseInt((String)session.getAttribute("marksScheme"));

			int nstat=2;
			if(status>=4)
				nstat=6;

			int attemptVal=0;	

			//Formatting the answer string to store in ques_list of exam instance table

			ansStr=ansStr.substring(0,ansStr.length()-1);
			ansStr=ansStr+"&";
			
			rs=st.executeQuery("select ques_list from "+stuTblName+" where exam_id='"+examId+"' and student_id='"+studentId+"' and count="+count);
			if(rs.next())
			{
				qList=rs.getString(1);
			}

			quesStr=new StringTokenizer(qList,"&");
			if(quesStr.hasMoreTokens())
			{
				qStr=quesStr.nextToken();
				try
				{
					qStr=quesStr.nextToken();
				}
				catch(NoSuchElementException e)
				{
					//System.out.println("EvaluateSubmission.java Message::Previous points are not stored");
				}
			}

			qStr=ansStr+qStr;
											
			if(!mode.equals("reeval"))
			{
				marks=marksSecured+marks;
				System.out.println("nstat..."+nstat);
				System.out.println("In Evaluation.....mode..."+mode+"......stuTblName..."+stuTblName);

				i=st.executeUpdate("update "+stuTblName+" set ques_list='"+qStr+"',status='"+nstat+"',marks_secured="+marks+",eval_date=curdate() where exam_id='"+examId+"' and student_id='"+studentId+"' and count="+count);
			
				if(markScheme==0)
				{
					rs=st.executeQuery("select max(marks_secured) marks from "+stuTblName+" where exam_id='"+examId+"' and student_id='"+studentId+"'");
				}
				else if(markScheme==1)
				{
					rs=st.executeQuery("select marks_secured marks from "+stuTblName+" where exam_id='"+examId+"' and student_id='"+studentId+"' order by count desc");
				}
				else
				{
					rs=st.executeQuery("select avg(marks_secured) marks from "+stuTblName+" where exam_id='"+examId+"' and student_id='"+studentId+"'");
				}
				if(rs.next()) 
				{
					marksSecured=rs.getFloat("marks");
				}
				rs=st.executeQuery("select count(*) as cnt from "+stuTblName+" where exam_id='"+examId+"' and student_id='"+studentId+"'  and status='1'");
				char new_status='2';    // Completed
				if(rs.next()) {
				if(rs.getInt("cnt")>0)
					new_status='1';   // Partially evaluated
				}
				i=st.executeUpdate("update "+schoolId+"_cescores set marks_secured="+marksSecured+",status="+new_status+" where work_id='"+examId+"' and user_id='"+studentId+"' and category_id='"+examType+"' and school_id='"+schoolId+"'");

				//Adding default feedback

				rs=st.executeQuery("select feed_back from teacher_feedback where school_id='"+schoolId+"' and course_id='"+courseId+"' and exam_id='"+examId+"' and student_id='"+studentId+"' and attempt_no='"+attempt+"'");
				
				if(rs.next())
				{
					fbFlag=true;
				}
				
				if(fbFlag=true)
				{
					session.setAttribute("submissionNo",attempt);
					session.setAttribute("marksSecured",String.valueOf(marks));
					session.setAttribute("evalStatus","done");

					//st.executeUpdate("update teacher_feedback set feed_back='' where school_id='"+schoolId+"' and course_id='"+courseId+"' and exam_id='"+examId+"' and student_id='"+studentId+"' and attempt_no="+attempt);
				}
				else
				{
					session.setAttribute("submissionNo",attempt);
					session.setAttribute("marksSecured",String.valueOf(marks));

					st.executeUpdate("insert into teacher_feedback 	values('"+schoolId+"','"+courseId+"','"+examId+"','"+studentId+"',"+attempt+",'')");
				}	

				if(i!=0)
				{
					out.println("<script>");		
					out.println("parent.papernos.location='/LBCOM/exam/StudentExamPapers.jsp?examid="+examId+"&studentid="+studentId+"&examname="+examName+"&examtype="+examType+"&status="+status+"'");

					//out.println("alert('i not 0')");		
					//out.println("parent.fb_f.location.href='/LBCOM/exam/StudentExamPapers.jsp?<%=req.getQueryString().toString()%>'");
					
					//out.println("parent.fb_f.location.href='/LBCOM/exam/FeedBack.jsp?mode=T&actmode=&examid="+examId+"&examname="+examName+"&studentid="+studentId+"&attempt="+attempt+"&markssecured="+marksSecured+"&marks="+marks+"';");
					out.println("</script>");
				}
				else
				{
					out.println("The points have not been assigned");
				}
			}
			else		//code for reevaluation
			{
				
				System.out.println("marks are..."+marks+"....secmarks are...."+marksSecured+"...stuTblName..."+stuTblName);
				marks=marksSecured+marks;
				/*
				if(totalMarks<marks)
					marks=totalMarks;
					*/
				System.out.println("In ....ReEvaluation....mode..."+mode);
				i=st.executeUpdate("update "+stuTblName+" set ques_list='"+qStr+"',marks_secured="+marks+",eval_date=curdate() where exam_id='"+examId+"' and student_id='"+studentId+"' and (status=2 or status=6) and count="+count);
	
				if(markScheme==0)
				{
					rs=st.executeQuery("select max(marks_secured) marks from "+stuTblName+" where exam_id='"+examId+"' and student_id='"+studentId+"'");
				}
				else if(markScheme==1)
				{
					rs=st.executeQuery("select marks_secured marks from "+stuTblName+" where exam_id='"+examId+"' and student_id='"+studentId+"' order by count desc");
				}
				else
				{
					rs=st.executeQuery("select avg(marks_secured) marks from "+stuTblName+" where exam_id='"+examId+"' and student_id='"+studentId+"'");
				}
				if(rs.next()) 
				{
					marksSecured=rs.getFloat("marks");
				}
				rs=st.executeQuery("select count(*) as cnt from "+stuTblName+" where exam_id='"+examId+"' and student_id='"+studentId+"'  and status='1'");
				char new_status='2';    // Completed
				if(rs.next()) {
				if(rs.getInt("cnt")>0)
					new_status='1';   // Partially evaluated
				}
				
				i=st.executeUpdate("update "+schoolId+"_cescores set marks_secured="+marksSecured+",status="+new_status+" where work_id='"+examId+"' and user_id='"+studentId+"' and category_id='"+examType+"' and school_id='"+schoolId+"'");
			
				if(i!=0)
				{
					out.println("<script>");		
					//out.println("parent.papernos.location.reload(true);");
					out.println("parent.papernos.location='/LBCOM/exam/StudentExamPapers.jsp?examid="+examId+"&studentid="+studentId+"&examname="+examName+"&examtype="+examType+"&status="+status+"'");
					//out.println("parent.fb_f.location.href='/LBCOM/exam/StudentExamPapers.jsp?<%=req.getQueryString().toString()%>'");
					//out.println("parent.fb_f.location.href='/LBCOM/exam/FeedBack.jsp?mode=T&actmode=&examid="+examId+"&examname="+examName+"&studentid="+studentId+"&attempt="+attempt+"&markssecured="+marksSecured+"&marks="+marks+"';");
					out.println("</script>");
				}
				else
				{
					out.println("The points have not been assigned");
				}
			}
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("EvaluateSubmission.java","doPost","Exception",e.getMessage());
			System.out.println("Exception in EvaluateSubmission.java"+e);
		}
		finally
		{
			try
			{
				if(st!=null)
					st.close();
                if(con!=null)
					con.close();
            }
			catch(SQLException se)
			{
				ExceptionsFile.postException("EvaluateSubmission.java","closing connections","SQLException",se.getMessage());
			}
		}	  
	}
}

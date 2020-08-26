package exam;
import sqlbean.DbBean;
import utility.Utility;
import java.io.*;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;

public class FeedBackAction extends HttpServlet
{

public void service(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
{
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	HttpSession session=null;

	try
	{
		PrintWriter out=null;
		response.setContentType("text/html");
		out=response.getWriter();

		session=request.getSession(false);
		if(session==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	    }

		String schoolId,courseId,examId,studentId,mode,attempt,feedBack;
		boolean fbFlag=false;
		DbBean db;

		schoolId=(String)session.getAttribute("schoolid");
		courseId=(String)session.getAttribute("courseid");
		
		db=new DbBean();
		con=db.getConnection();		
		st=con.createStatement();
		
		mode=request.getParameter("mode");
		System.out.println("Mode is ..JAVA..."+mode);
		studentId=request.getParameter("studentid");
		examId=request.getParameter("examid");
		attempt=request.getParameter("attempt");
		feedBack=request.getParameter("feedback");
		rs=st.executeQuery("select feed_back from teacher_feedback where school_id='"+schoolId+"' and course_id='"+courseId+"' and exam_id='"+examId+"' and student_id='"+studentId+"' and attempt_no='"+attempt+"'");
		if(rs.next())
		{
			fbFlag=true;
		}

		if(fbFlag==true)
		{
			st.executeUpdate("update teacher_feedback set feed_back='"+feedBack+"' where school_id='"+schoolId+"' and course_id='"+courseId+"' and exam_id='"+examId+"' and student_id='"+studentId+"' and attempt_no="+attempt);
		}
		else
		{
			st.executeUpdate("insert into teacher_feedback 	values('"+schoolId+"','"+courseId+"','"+examId+"','"+studentId+"',"+attempt+",'"+feedBack+"')");
		}
		session.setAttribute("submissionNo",attempt);
		out.println("<script>");		
		out.println("parent.papernos.location.reload(true);");
		out.println("</script>");	
	}
	catch(SQLException se)
	{
		ExceptionsFile.postException("FeedBackAction.java","service","SQLException",se.getMessage());	
		System.out.println("SQLException in FeedBackAction.java is...:"+se.getMessage());
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("FeedBackAction.java","service","Exception",e.getMessage());	
		System.out.println("Exception in FeedBackAction.java is...:"+e.getMessage());		
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if (con!=null && ! con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("FeedBackAction.java","closing connections","SQLException",se.getMessage());
		}
	}// finally block end
}// End of Service

}// End


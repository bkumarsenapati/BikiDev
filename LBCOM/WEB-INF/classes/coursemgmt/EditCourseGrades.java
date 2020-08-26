package coursemgmt;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.Calendar;
import sqlbean.DbBean;

public class EditCourseGrades extends HttpServlet
{
	
	public void init(ServletConfig conf ) throws ServletException
	{
		super.init();	
	}

	public void doGet(HttpServletRequest req,HttpServletResponse res) throws 
	ServletException,IOException
	{
		doPost(req,res);
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		int i=0;
		int records=0;
		boolean bool=false;
		DbBean con1=null;
		HttpSession session=request.getSession(false);
		PrintWriter out=response.getWriter();
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;	
		PreparedStatement prestmt=null;
		String courseId="",schoolId="",classId="";
		try
		{
			response.setContentType("text/html");
			if(session==null)
			{
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			con1=new DbBean();
			con=con1.getConnection();
			st=con.createStatement();
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("AddGrades.java","getting connection","Exception",e.getMessage());
			try{
				if(st!=null){
				    st.close();
				}
				if (con!=null && !con.isClosed()){
				   con.close();
				}
			}catch(SQLException se){
				ExceptionsFile.postException("EditCourseGrades.java","Closing Connection objects","SQLException",se.getMessage());
				
			}
		}
	
		//start of editing the course grades
		
		schoolId=(String)session.getAttribute("schoolid");
		classId=request.getParameter("classid");
		records=Integer.parseInt(request.getParameter("no_of_records"));
		String last_record=request.getParameter("last_record"); // We have to enter last value if value is 'yes' on behalf of teacher.
		String scale=request.getParameter("scale");
		float scaleVal = Float.parseFloat(scale);
		
		if(scale.equals("10"))
			scale="10scale";
		else
			scale="100scale";

		if(records==0)
		{
			out.println("<br><br><center><b>You have to assign atleast one grade in the grading system");
			out.print("<FONT face=Verdana size=2><a href='javascript:history.go(-1);'>BACK</a></font></center>");
			return;
		}

		String minimum[]=request.getParameterValues("minimum");
		float min[] = new float[minimum.length];
		for(int x=0;x<minimum.length;x++)
			min[x]=Float.parseFloat(minimum[x]);
		String gradenames[]=request.getParameterValues("gradenames");
		String gradecodes[]=request.getParameterValues("gradecodes");
		String description[]=request.getParameterValues("descriptions");
		
		courseId=request.getParameter("courseid");
		
		try 
		{
			con.setAutoCommit(false);

			st.executeUpdate("update coursewareinfo set grading_scale='"+scale+"' where school_id='"+schoolId+"' and class_id='"+classId+"' and course_id='"+courseId+"'");
			
			rs=st.executeQuery("select * from course_grades where  courseid='"+courseId+"' and schoolid='"+schoolId+"' and classid='"+classId+"'");		
			if(rs.next())
			{
				st.executeUpdate("delete from course_grades where courseid='"+courseId+"' and schoolid='"+schoolId+"' and classid='"+classId+"'");
				prestmt=con.prepareStatement("INSERT INTO course_grades VALUES(?,?,?,?,?,?,?,?)");

				prestmt.setString(1,schoolId);
				prestmt.setString(2,classId);
				prestmt.setString(3,courseId);
				prestmt.setString(4,gradenames[0]);
				prestmt.setString(5,gradecodes[0]);
				prestmt.setFloat(6,min[0]);
				prestmt.setFloat(7,scaleVal);
				prestmt.setString(8,description[0]);
				int res1=prestmt.executeUpdate();

				for(i=1;i<records;i++)
				{
					prestmt.setString(1,schoolId);
					prestmt.setString(2,classId);
					prestmt.setString(3,courseId);
					prestmt.setString(4,gradenames[i]);
					prestmt.setString(5,gradecodes[i]);
					prestmt.setFloat(6,min[i]);
					prestmt.setFloat(7,min[i-1]);
					prestmt.setString(8,description[i]);
					
					int res=prestmt.executeUpdate();
				}

				if(last_record.equals("yes"))  // It will execute only if the teacher does not enter the last grade.
				{
					prestmt.setString(1,schoolId);
					prestmt.setString(2,classId);
					prestmt.setString(3,courseId);
					prestmt.setString(4,"Last");
					prestmt.setString(5,"Failed");
					prestmt.setFloat(6,0);
					prestmt.setFloat(7,min[records-1]);
					prestmt.setString(8,"Failed");
					int res2=prestmt.executeUpdate();
				}

				bool=true;				
				con.commit();
				if(con!=null)
					con.close();
				response.sendRedirect("/LBCOM/coursemgmt/teacher/CoursesList.jsp");
			}
			else
			{
				prestmt=con.prepareStatement("INSERT INTO course_grades VALUES(?,?,?,?,?,?,?,?)");
				
				prestmt.setString(1,schoolId);
				prestmt.setString(2,classId);
				prestmt.setString(3,courseId);
				prestmt.setString(4,gradenames[0]);
				prestmt.setString(5,gradecodes[0]);
				prestmt.setFloat(6,min[0]);
				prestmt.setFloat(7,scaleVal);
				prestmt.setString(8,description[0]);
				int res1=prestmt.executeUpdate();
				
				for(i=1;i<records;i++)
				{
					prestmt.setString(1,schoolId);
					prestmt.setString(2,classId);
					prestmt.setString(3,courseId);
					prestmt.setString(4,gradenames[i]);
					prestmt.setString(5,gradecodes[i]);
					prestmt.setFloat(6,min[i]);
					prestmt.setFloat(7,min[i-1]);
					prestmt.setString(8,description[i]);
					int res=prestmt.executeUpdate();
				}

				if(last_record.equals("yes"))  // It will execute only if the teacher does not enter the last grade.
				{
					prestmt.setString(1,schoolId);
					prestmt.setString(2,classId);
					prestmt.setString(3,courseId);
					prestmt.setString(4,"Last");
					prestmt.setString(5,"Failed");
					prestmt.setFloat(6,0);
					prestmt.setFloat(7,min[records-1]);
					prestmt.setString(8,"Failed");
					int res2=prestmt.executeUpdate();
				}

				bool=true;
				con.commit();
				if(con!=null)
					con.close();
				response.sendRedirect("/LBCOM/coursemgmt/teacher/CoursesList.jsp");
			}
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("AddGrades.java","Post","SQLException",se.getMessage());
			try  
			{
				if (con!=null){
					con.rollback();
				}
			}catch(Exception e){ 
				ExceptionsFile.postException("AddGrades.java","Connection rollback","Exception",e.getMessage());
			}
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("AddGrades.java","Post","Exception",e.getMessage());
     	}
		finally
		{
			try  
			{
				if(st!=null)
				{
					st.close();
				}
				if( prestmt!=null){
					prestmt.close();   
				}
				if (con!=null && !con.isClosed()){
				   con.close();
				}
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("EditCourseGrades.java","Closing Connection objects","SQLException",se.getMessage());
				
			}
		}
	}
}

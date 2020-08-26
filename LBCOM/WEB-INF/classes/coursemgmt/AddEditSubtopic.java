package coursemgmt;

import java.io.*;
import java.lang.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import utility.Utility;
import sqlbean.DbBean;

public class AddEditSubtopic extends HttpServlet
{
	

	public void init(ServletConfig config)
	{
		try
		{
			super.init(config);
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("AddEditSubtopic.java","init","Exception",e.getMessage());
			
		}
	}

	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{	
		response.setContentType("text/html");
		HttpSession session=null;
		PrintWriter out=null;
		out=response.getWriter();
		session = request.getSession(false);
		//String sessid=(String)session.getAttribute("sessid");
		if(session==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		DbBean db=null;
		Connection con=null;
		Statement st=null;
		Utility u1=null;
		String schoolId=null,mode=null,courseId=null,topicId=null,subtopicId=null,subTopicDesc=null,schoolPath=null;
		ResultSet rs=null;
		int i=0,counter=0;

		ServletContext application = getServletContext();
		schoolPath = application.getInitParameter("schools_path");
		schoolId = (String)session.getAttribute("schoolid");
		mode = request.getParameter("mode");
		courseId = request.getParameter("courseid");
		topicId = request.getParameter("topicid");
		subTopicDesc = request.getParameter("subtopicdesc");
		
		
		
		try
		{
			db = new DbBean(); 
			con=db.getConnection();
			st=con.createStatement();

			u1 = new Utility(schoolId,schoolPath);
			if(mode.equals("add")){
				rs=st.executeQuery("select subtopic_id from subtopic_master where school_id='"+schoolId+"' and course_id='"+courseId+"' and topic_id='"+topicId+"' and subtopic_des='"+subTopicDesc+"'");
				if(rs.next())
				{
					out=response.getWriter();
					//out.println("<script language=javascript>alert('The class already exists. Please choose another name.'); \n history.go(-1); \n </script>");
					out.println("<center><h3><FONT COLOR=red>Subtopic already exists.Please choose another one</FONT></h3></center>");
					out.println("<center><input type=button onclick=history.go(-1) value=OK ></center>");
					out.close();
					return;
				}
				subtopicId=u1.getId("SubtopicId");
				if (subtopicId.equals(""))
				{
					u1.setNewId("SubtopicId","ST000");
					subtopicId=u1.getId("SubtopicId");
				}
				//i = con.updateSQL("insert into subtopic_master values('"+courseId+"','"+topicId+"','"+subtopicId+"','"+subTopicDesc+"')");	
				i = st.executeUpdate("insert into subtopic_master values('"+schoolId+"','"+courseId+"','"+topicId+"','"+subtopicId+"','"+subTopicDesc+"')");	
								
			}
			else if(mode.equals("edit"))
			{
				subtopicId = request.getParameter("subtopicid");
				 rs=st.executeQuery("select subtopic_id from subtopic_master where school_id='"+schoolId+"' and course_id='"+courseId+"' and topic_id='"+topicId+"' and subtopic_des='"+subTopicDesc+"'");
				
				if(rs.next())
				{
				    if(!subtopicId.equals(rs.getString("subtopic_id"))){
				        out=response.getWriter();
						out.println("<center><h3><FONT COLOR=red>Subtopic already exists.Please choose another one</FONT></h3></center>");
						out.println("<center><input type=button onclick=history.go(-1) value=OK ></center>");
						out.close();
						return;
				    }	
				}
				i = st.executeUpdate("update subtopic_master set subtopic_des='"+subTopicDesc+"' where course_id='"+courseId+"' and topic_id='"+topicId+"' and subtopic_id='"+subtopicId+"' and school_id='"+schoolId+"'");
			}
			else if(mode.equals("delete"))
			{
				subtopicId = request.getParameter("subtopicid");
				//i = con.updateSQL("delete from subtopic_master where course_id='"+courseId+"' and topic_id='"+topicId+"' and subtopic_id='"+subtopicId+"'");
				i = st.executeUpdate("delete from subtopic_master where course_id='"+courseId+"' and topic_id='"+topicId+"' and subtopic_id='"+subtopicId+"' and school_id='"+schoolId+"'");
				
			}

			if(i==1){
				out.println("<html><script>");
				out.println("window.location.href='/LBCOM/coursemgmt/teacher/DisplaySubtopics.jsp?courseid="+courseId+"&topicid="+topicId+"';");
				out.println("</script></html>");

//					response.sendRedirect("../coursemgmt/teacher/DisplaySubtopics.jsp?courseid="+courseId+"&topicid="+topicId);
					
			}
		}
		catch(SQLException es)
		{
			ExceptionsFile.postException("AddEditSubtopic.java","post","SQLException",es.getMessage());
			
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("AddEditSubtopic.java","post","Exception",e.getMessage());
			
		}
		finally
		{
			try
			{
				if(st!=null){
				  st.close();
				}
				if (con!=null && !con.isClosed()){
				  con.close();
				}
			}
			catch(Exception ee)
			{
				ExceptionsFile.postException("AddEditSubtopic.java","closing connection","Exception",ee.getMessage());
				
			}
		}
	}
}

package coursemgmt;

import java.io.*;
import java.lang.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import utility.Utility;
import sqlbean.DbBean;

public class AddEditTopic extends HttpServlet
{
	public void init(ServletConfig config)
	{
		try
		{
			super.init(config);
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("AddEditTopic.java","init","Exception",e.getMessage());
			
		}
	}

	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		
		HttpSession session=null;
		PrintWriter out=null;
		response.setContentType("text/html");
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
		String schoolId=null,sPath=null,mode=null,courseId=null,topicId=null,topicDesc=null,classId=null,courseName=null,className=null;
		ResultSet rs=null;
		int i=0,counter=0;
		
		ServletContext application = getServletContext();
		sPath = application.getInitParameter("schools_path");
		schoolId = (String)session.getAttribute("schoolid");		
		courseId = request.getParameter("courseid");
		classId  = request.getParameter("classid");
		courseName=request.getParameter("coursename");
		className=request.getParameter("classname");
		mode = request.getParameter("mode");
		topicId=request.getParameter("topicid");
		topicDesc = request.getParameter("topicdesc");
		try
		{
			db = new DbBean(); 
			con=db.getConnection();
			st=con.createStatement();

			u1 = new Utility(schoolId,sPath);
			i=0;
			if(mode.equals("add")){
				rs=st.executeQuery("select topic_des from topic_master where school_id='"+schoolId+"' and course_id='"+courseId+"' and topic_des='"+topicDesc+"'");
				if(rs.next())
				{
					out=response.getWriter();
					//out.println("<script language=javascript>alert('The class already exists. Please choose another name.'); \n history.go(-1); \n </script>");
					out.println("<center><h3><FONT COLOR=red>Topic already exists.Please choose another one</FONT></h3></center>");
					out.println("<center><input type=button onclick=history.go(-1) value=OK ></center>");
					out.close();
					return;
				}
				topicId=u1.getId("TopicId");
				if (topicId.equals(""))
				{
					u1.setNewId("TopicId","T000");
					topicId=u1.getId("TopicId");
				}

				//i = con.updateSQL("insert into topic_master values('"+courseId+"','"+topicId+"','"+topicDesc+"')");	
				i = st.executeUpdate("insert into topic_master values('"+schoolId+"','"+courseId+"','"+topicId+"','"+topicDesc+"')");	
								
			}
			else if(mode.equals("edit"))
			{
				topicId = request.getParameter("topicid");
				 rs=st.executeQuery("select topic_id from topic_master where school_id='"+schoolId+"' and course_id='"+courseId+"' and topic_des='"+topicDesc+"'");
				if(rs.next())
				{
				    if(!topicId.equals(rs.getString("topic_id"))){
				        out=response.getWriter();
						out.println("<center><h3><FONT COLOR=red>Topic already exists.Please choose another one</FONT></h3></center>");
						out.println("<center><input type=button onclick=history.go(-1) value=OK ></center>");
						out.close();
						return;
				    }	
				}
				i = st.executeUpdate("update topic_master set topic_des='"+topicDesc+"' where course_id='"+courseId+"' and topic_id='"+topicId+"' and school_id='"+schoolId+"'");
			}
			else if(mode.equals("delete"))
			{
				topicId = request.getParameter("topicid");
				//i = con.updateSQL("delete from topic_master where course_id='"+courseId+"' and topic_id='"+topicId+"'");
				i = st.executeUpdate("delete from topic_master where course_id='"+courseId+"' and topic_id='"+topicId+"' and school_id='"+schoolId+"'");
				
			}
			if (i==1)
			{
				response.sendRedirect("/LBCOM/coursemgmt/teacher/DisplayTopics.jsp?coursename="+courseName+"&courseid="+courseId+"&classid="+classId+"&classname="+className);
			}
		}
		catch(SQLException es)
		{
			ExceptionsFile.postException("AddEditTopic.java","post","SQLException",es.getMessage());
			
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("AddEditTopic.java","post","Exception",e.getMessage());
			
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
				ExceptionsFile.postException("AddEditTopic.java","closing connection","Exception",ee.getMessage());
				
			}
		}
	}
}

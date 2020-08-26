/**
Author  : Srinivas Nagam
Version : 1.0
Description : This program is written to Post a Topic or Reply irrespective of the user i.e Administrator or Teacher or Student.
*/
package forums;

import java.io.*;
import java.lang.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;

public class SaveForum extends HttpServlet
{
	HttpSession session;
	
	PrintWriter out;
	
	public void init(ServletConfig config){
		try{
			super.init(config);
		}
		catch(Exception e){
			ExceptionsFile.postException("SaveForum.java","init","Exception",e.getMessage());
			
		}
	}
	public void service(HttpServletRequest request,HttpServletResponse response){
		Connection con=null;
		DbBean con1=null;
		Statement stmt=null;
		String userName=null,schoolId=null,sId=null,uType=null,forumId=null;
		String transType=null,topicName=null,topicDesc=null,forumName=null,mode="";
		try  
		{
			response.setContentType("text/html");
			sId=request.getParameter("sid");
			forumId=request.getParameter("fid");
			forumName=request.getParameter("fname");
			transType=request.getParameter("type");
			topicName=request.getParameter("topic");
			topicDesc=request.getParameter("message");
			session=request.getSession(false);
			userName=(String)session.getAttribute("emailid");
			schoolId=(String)session.getAttribute("schoolid");
			uType=(String)session.getAttribute("logintype");
			mode=request.getParameter("mode");
			//DELETED BY RAJESH //topicDesc = check4Opostrophe(topicDesc);
			if(transType.equals("3"))
				topicName="Suggestion";
			topicName = check4Opostrophe(topicName);
			con1 = new DbBean();
			con = con1.getConnection();
			stmt = con.createStatement();
			if(mode.equals("edit"))
			{
				int j=stmt.executeUpdate("update forum_post_topic_reply set school_id='"+sId+"',forum_id='"+forumId+"',user_id='"+userName+"',trans_type='"+transType+"',topic='"+topicName+"',message='"+topicDesc+"',trans_date=curdate())");
				if(j==1)
				{
				if(uType.equals("admin"))
					uType="school";
				//response.sendRedirect("/LBCOM/"+uType+"Admin/ShowTopics.jsp?sid="+sId+"&fid="+forumId+"&fname="+forumName);
				response.sendRedirect("/LBCOM/schoolAdmin/ShowThreads.jsp?sid="+sId+"&fid="+forumId+"&fname="+forumName);
				}
			}
			else
			{
			int i = stmt.executeUpdate("insert into forum_post_topic_reply values('"+sId+"','"+forumId+"','"+userName+"','"+transType+"','"+topicName+"','"+topicDesc+"',curdate())");
			if(i==1)
			{
				if(uType.equals("admin"))
					uType="school";
				//response.sendRedirect("/LBCOM/"+uType+"Admin/ShowTopics.jsp?sid="+sId+"&fid="+forumId+"&fname="+forumName);
				response.sendRedirect("/LBCOM/schoolAdmin/ShowThreads.jsp?sid="+sId+"&fid="+forumId+"&fname="+forumName);
			}
			}
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("SaveForum.java","service","Exception",e.getMessage());
			
		}
		finally
		{
				 try{
					   if(stmt!=null)
						   stmt.close();
					   if(con!=null && !con.isClosed()){
						  
						  con.close();
					   }
				   }catch(SQLException se){
						ExceptionsFile.postException("SaveForum.java","closing connections","SQLException",se.getMessage());
						
			   }


		}
	}
	synchronized private String check4Opostrophe(String s)
    {
        StringBuffer stringbuffer = new StringBuffer(s);
        int i = 0;
        int j = 0;
        while(i < s.length()) 
            if(s.charAt(i++) == '\'')
            {
                stringbuffer.replace(j + i, j + i, "'");
                j++;
            }

        return stringbuffer.toString();
    }
/*	public void destroy(){
		try{
			if(stmt!=null)
			   stmt.close();
		   if(con!=null){
			  
			  con.close();
		   }
		}
		catch(Exception e1){
			ExceptionsFile.postException("SaveForum.java","destroy","Exception",e1.getMessage());
			
		}
	}*/
}